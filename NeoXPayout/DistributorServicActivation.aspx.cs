using RestSharp;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NeoXPayout
{
    public partial class DistributorServicActivation : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString);
        UserManagement um = new UserManagement();
        protected void Page_Load(object sender, EventArgs e)
        {
            string Acctype = (Session["AccountHolderType"]?.ToString() ?? "").Trim().ToUpper();
            if (this.Session["BankURTName"] == null || !(Session["IsMPINVerified"] is bool isVerified && isVerified))
            {
                Response.Redirect("LoginBankU.aspx");

            }
            if (Acctype != "DISTRIBUTOR")
            {
                Response.Redirect("Dashboard.aspx");
            }
            if (!IsPostBack)
            {
                LoadProcessingButtons();
            }

        }
        protected void lnkSaveToDB_Click(object sender, EventArgs e)
        {

            string TeamSize = txtUseCase.Text.Trim();
            string title = Request.Form["selected-api-title"];
            string MobileNo = Session["mobileno"].ToString();
            string userId = Session["BankURTUID"].ToString();
            string Name = Session["BankURTName"].ToString();

            if (string.IsNullOrEmpty(userId) || string.IsNullOrEmpty(title))
            {
                ClientScript.RegisterStartupScript(this.GetType(), "popup", "alert('Missing required data.');", true);
                return;
            }

            string checkQuery = "SELECT COUNT(*) FROM DistAcctiveRequest WHERE UserId = @UserId AND Title = @Title";
            SqlCommand checkCmd = new SqlCommand(checkQuery, con);
            checkCmd.Parameters.AddWithValue("@UserId", userId);
            checkCmd.Parameters.AddWithValue("@Title", title);
            con.Open();
            int count = (int)checkCmd.ExecuteScalar();
            con.Close();

            if (count > 0)
            {
                LoadProcessingButtons(); // Initial load
                ClientScript.RegisterStartupScript(this.GetType(), "popup", "alert('This request is already in Processing.');", true);
                return;
            }
            string ReqId = "DIS" + DateTime.Now.ToString("yyyyMMdd") + "-" + new Random().Next(1000, 9999);
           
            string sqlfr12 = "insert into DistAcctiveRequest(UserId,Title,ReqId,Status,ReqDate,TeamSize)values(@UserId,@Title,@ReqId,@Status, @ReqDate,@TeamSize);";
            SqlCommand cmdfr12 = new SqlCommand(sqlfr12, con);
            cmdfr12.Parameters.AddWithValue("@UserId", userId);
            cmdfr12.Parameters.AddWithValue("@Title", title);
            cmdfr12.Parameters.AddWithValue("@ReqId", ReqId);
            cmdfr12.Parameters.AddWithValue("@TeamSize", TeamSize);
            cmdfr12.Parameters.AddWithValue("@Status", "Processing");
            cmdfr12.Parameters.Add("@ReqDate", SqlDbType.DateTime).Value = DateTime.Now;
            con.Open();
            int rowsAffected = cmdfr12.ExecuteNonQuery();
            con.Close();

            if (rowsAffected > 0)
            {
                LoadProcessingButtons();
                um.ProcessMsg(MobileNo, title, Name, ReqId);
                //sendsms();
                ClientScript.RegisterStartupScript(this.GetType(), "popup",
                    "Swal.fire({ " +
                    "icon: 'success', " +
                    "title: 'Request Added', " +
                    "text: 'Your request has been submitted successfully!', " +
                    "confirmButtonColor: '#3085d6', " +
                    "confirmButtonText: 'OK' " +
                    "});", true);


            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "popup",
                    "Swal.fire({ " +
                    "icon: 'error', " +
                    "title: 'Oops...', " +
                    "text: 'Something went wrong! Please try again later.', " +
                    "confirmButtonColor: '#d33', " +
                    "confirmButtonText: 'Close' " +
                    "});", true);
            }


        }

        public string sendsms()
        {
            string MobileNo = Session["mobileno"].ToString();
            string msg = "Dear" + MobileNo + ", your request for{#var#} Request ID: {#var#} has been successfully approved. You can now access this service via your dashboard. – BankU India | help@banku.co.in";
            try
            {
                //WBTXSL
                string Message = msg.ToString().Trim();
                string MobileNumber = MobileNo;
                string strUrl = "http://sms.webtextsolution.com/sms-panel/api/http/index.php?username=INTSALITE&apikey=90852-AB6E3&apirequest=Text&sender=BANKUI&mobile=" + MobileNumber + "&message=" + Message + "&route=TRANS&TemplateID=1707175178872908463&format=JSON";
                var client = new RestSharp.RestClient(strUrl);
                var request = new RestRequest(Method.GET);
                IRestResponse response = client.Execute(request);
                var content = response.Content;
                return "1";
            }
            catch
            {
                return "-1";
            }
        }
        private void LoadProcessingButtons()
        {
            string userId = Session["BankURTUID"]?.ToString();
            if (!string.IsNullOrEmpty(userId))
            {
                var apiStatusList = new List<object>();
                string sql = "SELECT Title, Status FROM DistAcctiveRequest WHERE UserId = @UserId AND (Status = 'Processing' OR Status = 'Approved'  OR Status = 'Rejected')";
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

    }
}