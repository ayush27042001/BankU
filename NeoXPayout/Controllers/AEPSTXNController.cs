using NeoXPayout.Models;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using RestSharp;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Net;
using System.Net.Http;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.Http;

namespace NeoXPayout.Controllers
{
    public class AEPSTXNController : ApiController
    {

        public const string InstanPayEkycAesKey = "25835e97bad3d45525835e97bad3d455";
        string opening_bal = "";
        string ipay_id = "";
        string amount = "";
        string amount_txn = "";
        string account_no = "";
        //string txn_mode = "";
        //string txn_status = "";
        string opr_id = "";
        string balance = "";
        string timestamp = "";
        string ipay_uuid = "";
        string orderid = "";
        string environment = "";
        [HttpPost]

        public LoginModel GetData(JObject obj)
        {
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["OrbitStepConnectionString"].ConnectionString);
            string a = obj.ToString();
            string sqlfr12 = "insert into AEPSRequestLogs(request,responce,ApiType,reqdate)values(@request,@responce,@ApiType,@reqdate)";
            SqlCommand cmdfr12 = new SqlCommand(sqlfr12, con);
            cmdfr12.Parameters.AddWithValue("@request", "AePS Request");
            cmdfr12.Parameters.AddWithValue("@responce", a);
            cmdfr12.Parameters.AddWithValue("@reqdate", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss.fff"));
            cmdfr12.Parameters.AddWithValue("@ApiType", "FULL Request");
            con.Open();
            cmdfr12.ExecuteNonQuery();
            con.Close();
            try
            {
                string mobileNo = obj["mobileNo"].ToString();//New Perameter
                string userid = obj["userid"].ToString();// New Perameter
                string token = "70515b9af3638f7fb5b87e22883e500a";
                string outlet_id = getoutlet(userid);
                string useramount = obj["request"]["amount"].ToString();
                string aadhaar_uid = obj["request"]["aadhaar_uid"].ToString();
                string bankiin = obj["request"]["bankiin"].ToString();
                string latitude = obj["request"]["latitude"].ToString();
                string longitude = obj["request"]["longitude"].ToString();
                string mobile = obj["request"]["mobile"].ToString();
                string agent_id = obj["request"]["agent_id"].ToString();
                string sp_key = obj["request"]["sp_key"].ToString();
                string pidDataType = obj["request"]["pidDataType"].ToString();
                string pidData = obj["request"]["pidData"].ToString();
                string ci = obj["request"]["ci"].ToString();
                string dc = obj["request"]["dc"].ToString();
                string dpId = obj["request"]["dpId"].ToString();
                string errCode = obj["request"]["errCode"].ToString();
                string errInfo = obj["request"]["errInfo"].ToString();
                string fCount = obj["request"]["fCount"].ToString();
                //string tType = null;
                string hmac = obj["request"]["hmac"].ToString();
                string iCount = obj["request"]["iCount"].ToString();
                string mc = obj["request"]["mc"].ToString();
                string mi = obj["request"]["mi"].ToString();
                string nmPoints = obj["request"]["nmPoints"].ToString();
                string pCount = obj["request"]["pCount"].ToString();
                string pType = obj["request"]["pType"].ToString();
                string qScore = obj["request"]["qScore"].ToString();
                string rdsId = obj["request"]["rdsId"].ToString();
                string rdsVer = obj["request"]["rdsVer"].ToString();
                string sessionKey = obj["request"]["sessionKey"].ToString();
                string srno = obj["request"]["srno"].ToString();
                string user_agent = obj["user_agent"].ToString();
                string appversion = obj["newmobileappversion"].ToString();
                if (appversion == GetMobileAppVersion())
                {
                    if (outlet_id != "0" && outlet_id != "")
                    {
                        string uvarify = userid;
                        if (uvarify != "0")
                        {
                            string ProdKey = "";
                            string ProdName = "";
                            if (sp_key == "BAP")
                            {
                                ProdKey = "5011";
                                ProdName = "BALANCE_ENQUIRY";
                            }
                            if (sp_key.ToUpper() == "LOGIN")
                            {
                                ProdKey = "0";
                                ProdName = "LOGIN";
                            }
                            if (sp_key == "SAP")
                            {
                                ProdKey = "5012";
                                ProdName = "Mini Statement";
                            }
                            if (sp_key == "WAP")
                            {
                                decimal tamt = Convert.ToDecimal(useramount);
                                if (tamt <= 499)
                                {
                                    ProdKey = "5013";
                                    ProdName = "100-499";
                                }
                                else if (tamt <= 999)
                                {
                                    ProdKey = "5014";
                                    ProdName = "500-999";
                                }
                                else if (tamt <= 1499)
                                {
                                    ProdKey = "5015";
                                    ProdName = "1000-1499";
                                }
                                else if (tamt <= 1999)
                                {
                                    ProdKey = "5016";
                                    ProdName = "1500-1999";
                                }
                                else if (tamt <= 2999)
                                {
                                    ProdKey = "5017";
                                    ProdName = "2000-2999";
                                }
                                else if (tamt <= 3499)
                                {
                                    ProdKey = "5018";
                                    ProdName = "3000-3499";
                                }
                                else if (tamt == 3500)
                                {
                                    ProdKey = "5019";
                                    ProdName = "3500";
                                }
                                else if (tamt <= 7000)
                                {
                                    ProdKey = "5020";
                                    ProdName = "3501-7000";
                                }
                                else if (tamt <= 10000)
                                {
                                    ProdKey = "5021";
                                    ProdName = "7001-10000";
                                }
                            }

                            if (sp_key == "MZZ")
                            {
                                ProdKey = "5030";
                                ProdName = "Aadhaar Pay Withdrawal";
                            }

                            string TransactionID = DateTime.Now.ToString("yyMMddHHmmssfff");
                            UserManagement Um = new UserManagement();
                            decimal oldbalance = Convert.ToDecimal(Um.bindaepsbal(userid));
                            string commission = Um.GetCommission(Convert.ToInt32(Um.GetPlan(userid)), Convert.ToInt32(ProdKey), Convert.ToDecimal(useramount));
                            string charge = Um.GetCharge(Convert.ToInt32(Um.GetPlan(userid)), Convert.ToInt32(ProdKey), Convert.ToDecimal(useramount));
                            decimal Comm = 0, Surcharge = 0, Tds = 0, Gst = 0;
                            decimal.TryParse(commission, out Comm);
                            decimal.TryParse(charge, out Surcharge);
                            Tds = Comm * 5 / 100;
                            Gst = Surcharge * 18 / 100;
                            decimal newbalance = (oldbalance + Convert.ToDecimal(useramount) + (Convert.ToDecimal(commission) - Tds) - (Convert.ToDecimal(charge) + Gst));
                            //if (aepscontent == "1")
                            //{
                            string AePSTransactionUrl = "";
                            string RequestBody = "";
                            if (sp_key.ToLower() == "wap")
                            {
                                AePSTransactionUrl = "https://api.instantpay.in/fi/aeps/cashWithdrawal";
                                RequestBody = "{\"bankiin\":\"" + bankiin + "\",\"latitude\": \"" + latitude + "\",\"longitude\": \"" + longitude + "\",\"mobile\": \"" + mobileNo + "\",\"amount\": \"" + useramount + "\",\"externalRef\": \"" + TransactionID + "\",\"biometricData\": {\"encryptedAadhaar\":\"" + AESEncryption(aadhaar_uid) + "\",\"dc\":\"" + dc + "\",\"ci\":\"" + ci + "\",\"hmac\": \"" + hmac + "\",\"dpId\": \"" + dpId + "\",\"mc\": \"" + mc + "\",\"pidDataType\": \"X\",\"sessionKey\": \"" + sessionKey + "\",\"mi\": \"" + mi + "\",\"rdsId\": \"" + rdsId + "\",\"errCode\": \"" + errCode + "\",\"errInfo\": \"" + errInfo + "\",\"fCount\": \"" + fCount + "\",\"fType\": \"2\",\"iCount\": 0,\"iType\": \"\",\"pCount\": 0,\"pType\": \"\",\"srno\": \"N00115075\",\"sysid\": \"\",\"ts\": \"\",\"pidData\": \"" + pidData + "\",\"qScore\": \"" + qScore + "\",\"nmPoints\": \"" + nmPoints + "\",\"rdsVer\": \"" + rdsVer + "\"}}";
                            }
                            else if (sp_key.ToLower() == "bap")
                            {
                                AePSTransactionUrl = "https://api.instantpay.in/fi/aeps/balanceInquiry";
                                RequestBody = "{\"bankiin\":\"" + bankiin + "\",\"latitude\": \"" + latitude + "\",\"longitude\": \"" + longitude + "\",\"mobile\": \"" + mobileNo + "\",\"externalRef\": \"" + TransactionID + "\",\"biometricData\": {\"encryptedAadhaar\":\"" + AESEncryption(aadhaar_uid) + "\",\"dc\":\"" + dc + "\",\"ci\":\"" + ci + "\",\"hmac\": \"" + hmac + "\",\"dpId\": \"" + dpId + "\",\"mc\": \"" + mc + "\",\"pidDataType\": \"X\",\"sessionKey\": \"" + sessionKey + "\",\"mi\": \"" + mi + "\",\"rdsId\": \"" + rdsId + "\",\"errCode\": \"" + errCode + "\",\"errInfo\": \"" + errInfo + "\",\"fCount\": \"" + fCount + "\",\"fType\": \"2\",\"iCount\": 0,\"iType\": \"\",\"pCount\": 0,\"pType\": \"\",\"srno\": \"N00115075\",\"sysid\": \"\",\"ts\": \"\",\"pidData\": \"" + pidData + "\",\"qScore\": \"" + qScore + "\",\"nmPoints\": \"" + nmPoints + "\",\"rdsVer\": \"" + rdsVer + "\"}}";
                            }
                            else if (sp_key.ToLower() == "sap")
                            {
                                AePSTransactionUrl = "https://api.instantpay.in/fi/aeps/miniStatement";
                                RequestBody = "{\"bankiin\":\"" + bankiin + "\",\"latitude\": \"" + latitude + "\",\"longitude\": \"" + longitude + "\",\"mobile\": \"" + mobileNo + "\",\"amount\": \"" + useramount + "\",\"externalRef\": \"" + TransactionID + "\",\"biometricData\": {\"encryptedAadhaar\":\"" + AESEncryption(aadhaar_uid) + "\",\"dc\":\"" + dc + "\",\"ci\":\"" + ci + "\",\"hmac\": \"" + hmac + "\",\"dpId\": \"" + dpId + "\",\"mc\": \"" + mc + "\",\"pidDataType\": \"X\",\"sessionKey\": \"" + sessionKey + "\",\"mi\": \"" + mi + "\",\"rdsId\": \"" + rdsId + "\",\"errCode\": \"" + errCode + "\",\"errInfo\": \"" + errInfo + "\",\"fCount\": \"" + fCount + "\",\"fType\": \"2\",\"iCount\": 0,\"iType\": \"\",\"pCount\": 0,\"pType\": \"\",\"srno\": \"N00115075\",\"sysid\": \"\",\"ts\": \"\",\"pidData\": \"" + pidData + "\",\"qScore\": \"" + qScore + "\",\"nmPoints\": \"" + nmPoints + "\",\"rdsVer\": \"" + rdsVer + "\"}}";
                            }
                            else if (sp_key.ToLower() == "login")
                            {
                                AePSTransactionUrl = "https://api.instantpay.in/fi/aeps/outletLogin";
                                RequestBody = "{\"type\":\"DAILY_LOGIN\",\"bankiin\":\"" + bankiin + "\",\"externalRef\": \"" + TransactionID + "\",\"latitude\": \"" + latitude + "\",\"longitude\": \"" + longitude + "\",\"biometricData\": {\"encryptedAadhaar\":\"" + AESEncryption(aadhaar_uid) + "\",\"dc\":\"" + dc + "\",\"ci\":\"" + ci + "\",\"hmac\": \"" + hmac + "\",\"dpId\": \"" + dpId + "\",\"mc\": \"" + mc + "\",\"pidDataType\": \"X\",\"sessionKey\": \"" + sessionKey + "\",\"mi\": \"" + mi + "\",\"rdsId\": \"" + rdsId + "\",\"errCode\": \"" + errCode + "\",\"errInfo\": \"" + errInfo + "\",\"fCount\": \"" + fCount + "\",\"fType\": \"2\",\"iCount\": 0,\"iType\": \"\",\"pCount\": 0,\"pType\": \"\",\"srno\": \"N00115075\",\"sysid\": \"\",\"ts\": \"\",\"pidData\": \"" + pidData + "\",\"qScore\": \"" + qScore + "\",\"nmPoints\": \"" + nmPoints + "\",\"rdsVer\": \"" + rdsVer + "\"}}";
                            }
                            else
                            {
                                AePSTransactionUrl = "https://api.instantpay.in/fi/aeps/aadhaarPay";
                                RequestBody = "{\"bankiin\":\"" + bankiin + "\",\"latitude\": \"" + latitude + "\",\"longitude\": \"" + longitude + "\",\"mobile\": \"" + mobileNo + "\",\"amount\": \"" + useramount + "\",\"externalRef\": \"" + TransactionID + "\",\"biometricData\": {\"encryptedAadhaar\":\"" + AESEncryption(aadhaar_uid) + "\",\"dc\":\"" + dc + "\",\"ci\":\"" + ci + "\",\"hmac\": \"" + hmac + "\",\"dpId\": \"" + dpId + "\",\"mc\": \"" + mc + "\",\"pidDataType\": \"X\",\"sessionKey\": \"" + sessionKey + "\",\"mi\": \"" + mi + "\",\"rdsId\": \"" + rdsId + "\",\"errCode\": \"" + errCode + "\",\"errInfo\": \"" + errInfo + "\",\"fCount\": \"" + fCount + "\",\"fType\": \"2\",\"iCount\": 0,\"iType\": \"\",\"pCount\": 0,\"pType\": \"\",\"srno\": \"N00115075\",\"sysid\": \"\",\"ts\": \"\",\"pidData\": \"" + pidData + "\",\"qScore\": \"" + qScore + "\",\"nmPoints\": \"" + nmPoints + "\",\"rdsVer\": \"" + rdsVer + "\"}}";
                            }
                            //var client = new RestClient(AePSTransactionUrl);
                            //client.Timeout = -1;
                            //var request = new RestRequest(Method.POST);
                            //request.AddHeader("Content-Type", "application/json");
                            //request.AddHeader("X-Ipay-Auth-Code", "1");
                            //request.AddHeader("X-Ipay-Client-Id", "YWY3OTAzYzNlM2ExZTJlObfzvic/bTaahaNPYnBJ8UI=");
                            //request.AddHeader("X-Ipay-Client-Secret", "a0cf47b2ffd39a4ab3ab337a00dfea7dcb82db71e84831d862622687353e2eff");
                            //request.AddHeader("X-Ipay-Outlet-Id", outlet_id);
                            //request.AddHeader("X-Ipay-Endpoint-Ip", HttpContext.Current.Request.UserHostAddress);
                            //request.AddParameter("application/json", RequestBody, ParameterType.RequestBody);
                            //IRestResponse response = client.Execute(request);
                            var headers = new Dictionary<string, string>
                            {
                            { "X-Ipay-Auth-Code","1"},
                            { "X-Ipay-Client-Id","YWY3OTAzYzNlM2ExZTJlObfzvic/bTaahaNPYnBJ8UI="},
                            { "X-Ipay-Client-Secret","a0cf47b2ffd39a4ab3ab337a00dfea7dcb82db71e84831d862622687353e2eff"},
                            { "X-Ipay-Outlet-Id",outlet_id},
                            { "X-Ipay-Endpoint-Ip",HttpContext.Current.Request.UserHostAddress},
                            };
                            string content = ApiPost(AePSTransactionUrl, RequestBody, headers);
                            string bodyparameter = "App Aeps" + RequestBody;
                            string sqlfr = "insert into AEPSRequestLogs(request,responce,ApiType,reqdate)values(@request,@responce,@ApiType,@reqdate)";
                            SqlCommand cmdfr = new SqlCommand(sqlfr, con);
                            cmdfr.Parameters.AddWithValue("@request", bodyparameter);
                            cmdfr.Parameters.AddWithValue("@responce", content);
                            cmdfr.Parameters.AddWithValue("@reqdate", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss.fff"));
                            cmdfr.Parameters.AddWithValue("@ApiType", "transaction");
                            con.Open();
                            cmdfr.ExecuteNonQuery();
                            con.Close();
                            if (!string.IsNullOrEmpty(content))
                            {
                                if (sp_key.ToLower() == "login")
                                {
                                    JObject jobject = JObject.Parse(content);
                                    string statuscode = "";
                                    string status = "";
                                    statuscode = jobject["statuscode"].ToString();
                                    status = jobject["status"].ToString();
                                    if (statuscode == "TXN" || statuscode == "TUP")
                                    {
                                        LoginModel Name1 = new LoginModel();
                                        List<aepsresponse> responses = new List<aepsresponse>();
                                        responses.Add(new aepsresponse
                                        {
                                            status = status,
                                            orderstatus = "SUCCESS",
                                            txntype = "LOGIN",
                                            orderamount = "0",
                                            acamount = "0",
                                            agentid = "0",
                                            bankrefno = "0",
                                            OldBalance = "0",
                                            NewBalance = "0",
                                            Commission = "0"
                                        });
                                        Name1.Status = "SUCCESS";
                                        Name1.Message = "Transaction Successful.";
                                        Name1.Data = responses;
                                        return Name1;
                                    }
                                    else
                                    {
                                        LoginModel Name1 = new LoginModel();
                                        List<aepsresponse> responses = new List<aepsresponse>();
                                        responses.Add(new aepsresponse
                                        {
                                            status = status,
                                            orderstatus = "FAILED",
                                            txntype = "LOGIN",
                                            orderamount = "0",
                                            acamount = "0",
                                            agentid = "0",
                                            bankrefno = "0",
                                            OldBalance = "0",
                                            NewBalance = "0",
                                            Commission = "0"
                                        });
                                        Name1.Status = "FAILED";
                                        Name1.Message = "Transaction FAILED.";
                                        Name1.Data = responses;
                                        return Name1;
                                    }

                                }
                                else
                                {
                                    JObject jobject = JObject.Parse(content);

                                    //JObject jobject = JObject.Parse("{\"statuscode\":\"TXN\", \"actcode\":null,\"status\":\"Transaction Successful\", \"data\":{ \"externalRef\":\"230816182847865\",\"bankName\":\"IndusInd Bank\", \"accountNumber\":\"xxxxxxxx3762\", \"ipayId\":\"CPJ012322818284922\", \"transactionMode\":\"CR\", \"payableValue\":\"200.72\", \"transactionValue\":\"200.00\", \"openingBalance\":\"188.68\", \"closingBalance\":\"389.40\", \"operatorId\":\"322818309934\", \"walletIpayId\":\"1230816182851ZHRFF\", \"bankAccountBalance\":\"3813.56\",\"miniStatement\":[]},\"timestamp\":\"2023 - 08 - 16 18:28:51\", \"ipay_uuid\":\"h06899e762b9 - 7cad - 43b6 - 9982 - 2114a0b4eae7 - CK6bIYjhr0AG\", \"orderid\":\"1230816182851ZHRFF\", \"environment\":\"LIVE\", \"internalCode\":null}");
                                    string statuscode = "";
                                    string status = "";
                                    statuscode = jobject["statuscode"].ToString();
                                    status = jobject["status"].ToString();
                                    if (statuscode == "TXN" || statuscode == "TUP")
                                    {

                                        opening_bal = jobject["data"]["openingBalance"].ToString();
                                        ipay_id = jobject["data"]["ipayId"].ToString();
                                        amount = jobject["data"]["transactionValue"].ToString();
                                        amount_txn = jobject["data"]["transactionValue"].ToString();
                                        account_no = jobject["data"]["accountNumber"].ToString();
                                        //txn_mode = jobject["data"]["txn_mode"].ToString();
                                        //txn_status = jobject["data"]["status"].ToString();
                                        opr_id = jobject["data"]["operatorId"].ToString();
                                        balance = jobject["data"]["bankAccountBalance"].ToString();
                                        timestamp = jobject["timestamp"].ToString();
                                        ipay_uuid = jobject["ipay_uuid"].ToString();
                                        orderid = jobject["orderid"].ToString();
                                        environment = jobject["environment"].ToString();
                                        string aepscontent = Um.AEPSTransactionInsert(Convert.ToInt32(userid), TransactionID, mobile, Convert.ToDecimal(useramount), "APP", "SUCCESS", ProdKey, ProdName, bankiin, aadhaar_uid, content, ipay_uuid, opr_id, orderid);
                                        string aepsUpdateTxn = Um.AEPSTransactionUpdate(Convert.ToInt32(userid), TransactionID, content, ipay_uuid, "SUCCESS", orderid, opr_id, useramount, ProdKey, aadhaar_uid);
                                        if (aepscontent == "1")
                                        {
                                            if (sp_key == "WAP")
                                            {
                                                string comment = "";
                                                string balancecredit = Um.AEPSBalanceCredit(Convert.ToInt32(userid), "AEPS WITHDRAWAL", comment, Convert.ToDecimal(useramount), aadhaar_uid);

                                                LoginModel Name1 = new LoginModel();
                                                List<aepsresponse> responses = new List<aepsresponse>();
                                                responses.Add(new aepsresponse
                                                {
                                                    status = status,
                                                    orderstatus = "SUCCESS",
                                                    txntype = "CASH WITHDRAW",
                                                    orderamount = useramount,
                                                    acamount = "₹" + balance,
                                                    agentid = orderid,
                                                    bankrefno = opr_id,
                                                    OldBalance = oldbalance,
                                                    NewBalance = newbalance,
                                                    Commission = commission
                                                });
                                                Name1.Status = "SUCCESS";
                                                Name1.Message = "Transaction Successful.";
                                                Name1.Data = responses;
                                                return Name1;
                                            }
                                            else if (sp_key == "BAP")
                                            {
                                                LoginModel Name1 = new LoginModel();
                                                List<aepsresponse> responses = new List<aepsresponse>();
                                                responses.Add(new aepsresponse
                                                {
                                                    status = status,
                                                    orderstatus = "SUCCESS",
                                                    txntype = "BALANCE ENQUIRY",
                                                    acamount = "₹" + balance,
                                                    agentid = orderid,
                                                    bankrefno = opr_id,
                                                    OldBalance = oldbalance,
                                                    NewBalance = newbalance,
                                                    Commission = commission
                                                });
                                                Name1.Status = "SUCCESS";
                                                Name1.Message = "Transaction Successful.";
                                                Name1.Data = responses;
                                                return Name1;
                                            }
                                            else if (sp_key == "MZZ")
                                            {
                                                string comment = "";
                                                string balancecredit = Um.AEPSBalanceCredit(Convert.ToInt32(userid), "Aadhaar Pay Withdrawal", comment, Convert.ToDecimal(useramount), aadhaar_uid);
                                                string balanceDebit = Um.AEPSBalanceDebit(Convert.ToInt32(userid), "Aadhaar Pay Surcharge", comment, Convert.ToDecimal(charge), aadhaar_uid);

                                                LoginModel Name1 = new LoginModel();
                                                List<aepsresponse> responses = new List<aepsresponse>();
                                                responses.Add(new aepsresponse
                                                {
                                                    status = status,
                                                    orderstatus = "SUCCESS",
                                                    txntype = "AADHAR PAY WITHDRAW",
                                                    orderamount = useramount,
                                                    acamount = "₹" + balance,
                                                    agentid = orderid,
                                                    bankrefno = opr_id,
                                                    OldBalance = oldbalance,
                                                    NewBalance = newbalance,
                                                    Commission = commission
                                                });
                                                Name1.Status = "SUCCESS";
                                                Name1.Message = "Transaction Successful.";
                                                Name1.Data = responses;
                                                return Name1;
                                            }
                                            else
                                            {
                                                string comment = "";
                                                //string balancecredit = Um.AEPSBalanceCredit(Convert.ToInt32(userid), "Mini Statement", comment, Convert.ToDecimal(1), aadhaar_uid);
                                                LoginModel Name1 = new LoginModel();
                                                List<aepsresponse> responses = new List<aepsresponse>();
                                                responses.Add(new aepsresponse
                                                {
                                                    status = status,
                                                    orderstatus = "SUCCESS",
                                                    txntype = "MINI STATEMENT",
                                                    acamount = "₹" + balance,
                                                    agentid = orderid,
                                                    bankrefno = opr_id,
                                                    xmllist = jobject["data"]["miniStatement"],
                                                    OldBalance = oldbalance,
                                                    NewBalance = newbalance,
                                                    Commission = commission
                                                });

                                                Name1.Status = "SUCCESS";
                                                Name1.Message = "Transaction Successful.";
                                                Name1.Data = responses;
                                                return Name1;
                                            }
                                        }
                                        else
                                        {
                                            if (sp_key == "WAP")
                                            {
                                                LoginModel Name1 = new LoginModel();
                                                List<aepsresponse> responses = new List<aepsresponse>();
                                                responses.Add(new aepsresponse
                                                {
                                                    status = status,
                                                    orderstatus = "FAILED",
                                                    txntype = "CASH WITHDRAW",
                                                    orderamount = useramount,
                                                    acamount = "₹" + balance,
                                                    agentid = orderid,
                                                    bankrefno = opr_id,
                                                    OldBalance = oldbalance,
                                                    NewBalance = oldbalance,
                                                    Commission = "0"
                                                });
                                                Name1.Status = "FAILED";
                                                Name1.Message = "Transaction Failed.";
                                                Name1.Data = responses;
                                                return Name1;
                                            }
                                            else if (sp_key == "BAP")
                                            {
                                                LoginModel Name1 = new LoginModel();
                                                List<aepsresponse> responses = new List<aepsresponse>();
                                                responses.Add(new aepsresponse
                                                {
                                                    status = status,
                                                    orderstatus = "FAILED",
                                                    txntype = "BALANCE ENQUIRY",
                                                    acamount = "₹" + balance,
                                                    agentid = orderid,
                                                    bankrefno = opr_id,
                                                    OldBalance = oldbalance,
                                                    NewBalance = oldbalance,
                                                    Commission = "0"
                                                });
                                                Name1.Status = "FAILED";
                                                Name1.Message = "Transaction Failed.";
                                                Name1.Data = responses;
                                                return Name1;
                                            }
                                            else
                                            {
                                                LoginModel Name1 = new LoginModel();
                                                List<aepsresponse> responses = new List<aepsresponse>();
                                                responses.Add(new aepsresponse
                                                {
                                                    status = status,
                                                    orderstatus = "FAILED",
                                                    txntype = "MINI STATEMENT",
                                                    acamount = "₹" + balance,
                                                    agentid = orderid,
                                                    bankrefno = opr_id,
                                                    OldBalance = oldbalance,
                                                    NewBalance = oldbalance,
                                                    Commission = "0"
                                                });
                                                Name1.Status = "FAILED";
                                                Name1.Message = "Transaction Failed.";
                                                Name1.Data = responses;
                                                return Name1;
                                            }
                                        }
                                    }
                                    else if (statuscode == "ERR" || statuscode == "SPD" || statuscode == "DTX" || statuscode == "TDE" || statuscode == "ISE" || statuscode == "FAB" || statuscode == "IUA" || statuscode == "IPE" || statuscode == "SPE")
                                    {
                                        opening_bal = jobject["data"]["openingBalance"].ToString();
                                        ipay_id = jobject["data"]["ipayId"].ToString();
                                        amount = jobject["data"]["transactionValue"].ToString();
                                        amount_txn = jobject["data"]["transactionValue"].ToString();
                                        account_no = jobject["data"]["accountNumber"].ToString();
                                        //txn_mode = jobject["data"]["txn_mode"].ToString();
                                        //txn_status = jobject["data"]["status"].ToString();
                                        opr_id = jobject["data"]["operatorId"].ToString();
                                        balance = jobject["data"]["bankAccountBalance"].ToString();
                                        //wallet_txn_id = xn["wallet_txn_id"].InnerText;
                                        timestamp = jobject["timestamp"].ToString();
                                        ipay_uuid = jobject["ipay_uuid"].ToString();
                                        orderid = jobject["orderid"].ToString();
                                        environment = jobject["environment"].ToString();
                                        string aepscontent = Um.AEPSTransactionInsert(Convert.ToInt32(userid), TransactionID, mobile, Convert.ToDecimal(useramount), "APP", "FAILED", ProdKey, ProdName, bankiin, aadhaar_uid, content, ipay_uuid, opr_id, orderid);
                                        if (aepscontent == "1")
                                        {
                                            if (sp_key == "WAP")
                                            {
                                                LoginModel Name1 = new LoginModel();
                                                List<aepsresponse> responses = new List<aepsresponse>();
                                                responses.Add(new aepsresponse
                                                {
                                                    status = status,
                                                    orderstatus = "FAILED",
                                                    txntype = "CASH WITHDRAW",
                                                    orderamount = useramount,
                                                    acamount = "₹" + balance,
                                                    agentid = orderid,
                                                    bankrefno = opr_id,
                                                    OldBalance = oldbalance,
                                                    NewBalance = oldbalance,
                                                    Commission = "0"
                                                });
                                                Name1.Status = "FAILED";
                                                Name1.Message = "Transaction Failed.";
                                                Name1.Data = responses;
                                                return Name1;
                                            }
                                            else if (sp_key == "BAP")
                                            {
                                                LoginModel Name1 = new LoginModel();
                                                List<aepsresponse> responses = new List<aepsresponse>();
                                                responses.Add(new aepsresponse
                                                {
                                                    status = status,
                                                    orderstatus = "FAILED",
                                                    txntype = "BALANCE ENQUIRY",
                                                    acamount = "₹" + balance,
                                                    agentid = orderid,
                                                    bankrefno = opr_id,
                                                    OldBalance = oldbalance,
                                                    NewBalance = oldbalance,
                                                    Commission = "0"
                                                });
                                                Name1.Status = "FAILED";
                                                Name1.Message = "Transaction Failed.";
                                                Name1.Data = responses;
                                                return Name1;
                                            }

                                            else if (sp_key == "MZZ")
                                            {
                                                LoginModel Name1 = new LoginModel();
                                                List<aepsresponse> responses = new List<aepsresponse>();
                                                responses.Add(new aepsresponse
                                                {
                                                    status = status,
                                                    orderstatus = "FAILED",
                                                    txntype = "AADHAR PAY WITHDRAW",
                                                    orderamount = useramount,
                                                    acamount = "₹" + balance,
                                                    agentid = orderid,
                                                    bankrefno = opr_id,
                                                    OldBalance = oldbalance,
                                                    NewBalance = oldbalance,
                                                    Commission = "0"
                                                });
                                                Name1.Status = "FAILED";
                                                Name1.Message = "Transaction Failed.";
                                                Name1.Data = responses;
                                                return Name1;
                                            }
                                            else
                                            {
                                                LoginModel Name1 = new LoginModel();
                                                List<aepsresponse> responses = new List<aepsresponse>();
                                                responses.Add(new aepsresponse
                                                {
                                                    status = status,
                                                    orderstatus = "FAILED",
                                                    txntype = "MINI STATEMENT",
                                                    acamount = "₹" + balance,
                                                    agentid = orderid,
                                                    bankrefno = opr_id,
                                                    OldBalance = oldbalance,
                                                    NewBalance = oldbalance,
                                                    Commission = "0"
                                                });
                                                Name1.Status = "FAILED";
                                                Name1.Message = "Transaction Failed.";
                                                Name1.Data = responses;
                                                return Name1;
                                            }
                                        }
                                        else
                                        {
                                            if (sp_key == "WAP")
                                            {
                                                LoginModel Name1 = new LoginModel();
                                                List<aepsresponse> responses = new List<aepsresponse>();
                                                responses.Add(new aepsresponse
                                                {
                                                    status = status,
                                                    orderstatus = "FAILED",
                                                    txntype = "CASH WITHDRAW",
                                                    orderamount = useramount,
                                                    acamount = "₹" + balance,
                                                    agentid = orderid,
                                                    bankrefno = opr_id,
                                                    OldBalance = oldbalance,
                                                    NewBalance = oldbalance,
                                                    Commission = "0"
                                                });
                                                Name1.Status = "FAILED";
                                                Name1.Message = "Transaction Failed.";
                                                Name1.Data = responses;
                                                return Name1;
                                            }
                                            else if (sp_key == "BAP")
                                            {
                                                LoginModel Name1 = new LoginModel();
                                                List<aepsresponse> responses = new List<aepsresponse>();
                                                responses.Add(new aepsresponse
                                                {
                                                    status = status,
                                                    orderstatus = "FAILED",
                                                    txntype = "BALANCE ENQUIRY",
                                                    acamount = "₹" + balance,
                                                    agentid = orderid,
                                                    bankrefno = opr_id,
                                                    OldBalance = oldbalance,
                                                    NewBalance = oldbalance,
                                                    Commission = "0"
                                                });
                                                Name1.Status = "FAILED";
                                                Name1.Message = "Transaction Failed.";
                                                Name1.Data = responses;
                                                return Name1;
                                            }
                                            else if (sp_key == "MZZ")
                                            {
                                                LoginModel Name1 = new LoginModel();
                                                List<aepsresponse> responses = new List<aepsresponse>();
                                                responses.Add(new aepsresponse
                                                {
                                                    status = status,
                                                    orderstatus = "FAILED",
                                                    txntype = "AADHAR PAY WITHDRAW",
                                                    orderamount = useramount,
                                                    acamount = "₹" + balance,
                                                    agentid = orderid,
                                                    bankrefno = opr_id,
                                                    OldBalance = oldbalance,
                                                    NewBalance = oldbalance,
                                                    Commission = "0"
                                                });
                                                Name1.Status = "FAILED";
                                                Name1.Message = "Transaction Failed.";
                                                Name1.Data = responses;
                                                return Name1;
                                            }
                                            else
                                            {
                                                LoginModel Name1 = new LoginModel();
                                                List<aepsresponse> responses = new List<aepsresponse>();
                                                responses.Add(new aepsresponse
                                                {
                                                    status = status,
                                                    orderstatus = "FAILED",
                                                    txntype = "MINI STATEMENT",
                                                    acamount = "₹" + balance,
                                                    agentid = orderid,
                                                    bankrefno = opr_id,
                                                    OldBalance = oldbalance,
                                                    NewBalance = oldbalance,
                                                    Commission = "0"
                                                });
                                                Name1.Status = "FAILED";
                                                Name1.Message = "Transaction Failed.";
                                                Name1.Data = responses;
                                                return Name1;
                                            }
                                        }
                                    }
                                    else
                                    {
                                        LoginModel Name = new LoginModel();
                                        Name.Status = "FAILED";
                                        Name.Message = status;
                                        Name.Data = status;
                                        return Name;
                                    }
                                }
                            }
                            else
                            {
                                string aepscontent = Um.AEPSTransactionInsert(Convert.ToInt32(userid), TransactionID, mobile, Convert.ToDecimal(useramount), "APP", "PENDING", ProdKey, ProdName, bankiin, aadhaar_uid, content, ipay_uuid, opr_id, orderid);
                                LoginModel Name = new LoginModel();
                                Name.Status = "FAILED";
                                Name.Message = "Api not responsed";
                                Name.Data = "Api not responsed";
                                return Name;
                            }
                        }
                        else
                        {
                            LoginModel Name = new LoginModel();
                            Name.Status = "FAILED";
                            Name.Message = "You are Not Authorised";
                            Name.Data = "You are Not Authorised";
                            return Name;
                        }
                    }
                    else
                    {
                        LoginModel Name = new LoginModel();
                        Name.Status = "FAILED";
                        Name.Message = "You are Not Authorised";
                        Name.Data = "You are Not Authorised";
                        return Name;
                    }
                }
                else
                {
                    LoginModel Name = new LoginModel();
                    Name.Status = "ERR";
                    Name.Message = "Login Failed.";
                    Name.Data = "Please update your app";
                    return Name;
                }
            }
            catch (Exception ex)
            {
                LoginModel Name = new LoginModel();
                Name.Status = "FAILED";
                Name.Message = ex.Message;
                Name.Data = ex.Message;
                return Name;
            }
        }

        public string getoutlet(string uid)
        {
            string query = "select * from  UserDetails where UserKey=@ProductId";
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["OrbitStepConnectionString"].ConnectionString);
            SqlCommand mcom = new SqlCommand(query, con);
            mcom.Parameters.AddWithValue("@ProductId", uid);
            SqlDataAdapter mda = new SqlDataAdapter(mcom);
            DataTable dt = new DataTable();
            mda.Fill(dt);
            string pid;
            if (dt.Rows.Count > 0)
            {
                pid = dt.Rows[0]["outletId"].ToString();
            }
            else
            {
                pid = "0";
            }
            return pid;
        }

