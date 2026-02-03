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
    public partial class Payout : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString;
        UserManagement Um = new UserManagement();
        protected void Page_Load(object sender, EventArgs e)
        {
   
            if (Session["BankURTName"] == null || !(Session["IsMPINVerified"] is bool isVerified && isVerified))
            {
                Response.Redirect("LoginBankU.aspx");
            }
            if (!IsRechargeServiceActive())
            {
                pnlMain.Visible = false;
                pnlError.Visible = true;
               
                return;
            }

            if (!IsPostBack) 
            {
                string UserId = Session["BankURTUID"].ToString();
                string BankURTName = Session["BankURTName"].ToString();
                string MobNO = Session["mobileno"].ToString();
                hdnUserId.Value = UserId;
                hdnUserName.Value = BankURTName;
                hdnUserMob.Value = MobNO;
                getReport();
                DebitAcc.Text = Session["mobileno"].ToString();
            }   
        }

        private bool IsRechargeServiceActive()
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {

                string query = "SELECT Status FROM BankUServices WHERE ServiceName = @ServiceName";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@ServiceName", "payout");
                    con.Open();

                    object statusObj = cmd.ExecuteScalar();
                    if (statusObj == null || statusObj == DBNull.Value)
                        return false;

                    string status = statusObj.ToString();

                    return (status.Equals("Active", StringComparison.OrdinalIgnoreCase) || status == "1");
                }
            }
        }

        [System.Web.Services.WebMethod]
        public static string GetBalance()
        {
            string userid = HttpContext.Current.Session["BankURTUID"].ToString();
            UserManagement Um1 = new UserManagement();
            string balance = Um1.GetBalance(userid);
            return "₹ " + balance;
        }

        //protected void BankPayout_Click(object sender, EventArgs e)
        //{
        //    string UserId= Session["BankURTUID"].ToString();
        //    decimal balance = 0;
        //    decimal.TryParse(Um.GetBalance(UserId), out balance); 
        //    //string payoutTo = txtPayout.Text.Trim();
        //    string accountNumber = txtAccount.Text.Trim();
        //    string beneName = txtBene.Text.Trim();
        //    string ifsc = txtIFSC.Text.Trim();
        //    decimal amount;
        //    decimal.TryParse(txtAmount.Text.Trim(), out amount);
        //    string mode = hfPaymentMode.Value;
        //    string remarks = txtMobile.Text.Trim();
        //    string beneficiaryEmail = ddlBankName.SelectedValue;
        //    string orderId = "ORD" + DateTime.Now.ToString("yyyyMMddHHmmssfff");
        //    string Mobile= txtMobile.Text.Trim();
        //    string BankName = ddlBankName.SelectedValue;
        //    Random random = new Random();
        //    string RefId = random.Next(1000000000, 1999999999).ToString(); 


        //    if (amount > balance)
        //    {
        //        lblMessage.InnerText = "Error: Insufficient balance for this payout.";
        //        lblMessage.Attributes["class"] = "text-danger"; 
        //        return; 
        //    }
        //    else 
        //    {
        //        Decimal NewBalance = balance - amount;
        //        string con = ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString;
        //        using (SqlConnection conn = new SqlConnection(con))
        //        {
        //             string query = "insert into tbluserbalance(Old_Bal,Amount,New_Bal,TxnType,crDrType,UserId,Remarks,TxnDatetime)values(@Old_Bal,@Amount,@New_Bal,@TxnType,@crDrType,@UserId,@Remarks,GETDATE());";
        //            using (SqlCommand cmd = new SqlCommand(query, conn))
        //            {
        //                cmd.Parameters.AddWithValue("@Old_Bal", balance);
        //                cmd.Parameters.AddWithValue("@Amount", amount);
        //                cmd.Parameters.AddWithValue("@New_Bal", NewBalance);
        //                cmd.Parameters.AddWithValue("@TxnType", "Payout");
        //                cmd.Parameters.AddWithValue("@crDrType", "Debit");
        //                cmd.Parameters.AddWithValue("@UserId", UserId);
        //                cmd.Parameters.AddWithValue("@Remarks", "Amount Debitted from user");


        //                conn.Open();
        //                cmd.ExecuteNonQuery();
        //            }
        //        }
        //    }


        //    string connStr = ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString;
        //    using (SqlConnection conn = new SqlConnection(connStr))
        //    {
        //        string query = @"
        //    INSERT INTO BankPayouts 
        //    ( AccountNumber, BeneficiaryName, IFSC, Amount, OrderId, UserId, Mode, Type, Status, MobileNo, BankName, CreatedAt)
        //    VALUES 
        //    (, @AccountNumber, @BeneficiaryName, @IFSC, @Amount, @OrderId, @UserId, @Mode, @Type, @Status, @MobileNo, @BankName, GETDATE())";

        //        using (SqlCommand cmd = new SqlCommand(query, conn))
        //        {
                   
        //            cmd.Parameters.AddWithValue("@AccountNumber", accountNumber);
        //            cmd.Parameters.AddWithValue("@BeneficiaryName", beneName);
        //            cmd.Parameters.AddWithValue("@IFSC", ifsc);
        //            cmd.Parameters.AddWithValue("@Amount", amount);
        //            cmd.Parameters.AddWithValue("@OrderId", orderId);
        //            cmd.Parameters.AddWithValue("@UserId", UserId);
        //            cmd.Parameters.AddWithValue("@Mode", mode);
        //            cmd.Parameters.AddWithValue("@Type", "Bank");
        //            cmd.Parameters.AddWithValue("@Status", "Pending");
        //            cmd.Parameters.AddWithValue("@MobileNo", string.IsNullOrEmpty(remarks) ? (object)DBNull.Value : remarks);
        //            cmd.Parameters.AddWithValue("@BankName", string.IsNullOrEmpty(beneficiaryEmail) ? (object)DBNull.Value : beneficiaryEmail);

        //            conn.Open();
        //            cmd.ExecuteNonQuery();
        //        }
        //    }

        //    string urlRecharge = "https://app.neox.business/api/PayoutApi";
        //    string bodyRecharge = "{\"ApiKey\":\"" + "BANK250218174703U" + "\",\"password\":\"" + "1.0" + "\",\"APIName\":\"" + "BANKU" + "\",\"MobileNo\":\"" + Mobile + "\",\"BeneName\":\"" + beneName + "\",\"AccountNo\":\"" + accountNumber + "\",\"Amount\":\"" + amount + "\",\"Ifsccode\":\"" + ifsc + "\",\"TXNMode\":\"" + mode + "\",\"BankName\":\"" + BankName + "\",\"Client_refId\":\"" + RefId + "\"}";
        //    string ApiresponseRecharge = String.Empty;
        //    var client = new RestClient(urlRecharge);
        //    var request = new RestRequest(Method.POST);
        //    request.AddHeader("cache-control", "no-cache");
        //    request.AddHeader("Accept", "application/json");
        //    request.AddHeader("Content-Type", "application/json");
        //    request.AddParameter("application/json", bodyRecharge, RestSharp.ParameterType.RequestBody);
        //    IRestResponse response = client.Execute(request);
        //    ApiresponseRecharge = response.Content;

        //    JObject jObjects = JObject.Parse(ApiresponseRecharge);
        //    lblMessage.InnerText = jObjects["Message"].ToString();
        //    string scode = jObjects["Status"].ToString();
        //    if (scode == "1")
        //    {            
        //        using (SqlConnection conn = new SqlConnection(connStr))
        //        {
        //            string updateQuery = @"
        //            UPDATE BankPayouts
        //            SET Status = @Status, ApiResponse = @ApiResponse
        //            WHERE OrderId = @OrderId";

        //            using (SqlCommand cmd = new SqlCommand(updateQuery, conn))
        //            {
        //                cmd.Parameters.AddWithValue("@Status", scode == "1" ? "Success" : "Failed");
        //                cmd.Parameters.AddWithValue("@ApiResponse", ApiresponseRecharge);
        //                cmd.Parameters.AddWithValue("@OrderId", orderId);

        //                conn.Open();
        //                cmd.ExecuteNonQuery();
        //            }
        //        }
        //        getReport();
        //    }
        //    else
        //    {
        //        decimal balance1 = 0;
        //        decimal.TryParse(Um.GetBalance(UserId), out balance1);
        //        Decimal NewBalance = balance1 + amount;
        //        string con = ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString;
        //        using (SqlConnection conn = new SqlConnection(con))
        //        {
        //            string query = "insert into tbluserbalance(Old_Bal,Amount,New_Bal,TxnType,crDrType,UserId,Remarks,TxnDatetime)values(@Old_Bal,@Amount,@New_Bal,@TxnType,@crDrType,@UserId,@Remarks,GETDATE());";
        //            using (SqlCommand cmd = new SqlCommand(query, conn))
        //            {
        //                cmd.Parameters.AddWithValue("@Old_Bal", balance1);
        //                cmd.Parameters.AddWithValue("@Amount", amount);
        //                cmd.Parameters.AddWithValue("@New_Bal", NewBalance);
        //                cmd.Parameters.AddWithValue("@TxnType", "Payout Return");
        //                cmd.Parameters.AddWithValue("@crDrType", "Credit");
        //                cmd.Parameters.AddWithValue("@UserId", UserId);
        //                cmd.Parameters.AddWithValue("@Remarks", "Amount returned to user");


        //                conn.Open();
        //                cmd.ExecuteNonQuery();
        //            }
        //        }

        //        lblerror.InnerText = "Something Went Wrong ";
        //        getReport();
        //    }
        //    // Prevent resubmission on refresh
        //    Response.Redirect(Request.Url.AbsolutePath, false);
        //}

        protected void btnProceedUPI_Click(object sender, EventArgs e)
        {
            string userId = Session["BankURTUID"].ToString();
            decimal balance = 0;
            decimal.TryParse(Um.GetBalance(userId), out balance); 

            //string payoutTo = txtUPIPayoutTo.Text.Trim(); 
            string upiId = txtUPIID.Text.Trim(); 
            decimal amount;
            decimal.TryParse(txtUPIAmount.Text.Trim(), out amount);
            string remarks = txtUPIRemarks.Text.Trim();
            string beneficiaryEmail = txtUPIBeneficiaryEmail.Text.Trim();
            string orderId = "ORD" + DateTime.Now.ToString("yyyyMMddHHmmssfff");
            if (amount > balance)
            {
                lblMessage.InnerText = "Insufficient balance for this UPI payout!";
                return;
            }

            string connStr = ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = @"
            INSERT INTO BankPayouts
            (PayoutTo, AccountNumber, BeneficiaryName, IFSC, Amount, Mode, Type, Status, Remarks, BeneficiaryEmail, CreatedAt, UserId, OrderId)
            VALUES
            (@PayoutTo, @AccountNumber, @BeneficiaryName, @IFSC, @Amount, @Mode, @Type, @Status, @Remarks, @BeneficiaryEmail, GETDATE(), @UserId, @OrderId)";


                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    
                    cmd.Parameters.AddWithValue("@AccountNumber", upiId); 
                    //cmd.Parameters.AddWithValue("@BeneficiaryName", payoutTo); 
                    cmd.Parameters.AddWithValue("@IFSC", "NA"); 
                    cmd.Parameters.AddWithValue("@Amount", amount);
                    cmd.Parameters.AddWithValue("@Mode", "UPI");
                    cmd.Parameters.AddWithValue("@Type", "UPI");
                    cmd.Parameters.AddWithValue("@Status", "Pending");
                    cmd.Parameters.AddWithValue("@Remarks", string.IsNullOrEmpty(remarks) ? (object)DBNull.Value : remarks);
                    cmd.Parameters.AddWithValue("@BeneficiaryEmail", string.IsNullOrEmpty(beneficiaryEmail) ? (object)DBNull.Value : beneficiaryEmail);
                    cmd.Parameters.AddWithValue("@OrderId", orderId);
                    cmd.Parameters.AddWithValue("@UserId", userId);
                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
            }        
            lblMessage.InnerText = "UPI payout request saved successfully!";
            Response.Redirect(Request.Url.AbsolutePath, false);

        }

        protected void getReport()
        {
            string UserId = Session["BankURTUID"].ToString();
            using (SqlConnection con = new SqlConnection(connStr))
            {
                string query = "SELECT * FROM TxnReport WHERE UserId = @UserId AND ServiceName='SINGLE_PAYOUT' Order By TransId DESC";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    con.Open();
                    cmd.Parameters.AddWithValue("@UserId", UserId);
                    SqlDataReader reader = cmd.ExecuteReader();

                    if (!reader.HasRows)
                    {
                        gvRequests.Visible = false;
                        lblMessage1.Text = "No request available";
                        lblMessage1.ForeColor = System.Drawing.Color.Red;
                    }
                    else
                    {
                        gvRequests.Visible = true;
                        gvRequests.DataSource = reader;
                        gvRequests.DataBind();
                        lblMessage1.Text = "";
                    }
                }

            }
            // 🔹 Get today's summary
            using (SqlConnection con = new SqlConnection(connStr))
            {
                string summaryQuery = @"
                SELECT 
                    COUNT(*) AS TxnCount, 
                    ISNULL(SUM(Amount),0) AS TotalValue, 
                    ISNULL(AVG(Amount),0) AS AvgValue
                FROM TxnReport 
                WHERE UserId = @UserId 
                  AND CAST(TxnDate AS DATE) = CAST(GETDATE() AS DATE)  AND Status = 'SUCCESS'";

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

    }    
}