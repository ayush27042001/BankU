using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NeoXPayout
{
    public partial class DeveloperAPI : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString);
        UserManagement um = new UserManagement();
        string connStr = ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            string Acctype = (Session["AccountHolderType"]?.ToString() ?? "").Trim().ToUpper();
            if (this.Session["BankURTUID"] == null || !(Session["IsMPINVerified"] is bool isVerified && isVerified))
            {
                Response.Redirect("LoginBankU.aspx");
            }
            if (Acctype != "BUSINESS & APIS")
            {
                Response.Redirect("Dashboard.aspx");
            }
            if (!IsPostBack)
            {
                lblKey.Text =Encrypt(this.Session["BankURTUID"].ToString());
                lblnumber.Text = this.Session["BankURTMobileno"].ToString();
                GetCategory();
                getAPI();
                LoadProcessingButtons();
                LoadIp();
            }
            
        }
         public void LoadIp() 
        {
            string userId = Session["BankURTUID"]?.ToString();

            using (SqlConnection con = new SqlConnection(connStr))
            {
                string query = "SELECT ApprovedIP, ApprovCallback FROM Registration WHERE RegistrationId = @RegistrationId";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@RegistrationId", userId);
                    con.Open();

                    SqlDataReader reader = cmd.ExecuteReader();

                    if (reader.Read())  
                    {
                        string approvedIP = reader["ApprovedIP"]?.ToString();
                        lblIP.Text = !string.IsNullOrEmpty(approvedIP) ? approvedIP : "";
                        string ApprovCallback = reader["ApprovCallback"]?.ToString();
                        lblCallback.Text = !string.IsNullOrEmpty(ApprovCallback) ? ApprovCallback : "";
                    }
                    else
                    {
                       
                        lblIP.Text = "";
                    }

                    reader.Close();
                }
            }
        }
        public static string Encrypt(string text)
        {
            string key = "Banku";
            using (var md5 = new MD5CryptoServiceProvider())
            {
                using (var tdes = new TripleDESCryptoServiceProvider())
                {
                    tdes.Key = md5.ComputeHash(UTF8Encoding.UTF8.GetBytes(key));
                    tdes.Mode = CipherMode.ECB;
                    tdes.Padding = PaddingMode.PKCS7;

                    using (var transform = tdes.CreateEncryptor())
                    {
                        byte[] textBytes = UTF8Encoding.UTF8.GetBytes(text);
                        byte[] bytes = transform.TransformFinalBlock(textBytes, 0, textBytes.Length);
                        return Convert.ToBase64String(bytes, 0, bytes.Length);
                    }
                }
            }
        }

        protected void GetCategory()
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                string query = "SELECT  Category FROM APICategory"; 
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    if (reader.HasRows)
                    {
                        ddlCategory.DataSource = reader;
                        ddlCategory.DataTextField = "Category";   
                        ddlCategory.DataValueField = "Category";  
                        ddlCategory.DataBind();
                    }

                    reader.Close();
                }
            }
            ddlCategory.Items.Insert(0, new ListItem("All Category", ""));
        }
        protected void ddlCategory_SelectedIndexChanged(object sender, EventArgs e)
        {
            string selectedCategory = ddlCategory.SelectedValue;

            if (string.IsNullOrEmpty(selectedCategory))
            {
                // Show all
                getAPI();
                LoadProcessingButtons();
            }
            else
            {
                
                getAPI(selectedCategory);
                LoadProcessingButtons();
            }
        }

        protected void lnkSaveToDB_Click(object sender, EventArgs e)
        {
            string WebsiteUrl = txtWebsiteUrl.Text.Trim();
            string useCase = txtUseCase.Text.Trim();
            string title = Request.Form["selected-api-title"];
            string MobileNo = Session["mobileno"].ToString();
            string UserId = Session["BankURTUID"].ToString();
            string Name = Session["BankURTName"].ToString();

            //if (string.IsNullOrEmpty(WebsiteUrl) || string.IsNullOrEmpty(useCase))
            //{
            //    LoadProcessingButtons(); // Initial load
            //    lblerror.Text = "Fill All Details";
            //    return;
            //}
            string userId = Session["BankURTUID"].ToString();
            if (string.IsNullOrEmpty(userId) || string.IsNullOrEmpty(title))
            {
                ClientScript.RegisterStartupScript(this.GetType(), "popup", "alert('Missing required data.');", true);
                return;
            }

            string checkQuery = "SELECT COUNT(*) FROM APIAcctiveRequest WHERE UserId = @UserId AND Title = @Title";
            SqlCommand checkCmd = new SqlCommand(checkQuery, con);
            checkCmd.Parameters.AddWithValue("@UserId", userId);
            checkCmd.Parameters.AddWithValue("@Title", title);
            con.Open();
            int count = (int)checkCmd.ExecuteScalar();
            con.Close();

            if (count > 0)
            {
                LoadProcessingButtons(); 
                ClientScript.RegisterStartupScript(this.GetType(), "popup", "alert('This request is already in Processing.');", true);
                return;
            }


            decimal amount = 59;

            decimal balance = 0;
            decimal.TryParse(um.GetBalance(UserId), out balance);
            if (amount > balance)
            {
                lblerror.Text = "Error: Insufficient balance for your account.";
                lblerror.Attributes["class"] = "text-danger";
                return;
            }
            else
            {
                Decimal NewBalance = balance - amount;
                string con = ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString;
                using (SqlConnection conn = new SqlConnection(con))
                {

                    string query = "insert into tbluserbalance(Old_Bal,Amount,New_Bal,TxnType,crDrType,UserId,Remarks,TxnDatetime)values(@Old_Bal,@Amount,@New_Bal,@TxnType,@crDrType,@UserId,@Remarks,GETDATE());";
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@Old_Bal", balance);
                        cmd.Parameters.AddWithValue("@Amount", amount);
                        cmd.Parameters.AddWithValue("@New_Bal", NewBalance);
                        cmd.Parameters.AddWithValue("@TxnType", "API Request");
                        cmd.Parameters.AddWithValue("@crDrType", "Debit");
                        cmd.Parameters.AddWithValue("@UserId", UserId);
                        cmd.Parameters.AddWithValue("@Remarks", "Amount Debitted from user");


                        conn.Open();
                        cmd.ExecuteNonQuery();
                    }
                }
            }
            Decimal NewBalance2 = balance - amount;
            string ReqId = "API" + DateTime.Now.ToString("yyyyMMdd") + "-" + new Random().Next(1000, 9999);
            string sqlfr12 = "insert into APIAcctiveRequest(UserId,Title,ReqId,Status,ReqDate,WebsiteUrl,APIUsecase)values(@UserId,@Title,@ReqId,@Status, @ReqDate,@WebsiteUrl,@APIUsecase);";
            SqlCommand cmdfr12 = new SqlCommand(sqlfr12, con);
            cmdfr12.Parameters.AddWithValue("@UserId", userId);
            cmdfr12.Parameters.AddWithValue("@Title", title);
            cmdfr12.Parameters.AddWithValue("@ReqId", ReqId);
            cmdfr12.Parameters.AddWithValue("@WebsiteUrl", WebsiteUrl);
            cmdfr12.Parameters.AddWithValue("@APIUsecase", useCase);
            cmdfr12.Parameters.AddWithValue("@Status", "Processing");
            cmdfr12.Parameters.Add("@ReqDate", SqlDbType.DateTime).Value = DateTime.Now;
            con.Open();
            int rowsAffected = cmdfr12.ExecuteNonQuery();
            con.Close();

            if (rowsAffected > 0)
            {
                um.ProcessMsg(MobileNo, title, Name, ReqId);
                LoadProcessingButtons();
                //ClientScript.RegisterStartupScript(this.GetType(), "popup", "alert('Request Added.');", true);
                string finalMsg = $@"
                  <p>Your request has been submitted successfully. Our team will review it and notify you with further updates soon.</p>
                <table style='width:100%; border-collapse:collapse; text-align:left;'>
                    <tr>
                        <td style='padding:6px; width:40%;'><strong>Current Balance:</strong></td>
                        <td style='padding:6px;'>{NewBalance2}</td>
                    </tr>
           
                </table>";

                //string finalMsg = $"{Message}. Your recharge for mobile number {mobileNo} was successful with Transaction ID {txnId} on {txnDate}. Your current balance is ₹{currentBal}.";

                successModalLabel.Text = "Request Added Successful";
                lblSuccessMsg.Text = finalMsg;
                string script = "var myModal = new bootstrap.Modal(document.getElementById('successModal')); myModal.show();";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "showSuccessModal", script, true);
            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "popup", "alert('Something went wrong! Please try after some time.');", true);

            }
           

        }
        private void LoadProcessingButtons()
        {
            string userId = Session["BankURTUID"]?.ToString();
            if (!string.IsNullOrEmpty(userId))
            {
                var apiStatusList = new List<object>();
                string sql = "SELECT Title, Status FROM APIAcctiveRequest WHERE UserId = @UserId AND (Status = 'Processing' OR Status = 'Approved' OR Status = 'Rejected')";
                SqlCommand cmd = new SqlCommand(sql, con);
                cmd.Parameters.AddWithValue("@UserId", userId);
                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                while (reader.Read())
                {
                    apiStatusList.Add(new
                    {
                        Title = reader["Title"].ToString(),
                        Status = reader["Status"].ToString()
                    });
                }
                con.Close();

                string json = Newtonsoft.Json.JsonConvert.SerializeObject(apiStatusList);
                ClientScript.RegisterStartupScript(this.GetType(), "apiStatus", $"setApiStatusButtons({json});", true);
            }
        }
        private void getAPI(string categoryFilter = null)
        {
            string connStr = ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connStr))
            {
                // Build query
                string query = "SELECT Id, ApiName, ApiDesc, Amount, ApiIcon, Status, Category FROM APIList WHERE Status = 'Active'";
                if (!string.IsNullOrEmpty(categoryFilter))
                {
                    query += " AND Category = @Category";
                }
                query += " ORDER BY Category";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    if (!string.IsNullOrEmpty(categoryFilter))
                    {
                        cmd.Parameters.AddWithValue("@Category", categoryFilter);
                    }

                    con.Open();
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    // group by category
                    var categories = dt.AsEnumerable()
                        .GroupBy(r => r["Category"].ToString())
                        .Select(g => new
                        {
                            Category = g.Key,
                            APIs = g.CopyToDataTable()
                        }).ToList();

                    rptCategory.DataSource = categories;
                    rptCategory.DataBind();
                }
            }
        }

        protected void btnAddIP_Click(object sender, EventArgs e)
        {
            string bankUrtuId = Session["BankURTUID"]?.ToString();
            string ApprovedIP = txtIP.Text;
            string sqlfr12 = "UPDATE Registration SET ApprovedIP = @ApprovedIP WHERE RegistrationId = @RegistrationId";
            SqlCommand cmdfr12 = new SqlCommand(sqlfr12, con);
            cmdfr12.Parameters.AddWithValue("@ApprovedIP", ApprovedIP);
            cmdfr12.Parameters.AddWithValue("@RegistrationId", bankUrtuId);
           
            con.Open();
            int rowsAffected = cmdfr12.ExecuteNonQuery();
            con.Close();

            if (rowsAffected > 0)
            {

                lblIP.Text = ApprovedIP;
                LoadProcessingButtons();
                LoadIp();
                txtIP.Text = "";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "success",
                "Swal.fire({ icon: 'success', title: 'Updated Successfully!', showConfirmButton: false, timer: 1500 });", true);

            }
            else
            {
                string strscript = "<script>alert('Something went wrong! Please try after some time.');</script>";
                Page.RegisterStartupScript("popup", strscript);
                
            }
        }

        protected void btnAddCallback_Click(object sender, EventArgs e)
        {
            string bankUrtuId = Session["BankURTUID"]?.ToString();
            string ApprovedCall = txtCallBack.Text;
            string sqlfr12 = "UPDATE Registration SET ApprovCallback = @ApprovCallback WHERE RegistrationId = @RegistrationId";
            SqlCommand cmdfr12 = new SqlCommand(sqlfr12, con);
            cmdfr12.Parameters.AddWithValue("@ApprovCallback", ApprovedCall);
            cmdfr12.Parameters.AddWithValue("@RegistrationId", bankUrtuId);

            con.Open();
            int rowsAffected = cmdfr12.ExecuteNonQuery();
            con.Close();

            if (rowsAffected > 0)
            {

                lblCallback.Text = ApprovedCall;
                LoadProcessingButtons();
                LoadIp();
                txtCallBack.Text = "";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "success",
                "Swal.fire({ icon: 'success', title: 'Updated Successfully!', showConfirmButton: false, timer: 1500 });", true);

            }
            else
            {
                string strscript = "<script>alert('Something went wrong! Please try after some time.');</script>";
                Page.RegisterStartupScript("popup", strscript);

            }
        }
    }
}