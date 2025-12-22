using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using RestSharp;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;

namespace NeoXPayout
{
    public partial class AEPSNew : System.Web.UI.Page
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
                lblMessage1.Text = "AEPS Service is currently down. Please try later.";
                lblMessage1.ForeColor = System.Drawing.Color.Red;
                return;
            }


            if (!IsPostBack)
            {
                getbanklist();
                lblMessage1.Text = "No request available";
                    lblMessage1.ForeColor = System.Drawing.Color.Red;// remove this after report active
                //getReport();
            }
        }

        public class BankApiResponse
        {
            public string Status { get; set; }
            public string Message { get; set; }
            public string Data { get; set; }   
        }

        public class BankItem
        {
            public int bankId { get; set; }
            public string name { get; set; }
            public string iin { get; set; }
            public bool aepsEnabled { get; set; }
            public bool aadhaarpayEnabled { get; set; }
            public string aepsFailureRate { get; set; }
            public string aadhaarpayFailureRate { get; set; }
        }

        private void getbanklist()
        {
            try
            {
                string urlRecharge = "https://partner.banku.co.in/api/BankList";
                string bodyRecharge = "{\"Stype\":\"Bank\"}";

                var client = new RestClient(urlRecharge);
                var request = new RestRequest(Method.POST);

                request.AddHeader("Accept", "application/json");
                request.AddHeader("Content-Type", "application/json");
                request.AddParameter("application/json", bodyRecharge, ParameterType.RequestBody);

                IRestResponse response = client.Execute(request);

                if (!response.IsSuccessful || string.IsNullOrEmpty(response.Content))
                    throw new Exception("API call failed");

              
                BankApiResponse apiResponse =
                    JsonConvert.DeserializeObject<BankApiResponse>(response.Content);

                if (apiResponse == null || apiResponse.Status != "SUCCESS")
                    throw new Exception(apiResponse?.Message ?? "Invalid API response");

               
                List<BankItem> banks =
                    JsonConvert.DeserializeObject<List<BankItem>>(apiResponse.Data);

             
                ddlCircle.DataSource = banks;
                ddlCircle.DataTextField = "name";   // Bank Name
                ddlCircle.DataValueField = "iin";   // Bank IIN
                ddlCircle.DataBind();

                ddlCircle.Items.Insert(0, new ListItem("-- Select Bank --", ""));
            }
            catch (Exception ex)
            {
               
                lblError1.Text = ex.Message;

            }
        }

        private bool IsRechargeServiceActive()
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
               
                string query = "SELECT Status FROM BankUServices WHERE ServiceName = @ServiceName";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@ServiceName", "AEPS");
                    con.Open();

                    object statusObj = cmd.ExecuteScalar();
                    if (statusObj == null || statusObj == DBNull.Value)
                        return false; 

                    string status = statusObj.ToString();
                    
                    return (status.Equals("Active", StringComparison.OrdinalIgnoreCase) || status == "1");
                }
            }
        }
        //protected void getReport()
        //{
        //    using (SqlConnection con = new SqlConnection(connStr))
        //    {
        //        string query = "SELECT * FROM BankPayouts Order By Id Asc";
        //        using (SqlCommand cmd = new SqlCommand(query, con))
        //        {
        //            con.Open();
        //            SqlDataReader reader = cmd.ExecuteReader();

        //            if (!reader.HasRows)
        //            {
        //                gvRequests.Visible = false;
        //                lblMessage1.Text = "No request available";
        //                lblMessage1.ForeColor = System.Drawing.Color.Red;
        //            }
        //            else
        //            {
        //                gvRequests.Visible = true;
        //                gvRequests.DataSource = reader;
        //                gvRequests.DataBind();
        //                lblMessage1.Text = "";
        //            }
        //        }
        //    }
        //}
        protected void lnkSaveFingerprint_Click(object sender, EventArgs e)
        {
            try
            {
                string pidXml = hdnPidData.Value;

                if (string.IsNullOrEmpty(pidXml) || !pidXml.Contains("<PidData"))
                {
                    throw new Exception("Invalid fingerprint data");
                }

                SaveFingerprintToDatabase(pidXml);
                //AepsTxn(pidXml);

                //ScriptManager.RegisterStartupScript(
                //    this, GetType(),
                //    "msg",
                //    "alert('Fingerprint stored successfully');",
                //    true
                //);
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(
                    this, GetType(),
                    "err",
                    $"alert('Error saving fingerprint: {ex.Message}');",
                    true
                );
            }
        }
        public class AepsMainRequest
        {
            public string mobileNo { get; set; }
            public AepsRequest request { get; set; }

            // Root-level fields
            public string user_agent { get; set; }
            public string userid { get; set; }
            public string newmobileappversion { get; set; }
        }

        public class AepsRequest
        {
            public string aadhaarUid { get; set; }
            public string agentId { get; set; }
            public string amount { get; set; }
            public string bankIIn { get; set; }
            public string ci { get; set; }
            public string dc { get; set; }
            public string dpId { get; set; }
            public string errCode { get; set; }
            public string errInfo { get; set; }
            public string fCount { get; set; }
            public string hmac { get; set; }
            public string iCount { get; set; }
            public string latitude { get; set; }
            public string longitude { get; set; }
            public string mc { get; set; }
            public string mi { get; set; }
            public string mobile { get; set; }
            public string nmPoints { get; set; }
            public string pCount { get; set; }
            public string pType { get; set; }
            public string pidData { get; set; }
            public string pidDataType { get; set; }
            public string qScore { get; set; }
            public string rdsId { get; set; }
            public string rdsVer { get; set; }
            public string sessionKey { get; set; }
            public string sp_key { get; set; }
            public string srno { get; set; }
            public string tType { get; set; }
            public string user_agent { get; set; }
            public string userid { get; set; }
            public string newmobileappversion { get; set; }
        }

        public class AepsAjaxRequest
        {
            public string pidXml { get; set; }
            public string mobile { get; set; }
            public string amount { get; set; }
            public string bankIin { get; set; }
            public string aadhaar { get; set; }
            public string latitude { get; set; }
            public string longitude { get; set; }
            public string operatorType { get; set; }
        }
        [WebMethod]
        [System.Web.Script.Services.ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static object AepsTxnAjax(AepsAjaxRequest model)
        {
            try
            {
                HttpContext context = HttpContext.Current;

                string UserId = context.Session["BankURTUID"].ToString();
                string txnType = "";

                switch (model.operatorType)
                {
                    case "Statement": txnType = "SAP"; break;
                    case "Balance": txnType = "BAP"; break;
                    case "Withdraw": txnType = "WAP"; break;
                    case "AadharPay": txnType = "MZZ"; break;
                    case "login": txnType = "login"; break;
                }

             
                string Agentid = "BANKU"+ DateTime.Now.ToString("yyyyMMdd") + new Random().Next(100000, 999999).ToString();

                XmlDocument doc = new XmlDocument();
                doc.LoadXml(model.pidXml);

                string errCode = doc.SelectSingleNode("//Resp")?.Attributes["errCode"]?.Value;
                string errInfo = doc.SelectSingleNode("//Resp")?.Attributes["errInfo"]?.Value;
                string fCount = doc.SelectSingleNode("//Resp")?.Attributes["fCount"]?.Value;
                string hmac = doc.SelectSingleNode("//Hmac")?.InnerText;

                string ci = doc.SelectSingleNode("//Skey")?.Attributes["ci"]?.Value;
                string dc = doc.SelectSingleNode("//DeviceInfo")?.Attributes["dc"]?.Value;
                string mc = doc.SelectSingleNode("//DeviceInfo")?.Attributes["mc"]?.Value;
                string dpId = doc.SelectSingleNode("//DeviceInfo")?.Attributes["DpId"]?.Value;
                string mi = doc.SelectSingleNode("//DeviceInfo")?.Attributes["mi"]?.Value;
                string nmPoints = doc.SelectSingleNode("//Resp")?.Attributes["nmPoints"]?.Value;
                string qScore = doc.SelectSingleNode("//Resp")?.Attributes["qScore"]?.Value;
                string rdsId = doc.SelectSingleNode("//DeviceInfo")?.Attributes["rdsId"]?.Value;
                string rdsVer = doc.SelectSingleNode("//DeviceInfo")?.Attributes["rdsVer"]?.Value;
                string pidData = doc.SelectSingleNode("//Data")?.InnerText;
                string pidDataType = doc.SelectSingleNode("//Data")?.Attributes["type"]?.Value;
                string skey = doc.SelectSingleNode("//Skey")?.InnerText;

                XmlNode srnoNode = doc.SelectSingleNode("//additional_info/Param[@name='srno']");
                string srno = srnoNode?.Attributes["value"]?.Value;

                var bodyObj = new AepsMainRequest
                {
                    mobileNo = model.mobile,
                    userid = UserId,
                    user_agent = context.Request.UserAgent,
                    newmobileappversion = "1.0.1",
                    request = new AepsRequest
                    {
                        aadhaarUid = model.aadhaar,
                        agentId = Agentid,
                        amount = model.amount,
                        bankIIn = model.bankIin,
                        ci = ci,
                        dc = dc,
                        dpId = dpId,
                        errCode = errCode,
                        errInfo = errInfo,
                        fCount = fCount,
                        hmac = hmac,
                        iCount = "0",
                        latitude = model.latitude,
                        longitude = model.longitude,
                        mc = mc,
                        mi = mi,
                        mobile = model.mobile,
                        nmPoints = nmPoints,
                        pCount = "0",
                        pType = "",
                        pidData = pidData,
                        pidDataType = pidDataType,
                        qScore = qScore,
                        rdsId = rdsId,
                        rdsVer = rdsVer,
                        sessionKey = skey,
                        sp_key = txnType,
                        srno = srno,
                        tType = "null"
                    }
                };

                string jsonBody = JsonConvert.SerializeObject(bodyObj);

                var client = new RestClient("https://partner.banku.co.in/api/AEPSTXN");
                var request = new RestRequest(Method.POST);
                request.AddHeader("Content-Type", "application/json");
                request.AddParameter("application/json", jsonBody, ParameterType.RequestBody);

                IRestResponse apiResponse = client.Execute(request);

                return new
                {
                    success = true,
                    response = apiResponse.Content
                };
            }
            catch (Exception ex)
            {
                return new
                {
                    success = false,
                    message = ex.Message
                };
            }
        }
      
        //private void AepsTxn(string pidXml)
        //{
        //    string UserId = Session["BankURTUID"].ToString();
        //    string mobileno = txtMobile.Text;
        //    string amount = txtamount.Text;
        //    string Bankin = ddlCircle.SelectedValue;
        //    string aadhar = txtAadhar.Text;
        //    string Latitude = hdLatitude.Value;
        //    string Longitude = hdLongitude.Value;
        //    string txnType = "";
        //    switch (hfOperator.Value)
        //    {
        //        case "Statement":
        //            txnType = "SAP";
        //            break;
        //        case "Balance":
        //            txnType = "BAP";
        //            break;
        //        case "Withdraw":
        //            txnType = "WAP";
        //            break;
        //        case "login":
        //            txnType = "login";
        //            break;
        //    }

        //    XmlDocument doc = new XmlDocument();
        //    doc.LoadXml(pidXml);

        //    Read attribute
        //    string errCode = doc.SelectSingleNode("//Resp")
        //                        .Attributes["errCode"].Value;

        //    string errInfo = doc.SelectSingleNode("//Resp")
        //                     .Attributes["errInfo"].Value;

        //    string FCount = doc.SelectSingleNode("//Resp")
        //                     .Attributes["fCount"].Value;

        //    string hmac = doc.SelectSingleNode("//Hmac").InnerText;


        //    string ci = doc.SelectSingleNode("//Skey")
        //                    .Attributes["ci"].Value;

        //    string Dcvalue = doc.SelectSingleNode("//DeviceInfo")
        //                 .Attributes["dc"].Value;

        //    string MCvalue = doc.SelectSingleNode("//DeviceInfo")
        //               .Attributes["mc"].Value;

        //    string DpId = doc.SelectSingleNode("//DeviceInfo")
        //                .Attributes["DpId"].Value;

        //    string MIValue = doc.SelectSingleNode("//DeviceInfo")
        //              .Attributes["mi"].Value;

        //    string NMPoint = doc.SelectSingleNode("//Resp")
        //                    .Attributes["nmPoints"].Value;

        //    string PIDData = doc.SelectSingleNode("//Data").InnerText;

        //    string PIDDataType = doc.SelectSingleNode("//Data")
        //                      .Attributes["type"].Value;

        //    string QScore = doc.SelectSingleNode("//Resp")
        //                  .Attributes["qScore"].Value;

        //    string RDsId = doc.SelectSingleNode("//DeviceInfo")
        //              .Attributes["rdsId"].Value;

        //    string RDSVer = doc.SelectSingleNode("//DeviceInfo")
        //             .Attributes["rdsVer"].Value;

        //    string SKey = doc.SelectSingleNode("//Skey").InnerText;

        //    XmlNode srnoNode = doc.SelectSingleNode(
        //        "//additional_info/Param[@name='srno']"
        //    );

        //    string srno = srnoNode.Attributes["value"].Value;

        //    string urlRecharge = "https://partner.banku.co.in/api/AEPSTXN";
        //    var bodyObj = new AepsMainRequest
        //    {
        //        mobileNo = mobileno,
        //        request = new AepsRequest
        //        {
        //            aadhaarUid = aadhar,
        //            agentId = "ORBIT20220401211758",
        //            amount = amount,
        //            bankIIn = Bankin,
        //            ci = ci,
        //            dc = Dcvalue,
        //            dpId = DpId,
        //            errCode = errCode,
        //            errInfo = errInfo,
        //            fCount = FCount,
        //            hmac = hmac,
        //            iCount = "0",
        //            latitude = Latitude,
        //            longitude = Longitude,
        //            mc = MCvalue,
        //            mi = MIValue,
        //            mobile = mobileno,
        //            nmPoints = NMPoint,
        //            pCount = "0",
        //            pType = "",
        //            pidData = PIDData,
        //            pidDataType = PIDDataType,
        //            qScore = QScore,
        //            rdsId = RDsId,
        //            rdsVer = RDSVer,
        //            sessionKey = SKey,
        //            sp_key = txnType,
        //            srno = srno,
        //            tType = "null"
        //        },
        //        user_agent = Request.UserAgent,
        //        userid = UserId,
        //        newmobileappversion = "1.0.1"
        //    };

        //    string bodyAEPS = JsonConvert.SerializeObject(bodyObj);

        //    string Apiresponse = String.Empty;
        //    var client = new RestClient(urlRecharge);
        //    var request = new RestRequest(Method.POST);
        //    request.AddHeader("cache-control", "no-cache");
        //    request.AddHeader("Accept", "application/json");
        //    request.AddHeader("Content-Type", "application/json");
        //    request.AddParameter("application/json", bodyAEPS, RestSharp.ParameterType.RequestBody);
        //    IRestResponse response = client.Execute(request);
        //    Apiresponse = response.Content;
        //    Um.LogApiCall(UserId, bodyAEPS, Apiresponse, "AEPSTXN");

        //    if (!string.IsNullOrEmpty(Apiresponse))
        //    {
        //        if (txnType.ToLower() == "login")
        //        {
        //            JObject jobject = JObject.Parse(Apiresponse);
        //            string Message = "";
        //            string status = "";
        //            Message = jobject["Message"].ToString();
        //            status = jobject["status"].ToString();
        //            if (status == "SUCCESS")
        //            {
        //                ClientScript.RegisterStartupScript(
        //                 this.GetType(),
        //                 "successPopup",
        //                 "showSuccess('Authentication Successful');",
        //                 true
        //             );

        //            }
        //            else
        //            {
        //                ClientScript.RegisterStartupScript(
        //                   this.GetType(),
        //                   "failedPopup",
        //                   "showFailed('Authentication failed');",
        //                   true
        //               );
        //            }

        //        }
        //        else
        //        {
        //            JObject jobject = JObject.Parse(Apiresponse);


        //            string Message = "";
        //            string status = "";
        //            Message = jobject["Message"].ToString(); // continue from here acc to response
        //            status = jobject["status"].ToString();
        //            if (status == "SUCCESS")
        //            {
        //                if (txnType == "WAP")
        //                {

        //                    ClientScript.RegisterStartupScript(
        //                        this.GetType(),
        //                        "successPopup",
        //                        "showSuccess('Cash Withdrawal Successful');",
        //                        true
        //                    );

        //                }
        //                else if (txnType == "BAP")
        //                {

        //                    ClientScript.RegisterStartupScript(
        //                     this.GetType(),
        //                     "successPopup",
        //                     "showSuccess('Balance Inquiry Successful');",
        //                     true
        //                     );

        //                }
        //                else if (txnType == "sap")
        //                {

        //                    ClientScript.RegisterStartupScript(
        //                  this.GetType(),
        //                  "successPopup",
        //                  "showSuccess('Mini Statement Fetched Successfully');",
        //                  true
        //                  );

        //                }

        //            }
        //            else
        //            {
        //                if (txnType == "WAP")
        //                {
        //                    ClientScript.RegisterStartupScript(
        //                   this.GetType(),
        //                   "failedPopup",
        //                   "showFailed('Cash Withdrawal failed');",
        //                   true
        //                    );
        //                }
        //                else if (txnType == "BAP")
        //                {
        //                    ClientScript.RegisterStartupScript(
        //                        this.GetType(),
        //                        "failedPopup",
        //                        "showFailed('Balance Inquiry failed');",
        //                        true
        //                    );
        //                }
        //                else
        //                {
        //                    ClientScript.RegisterStartupScript(
        //                        this.GetType(),
        //                        "failedPopup",
        //                        "showFailed('Mini Statement failed');",
        //                        true
        //                    );
        //                }
        //            }

        //            if (statuscode == "ERR" || statuscode == "SPD" || statuscode == "DTX" || statuscode == "TDE" || statuscode == "ISE" || statuscode == "FAB" || statuscode == "IUA" || statuscode == "IPE" || statuscode == "SPE")
        //            {

        //                if (txnType == "WAP")
        //                {
        //                    ClientScript.RegisterStartupScript(
        //                        this.GetType(),
        //                        "failedPopup",
        //                        "showFailed('Cash Withdrawal failed');",
        //                        true
        //                    );
        //                }
        //                else if (txnType == "BAP")
        //                {
        //                    ClientScript.RegisterStartupScript(
        //                        this.GetType(),
        //                        "failedPopup",
        //                        "showFailed('Balance Inquiry failed');",
        //                        true
        //                    );
        //                }

        //                else if (txnType == "MZZ")
        //                {
        //                    ClientScript.RegisterStartupScript(
        //                    this.GetType(),
        //                    "failedPopup",
        //                    "showFailed('Mini Statement failed');",
        //                    true
        //                );
        //                }
        //                else
        //                {
        //                    ClientScript.RegisterStartupScript(
        //                        this.GetType(),
        //                        "failedPopup",
        //                        "showFailed('Login failed');",
        //                        true
        //                    );
        //                }

        //            }
        //            else
        //            {
        //                ClientScript.RegisterStartupScript(
        //                    this.GetType(),
        //                    "failedPopup",
        //                    "showFailed('Login failed');",
        //                    true
        //                );

        //            }
        //        }
        //    }

        //}
        private void SaveFingerprintToDatabase(string pidXml)
        {
            if (string.IsNullOrEmpty(pidXml) || !pidXml.Contains("<PidData"))
            {
                throw new Exception("Invalid PID XML");
            }

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand(
                    @"INSERT INTO tblFingerprintLog
              (UserId, PidXml, CreatedDate, IPAddress)
              VALUES
              (@UserId, @PidXml, GETDATE(), @IP)", con))
                {
                    cmd.Parameters.AddWithValue("@UserId", Session["BankURTUID"]);
                    cmd.Parameters.AddWithValue("@PidXml", pidXml);
                    cmd.Parameters.AddWithValue("@IP", Request.UserHostAddress);

                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }
        }
    }
}