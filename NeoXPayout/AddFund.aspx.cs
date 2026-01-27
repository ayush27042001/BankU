using Newtonsoft.Json.Linq;
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
    public partial class AddFund : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString;
        UserManagement Um = new UserManagement();
        SqlCommand com = new SqlCommand();
        SqlDataAdapter da = new SqlDataAdapter();
        SqlDataAdapter da1 = new SqlDataAdapter();
        DataSet ds = new DataSet();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (this.Session["BankURTName"] == null || !(Session["IsMPINVerified"] is bool isVerified && isVerified))
            {
                Response.Redirect("LoginBankU.aspx");
            }
            else
            {
                if (!IsPostBack)
                {
                    if (Session["ShowSuccessModal"] != null)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(),
                      "showSuccessModal", "var myModal = new bootstrap.Modal(document.getElementById('successModal')); myModal.show();", true);


                        Session.Remove("ShowSuccessModal");
                    }

                    // Check for error modal flag
                    else if (Session["ShowErrorModal"] != null)
                    {
                        string msg = Session["ErrorMsg"]?.ToString();
                        if (string.IsNullOrWhiteSpace(msg))
                        {
                            msg = "No error message available.";
                        }
                        lblmsg.Text = msg;

                        ScriptManager.RegisterStartupScript(this, this.GetType(),
                           "showErrorModal", "var myModal = new bootstrap.Modal(document.getElementById('errorModal')); myModal.show();", true);


                        Session.Remove("ShowErrorModal");
                    }
                   
                    LoadBillPayments();
                    string User = this.Session["BankURTUID"].ToString();
                    string url = "https://partner.banku.co.in/api/GetUserBalance";
                    string body = "{\"UserId\":\"" + User + "\",\"Apiversion\":\"" + "1.0" + "\"}";
                    string Apiresponse = String.Empty;
                    var client = new RestClient(url);
                    var request = new RestRequest(Method.POST);
                    request.AddHeader("cache-control", "no-cache");
                    request.AddHeader("Accept", "application/json");
                    request.AddHeader("Content-Type", "application/json");
                    request.AddParameter("application/json", body, RestSharp.ParameterType.RequestBody);
                    IRestResponse response = client.Execute(request);
                    Apiresponse = response.Content;

                    try
                    {
                        JObject jObject = JObject.Parse(Apiresponse);
                        string scode = jObject["Status"]?.ToString();

                        // Safe check before accessing "Data"
                        if (scode == "SUCCESS" && jObject["Data"] != null && jObject["Data"].Type == JTokenType.Array)
                        {
                            JArray dataArray = (JArray)jObject["Data"];

                            if (dataArray.Count > 0)
                            {
                                string currentBalance = dataArray[0]["CurrentBalance"]?.ToString();
                                txtCurrBal.Text = currentBalance;
                            }
                            else
                            {
                                txtCurrBal.Text = "0.00";
                            }
                        }
                        else
                        {
                            txtCurrBal.Text = "0.00";
                        }
                    }
                    catch
                    {
                     
                        txtCurrBal.Text = "0.00";
                    }

                }
            }

        }

        protected void LoadBillPayments()
        {
            string UserId = Session["BankURTUID"].ToString();
            string cs = ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString;

            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = "SELECT * FROM dbo.AddFund WHERE UserId = @UserId ORDER BY ReqDate DESC";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@UserId", UserId);

                con.Open();
                rptFund.DataSource = cmd.ExecuteReader();
                rptFund.DataBind();
                con.Close();
            }

            // 🔹 Get today's summary
            using (SqlConnection con = new SqlConnection(cs))
            {
                string summaryQuery = @"
                SELECT  COUNT(*) AS TxnCount,  ISNULL(SUM(Amount),0) AS TotalValue,  ISNULL(AVG(Amount),0) AS AvgValue FROM dbo.AddFund  WHERE UserId = @UserId  AND CAST(ReqDate AS DATE) = CAST(GETDATE() AS DATE)  AND Status = 'Success'";

                SqlCommand summaryCmd = new SqlCommand(summaryQuery, con);
                summaryCmd.Parameters.AddWithValue("@UserId", UserId);

                con.Open();
                SqlDataReader reader = summaryCmd.ExecuteReader();
                if (reader.Read())
                {
                    lblTxnToday.Text = reader["TxnCount"].ToString();
                    lblTotalValue.Text = "₹" + Convert.ToDecimal(reader["TotalValue"]).ToString("N2");
                    lblAvgValue.Text = "₹" + Convert.ToDecimal(reader["AvgValue"]).ToString("N2");
                }
                reader.Close();
            }
        }


        //public string apipassword(string uid)
        //{

        //    string ProductId = uid;
        //    string query = "select TOP 1* from  tblapiusers where Id=@ProductId order by Id desc";
        //    SqlCommand mcom = new SqlCommand(query, con);
        //    mcom.Parameters.AddWithValue("@ProductId", ProductId);
        //    SqlDataAdapter mda = new SqlDataAdapter(mcom);
        //    DataTable dt = new DataTable();
        //    mda.Fill(dt);
        //    string mainbalance;
        //    if (dt.Rows.Count > 0)
        //    {
        //        mainbalance = dt.Rows[0]["Password"].ToString();
        //    }
        //    else
        //    {
        //        mainbalance = "0";
        //    }
        //    return mainbalance;
        //}
        public string CreateUPIOrder(string order_id, int txn_amount, string APIName)
        {
            string User = this.Session["BankURTUID"].ToString();
            try
            {
                string customer_name = Session["BankURTName"].ToString();
                string customer_mobile = Session["BankURTMobileno"].ToString();
                string customer_email = Session["BankURTEmail"].ToString();
                //string password = apipassword(Session["NeoxWLId"].ToString());
                //string ApiKey = Session["NeoxApikey"].ToString();
                string callback_url = "TransactionDone.aspx";
                string Apiresponse = String.Empty;
                string url = "https://allapi.in/order/create";
                string body = "{ \"token\":\"" + "4a33cc-594dcc-2b6c9b-c062fa-9ac491" + "\",\"order_id\":\"" + order_id + "\",\"txn_amount\":\"" + txn_amount + "\",\"txn_note\":\"" + "Add Fund" + "\",\"product_name\":\"" + "Add Fund" + "\",\"customer_name\":\"" + customer_name + "\",\"customer_mobile\":\"" + customer_mobile + "\",\"customer_email\":\"" + customer_email + "\",\"redirect_url\":\"" + callback_url + "\"}";
                var client = new RestClient(url);
                var request = new RestRequest(Method.POST);

                request.AddHeader("cache-control", "no-cache");
                request.AddHeader("Accept", "application/json");
                request.AddHeader("Content-Type", "application/json");
                request.AddParameter("application/json", body, RestSharp.ParameterType.RequestBody);
                IRestResponse response = client.Execute(request);
                Apiresponse = response.Content;
                Um.LogApiCall(User, body, Apiresponse, "AddFundOrder");
                return Apiresponse;
            }
            catch
            {
                return "-1";
            }
        }
        protected void Checkstatus()
        {
            string User = this.Session["BankURTUID"].ToString();
            try
            {
                string order_id = getLastOrderId();
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
                Um.LogApiCall(User, body, Apiresponse, "AddFundStatus");
                JObject jObjects = JObject.Parse(Apiresponse);
                decimal amount = 0;

                string scode = jObjects["status"].ToString().ToUpper();
                if (scode == "TRUE")
                {
                    JObject resultObj = (JObject)jObjects["results"];
                    string paymentStatus = resultObj["status"]?.ToString().ToUpper();

                    if (decimal.TryParse(resultObj["txn_amount"]?.ToString(), out decimal amt))
                        amount = amt;

                    // Step 1: Check if already processed
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
                                alreadyProcessed = true;
                        }
                    }

                    if (alreadyProcessed)
                    {
                        Session["ShowSuccessModal"] = true;
                        Response.Redirect(Request.RawUrl, false);
                        Context.ApplicationInstance.CompleteRequest();
                        return;
                    }

                    // Step 2: Update Addfund
                    using (SqlConnection conn = new SqlConnection(connStr))
                    {
                        string updateQuery = @" UPDATE dbo.Addfund SET Status = @status, AmountPaid=@AmountPaid, ApiResponse = @ApiResponse  WHERE OrderId = @OrderId";

                        using (SqlCommand cmd = new SqlCommand(updateQuery, conn))
                        {
                            cmd.Parameters.AddWithValue("@status", paymentStatus == "SUCCESS" ? "Success" : "Failed");
                            cmd.Parameters.AddWithValue("@AmountPaid", paymentStatus == "SUCCESS" ? amount : 0);
                            cmd.Parameters.AddWithValue("@ApiResponse", Apiresponse);
                            cmd.Parameters.AddWithValue("@OrderId", order_id);
                            conn.Open();
                            cmd.ExecuteNonQuery();
                        }
                    }

                    // Step 3: Add balance
                    if (paymentStatus == "SUCCESS")
                    {
                        string UserId = Session["BankURTUID"].ToString();
                        decimal balance = Convert.ToDecimal(Um.GetBalance(UserId));
                        decimal newBalance = balance + amount;

                        string con = ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString;
                        using (SqlConnection conn = new SqlConnection(con))
                        {
                            string query = @"INSERT INTO tbluserbalance
                    (Old_Bal, Amount, New_Bal, TxnType, crDrType, UserId, Remarks, TxnDatetime)
                    VALUES (@Old_Bal, @Amount, @New_Bal, @TxnType, @crDrType, @UserId, @Remarks, @TxnDatetime);";

                            using (SqlCommand cmd = new SqlCommand(query, conn))
                            {
                                cmd.Parameters.AddWithValue("@Old_Bal", balance);
                                cmd.Parameters.AddWithValue("@Amount", amount);
                                cmd.Parameters.AddWithValue("@New_Bal", newBalance);
                                cmd.Parameters.AddWithValue("@TxnType", "Fund Added By User");
                                cmd.Parameters.AddWithValue("@crDrType", "Credit");
                                cmd.Parameters.AddWithValue("@UserId", UserId);
                                cmd.Parameters.AddWithValue("@Remarks", "Amount Added By user");
                                cmd.Parameters.AddWithValue("@TxnDatetime", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss.fff"));

                                conn.Open();
                                cmd.ExecuteNonQuery();
                            }
                        }

                        Session["ShowSuccessModal"] = true;
                        Response.Redirect(Request.RawUrl, false);
                        Context.ApplicationInstance.CompleteRequest();
                        return;
                    }
                    else
                    {
                        Session["ShowErrorModal"] = true;
                        Response.Redirect(Request.RawUrl, false);
                        Context.ApplicationInstance.CompleteRequest();
                        return;
                    }
                }
                else
                {
                    Session["ShowErrorModal"] = true;
                    Response.Redirect(Request.RawUrl, false);
                    Context.ApplicationInstance.CompleteRequest();
                    return;
                }
            }
            catch (Exception ex)
            {
                Session["ErrorMsg"] = ex.ToString();
                Session["ShowErrorModal"] = true;
                Response.Redirect(Request.RawUrl, false);
                Context.ApplicationInstance.CompleteRequest();
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

        protected void btnAddFund_Click(object sender, EventArgs e)
        {
            if (txtAmount.Text == "")
            {
                Label1.Text = "Please Enter Amount";

            }
            else
            {
                string orderid = "ORD" + Session["BankURTUID"].ToString() + "M" + DateTime.Now.ToString("yyyyMMddHHmmssfff");
                string content = CreateUPIOrder(orderid, Convert.ToInt32(txtAmount.Text), "BANKUP2");
                try
                {
                    if (string.IsNullOrWhiteSpace(content))
                    {
                        lblerror2.Text = "Empty API response. Please try again later.";
                        return;
                    }

                    JObject jObject;
                    try
                    {
                        jObject = JObject.Parse(content);
                    }
                    catch (Exception)
                    {
                        lblerror2.Text = "Invalid response format. Please try again.";
                        return;
                    }

                    // Safely extract fields
                    string status = jObject["status"]?.ToString()?.ToUpper() ?? "FALSE";
                    string message = jObject["message"]?.ToString() ?? "Unknown error.";

                    // Handle error or false status
                    if (status != "TRUE")
                    {
                        lblerror2.Text = message;  
                        return;
                    }

                    // Continue only if status == TRUE
                    JObject results = jObject["results"] as JObject;
                    if (results == null)
                    {
                        lblerror2.Text = "Invalid result data from API.";
                        return;
                    }

                    string qrImageBase64 = results["qr_image"]?.ToString();
                    string txn_id = results["txn_id"]?.ToString() ?? "";
                    string paymentUrl = results["payment_url"]?.ToString() ?? "";

                    string bhim = results["upi_intent"]?["bhim"]?.ToString() ?? "";
                    string phonepe = results["upi_intent"]?["phonepe"]?.ToString() ?? "";
                    string paytm = results["upi_intent"]?["paytm"]?.ToString() ?? "";
                    string gpay = results["upi_intent"]?["gpay"]?.ToString() ?? "";

                    // Insert transaction in DB
                    string sqlfr = @"INSERT INTO dbo.Addfund
        (Wlid, UserId, UserName, Amount, OrderId, TxnId, Status, ReqDate, Reqlogs)
        VALUES
        (@Wlid, @UserId, @UserName, @Amount, @OrderId, @TxnId, @Status, @ReqDate, @Reqlogs)";

                    using (SqlConnection con = new SqlConnection(connStr))
                    using (SqlCommand cmdfr = new SqlCommand(sqlfr, con))
                    {
                        cmdfr.Parameters.AddWithValue("@Wlid", "");
                        cmdfr.Parameters.AddWithValue("@UserId", Session["BankURTUID"].ToString());
                        cmdfr.Parameters.AddWithValue("@UserName", Session["BankURTName"].ToString());
                        cmdfr.Parameters.AddWithValue("@Amount", txtAmount.Text);
                        cmdfr.Parameters.AddWithValue("@TxnId", txn_id);
                        cmdfr.Parameters.AddWithValue("@Status", "Pending");
                        cmdfr.Parameters.AddWithValue("@Reqlogs", content);
                        cmdfr.Parameters.AddWithValue("@ReqDate", DateTime.Now);
                        cmdfr.Parameters.AddWithValue("@OrderId", orderid);

                        con.Open();
                        cmdfr.ExecuteNonQuery();
                    }

                    // Show Payment Sidebar
                    lblAmount.Text = "Amount: ₹" + (txtAmount.Text ?? "0.00");
                    paymentQrImage.ImageUrl = qrImageBase64;

                    string script = "var myOffcanvas = new bootstrap.Offcanvas(document.getElementById('paymentSidebar')); myOffcanvas.show();";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "showPaymentSidebar", script, true);

                    LoadBillPayments();
                    txtAmount.Text = "";
                    Label1.Text = "";
                }
                catch (Exception ex)
                {
                    // Catch any unexpected error safely
                    lblerror2.Text = "An error occurred: " + ex.Message;
                }
            }
        }

        //protected void btnPayment_Click(object sender, EventArgs e)
        //{
        //    Checkstatus();
        //}

        protected void btnCheckStatus_Click(object sender, EventArgs e)
        {
            Checkstatus();
        }

        //protected void forcecheck_Click(object sender, EventArgs e)
        //{
        //    Checkstatus();
        //}
    }
}