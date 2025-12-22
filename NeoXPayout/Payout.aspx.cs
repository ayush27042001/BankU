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

        protected void BankPayout_Click(object sender, EventArgs e)
        {
            string UserId= Session["BankURTUID"].ToString();
            decimal balance = 0;
            decimal.TryParse(Um.GetBalance(UserId), out balance); 
            //string payoutTo = txtPayout.Text.Trim();
            string accountNumber = txtAccount.Text.Trim();
            string beneName = txtBene.Text.Trim();
            string ifsc = txtIFSC.Text.Trim();
            decimal amount;
            decimal.TryParse(txtAmount.Text.Trim(), out amount);
            string mode = hfPaymentMode.Value;
            string remarks = txtMobile.Text.Trim();
            string beneficiaryEmail = ddlBankName.SelectedValue;
            string orderId = "ORD" + DateTime.Now.ToString("yyyyMMddHHmmssfff");
            string Mobile= txtMobile.Text.Trim();
            string BankName = ddlBankName.SelectedValue;
            Random random = new Random();
            string RefId = random.Next(1000000000, 1999999999).ToString(); 


            if (amount > balance)
            {
                lblMessage.InnerText = "Error: Insufficient balance for this payout.";
                lblMessage.Attributes["class"] = "text-danger"; 
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
                        cmd.Parameters.AddWithValue("@TxnType", "Payout");
                        cmd.Parameters.AddWithValue("@crDrType", "Debit");
                        cmd.Parameters.AddWithValue("@UserId", UserId);
                        cmd.Parameters.AddWithValue("@Remarks", "Amount Debitted from user");


                        conn.Open();
                        cmd.ExecuteNonQuery();
                    }
                }
            }


            string connStr = ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = @"
            INSERT INTO BankPayouts 
            ( AccountNumber, BeneficiaryName, IFSC, Amount, OrderId, UserId, Mode, Type, Status, MobileNo, BankName, CreatedAt)
            VALUES 
            (, @AccountNumber, @BeneficiaryName, @IFSC, @Amount, @OrderId, @UserId, @Mode, @Type, @Status, @MobileNo, @BankName, GETDATE())";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                   
                    cmd.Parameters.AddWithValue("@AccountNumber", accountNumber);
                    cmd.Parameters.AddWithValue("@BeneficiaryName", beneName);
                    cmd.Parameters.AddWithValue("@IFSC", ifsc);
                    cmd.Parameters.AddWithValue("@Amount", amount);
                    cmd.Parameters.AddWithValue("@OrderId", orderId);
                    cmd.Parameters.AddWithValue("@UserId", UserId);
                    cmd.Parameters.AddWithValue("@Mode", mode);
                    cmd.Parameters.AddWithValue("@Type", "Bank");
                    cmd.Parameters.AddWithValue("@Status", "Pending");
                    cmd.Parameters.AddWithValue("@MobileNo", string.IsNullOrEmpty(remarks) ? (object)DBNull.Value : remarks);
                    cmd.Parameters.AddWithValue("@BankName", string.IsNullOrEmpty(beneficiaryEmail) ? (object)DBNull.Value : beneficiaryEmail);

                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
            }

            string urlRecharge = "https://app.neox.business/api/PayoutApi";
            string bodyRecharge = "{\"ApiKey\":\"" + "BANK250218174703U" + "\",\"password\":\"" + "1.0" + "\",\"APIName\":\"" + "BANKU" + "\",\"MobileNo\":\"" + Mobile + "\",\"BeneName\":\"" + beneName + "\",\"AccountNo\":\"" + accountNumber + "\",\"Amount\":\"" + amount + "\",\"Ifsccode\":\"" + ifsc + "\",\"TXNMode\":\"" + mode + "\",\"BankName\":\"" + BankName + "\",\"Client_refId\":\"" + RefId + "\"}";
            string ApiresponseRecharge = String.Empty;
            var client = new RestClient(urlRecharge);
            var request = new RestRequest(Method.POST);
            request.AddHeader("cache-control", "no-cache");
            request.AddHeader("Accept", "application/json");
            request.AddHeader("Content-Type", "application/json");
            request.AddParameter("application/json", bodyRecharge, RestSharp.ParameterType.RequestBody);
            IRestResponse response = client.Execute(request);
            ApiresponseRecharge = response.Content;

            JObject jObjects = JObject.Parse(ApiresponseRecharge);
            lblMessage.InnerText = jObjects["Message"].ToString();
            string scode = jObjects["Status"].ToString();
            if (scode == "1")
            {            
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    string updateQuery = @"
                    UPDATE BankPayouts
                    SET Status = @Status, ApiResponse = @ApiResponse
                    WHERE OrderId = @OrderId";

                    using (SqlCommand cmd = new SqlCommand(updateQuery, conn))
                    {
                        cmd.Parameters.AddWithValue("@Status", scode == "1" ? "Success" : "Failed");
                        cmd.Parameters.AddWithValue("@ApiResponse", ApiresponseRecharge);
                        cmd.Parameters.AddWithValue("@OrderId", orderId);

                        conn.Open();
                        cmd.ExecuteNonQuery();
                    }
                }
                getReport();
            }
            else
            {
                decimal balance1 = 0;
                decimal.TryParse(Um.GetBalance(UserId), out balance1);
                Decimal NewBalance = balance1 + amount;
                string con = ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString;
                using (SqlConnection conn = new SqlConnection(con))
                {
                    string query = "insert into tbluserbalance(Old_Bal,Amount,New_Bal,TxnType,crDrType,UserId,Remarks,TxnDatetime)values(@Old_Bal,@Amount,@New_Bal,@TxnType,@crDrType,@UserId,@Remarks,GETDATE());";
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@Old_Bal", balance1);
                        cmd.Parameters.AddWithValue("@Amount", amount);
                        cmd.Parameters.AddWithValue("@New_Bal", NewBalance);
                        cmd.Parameters.AddWithValue("@TxnType", "Payout Return");
                        cmd.Parameters.AddWithValue("@crDrType", "Credit");
                        cmd.Parameters.AddWithValue("@UserId", UserId);
                        cmd.Parameters.AddWithValue("@Remarks", "Amount returned to user");


                        conn.Open();
                        cmd.ExecuteNonQuery();
                    }
                }

                lblerror.InnerText = "Something Went Wrong ";
                getReport();
            }
            // Prevent resubmission on refresh
            Response.Redirect(Request.Url.AbsolutePath, false);
        }

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
                string query = "SELECT * FROM BankPayouts WHERE UserId = @UserId Order By Id DESC";
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
                FROM BankPayouts 
                WHERE UserId = @UserId 
                  AND CAST(CreatedAt AS DATE) = CAST(GETDATE() AS DATE)  AND Status = 'Success'";

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
        //public void Banklist()
        //{
        //    string TokenKey = "Bank";
        //    string url = "https://app.banku.co.in/api/BankList";
        //    string body = "{\"Service\":\"" + TokenKey + "\"}";
        //    var client = new RestClient(url);
        //    var request = new RestRequest(Method.POST);
        //    request.AddHeader("cache-control", "no-cache");
        //    request.AddHeader("Accept", "application/json");
        //    request.AddHeader("Content-Type", "application/json");
        //    request.AddParameter("application/json", body, RestSharp.ParameterType.RequestBody);
        //    IRestResponse response = client.Execute(request);
        //    string content = response.Content;
        //    JObject jObjects = JObject.Parse(content);
        //    if (jObjects["Status"].ToString() == "SUCCESS")
        //    {
        //        JArray jredmill = JArray.Parse(jObjects["Data"].ToString());
        //        DataTable dt = new DataTable();
        //        dt.Columns.AddRange(new DataColumn[2] { new DataColumn("bank_iin", typeof(string)),
        //                    new DataColumn("bank_name",typeof(string))});
        //        if (jredmill != null)
        //        {
        //            foreach (JToken item in (IEnumerable<JToken>)jredmill)
        //            {
        //                JObject jObjects1 = JObject.Parse(item.ToString());
        //                dt.Rows.Add(jObjects1["iin"].ToString(), jObjects1["name"].ToString());
        //            }
        //            if (dt.Rows.Count > 0)
        //            {
        //                ddlBankName.DataSource = dt;
        //                ddlBankName.DataBind();
        //                ddlBankName.DataTextField = "bank_name";
        //                ddlBankName.DataValueField = "bank_iin";
        //                ddlBankName.DataBind();
        //                ddlBankName.Items.Insert(0, new ListItem("Please select", ""));
        //            }
        //        }
        //    }
        //    else
        //    {

        //    }
        //}
        //private void LoadRechargeHistory()
        //{
        //    try
        //    {
        //        // Calculate date range (last 5 days including today)
        //        string dateTo = DateTime.Now.ToString("yyyy-MM-dd");
        //        string dateFrom = DateTime.Now.AddDays(-4).ToString("yyyy-MM-dd");

        //        // --- TEMP OVERRIDE for testing (delete this block after confirming dropdown works)
        //        //dateFrom = "2025-06-01";
        //        //dateTo = "2025-06-12";
        //        string userId = Session["BankURTUID"]?.ToString();
        //        if (string.IsNullOrEmpty(userId))
        //        {
        //            litRechargeHistory.Text = "<div class='text-danger'>User session expired. Please log in again.</div>";
        //            return;
        //        }

        //        string url = "https://partner.banku.co.in/api/TxnReport";

        //        // JSON body with dynamic date range and selected service
        //        string body = $@"
        //            {{
        //                ""UserId"": ""{userId}"",
        //                ""Apiversion"": ""1.0"",
        //                ""ServiceName"": ""PAYOUT"",
        //                ""DateFrom"": ""{dateFrom}"",
        //                ""DateTo"": ""{dateTo}""
        //            }}";

        //        var client = new RestClient(url);
        //        var request = new RestRequest(Method.POST);
        //        request.AddHeader("Accept", "application/json");
        //        request.AddHeader("Content-Type", "application/json");
        //        request.AddParameter("application/json", body, ParameterType.RequestBody);

        //        IRestResponse response = client.Execute(request);

        //        if (response.IsSuccessful)
        //        {
        //            JObject result = JObject.Parse(response.Content);

        //            if (result["Status"]?.ToString() == "SUCCESS")
        //            {
        //                JArray dataArray = result["Data"] as JArray;

        //                if (dataArray == null || !dataArray.Any())
        //                {
        //                    litRechargeHistory.Text = "<div class='text-muted'>No transaction history found.</div>";
        //                    return;
        //                }

        //                string html = "";

        //                foreach (var item in dataArray.Take(5))
        //                {
        //                    string operatorName = item["OperatorName"]?.ToString() ?? "";
        //                    string mobile = item["MobileNo"]?.ToString() ?? "-";
        //                    string amount = item["Amount"]?.ToString() ?? "0";
        //                    string date = Convert.ToDateTime(item["TxnDate"]).ToString("MMM dd, yyyy");
        //                    string status = item["Status"]?.ToString() ?? "PENDING";

        //                    string logo = "Rupee.png";

        //                    string amountColor = status == "SUCCESS" ? "green" : "red";

        //                    html += $@"
        //                            <div class='d-flex align-items-center mb-3'>
        //                                <img class='avatar rounded' src='assets/images/xs/{logo}' alt=''>
        //                                <div class='flex-fill ms-3'>
        //                                    <div class='h6 mb-0'>{mobile}</div>
        //                                    <small class='text-muted'>{operatorName}</small>
        //                                </div>
        //                                <div class='flex-end flex-column d-flex text-end'>
        //                                    <small class='fw-medium' style='color:{amountColor};'>₹{amount}</small>
        //                                    <small class='text-muted'>{date}</small>
        //                                </div>
        //                            </div>
        //                            <hr />";
        //                }

        //                litRechargeHistory.Text = html;
        //            }
        //            else
        //            {
        //                litRechargeHistory.Text = "<div class='text-danger'>No successful data found for the selected type.</div>";
        //            }
        //        }
        //        else
        //        {
        //            litRechargeHistory.Text = "<div class='text-danger'>Failed to fetch recharge history. Please try again later.</div>";
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        // Log exception (optional)
        //        litRechargeHistory.Text = $"<div class='text-danger'>Error: {ex.Message}</div>";
        //    }
        //}
        //protected void LinkButton1_Click(object sender, EventArgs e)
        //{
        //    string cardNo = txtAccount.Text.Trim();
        //    string BeneNo = txtBene.Text.Trim();
        //    string amount = txtamt.Text.Trim();
        //    string IFSC = txtIFSC.Text.Trim();
        //    string BranchName = txtBranch.Text.Trim();
        //    string operatorSelected = ddlOperator.SelectedItem.Text;
        //    string selectedOperatorId = ddlOperator.SelectedValue;
        //    if (operatorSelected == "Select" ||  string.IsNullOrWhiteSpace(cardNo) || string.IsNullOrWhiteSpace(BeneNo) || string.IsNullOrWhiteSpace(amount))
        //    {
        //        Label2.Text = "Fill all the details.";
        //        return;
        //    }
        //    else
        //    {
        //        Label2.Text = "";
        //    }

        //    if (!decimal.TryParse(cardNo, out _) || !decimal.TryParse(amount, out _) || !decimal.TryParse(BeneNo, out _))
        //    {
        //        Label1.Text = "Enter Valid Details.";
        //        return;
        //    }
        //    else
        //    {
        //        Label1.Text = "";
        //    }

        //    lblBillAmount.Text = amount;
        //    lblIFSC.Text = IFSC;            
        //    lblBranchName.Text = BranchName;          
        //    editModalLabel.Text = "Review Your Transaction.";
        //    editModalLabel.CssClass = "modal-title text-success";
        //    lblNumber.Text = cardNo;
        //    lblMobile.Text = BeneNo;
        //    string script = "window.onload = function() { $('#editModal').modal('show'); };";
        //     ClientScript.RegisterStartupScript(this.GetType(), "ShowModal", script, true);

        //}
        //protected void btnPayNow_Click(object sender, EventArgs e)
        //{
        //    string Amount = txtamt.Text.Trim();
        //    string Name = "Chandan";
        //    string billerResponse = "BillerResponse";
        //    string inputParams = "Input Param";
        //    string reqid = "250614110817305";
        //    string ainfo = "Additioanl Info";
        //    string selectedOperatorId = ddlOperator.SelectedValue;
        //    string BeneNo1 = txtBene.Text.Trim();
        //    string OTP = txtOTP.Text.Trim();
        //    string IFSC = txtIFSC.Text.Trim();
        //    string BranchName = txtBranch.Text.Trim();
        //    payBene.Text = BeneNo1;
        //    string AccountNo = txtAccount.Text.Trim();
        //    string UserBill = this.Session["BankURTUID"].ToString();
        //    string urlBill = "https://partner.banku.co.in/api/BillPay";
        //    string bodyBill = "{\"UserId\":\"" + UserBill + "\",\"Apiversion\":\"" + "1.0" + "\",\"ServiceName\":\"" + "CREDITCARD" + "\",\"OperatorId\":\"" + selectedOperatorId + "\",\"Accountno\":\"" + AccountNo + "\",\"MobileNo\":\"" + BeneNo1 + "\",\"Amt\":\"" + Amount + "\",\"CustomerName\":\"" + Name + "\",\"billerResponse\":\"" + billerResponse + "\",\"inputParams\":\"" + inputParams + "\",\"reqid\":\"" + reqid + "\",\"ainfo\":\"" + ainfo + "\"}";
        //    string ApiresponseBill = String.Empty;
        //    var clientBill = new RestClient(urlBill);
        //    var requestBill = new RestRequest(Method.POST);
        //    requestBill.AddHeader("cache-control", "no-cache");
        //    requestBill.AddHeader("Accept", "application/json");
        //    requestBill.AddHeader("Content-Type", "application/json");
        //    requestBill.AddParameter("application/json", bodyBill, RestSharp.ParameterType.RequestBody);
        //    IRestResponse responseBill = clientBill.Execute(requestBill);
        //    ApiresponseBill = responseBill.Content;        
        //    if (!string.IsNullOrWhiteSpace(OTP) && OTP.All(char.IsDigit))
        //    {
        //        JObject jObjectsBill = JObject.Parse(ApiresponseBill);
        //        string scode = jObjectsBill["Status"].ToString();

        //        if (scode == "SUCCESS")
        //        {
        //            JObject jObjectBill = JObject.Parse(ApiresponseBill);
        //            JArray dataArrayBill = (JArray)jObjectBill["Data"];

        //            if (dataArrayBill != null && dataArrayBill.Count > 0)
        //            {
        //                // Populate the PayModal fields
        //                payName.Text = Name;
        //                payAccount.Text = AccountNo;
        //                payBranch.Text = BranchName;
        //                payAmount.Text = Amount;
        //                payIFSC.Text = IFSC;
        //                payCurrBal.Text = dataArrayBill[0]["CurrentBalance"]?.ToString();
        //                PayTxnID.Text = dataArrayBill[0]["TxnID"]?.ToString();
        //                payDate.Text = Convert.ToDateTime(dataArrayBill[0]["TxnDate"]).ToString("dd-MM-yyyy");
        //                lblOtpError.Text = "";
        //                lblheader.Text = "Transaction Successfully";
        //                lblheader.CssClass = "modal-title text-success";
        //            }
        //            else
        //            {
        //                lblheader.Text = jObjectBill["Message"]?.ToString() ?? "Recharge failed or invalid response.";
        //                lblheader.CssClass = "modal-title text-danger";
        //                lblNumber.Text = BeneNo1;
        //            }


        //            string script = "window.onload = function() { $('#PayModal').modal('show'); };";
        //            ClientScript.RegisterStartupScript(this.GetType(), "ShowPayModal", script, true);
        //        }
        //        else
        //        {

        //            Label1.Text = "Something Went Wrong";
        //        }
        //    }
        //    else
        //    {

        //        lblOtpError.Text = "Please enter OTP";
        //        lblOtpError.ForeColor = System.Drawing.Color.Red;

        //        string script = "window.onload = function() { $('#editModal').modal('show'); };";
        //        ClientScript.RegisterStartupScript(this.GetType(), "ShowEditModal", script, true);
        //    }
        //}
        //protected void LinkButton3_Click(object sender, EventArgs e)
        //{
        //    string script = "window.onload = function() { $('#AddModal').modal('show'); };";
        //    ClientScript.RegisterStartupScript(this.GetType(), "ShowModal", script, true);
        //}
        //protected void btnAdd_Click(object sender, EventArgs e)
        //{
        //    string Account = txtAccountNumber.Text.Trim();
        //    string Benn = txtBeneNumber.Text.Trim();
        //    string IFSC = TextBox1.Text.Trim();
        //    string Branch = txtBranchName.Text.Trim();
        //    if (string.IsNullOrWhiteSpace(Account) || string.IsNullOrWhiteSpace(Benn) || string.IsNullOrWhiteSpace(IFSC) || string.IsNullOrWhiteSpace(Branch))
        //    {
        //        Label4.Text = "Fill all Details.";
        //        string script = "window.onload = function() { $('#AddModal').modal('show'); };";
        //        ClientScript.RegisterStartupScript(this.GetType(), "editModalLabel", script, true);
        //        return;
        //    }
        //    if (!decimal.TryParse(Account, out _) || !decimal.TryParse(IFSC, out _) || !decimal.TryParse(Benn, out _))
        //    {
        //        Label4.Text = "Enter valid Details.";
        //        string script = "window.onload = function() { $('#AddModal').modal('show'); };";
        //        ClientScript.RegisterStartupScript(this.GetType(), "editModalLabel", script, true);
        //        return;
        //    }
        //    Label4.Text = "";
        //    lblSuccess.Text = "Sender Added successfully.";

        //}

    }    
}