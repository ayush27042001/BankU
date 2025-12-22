using Newtonsoft.Json.Linq;
using RestSharp;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Security.Cryptography;
using System.Text;
using System.Configuration;
using System.Data.SqlClient;


namespace NeoXPayout
{
    public partial class DMT : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString;
        UserManagement Um = new UserManagement();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["BankURTName"] == null || !(Session["IsMPINVerified"] is bool isVerified && isVerified))
            {
                Response.Redirect("LoginBankU.aspx");
            }
            string Acctype = (Session["AccountHolderType"]?.ToString() ?? "").Trim().ToUpper();

            if (Acctype != "BANKU SEVA KENDRA")
            {
                Response.Redirect("Dashboard.aspx");
            }
            if (!IsRechargeServiceActive())
            {
                pnlMain.Visible = false;
                pnlError.Visible = true;
                
                return;
            }
          
        }
        private bool IsRechargeServiceActive()
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {

                string query = "SELECT Status FROM BankUServices WHERE ServiceName = @ServiceName";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@ServiceName", "DMT");
                    con.Open();

                    object statusObj = cmd.ExecuteScalar();
                    if (statusObj == null || statusObj == DBNull.Value)
                        return false;

                    string status = statusObj.ToString();

                    return (status.Equals("Active", StringComparison.OrdinalIgnoreCase) || status == "1");
                }
            }
        }
        protected void LinkButton2_Click(object sender, EventArgs e)
        {
            string senderMobile = txtmobile.Text.Trim();
            string senderName = txtname.Text.Trim();
            string senderGender = ddlgender.SelectedValue;
            string UserId = Session["BankURTUID"].ToString();

            string registrationUrl = "https://payzones.in/apipartner/apiservice/dmt/senderregistration";
            var regClient  = new RestClient(registrationUrl);
            var regRequest = new RestRequest(Method.POST);
            regRequest.AddParameter("apiToken", "c1fa1b07b5377fc9ca2c2894e7ba428d");
            regRequest.AddParameter("apiUserId", "5130");
            regRequest.AddParameter("senderMobileNo", senderMobile);
            regRequest.AddParameter("senderName", senderName);
            regRequest.AddParameter("senderGender", senderGender);
        
            var regRequestData = new JObject
            {
                { "apiToken", "c1fa1b07b5377fc9ca2c2894e7ba428d" },
                { "apiUserId", "5130" },
                { "senderMobileNo", senderMobile },
                { "senderName", senderName },
                { "senderGender", senderGender }
            }.ToString();

            IRestResponse regResponse = regClient.Execute(regRequest);
            string regResponseContent = regResponse.Content;
            Um.LogApiCall(UserId, regRequestData, regResponseContent, "DMTSenderReg");
            var regJson = JObject.Parse(regResponseContent);

            string regStatus = regJson["status"]?.ToString();
            string regMessage = regJson["message"]?.ToString();
            string senderID = regJson["data"]?["senderID"]?.ToString();

            if (regStatus == "success" || (regStatus == "error" && regMessage.Contains("successfully")))
            {
                
                using (SqlConnection con = new SqlConnection("Data Source=103.205.142.34,1433;Initial Catalog=BankUIndia_db;Persist Security Info=True;User ID=BankUIndia_db;Password=Chandan@80100"))
                {
                    con.Open();
                    string query = @"INSERT INTO DmtSenderRegistration 
                            (SenderMobileNo, SenderName, SenderGender, SenderId, ApiRequest, ApiResponse) 
                            VALUES (@SenderMobileNo, @SenderName, @SenderGender, @SenderId, @ApiRequest, @ApiResponse)";
                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@SenderMobileNo", senderMobile);
                    cmd.Parameters.AddWithValue("@SenderName", senderName);
                    cmd.Parameters.AddWithValue("@SenderGender", senderGender);
                    cmd.Parameters.AddWithValue("@SenderId", senderID ?? (object)DBNull.Value);
                    cmd.Parameters.AddWithValue("@ApiRequest", regRequestData);
                    cmd.Parameters.AddWithValue("@ApiResponse", regResponseContent);
                    cmd.ExecuteNonQuery();
                }
            
                string otpUrl = "https://payzones.in/apipartner/apiservice/dmt/receiveotp";
                var otpClient = new RestClient(otpUrl);
                var otpRequest = new RestRequest(Method.POST);
                otpRequest.AddParameter("apiToken", "c1fa1b07b5377fc9ca2c2894e7ba428d");
                otpRequest.AddParameter("apiUserId", "5130");
                otpRequest.AddParameter("senderId", senderID);
                otpRequest.AddParameter("senderMobileNo", senderMobile);
                otpRequest.AddParameter("otpReference", "senderVerification");

                var otpRequestData = new JObject
                {
                    { "apiToken", "c1fa1b07b5377fc9ca2c2894e7ba428d" },
                    { "apiUserId", "5130" },
                    { "senderId", senderID },
                    { "senderMobileNo", senderMobile },
                    { "otpReference", "senderVerification" }
                }.ToString();

                IRestResponse otpResponse = otpClient.Execute(otpRequest);
                string otpResponseContent = otpResponse.Content;
                Um.LogApiCall(UserId, otpRequestData, otpResponseContent, "DMTSenderOTP");
                var otpJson = JObject.Parse(otpResponseContent);
                string otpStatus = otpJson["status"]?.ToString();
                string otpMessage = otpJson["message"]?.ToString();
           
                using (SqlConnection con = new SqlConnection("Data Source=103.205.142.34,1433;Initial Catalog=BankUIndia_db;Persist Security Info=True;User ID=BankUIndia_db;Password=Chandan@80100"))
                {
                    con.Open();
                    string query = @"INSERT INTO DmtOtpLogs 
                            (SenderId, SenderMobileNo, ApiRequest, ApiResponse) 
                            VALUES (@SenderId, @SenderMobileNo, @ApiRequest, @ApiResponse)";
                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@SenderId", senderID ?? (object)DBNull.Value);
                    cmd.Parameters.AddWithValue("@SenderMobileNo", senderMobile);
                    cmd.Parameters.AddWithValue("@ApiRequest", otpRequestData);
                    cmd.Parameters.AddWithValue("@ApiResponse", otpResponseContent);
                    cmd.ExecuteNonQuery();
                }

                if (otpStatus == "success")
                {
                    hdnSenderId.Value = senderID;
                    ClientScript.RegisterStartupScript(this.GetType(), "OpenOtpModal",
                        "setTimeout(function(){ var otpModal = new bootstrap.Modal(document.getElementById('otpModal')); otpModal.show(); }, 500);", true);

                  
                    lblMessage.Text = "Sender registered successfully. OTP sent!";
                    string script = "var msgModal = new bootstrap.Modal(document.getElementById('messageModal')); msgModal.show();";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "OtpSuccessPopup", script, true);
                }
                else
                {
                    lblMessage.Text = "OTP send failed: " + otpMessage;
                    string script = "var msgModal = new bootstrap.Modal(document.getElementById('messageModal')); msgModal.show();";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "OtpFailedPopup", script, true);
                }
            }
            else
            {
                lblMessage.Text = "Sender already registered OR Error: " + regMessage;
                string script = "var msgModal = new bootstrap.Modal(document.getElementById('messageModal')); msgModal.show();";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "AlreadyRegisteredPopup", script, true);
            }
        }

        protected void LinkButton3_Click(object sender, EventArgs e)
        {
            string senderId = hdnSenderId.Value;
            string senderMobile = txtmobile.Text.Trim();
            string otp = txtOtp.Text.Trim();
            string UserId = Session["BankURTUID"].ToString();

            string verifyUrl = "https://payzones.in/apipartner/apiservice/dmt/verifyotp";
            var verifyClient = new RestClient(verifyUrl);
            var verifyRequest = new RestRequest(Method.POST);
            verifyRequest.AddParameter("apiToken", "c1fa1b07b5377fc9ca2c2894e7ba428d");
            verifyRequest.AddParameter("apiUserId", "5130");
            verifyRequest.AddParameter("senderId", senderId); 
            verifyRequest.AddParameter("senderMobileNo", senderMobile);
            verifyRequest.AddParameter("otpReference", "senderVerification");
            verifyRequest.AddParameter("otp", otp);
            string requestData = string.Join("&", verifyRequest.Parameters
              .Where(p => p.Type == ParameterType.GetOrPost)
              .Select(p => $"{p.Name}={p.Value}"));

            IRestResponse verifyResponse = verifyClient.Execute(verifyRequest);
            var verifyJson = JObject.Parse(verifyResponse.Content);
            Um.LogApiCall(UserId, requestData, verifyResponse.Content, "DMTVerifyOTP");
            string verifyStatus = verifyJson["status"]?.ToString();
            string verifyMessage = verifyJson["message"]?.ToString();

            if (verifyStatus == "success")
            {
                using (SqlConnection con = new SqlConnection("Data Source=103.205.142.34,1433;Initial Catalog=BankUIndia_db;Persist Security Info=True;User ID=BankUIndia_db;Password=Chandan@80100"))
                {
                    con.Open();
                    string query = "SELECT SenderName FROM DmtSenderRegistration WHERE SenderMobileNo = @SenderMobileNo";
                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@SenderMobileNo", senderMobile);

                    object result = cmd.ExecuteScalar();
                    if (result != null)
                    {
                        lblName.Text = "Sender Name: " + result.ToString(); 
                    }
                    else
                    {
                        lblName.Text = "Sender not found in database!";
                    }
                }
                lblMessage.Text = "OTP verified successfully!";
                string script = "var msgModal = new bootstrap.Modal(document.getElementById('messageModal')); msgModal.show();";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "AlreadyRegisteredPopup", script, true);
             
            }
            else
            {
                lblMessage.Text = "OTP verification failed";
                string script = "var msgModal = new bootstrap.Modal(document.getElementById('messageModal')); msgModal.show();";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "AlreadyRegisteredPopup", script, true);

                //Response.Write("<script>alert('OTP verification failed: " + verifyMessage + "');</script>");
            }
        }

        protected void LinkButton5_Click(object sender, EventArgs e)
        {
            string senderMobileNo = txtsendermobile.Text.Trim();
            string beneficiaryName = txtbenename.Text.Trim();
            string beneficiaryAccNo = txtaccountno.Text.Trim();
            string bankIfscCod = txtifsccode.Text.Trim();
            string beneficiaryBankName = txtbankname.Text.Trim();
            string beneficiaryMobileNumber = txtbenemobile.Text.Trim();
            string trnasferMode = ddltransfermode.SelectedValue;
            string UserId = Session["BankURTUID"].ToString();

            string senderId = "";
            using (SqlConnection con = new SqlConnection("Data Source=103.205.142.34,1433;Initial Catalog=BankUIndia_db;Persist Security Info=True;User ID=BankUIndia_db;Password=Chandan@80100"))
            {
                con.Open();
                string query = "SELECT SenderId FROM DMTSenderRegistration WHERE SenderMobileNo=@SenderMobileNo";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@SenderMobileNo", senderMobileNo);
                senderId = cmd.ExecuteScalar()?.ToString();
            }

            if (string.IsNullOrEmpty(senderId))
            {
                lblMessage.Text = "Sender not found! Please register sender first.";
                string script = "var msgModal = new bootstrap.Modal(document.getElementById('messageModal')); msgModal.show();";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "AlreadyRegisteredPopup", script, true);

                
                return;
            }
            string url = "https://payzones.in/apipartner/apiservice/dmt/addBeneficiary";
            var client = new RestClient(url);
            var request = new RestRequest(Method.POST);

            request.AddParameter("apiToken", "c1fa1b07b5377fc9ca2c2894e7ba428d");
            request.AddParameter("apiUserId", "5130");
            request.AddParameter("senderId", senderId);
            request.AddParameter("senderMobileNo", senderMobileNo);
            request.AddParameter("beneficiaryName", beneficiaryName);
            request.AddParameter("beneficiaryAccNo", beneficiaryAccNo);
            request.AddParameter("bankIfscCod", bankIfscCod);
            request.AddParameter("beneficiaryBankName", beneficiaryBankName);
            request.AddParameter("beneficiaryMobileNumber", beneficiaryMobileNumber);
            request.AddParameter("trnasferMode", trnasferMode);
            var requestData = new JObject
    {
        { "apiToken", "c1fa1b07b5377fc9ca2c2894e7ba428d" },
        { "apiUserId", "5130" },
        { "senderId", senderId },
        { "senderMobileNo", senderMobileNo },
        { "beneficiaryName", beneficiaryName },
        { "beneficiaryAccNo", beneficiaryAccNo },
        { "bankIfscCod", bankIfscCod },
        { "beneficiaryBankName", beneficiaryBankName },
        { "beneficiaryMobileNumber", beneficiaryMobileNumber },
        { "trnasferMode", trnasferMode }
    }.ToString();

            IRestResponse response = client.Execute(request);
            string apiResponse = response.Content; 
            var json = JObject.Parse(apiResponse);
            Um.LogApiCall(UserId, requestData, apiResponse, "DMTAddBeneficiary");

            string status = json["status"]?.ToString();
            string message = json["message"]?.ToString();
            string beneficiaryId = json["data"]?["beneficiaryId"]?.ToString();

            if (status == "success")
            {
                using (SqlConnection con = new SqlConnection("Data Source=103.205.142.34,1433;Initial Catalog=BankUIndia_db;Persist Security Info=True;User ID=BankUIndia_db;Password=Chandan@80100"))
                {
                    con.Open();
                    string query = @"INSERT INTO DMTAddBeneficiary 
                (SenderId, SenderMobileNo, BeneficiaryName, BeneficiaryAccNo, BankIfscCod, BeneficiaryBankName, BeneficiaryMobileNumber, TransferMode, BeneficiaryId, ApiRequest, ApiResponse) 
                VALUES (@SenderId, @SenderMobileNo, @BeneficiaryName, @BeneficiaryAccNo, @BankIfscCod, @BeneficiaryBankName, @BeneficiaryMobileNumber, @TransferMode, @BeneficiaryId, @ApiRequest, @ApiResponse)";

                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@SenderId", senderId);
                    cmd.Parameters.AddWithValue("@SenderMobileNo", senderMobileNo);
                    cmd.Parameters.AddWithValue("@BeneficiaryName", beneficiaryName);
                    cmd.Parameters.AddWithValue("@BeneficiaryAccNo", beneficiaryAccNo);
                    cmd.Parameters.AddWithValue("@BankIfscCod", bankIfscCod);
                    cmd.Parameters.AddWithValue("@BeneficiaryBankName", beneficiaryBankName);
                    cmd.Parameters.AddWithValue("@BeneficiaryMobileNumber", beneficiaryMobileNumber);
                    cmd.Parameters.AddWithValue("@TransferMode", trnasferMode);
                    cmd.Parameters.AddWithValue("@BeneficiaryId", (object)beneficiaryId ?? DBNull.Value);
                    cmd.Parameters.AddWithValue("@ApiRequest", requestData);
                    cmd.Parameters.AddWithValue("@ApiResponse", apiResponse);

                    cmd.ExecuteNonQuery();
                }
             
                lblMessage.Text = "Beneficiary added successfully!";
                string script = "var msgModal = new bootstrap.Modal(document.getElementById('messageModal')); msgModal.show();";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "AlreadyRegisteredPopup", script, true);

                txtbenename.Text = "";
                txtaccountno.Text = "";
                txtifsccode.Text = "";
                txtbankname.Text = "";
                txtbenemobile.Text = "";
                ddltransfermode.SelectedIndex = 0;
                GetBeneficiary();
            }
            else
            {
                using (SqlConnection con = new SqlConnection("Data Source=103.205.142.34,1433;Initial Catalog=BankUIndia_db;Persist Security Info=True;User ID=BankUIndia_db;Password=Chandan@80100"))
                {
                    con.Open();
                    string query = @"INSERT INTO DMTAddBeneficiaryErrors 
                (SenderId, SenderMobileNo, ApiRequest, ApiResponse, ErrorMessage) 
                VALUES (@SenderId, @SenderMobileNo, @ApiRequest, @ApiResponse, @ErrorMessage)";

                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@SenderId", senderId);
                    cmd.Parameters.AddWithValue("@SenderMobileNo", senderMobileNo);
                    cmd.Parameters.AddWithValue("@ApiRequest", requestData);
                    cmd.Parameters.AddWithValue("@ApiResponse", apiResponse);
                    cmd.Parameters.AddWithValue("@ErrorMessage", message ?? "Unknown Error");
                    cmd.ExecuteNonQuery();
                }

                lblMessage.Text = "Error: " + message;

                string script = "var msgModal = new bootstrap.Modal(document.getElementById('messageModal')); msgModal.show();";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "showMessageModal", script, true);
               
            }
        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            string mobileNo = txtmobileno.Text.Trim();

            if (string.IsNullOrEmpty(mobileNo))
            {
                lblName.Text = "Please enter a mobile number.";
                lblName.ForeColor = System.Drawing.Color.Red;
                return;
            }

            string senderName = null;
            string senderId = null;

            using (SqlConnection con = new SqlConnection("Data Source=103.205.142.34,1433;Initial Catalog=BankUIndia_db;Persist Security Info=True;User ID=BankUIndia_db;Password=Chandan@80100"))
            {
                con.Open();
                string query = "SELECT SenderName, SenderId FROM DmtSenderRegistration WHERE SenderMobileNo = @Mobile";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@Mobile", mobileNo);
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.Read())
                {
                    senderName = dr["SenderName"] != DBNull.Value ? dr["SenderName"].ToString() : "";
                    senderId = dr["SenderId"] != DBNull.Value ? dr["SenderId"].ToString() : "";

                    Session["SenderId"] = senderId;
                    Session["SenderName"] = senderName;
                }
            }

            if (!string.IsNullOrEmpty(senderName))
            {
                lblName.Text = "Sender: " + senderName;
                lblName.ForeColor = System.Drawing.Color.Green;

                Session["SenderMobile"] = mobileNo;
                GetBeneficiary();
            }
            else
            {
                lblName.Text = "";
                txtmobile.Text = mobileNo;
                Session["SenderMobile"] = mobileNo;
                ScriptManager.RegisterStartupScript(this, this.GetType(), "OpenSidebar", @"
                    var myOffcanvas = document.getElementById('singlePayoutSidebar');
                    var bsOffcanvas = new bootstrap.Offcanvas(myOffcanvas);
                    bsOffcanvas.show();
                ", true);
            }
        }

        protected void GetBeneficiary()
        {
            string senderMobileNo = Session["SenderMobile"].ToString();
            string SenderId = this.Session["SenderId"].ToString();
            string url = "https://payzones.in/apipartner/apiservice/dmt/getbeneficiary";
            var client = new RestClient(url);
            var request = new RestRequest(Method.POST);
            string UserId = Session["BankURTUID"].ToString();

            request.AddParameter("apiToken", "c1fa1b07b5377fc9ca2c2894e7ba428d");
            request.AddParameter("apiUserId", "5130");
            request.AddParameter("senderId", SenderId);
            request.AddParameter("senderMobileNo", senderMobileNo);
            string requestData = string.Join("&", request.Parameters
    .Where(p => p.Type == ParameterType.GetOrPost)
    .Select(p => $"{p.Name}={p.Value}"));

            IRestResponse response = client.Execute(request);
            Um.LogApiCall(UserId, requestData, response.Content, "DMTGetbeneficiary");
            if (response != null && !string.IsNullOrEmpty(response.Content))
            {
                try
                {
                    var json = JObject.Parse(response.Content);


                    string status = json["status"]?.ToString().ToUpper();

                    //string beneficiaryId = json["beneficiaryDetails"]?["id"]?.ToString();


                    if (status == "SUCCESS")
                    {
                        JArray dataArray = (JArray)json["beneficiaryDetails"];
                        if (dataArray != null && dataArray.Count > 0)
                        {
                            DataTable dt = new DataTable();
                            dt.Columns.Add("BeneId");
                            dt.Columns.Add("BeneName");
                            dt.Columns.Add("AccountNo");
                            dt.Columns.Add("BankId");
                            dt.Columns.Add("bene_mobno");
                            dt.Columns.Add("BeneBank");
                            dt.Columns.Add("IFSCCode");
                            dt.Columns.Add("TransferMode");
                            dt.Columns.Add("LasttranId");
                            dt.Columns.Add("LasttranStatus");
                            dt.Columns.Add("LasttranDate");
                            dt.Columns.Add("LasttranTime");



                            foreach (var item in dataArray)
                            {
                                DataRow row = dt.NewRow();
                                row["BeneId"] = item["id"]?.ToString();
                                row["BeneName"] = item["bene_name"]?.ToString();
                                row["AccountNo"] = item["bene_accno"]?.ToString();
                                row["BankId"] = item["bene_bankid"]?.ToString();
                                row["bene_mobno"] = item["bene_mobno"]?.ToString();
                                row["BeneBank"] = item["bene_bank"]?.ToString();
                                row["IFSCCode"] = item["bene_ifsc"]?.ToString();
                                row["TransferMode"] = item["trnasferMode"]?.ToString();
                                row["LasttranId"] = item["lasttran_id"]?.ToString();
                                row["LasttranStatus"] = item["lasttran_status"]?.ToString();

                                row["LasttranDate"] = item["lasttran_date"]?.ToString();
                                row["LasttranTime"] = item["lasttran_time"]?.ToString();

                                dt.Rows.Add(row);
                            }

                            Repeater1.DataSource = dt;
                            Repeater1.DataBind();
                        }
                    }
                    else
                    {
                        labelerror.Text = "No data found.";
                    }
                }
                catch (Exception ex)
                {
                    labelerror.Text = "Invalid JSON response" + ex.Message;
                }
            }
            else
            {
                labelerror.Text = "API returned empty response.";
            }
        }

  
        protected void LinkButton4_Click(object sender, EventArgs e)
        {
            if (Session["SenderMobile"] != null)
            {
                txtsendermobile.Text = Session["SenderMobile"].ToString();
            }

            // Sidebar open karna
            ScriptManager.RegisterStartupScript(this, this.GetType(), "OpenSidebar", @"
        var myOffcanvas = document.getElementById('singlePayoutSidebar1');
        var bsOffcanvas = new bootstrap.Offcanvas(myOffcanvas);
        bsOffcanvas.show();
    ", true);
        }

        protected void lnkPay_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            string[] values = btn.CommandArgument.Split('|');

            string beneId = values[0];
            string accountNo = values.Length > 1 ? values[1] : "";
            string ifsc = values.Length > 2 ? values[2] : "";
            string bankName = values.Length > 3 ? values[3] : "";

            //txtBeneficiaryId.Text = beneId;
            string script = "var myOffcanvas = new bootstrap.Offcanvas(document.getElementById('paySidebar')); myOffcanvas.show();";
            ScriptManager.RegisterStartupScript(this, this.GetType(), "OpenPaySidebar", script, true);
        }

        protected void LinkButton6_Click(object sender, EventArgs e)
        {
            string BeneficiaryId = txtBeneficiaryId.Value;
            string Amount = txtAmount.Text;
            string transferType = ddlTransferType.SelectedValue;
            string SenderId = this.Session["SenderId"].ToString();
            string OrderId = Guid.NewGuid().ToString();
            string UserId = this.Session["BankURTUID"].ToString();
            string SenderMobile = this.Session["SenderMobile"].ToString();
            string TxnPin = txtTxnPin.Text;

            // 🔹 API Request JSON prepare
            var apiRequestObj = new JObject
    {
        { "apiToken", "c1fa1b07b5377fc9ca2c2894e7ba428d" },
        { "apiUserId", "5130" },
        { "senderId", SenderId },
        { "senderMobileNo", SenderMobile },
        { "transferType", transferType },
        { "beneficiaryId", BeneficiaryId },
        { "amount", Amount }
    };
            string apiRequest = apiRequestObj.ToString();

           
            using (SqlConnection con = new SqlConnection("Data Source=103.205.142.34,1433;Initial Catalog=BankUIndia_db;Persist Security Info=True;User ID=BankUIndia_db;Password=Chandan@80100"))
            {
                string query = @"INSERT INTO DMTPay 
                (Amount, TxnPin, OrderId, UserId, SenderId, Status, ApiRequest) 
                 VALUES (@Amount, @TxnPin, @OrderId, @UserId, @SenderId, @Status, @ApiRequest)";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@Amount", Amount);
                    cmd.Parameters.AddWithValue("@TxnPin", TxnPin);
                    cmd.Parameters.AddWithValue("@OrderId", OrderId);
                    cmd.Parameters.AddWithValue("@UserId", UserId);
                    cmd.Parameters.AddWithValue("@SenderId", SenderId);
                    cmd.Parameters.AddWithValue("@Status", "PENDING");
                    cmd.Parameters.AddWithValue("@ApiRequest", apiRequest); 
                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }

            decimal amount;
            decimal.TryParse(txtAmount.Text.Trim(), out amount);
            decimal balance = 0;
            decimal.TryParse(Um.GetBalance(UserId), out balance);
            if (amount > balance)
            {
                
                labelerror.Text = "Error: Insufficient balance Please add balance";
                return;
            }
            else
            {
                Decimal NewBalance = balance - amount;
                string conStr = ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString;
                using (SqlConnection conn = new SqlConnection(conStr))
                {
                    string query = @"INSERT INTO tbluserbalance
                    (Old_Bal,Amount,New_Bal,TxnType,crDrType,UserId,Remarks,TxnDatetime)
                    VALUES(@Old_Bal,@Amount,@New_Bal,@TxnType,@crDrType,@UserId,@Remarks,GETDATE());";
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@Old_Bal", balance);
                        cmd.Parameters.AddWithValue("@Amount", amount);
                        cmd.Parameters.AddWithValue("@New_Bal", NewBalance);
                        cmd.Parameters.AddWithValue("@TxnType", "DMT");
                        cmd.Parameters.AddWithValue("@crDrType", "Debit");
                        cmd.Parameters.AddWithValue("@UserId", UserId);
                        cmd.Parameters.AddWithValue("@Remarks", "Amount Debitted from DMT");
                        conn.Open();
                        cmd.ExecuteNonQuery();
                    }
                }
            }

            string url = "https://payzones.in/apipartner/apiservice/dmt/moneytransfer ";
            var client = new RestClient(url);
            var request = new RestRequest(Method.POST);

            request.AddParameter("apiToken", "c1fa1b07b5377fc9ca2c2894e7ba428d");
            request.AddParameter("apiUserId", "5130");
            request.AddParameter("senderId", SenderId);
            request.AddParameter("senderMobileNo", SenderMobile);
            request.AddParameter("transferType", transferType);
            request.AddParameter("beneficiaryId", BeneficiaryId);
            request.AddParameter("amount", Amount);
            string requestData = string.Join("&", request.Parameters
                .Where(p => p.Type == ParameterType.GetOrPost)
                .Select(p => $"{p.Name}={p.Value}"));
            IRestResponse response = client.Execute(request);
            string apiResponse = response.Content;
            Um.LogApiCall(UserId, requestData, apiResponse, "DMTMoneyTransfer");
            //  SAFETY CHECK BEFORE PARSING 

            if (string.IsNullOrWhiteSpace(apiResponse) || !apiResponse.TrimStart().StartsWith("{"))
            {
                
                labelerror.Text = "Invalid response from API. Raw response: " + apiResponse;
                returnpay(UserId, amount);
                return;
            }

            JObject json;

            try
            {
                json = JObject.Parse(apiResponse);
            }
            catch (Exception ex)
            {
                labelerror.Text = "JSON Parse Error: " + ex.Message + "<br/>Raw: " + apiResponse;
                returnpay(UserId, amount);
                return;
            }
 

            string status = json["transactionstatus"]?.ToString().ToUpper();
            string BeneName = json["bencname"]?.ToString();
            string IFSC = json["ifsc"]?.ToString();
            string AccountNo = json["accountno"]?.ToString();

            if (status == "SUCCESS"|| status=="PENDING" || status == "SUCCESSFULL")
            {
                using (SqlConnection con = new SqlConnection("Data Source=103.205.142.34,1433;Initial Catalog=BankUIndia_db;Persist Security Info=True;User ID=BankUIndia_db;Password=Chandan@80100"))
                {
                    con.Open();
                    string query = @"UPDATE DMTPay 
                     SET BeneName=@BeneName, IFSCCode=@IFSCCode, BankTransferMode=@BankTransferMode, 
                         AccountNo=@AccountNo, Status=@Status, ApiResponse=@ApiResponse 
                     WHERE OrderId=@OrderId";
                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@BeneName", (object)BeneName ?? DBNull.Value);
                    cmd.Parameters.AddWithValue("@IFSCCode", (object)IFSC ?? DBNull.Value);
                    cmd.Parameters.AddWithValue("@BankTransferMode", transferType);
                    cmd.Parameters.AddWithValue("@AccountNo", (object)AccountNo ?? DBNull.Value);
                    cmd.Parameters.AddWithValue("@Status", "SUCCESS");
                    cmd.Parameters.AddWithValue("@ApiResponse", apiResponse);
                    cmd.Parameters.AddWithValue("@OrderId", OrderId);
                    cmd.ExecuteNonQuery();
                }

                string script = "var myModal = new bootstrap.Modal(document.getElementById('successModal')); myModal.show();";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "showSuccessModal", script, true);

            }
            else
            {
                using (SqlConnection con = new SqlConnection("Data Source=103.205.142.34,1433;Initial Catalog=BankUIndia_db;Persist Security Info=True;User ID=BankUIndia_db;Password=Chandan@80100"))
                {
                    con.Open();
                    string query = @"UPDATE DMTPay 
                     SET Status=@Status, ApiResponse=@ApiResponse 
                     WHERE OrderId=@OrderId";
                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@Status", status ?? "FAILED");
                    cmd.Parameters.AddWithValue("@ApiResponse", apiResponse);
                    cmd.Parameters.AddWithValue("@OrderId", OrderId);
                    cmd.ExecuteNonQuery();
                }

                returnpay(UserId, amount);
            }
        }
        public void returnpay(string UserId, Decimal amount) 
        {
            decimal balance1 = 0;
            decimal.TryParse(Um.GetBalance(UserId), out balance1);
            Decimal NewBalance = balance1 + amount;
            string conStr = ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(conStr))
            {
                string query = @"INSERT INTO tbluserbalance
                    (Old_Bal,Amount,New_Bal,TxnType,crDrType,UserId,Remarks,TxnDatetime)
                    VALUES(@Old_Bal,@Amount,@New_Bal,@TxnType,@crDrType,@UserId,@Remarks,GETDATE());";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Old_Bal", balance1);
                    cmd.Parameters.AddWithValue("@Amount", amount);
                    cmd.Parameters.AddWithValue("@New_Bal", NewBalance);
                    cmd.Parameters.AddWithValue("@TxnType", "DMT Return");
                    cmd.Parameters.AddWithValue("@crDrType", "Credit");
                    cmd.Parameters.AddWithValue("@UserId", UserId);
                    cmd.Parameters.AddWithValue("@Remarks", "Amount returned to user (Transaction Failed)");
                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
            }
            labelerror.Text = "Something Went Wrong";
        }
    }
}


