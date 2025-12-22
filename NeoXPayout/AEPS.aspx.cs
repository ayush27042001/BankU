using Newtonsoft.Json.Linq;
using RestSharp;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
namespace NeoXPayout
{
    public partial class AEPS : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Page.UnobtrusiveValidationMode = UnobtrusiveValidationMode.None;
            if (Session["BankURTName"] == null || !(Session["IsMPINVerified"] is bool isVerified && isVerified))
            {
                Response.Redirect("LoginBankU.aspx");
            }
            if (!IsPostBack)
            {
                hdnUserKey.Value = Session["BankURTUID"].ToString();
                LoadRechargeHistory();
                Banklist();
                btnTran.CssClass = "nav-link active";
                pnlTransaction.Visible = true;
                pnlAuthentication.Visible = false;
                btnAEPS.Attributes["type"] = "button";
                btnTran.Attributes["type"] = "button";        
            }
            // Optional: check during page load
            if (IsPostBack && !string.IsNullOrWhiteSpace(hdnPidData.Value))
            {
                //after testing should remove the text and also ValidateRequest="false"
                lblOutput.Text = Server.HtmlEncode(hdnPidData.Value);
            }
        }

        private void LoadRechargeHistory()
        {
            try
            {
                // Calculate date range (last 5 days including today)
                string dateTo = DateTime.Now.ToString("yyyy-MM-dd");
                string dateFrom = DateTime.Now.AddDays(-4).ToString("yyyy-MM-dd");

                // --- TEMP OVERRIDE for testing (delete this block after confirming dropdown works)
                //dateFrom = "2025-06-01";
                //dateTo = "2025-06-12";
                string userId = Session["BankURTUID"]?.ToString();
                if (string.IsNullOrEmpty(userId))
                {
                    litRechargeHistory.Text = "<div class='text-danger'>User session expired. Please log in again.</div>";
                    return;
                }

                string url = "https://partner.banku.co.in/api/TxnReport";

                // JSON body with dynamic date range and selected service
                string body = $@"
                    {{
                        ""UserId"": ""{userId}"",
                        ""Apiversion"": ""1.0"",
                        ""ServiceName"": ""AEPS"",
                        ""DateFrom"": ""{dateFrom}"",
                        ""DateTo"": ""{dateTo}""
                    }}";

                var client = new RestClient(url);
                var request = new RestRequest(Method.POST);
                request.AddHeader("Accept", "application/json");
                request.AddHeader("Content-Type", "application/json");
                request.AddParameter("application/json", body, ParameterType.RequestBody);

                IRestResponse response = client.Execute(request);

                if (response.IsSuccessful)
                {
                    JObject result = JObject.Parse(response.Content);

                    if (result["Status"]?.ToString() == "SUCCESS")
                    {
                        JArray dataArray = result["Data"] as JArray;

                        if (dataArray == null || !dataArray.Any())
                        {
                            litRechargeHistory.Text = "<div class='text-muted'>No transaction history found.</div>";
                            return;
                        }

                        string html = "";

                        foreach (var item in dataArray.Take(5))
                        {
                            string operatorName = item["OperatorName"]?.ToString() ?? "";
                            string mobile = item["MobileNo"]?.ToString() ?? "-";
                            string amount = item["Amount"]?.ToString() ?? "0";
                            string date = Convert.ToDateTime(item["TxnDate"]).ToString("MMM dd, yyyy");
                            string status = item["Status"]?.ToString() ?? "PENDING";

                            string logo = "Rupee.png";

                            string amountColor = status == "SUCCESS" ? "green" : "red";

                            html += $@"
                                    <div class='d-flex align-items-center mb-3'>
                                        <img class='avatar rounded' src='assets/images/xs/{logo}' alt=''>
                                        <div class='flex-fill ms-3'>
                                            <div class='h6 mb-0'>{mobile}</div>
                                            <small class='text-muted'>{operatorName}</small>
                                        </div>
                                        <div class='flex-end flex-column d-flex text-end'>
                                            <small class='fw-medium' style='color:{amountColor};'>₹{amount}</small>
                                            <small class='text-muted'>{date}</small>
                                        </div>
                                    </div>
                                    <hr />";
                        }

                        litRechargeHistory.Text = html;
                    }
                    else
                    {
                        litRechargeHistory.Text = "<div class='text-danger'>No successful data found for the selected type.</div>";
                    }
                }
                else
                {
                    litRechargeHistory.Text = "<div class='text-danger'>Failed to fetch recharge history. Please try again later.</div>";
                }
            }
            catch (Exception ex)
            {
                // Log exception (optional)
                litRechargeHistory.Text = $"<div class='text-danger'>Error: {ex.Message}</div>";
            }
        }
        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            string pidData = Request.Unvalidated.Form[hdnPidData.UniqueID];
            lblOutput.Text = Server.HtmlEncode(pidData);
           
            SavePidDataToDB(pidData);
        }
        private void SavePidDataToDB(string pidXml)
        {
            // Hardcoded connection string
            using (SqlConnection con = new SqlConnection("Data Source=Sqlplesk8.securehostdns.com,1234;Initial Catalog=SachinJha_db;Persist Security Info=True;User ID=SachinJha_db;Password=Chandan@80100"))
            {
                string query = "INSERT INTO FingerprintLogs (PidData) VALUES (@PidData)";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@PidData", pidXml);
                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }
        }
        public void Banklist()
        {
            string TokenKey = "Bank";
            string url = "https://app.banku.co.in/api/BankList";
            string body = "{\"Service\":\"" + TokenKey + "\"}";
            var client = new RestClient(url);
            var request = new RestRequest(Method.POST);
            request.AddHeader("cache-control", "no-cache");
            request.AddHeader("Accept", "application/json");
            request.AddHeader("Content-Type", "application/json");
            request.AddParameter("application/json", body, RestSharp.ParameterType.RequestBody);
            IRestResponse response = client.Execute(request);
            string content = response.Content;
            JObject jObjects = JObject.Parse(content);
            if (jObjects["Status"].ToString() == "SUCCESS")
            {
                JArray jredmill = JArray.Parse(jObjects["Data"].ToString());
                DataTable dt = new DataTable();
                dt.Columns.AddRange(new DataColumn[2] { new DataColumn("bank_iin", typeof(string)),
                            new DataColumn("bank_name",typeof(string))});
                if (jredmill != null)
                {
                    foreach (JToken item in (IEnumerable<JToken>)jredmill)
                    {
                        JObject jObjects1 = JObject.Parse(item.ToString());
                        dt.Rows.Add(jObjects1["iin"].ToString(), jObjects1["name"].ToString());
                    }
                    if (dt.Rows.Count > 0)
                    {
                        ddlbankname.DataSource = dt;
                        ddlbankname.DataBind();
                        ddlbankname.DataTextField = "bank_name";
                        ddlbankname.DataValueField = "bank_iin";
                        ddlbankname.DataBind();
                        ddlbankname.Items.Insert(0, new ListItem("Please select", ""));
                    }
                }
            }
            else
            {

            }
        }
        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            string Aadhaar = txtAadhaar.Text.Trim();

            // Check if empty
            if (string.IsNullOrWhiteSpace(Aadhaar))
            {
                Label2.Text = "Please enter your Aadhaar number.";
                Label1.Text = ""; // Clear any previous validation error
                return;
            }

            // Check if valid 10-digit number
            if (!Regex.IsMatch(Aadhaar, @"^\d{12}$"))
            {
                Label1.Text = "Enter a valid 12-digit Aadhaar number.";
                Label2.Text = ""; // Clear any previous empty check error
                return;
            }

            // Clear any previous error messages
            Label1.Text = "";
            Label2.Text = "";

            // Set review info
          
            Label1.Text = "Verification done successfully.";
            Label1.CssClass = "text-success"; // Optional: green color
            txtAadhaarNumber.Text = Aadhaar;
            string script = "window.onload = function() { $('#changeDeviceModal ').modal('show'); };";
            ClientScript.RegisterStartupScript(this.GetType(), "ShowModal", script, true);
        }
        protected void BillType_Click(object sender, EventArgs e)
        {
            LinkButton clickedButton = (LinkButton)sender;
            string selectedBillType = clickedButton.CommandArgument;


            ViewState["SelectedBillType"] = selectedBillType;
            string selected = ViewState["SelectedBillType"] as string;
            // Hide both panels by default
            pnlAuthentication.Visible = false;
            pnlTransaction.Visible = false;

            btnAEPS.CssClass = "nav-link";
            btnTran.CssClass = "nav-link";
           
            switch (selectedBillType)
            {
                case "Authentication":
                    pnlAuthentication.Visible = true;
                    btnAEPS.CssClass = "nav-link active";
                    break;

                case "Transaction":
                    pnlTransaction.Visible = true;
                    btnTran.CssClass = "nav-link active";
                    break;
              

                default:
                    
                    break;
            }
            // string script = "window.onload = function() { $('#Transaction ').modal('show'); };";
            //ClientScript.RegisterStartupScript(this.GetType(), "ShowModal", script, true);      

        }
        

        [System.Web.Services.WebMethod]
        public static string SaveFingerprintData(string type, string aadharno, string bankiinno, string mobileno, string spkey, string amount, string fingerdata, string latitude, string longitude, string userid)
        {
            try
            {
            
                using (SqlConnection conn = new SqlConnection("Data Source=Sqlplesk8.securehostdns.com,1234;Initial Catalog=SachinJha_db;Persist Security Info=True;User ID=SachinJha_db;Password=Chandan@80100"))
                {
                    string query = "INSERT INTO AePSTransactions (Type, AadharNo, BankIIN, MobileNo, TxnType, Amount, FingerData, Latitude, Longitude, UserId, CreatedAt) VALUES (@Type, @AadharNo, @BankIIN, @MobileNo, @TxnType, @Amount, @FingerData, @Latitude, @Longitude, @UserId, GETDATE())";

                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@Type", type);
                    cmd.Parameters.AddWithValue("@AadharNo", aadharno);
                    cmd.Parameters.AddWithValue("@BankIIN", bankiinno);
                    cmd.Parameters.AddWithValue("@MobileNo", mobileno);
                    cmd.Parameters.AddWithValue("@TxnType", spkey);
                    cmd.Parameters.AddWithValue("@Amount", amount);
                    cmd.Parameters.AddWithValue("@FingerData", fingerdata);
                    cmd.Parameters.AddWithValue("@Latitude", latitude);
                    cmd.Parameters.AddWithValue("@Longitude", longitude);
                    cmd.Parameters.AddWithValue("@UserId", userid);

                    conn.Open();
                    cmd.ExecuteNonQuery();
                }

                return "Success";
            }
            catch (Exception ex)
            {
                return "Error: " + ex.Message;
            }
        }

    }
}