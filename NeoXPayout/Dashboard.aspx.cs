using Newtonsoft.Json.Linq;
using RestSharp;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NeoXPayout
{
    public partial class Dashboard : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString);
        SqlCommand com = new SqlCommand();
        SqlDataAdapter da = new SqlDataAdapter();
        SqlDataAdapter da1 = new SqlDataAdapter();
        DataSet ds = new DataSet();
        UserManagement  Um = new  UserManagement();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (this.Session["BankURTName"] == null || !(Session["IsMPINVerified"] is bool isVerified && isVerified))
            {
                Response.Redirect("LoginBankU.aspx");
            }
            if (!IsPostBack)
            {
                // APIbindbal(this.Session["BankURTUID"].ToString());
                //Label1.Text = this.Session["BankURTName"].ToString();
                //lblmainwallet.Text = "0.00";
                //LoadNotification();
                LoadWalletSummary();
                string Acctype = (Session["AccountHolderType"]?.ToString() ?? "").Trim().ToUpper();
                if (Acctype == "BANKU SEVA KENDRA")
                {
                    pnlBsk.Visible = true;
                }
                else
                {
                    pnlElse.Visible = true;
                }

                Label10.Text = "XXXX-XXXX-XXXX-" + Session["BankURTUID"].ToString();

                string mobile = Session["BankURTMobileno"]?.ToString();
                if (!string.IsNullOrEmpty(mobile) && mobile.Length >= 4)
                {
                    //Label8.Text = "XX-XXXX-" + mobile.Substring(mobile.Length - 4);
                }
                else
                {
                    Label10.Text = "XX-XXXX-XXXX";
                }

                string UserID = this.Session["BankURTUID"].ToString();
                string balance = Um.GetBalance(UserID);
                Label3.Text = balance;
                
            }

        }

        //public void LoadNotification()
        //{
        //    string query = "SELECT TOP 1 NotificationID, Content FROM Notifications WHERE Status='Active' ORDER BY NotificationID DESC";
        //    SqlCommand cmd = new SqlCommand(query, con);
        //    SqlDataAdapter da = new SqlDataAdapter(cmd);
        //    DataTable dt = new DataTable();
        //    da.Fill(dt);

        //    if (dt.Rows.Count > 0)
        //    {

        //        lblNotificationContent.Text = dt.Rows[0]["Content"].ToString();
        //        ViewState["NotificationID"] = dt.Rows[0]["NotificationID"].ToString();
        //    }
        //    else
        //    {
        //        lblNotificationContent.Text = "";
        //        ViewState["NotificationID"] = null;
        //    }
        //}

        //protected void btnClose_Click(object sender, EventArgs e)
        //{
        //    if (ViewState["NotificationID"] != null)
        //    {
        //        string id = ViewState["NotificationID"].ToString();

        //        string query = "UPDATE Notifications SET Status='Inactive' WHERE NotificationID=@id";
        //        SqlCommand cmd = new SqlCommand(query, con);
        //        cmd.Parameters.AddWithValue("@id", id);

        //        con.Open();
        //        cmd.ExecuteNonQuery();
        //        con.Close();


        //        LoadNotification();
        //    }
        //}

        private void LoadWalletSummary()
        {
            decimal totalCredit = 0;
            decimal totalDebit = 0;
            string UserId = Session["BankURTUID"].ToString();
                

            using (con)
            {
                con.Open();


                using (SqlCommand cmd = new SqlCommand("SELECT ISNULL(SUM(Amount),0) FROM tbluserbalance WHERE  (CrDrType='Credit' OR CrDrType='CR') AND UserId=@UserID AND TxnType = 'Fund Added By User'", con))
                {
                    cmd.Parameters.AddWithValue("@UserId", UserId);
                    totalCredit = Convert.ToDecimal(cmd.ExecuteScalar());
                }

                using (SqlCommand cmd = new SqlCommand("SELECT ISNULL(SUM(Amount),0) FROM TxnReport WHERE Status='SUCCESS' AND UserId=@UserID", con))
                {
                    cmd.Parameters.AddWithValue("@UserId", UserId);
                    totalDebit = Convert.ToDecimal(cmd.ExecuteScalar());
                }
            }

            lblMoneyIn.Text = "₹" + totalCredit.ToString("0.00");
            lblMoneyOut.Text = "₹" + totalDebit.ToString("0.00");
        }

        [WebMethod(EnableSession = true)]
        public static object GetLastOrderId()
        {
            string lastOrderId = "";
            string userId = Convert.ToString(HttpContext.Current.Session["BankURTUID"]);

            if (string.IsNullOrEmpty(userId))
            {
                return new
                {
                    Status = "FAILED",
                    Message = "Session expired"
                };
            }

            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString))
            {
                string query = @"
                SELECT TOP 1 OrderId
                FROM dbo.Addfund
                WHERE UserId = @UserId AND Status = @Status
                ORDER BY ReqDate DESC";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@UserId", userId);
                    cmd.Parameters.AddWithValue("@Status", "Pending");

                    conn.Open();
                    object result = cmd.ExecuteScalar();

                    if (result != null)
                    {
                        lastOrderId = result.ToString();
                    }
                }
            }

            return new
            {
                Status = "SUCCESS",
                Data = lastOrderId
            };
        }
        //protected void Checkstatus()
        //{
        //    string User = this.Session["BankURTUID"].ToString();
        //    try
        //    {
        //        string order_id = getLastOrderId();
        //        string Apiresponse = String.Empty;
        //        string url = "https://allapi.in/order/status";
        //        string body = "{ \"token\":\"" + "4a33cc-594dcc-2b6c9b-c062fa-9ac491" + "\",\"order_id\":\"" + order_id + "\"}";
        //        var client = new RestClient(url);
        //        var request = new RestRequest(Method.POST);
        //        request.AddHeader("cache-control", "no-cache");
        //        request.AddHeader("Accept", "application/json");
        //        request.AddHeader("Content-Type", "application/json");
        //        request.AddParameter("application/json", body, RestSharp.ParameterType.RequestBody);
        //        IRestResponse response = client.Execute(request);
        //        Apiresponse = response.Content;
        //        Um.LogApiCall(User, body, Apiresponse, "AddFundStatus");
        //        JObject jObjects = JObject.Parse(Apiresponse);
        //        decimal amount = 0;

        //        string scode = jObjects["status"].ToString().ToUpper();
        //        if (scode == "TRUE")
        //        {
        //            JObject resultObj = (JObject)jObjects["results"];
        //            string paymentStatus = resultObj["status"]?.ToString().ToUpper();

        //            if (decimal.TryParse(resultObj["txn_amount"]?.ToString(), out decimal amt))
        //                amount = amt;


        //            // Step 2: Update Addfund
        //            using (con)
        //            {
        //                string updateQuery = @"
        //            UPDATE dbo.Addfund
        //            SET Status = @status, AmountPaid=@AmountPaid, ApiResponse = @ApiResponse
        //            WHERE OrderId = @OrderId";

        //                using (SqlCommand cmd = new SqlCommand(updateQuery, con))
        //                {
        //                    cmd.Parameters.AddWithValue("@status", paymentStatus == "SUCCESS" ? "Success" : "Failed");
        //                    cmd.Parameters.AddWithValue("@AmountPaid", paymentStatus == "SUCCESS" ? amount : 0);
        //                    cmd.Parameters.AddWithValue("@ApiResponse", Apiresponse);
        //                    cmd.Parameters.AddWithValue("@OrderId", order_id);
        //                    con.Open();
        //                    cmd.ExecuteNonQuery();
        //                }
        //            }

        //            // Step 3: Add balance
        //            if (paymentStatus == "SUCCESS")
        //            {
        //                string UserId = Session["BankURTUID"].ToString();
        //                decimal balance = Convert.ToDecimal(Um.GetBalance(UserId));
        //                decimal newBalance = balance + amount;

        //                string con = ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString;
        //                using (SqlConnection conn = new SqlConnection(con))
        //                {
        //                    string query = @"INSERT INTO tbluserbalance
        //            (Old_Bal, Amount, New_Bal, TxnType, crDrType, UserId, Remarks, TxnDatetime)
        //            VALUES (@Old_Bal, @Amount, @New_Bal, @TxnType, @crDrType, @UserId, @Remarks, @TxnDatetime);";

        //                    using (SqlCommand cmd = new SqlCommand(query, conn))
        //                    {
        //                        cmd.Parameters.AddWithValue("@Old_Bal", balance);
        //                        cmd.Parameters.AddWithValue("@Amount", amount);
        //                        cmd.Parameters.AddWithValue("@New_Bal", newBalance);
        //                        cmd.Parameters.AddWithValue("@TxnType", "Fund Added By User");
        //                        cmd.Parameters.AddWithValue("@crDrType", "Credit");
        //                        cmd.Parameters.AddWithValue("@UserId", UserId);
        //                        cmd.Parameters.AddWithValue("@Remarks", "Amount Added By user");
        //                        cmd.Parameters.AddWithValue("@TxnDatetime", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss.fff"));

        //                        conn.Open();
        //                        cmd.ExecuteNonQuery();
        //                    }
        //                }

        //                //Session["ShowSuccessModal"] = true;
        //                //Response.Redirect(Request.RawUrl, false);
        //                //Context.ApplicationInstance.CompleteRequest();
        //                return;
        //            }
        //            else
        //            {
        //                //Session["ShowErrorModal"] = true;
        //                //Response.Redirect(Request.RawUrl, false);
        //                //Context.ApplicationInstance.CompleteRequest();
        //                return;
        //            }
        //        }
        //        else
        //        {
        //            //Session["ShowErrorModal"] = true;
        //            //Response.Redirect(Request.RawUrl, false);
        //            //Context.ApplicationInstance.CompleteRequest();
        //            return;
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        //Session["ErrorMsg"] = ex.ToString();
        //        //Session["ShowErrorModal"] = true;
        //        //Response.Redirect(Request.RawUrl, false);
        //        //Context.ApplicationInstance.CompleteRequest();
        //    }
        //}
        [WebMethod(EnableSession = true)]
        public static object CheckstatusAjax()
        {
            UserManagement um = new UserManagement();
            try
            {
                string userId = Convert.ToString(HttpContext.Current.Session["BankURTUID"]);
                if (string.IsNullOrEmpty(userId))
                {
                    return new { Status = "FAILED", Message = "Session expired" };
                }

                string connStr = ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString;

              
                string orderId = "";
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    string q = @"SELECT TOP 1 OrderId FROM dbo.Addfund WHERE UserId=@UserId AND Status='Pending'  ORDER BY ReqDate DESC";

                    using (SqlCommand cmd = new SqlCommand(q, conn))
                    {
                        cmd.Parameters.AddWithValue("@UserId", userId);
                        conn.Open();
                        object r = cmd.ExecuteScalar();
                        if (r != null) orderId = r.ToString();
                    }
                }

                if (string.IsNullOrEmpty(orderId))
                {
                    return new { Status = "FAILED", Message = "No pending order found" };
                }

                string apiUrl = "https://allapi.in/order/status";
                string body = $"{{\"token\":\"4a33cc-594dcc-2b6c9b-c062fa-9ac491\",\"order_id\":\"{orderId}\"}}";

                var client = new RestClient(apiUrl);
                var request = new RestRequest(Method.POST);
                request.AddHeader("Accept", "application/json");
                request.AddHeader("Content-Type", "application/json");
                request.AddParameter("application/json", body, ParameterType.RequestBody);

                var response = client.Execute(request);
                string apiResponse = response.Content;

                um.LogApiCall(userId, body, apiResponse, "AddFundStatus");

                JObject jobj = JObject.Parse(apiResponse);
                if (jobj["status"]?.ToString().ToUpper() != "TRUE")
                {
                    return new { Status = "FAILED", Message = "API returned false" };
                }

                JObject result = (JObject)jobj["results"];
                string paymentStatus = result["status"]?.ToString().ToUpper();
                decimal amount = Convert.ToDecimal(result["txn_amount"] ?? 0);

               
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    string uq = @"UPDATE dbo.Addfund SET Status=@Status, AmountPaid=@AmountPaid, ApiResponse=@ApiResponse WHERE OrderId=@OrderId";

                    using (SqlCommand cmd = new SqlCommand(uq, conn))
                    {
                        cmd.Parameters.AddWithValue("@Status", paymentStatus == "SUCCESS" ? "Success" : "Failed");
                        cmd.Parameters.AddWithValue("@AmountPaid", paymentStatus == "SUCCESS" ? amount : 0);
                        cmd.Parameters.AddWithValue("@ApiResponse", apiResponse);
                        cmd.Parameters.AddWithValue("@OrderId", orderId);
                        conn.Open();
                        cmd.ExecuteNonQuery();
                    }
                }

              
                if (paymentStatus == "SUCCESS")
                {

                    decimal oldBal = Convert.ToDecimal(um.GetBalance(userId));
                    decimal newBal = oldBal + amount;

                    using (SqlConnection conn = new SqlConnection(connStr))
                    {
                        string iq = @"INSERT INTO tbluserbalance (Old_Bal, Amount, New_Bal, TxnType, crDrType, UserId, Remarks, TxnDatetime)  VALUES (@Old_Bal,@Amount,@New_Bal,@TxnType,@crDrType,@UserId,@Remarks,@TxnDatetime)";

                        using (SqlCommand cmd = new SqlCommand(iq, conn))
                        {
                            cmd.Parameters.AddWithValue("@Old_Bal", oldBal);
                            cmd.Parameters.AddWithValue("@Amount", amount);
                            cmd.Parameters.AddWithValue("@New_Bal", newBal);
                            cmd.Parameters.AddWithValue("@TxnType", "Fund Added By User");
                            cmd.Parameters.AddWithValue("@crDrType", "Credit");
                            cmd.Parameters.AddWithValue("@UserId", userId);
                            cmd.Parameters.AddWithValue("@Remarks", "Amount Added By user");
                            cmd.Parameters.AddWithValue("@TxnDatetime", DateTime.Now);
                            conn.Open();
                            cmd.ExecuteNonQuery();
                        }
                    }
                }

                return new
                {
                    Status = "SUCCESS",
                    PaymentStatus = paymentStatus,
                    Amount = amount,
                    OrderId = orderId
                };
            }
            catch (Exception ex)
            {
                return new { Status = "FAILED", Message = ex.Message };
            }
        }


        public string ApiBalanceCreditByAdmin(int ToUserKey, string transaction_type, string remarks, decimal amount, string Username)
        {
            try
            {

                string Pay_Ref_id = ToUserKey + DateTime.Now.ToString("yyMMddHHmmssfff");
                decimal oldbalance = Convert.ToDecimal(APIbindbal(ToUserKey.ToString()));

                decimal newbal = oldbalance + amount;
                // string rem = transaction_type + " For Account No " + Accountno + "| Credit by Services | " + remarks + " ";
                string rem = "Amount Credited to " + Username + "| Credited by Admin | " + remarks + " ";
                string sqlb1 = "insert into WlUserWallet(Wlid,UserId,Old_Bal,Amount,New_Bal,TxnType,Remarks,Txn_Date,Ip_Address,Cr_Dr_Type,Pay_Ref_id)values(@Wlid,@UserId,@Old_Bal,@Amount,@New_Bal,@TxnType,@Remarks,@Txn_Date,@Ip_Address,@Cr_Dr_Type,@Pay_Ref_id)";
                SqlCommand cmdb1 = new SqlCommand(sqlb1, con);
                cmdb1.Parameters.AddWithValue("@Wlid", Session["NeoxWLId"].ToString());
                cmdb1.Parameters.AddWithValue("@Pay_Ref_id", Pay_Ref_id);
                cmdb1.Parameters.AddWithValue("@UserId", ToUserKey);
                cmdb1.Parameters.AddWithValue("@Old_Bal", oldbalance);
                cmdb1.Parameters.AddWithValue("@New_Bal", newbal);
                cmdb1.Parameters.AddWithValue("@TxnType", transaction_type);
                cmdb1.Parameters.AddWithValue("@Txn_Date", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss.fff"));
                cmdb1.Parameters.AddWithValue("@Ip_Address", "000");
                cmdb1.Parameters.AddWithValue("@Cr_Dr_Type", "Credit");
                cmdb1.Parameters.AddWithValue("@Amount", amount);
                cmdb1.Parameters.AddWithValue("@Remarks", rem);
                con.Open();
                cmdb1.ExecuteNonQuery();
                con.Close();
                return "1";

            }
            catch
            {
                return "-1";
            }
        }
        public void updateinfo(string OrderId, string status)
        {
            string sqlfr1 = "Update Wlapionlinepayment set UpdateDate=@ResDate,Status=@Status where ClientRefId=@OrderId and UserId=@UserKey";
            SqlCommand cmdfr1 = new SqlCommand(sqlfr1, con);
            cmdfr1.Parameters.AddWithValue("@Status", status);
            cmdfr1.Parameters.AddWithValue("@OrderId", OrderId);
            cmdfr1.Parameters.AddWithValue("@UserKey", Session["NeoxUID"].ToString());
            cmdfr1.Parameters.AddWithValue("@ResDate", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss.fff"));
            con.Open();
            cmdfr1.ExecuteNonQuery();
            con.Close();
        }

        public string CreateUPIOrder(string order_id)
        {
            try
            {
                string ApiKey = Session["NeoxApikey"].ToString();
                string password = apipassword(Session["NeoxWLId"].ToString());
                string APIName = "BANKU";
                string Apiresponse = String.Empty;
                string url = "https://app.banku.co.in/api/CheckPaymentStatus";
                string body = "{ \"ApiKey\":\"" + ApiKey + "\",\"password\":\"" + password + "\",\"APIName\":\"" + APIName + "\",\"Client_refId\":\"" + order_id + "\"}";
                var client = new RestClient(url);
                var request = new RestRequest(Method.POST);
                request.AddHeader("cache-control", "no-cache");
                request.AddHeader("Accept", "application/json");
                request.AddHeader("Content-Type", "application/json");
                request.AddParameter("application/json", body, RestSharp.ParameterType.RequestBody);
                IRestResponse response = client.Execute(request);
                Apiresponse = response.Content;
                return Apiresponse;
            }
            catch
            {
                return "-1";
            }
        }
        public string bindlastTransactionOrderId()
        {
            string query = "select TOP 1* from  Wlapionlinepayment where UserId=@ProductId and Wlid=@Wlid and (Status=@Status or Status=@Status1) order by Id desc";
            SqlCommand mcom = new SqlCommand(query, con);
            mcom.Parameters.AddWithValue("@ProductId", Session["NeoxUID"].ToString());
            mcom.Parameters.AddWithValue("@Wlid", this.Session["NeoxWLId"].ToString());
            mcom.Parameters.AddWithValue("@Status", "Pending");
            mcom.Parameters.AddWithValue("@Status1", "PROCCESS");
            SqlDataAdapter mda = new SqlDataAdapter(mcom);
            DataTable dt = new DataTable();
            mda.Fill(dt);
            string mainbalance;
            if (dt.Rows.Count > 0)
            {
                mainbalance = dt.Rows[0]["ClientRefId"].ToString();
            }
            else
            {
                mainbalance = "NA";
            }
            return mainbalance;
        }
        public string successtotaltxn()
        {
            string from = DateTime.Now.ToString("yyyy-MM-dd");
            con.Open();
            string query = "select sum(Amount) as Totaltxnamt from Wlpayouttxn where ReqDate>=@TimeStampFrom and ReqDate<=@TimeStamp and Status=@Status and UserId=@UserId";
            SqlCommand mcom = new SqlCommand(query, con);
            mcom.Parameters.AddWithValue("@TimeStampFrom", from + " 00:00:00.000");
            mcom.Parameters.AddWithValue("@TimeStamp", from + " 23:59:59.000");
            mcom.Parameters.AddWithValue("@Status", "SUCCESS");
            mcom.Parameters.AddWithValue("@UserId", this.Session["NeoxUID"].ToString());
            SqlDataAdapter mda = new SqlDataAdapter(mcom);
            DataTable dt = new DataTable();
            mda.Fill(dt);
            string pc;
            if (dt.Rows.Count == 0)
            {
                pc = "0.00";
            }
            else
            {
                pc = dt.Rows[0]["Totaltxnamt"].ToString();
                if (pc == "")
                {
                    pc = "0.00";
                }
            }
            con.Close();
            return pc;
        }
        public string APIbindbal(string uid)
        {

            string ProductId = uid;
            string query = "select TOP 1* from  WlUserWallet where Userid=@ProductId order by Id desc";
            SqlCommand mcom = new SqlCommand(query, con);
            mcom.Parameters.AddWithValue("@ProductId", ProductId);
            SqlDataAdapter mda = new SqlDataAdapter(mcom);
            DataTable dt = new DataTable();
            mda.Fill(dt);
            string mainbalance;
            if (dt.Rows.Count > 0)
            {
                mainbalance = dt.Rows[0]["New_Bal"].ToString();
            }
            else
            {
                mainbalance = "0.00";
            }
            return mainbalance;
        }

        public string apipassword(string uid)
        {

            string ProductId = uid;
            string query = "select TOP 1* from  tblapiusers where Id=@ProductId order by Id desc";
            SqlCommand mcom = new SqlCommand(query, con);
            mcom.Parameters.AddWithValue("@ProductId", ProductId);
            SqlDataAdapter mda = new SqlDataAdapter(mcom);
            DataTable dt = new DataTable();
            mda.Fill(dt);
            string mainbalance;
            if (dt.Rows.Count > 0)
            {
                mainbalance = dt.Rows[0]["Password"].ToString();
            }
            else
            {
                mainbalance = "0";
            }
            return mainbalance;
        }
    }
}