        public string GetMobileAppVersion()
        {
            string pid = "NA";
            string query = "select * from MobileAppVersion";
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["OrbitStepConnectionString"].ConnectionString);
            SqlCommand mcom = new SqlCommand(query, con);
            SqlDataAdapter mda = new SqlDataAdapter(mcom);
            DataTable dt = new DataTable();
            mda.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                pid = dt.Rows[0]["AppVer"].ToString();
            }
            return pid;
        }
        public string ApiPost(string URL, string PostData, IDictionary<string, string> headers)
        {
            ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls12;
            HttpWebRequest http = (HttpWebRequest)System.Net.WebRequest.Create(URL);
            http.Method = HttpMethod.Post.ToString();
            if (headers != null)
            {
                foreach (var item in headers)
                {
                    http.Headers.Add(item.Key, item.Value);
                }
            }
            http.ContentType = "application/json";
            string result = string.Empty;
            try
            {
                using (var streamWriter = new StreamWriter(http.GetRequestStream()))
                {
                    streamWriter.Write(PostData);
                    streamWriter.Flush();
                }
                WebResponse response = http.GetResponse();

                using (StreamReader sr = new StreamReader(response.GetResponseStream()))
                {
                    result = sr.ReadToEnd();
                }
            }
            catch (UriFormatException ufx)
            {
                throw new Exception(ufx.Message);
            }
            catch (WebException wx)
            {
                if (wx.Response != null)
                {
                    using (var ErrorResponse = wx.Response)
                    {
                        using (StreamReader sr = new StreamReader(ErrorResponse.GetResponseStream()))
                        {
                            result = sr.ReadToEnd();
                        }
                    }
                }
                else
                {
                    throw new Exception(wx.Message);
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return result;
        }
        public string AESEncryption(string data)
        {
            string EncryptionKey = InstanPayEkycAesKey;
            string iniVector;
            byte[] IV = ASCIIEncoding.ASCII.GetBytes("91543c0ce2ff7bf4");
            byte[] clearBytes = Encoding.Unicode.GetBytes(data);
            AesCryptoServiceProvider crypt_provider;
            crypt_provider = new AesCryptoServiceProvider();
            crypt_provider.KeySize = 256;
            crypt_provider.Key = ASCIIEncoding.ASCII.GetBytes(EncryptionKey);
            crypt_provider.IV = IV;
            crypt_provider.Mode = CipherMode.CBC;
            crypt_provider.Padding = PaddingMode.PKCS7;
            ICryptoTransform transform = crypt_provider.CreateEncryptor();
            byte[] encrypted_bytes = transform.TransformFinalBlock(ASCIIEncoding.ASCII.GetBytes(data), 0, data.Length);
            byte[] encryptedData = new byte[encrypted_bytes.Length + IV.Length];
            IV.CopyTo(encryptedData, 0);
            encrypted_bytes.CopyTo(encryptedData, IV.Length);
            data = Convert.ToBase64String(encryptedData);
            return data;
        }

    }
}