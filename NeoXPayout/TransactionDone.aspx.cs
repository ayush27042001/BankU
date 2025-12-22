using Newtonsoft.Json.Linq;
using RestSharp;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NeoXPayout
{
    public partial class TransactionDone : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString;
        UserManagement Um = new UserManagement();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (this.Session["BankURTUID"] == null || !(Session["IsMPINVerified"] is bool isVerified && isVerified))
            {
                Response.Redirect("LoginBankU.aspx");
            }
            Checkstatus();
        }
        protected void Checkstatus()
        {
            try
            {
                string order_id=getLastOrderId();
                string Apiresponse = String.Empty;
                string url = "https://allapi.in/order/status";
                string body = "{ \"token\":\"" + "4a33cc-594dcc-2b6c9b-c062fa-9ac491" + "\",\"order_id\":\"" + order_id + "\"}";
                var client = new RestClient(url);
                var request = new RestRequest(Method.POST);
                request.AddHeader("cache-control", "no-cache");
                request.AddHeader("Accept", "application/json");
                request.AddHeader("Content-Type", "application/json");
                request.AddParameter("application/json", body, RestSharp.ParameterType.RequestBody);
                IRestResponse response = client.Execute(request);
                Apiresponse = response.Content;
                JObject jObjects = JObject.Parse(Apiresponse);

                string scode = jObjects["status"].ToString().ToUpper();
                if (scode == "TRUE")
                {
                    JObject resultObj = (JObject)jObjects["results"];
                    string paymentStatus = resultObj["status"]?.ToString().ToUpper();

                    // --- Step 1: Check if already processed ---
                    bool alreadyProcessed = false;
                    using (SqlConnection conn = new SqlConnection(connStr))
                    {
                        string checkQuery = "SELECT Status FROM dbo.Addfund WHERE OrderId = @OrderId";
                        using (SqlCommand cmd = new SqlCommand(checkQuery, conn))
                        {
                            cmd.Parameters.AddWithValue("@OrderId", order_id);
                            conn.Open();
                            var result = cmd.ExecuteScalar();
                            if (result != null && result.ToString().ToUpper() == "SUCCESS")
                            {
                                alreadyProcessed = true;
                            }
                        }
                    }

                    if (alreadyProcessed)
                    {
                        pnlSuccess.Visible = true;
                        pnlFailed.Visible = false;
                        return; // stop duplicate processing
                    }

                    // --- Step 2: Update Addfund status ---
                    using (SqlConnection conn = new SqlConnection(connStr))
                    {
                        string updateQuery = @"
        UPDATE dbo.Addfund
        SET Status = @status, ApiResponse = @ApiResponse
        WHERE OrderId = @OrderId";

                        using (SqlCommand cmd = new SqlCommand(updateQuery, conn))
                        {
                            cmd.Parameters.AddWithValue("@status", paymentStatus == "SUCCESS" ? "Success" : "Failed");
                            cmd.Parameters.AddWithValue("@ApiResponse", Apiresponse);
                            cmd.Parameters.AddWithValue("@OrderId", order_id);
                            conn.Open();
                            cmd.ExecuteNonQuery();
                        }
                    }

                    // --- Step 3: Add balance only if success ---
                    if (paymentStatus == "SUCCESS")
                    {
                        string UserId = Session["BankURTUID"].ToString();
                        decimal amount = Convert.ToDecimal(getLastOrderAmount());
                        decimal balance = Convert.ToDecimal(Um.GetBalance(UserId));
                        decimal newBalance = balance + amount;

                        string con = ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString;
                        using (SqlConnection conn = new SqlConnection(con))
                        {
                            string query = @"INSERT INTO tbluserbalance
                (Old_Bal, Amount, New_Bal, TxnType, crDrType, UserId, Remarks, TxnDatetime)
                VALUES (@Old_Bal, @Amount, @New_Bal, @TxnType, @crDrType, @UserId, @Remarks, GETDATE());";

                            using (SqlCommand cmd = new SqlCommand(query, conn))
                            {
                                cmd.Parameters.AddWithValue("@Old_Bal", balance);
                                cmd.Parameters.AddWithValue("@Amount", amount);
                                cmd.Parameters.AddWithValue("@New_Bal", newBalance);
                                cmd.Parameters.AddWithValue("@TxnType", "Fund Added By User");
                                cmd.Parameters.AddWithValue("@crDrType", "Credit");
                                cmd.Parameters.AddWithValue("@UserId", UserId);
                                cmd.Parameters.AddWithValue("@Remarks", "Amount Added By user");

                                conn.Open();
                                cmd.ExecuteNonQuery();
                            }
                        }

                        pnlSuccess.Visible = true;
                        pnlFailed.Visible = false;
                    }
                    else
                    {

                        using (SqlConnection conn = new SqlConnection(connStr))
                        {
                            string updateQuery = @"
                    UPDATE dbo.Addfund
                    SET Status = @status, ApiResponse = @ApiResponse
                    WHERE OrderId = @OrderId";

                            using (SqlCommand cmd = new SqlCommand(updateQuery, conn))
                            {
                                cmd.Parameters.AddWithValue("@status", "Failed");
                                cmd.Parameters.AddWithValue("@ApiResponse", Apiresponse);
                                cmd.Parameters.AddWithValue("@OrderId", order_id);
                                conn.Open();
                                cmd.ExecuteNonQuery();
                            }
                        }
                        pnlSuccess.Visible = false;
                        pnlFailed.Visible = true;
                    }
                }

            }
            catch
            {
                pnlSuccess.Visible = false;
                pnlFailed.Visible = true;
            }
        }
        protected string getLastOrderId()
        {
            string lastOrderId = string.Empty;
            string User = this.Session["BankURTUID"].ToString();
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = @"
                            SELECT TOP 1 OrderId
                FROM dbo.Addfund
                WHERE UserId = @UserId
                ORDER BY ReqDate DESC;";  

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@UserId", User);
                    conn.Open();
                    object result = cmd.ExecuteScalar();
                    if (result != null)
                    {
                        lastOrderId = result.ToString();
                    }
                }
            }

            return lastOrderId;
        }
        protected string getLastOrderAmount()
        {
            string lastOrderAmount = string.Empty;
            string User = this.Session["BankURTUID"].ToString();
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = @"
                SELECT TOP 1 Amount 
                FROM dbo.Addfund
                Where UserId = @UserId
                ORDER BY ReqDate DESC ;";  

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@UserId", User);
                    conn.Open();
                    object result = cmd.ExecuteScalar();
                    if (result != null)
                    {
                        lastOrderAmount = result.ToString();
                    }
                }
            }

            return lastOrderAmount;
        }
    }
}