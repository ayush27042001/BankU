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
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NeoXPayout
{
    public partial class Transaction : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection("Server=198.38.81.244,1232;DataBase=Intsalitefinserv_Db;uid=Intsalitefinserv_Db;pwd=Chandan#@80100");
        SqlCommand com = new SqlCommand();
        SqlDataAdapter da = new SqlDataAdapter();
        SqlDataAdapter da1 = new SqlDataAdapter();
        DataSet ds = new DataSet();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (this.Session["BankURTUID"] == null || !(Session["IsMPINVerified"] is bool isVerified && isVerified))
            {
                Response.Redirect("LoginBankU.aspx");
            }
            else
            {
                if (!IsPostBack)
                {

                }
            }
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
        public string getPayoutcostprice(string txnid, string UserId)
        {
            try
            {
                string query = "select * from Wlpayouttxn where ClientRefId=@ClientRefId and Status=@status and UserId=@UserId";
                SqlCommand mcom = new SqlCommand(query, con);
                mcom.Parameters.AddWithValue("@ClientRefId", txnid);
                mcom.Parameters.AddWithValue("@UserId", UserId);
                mcom.Parameters.AddWithValue("@status", "Pending");

                SqlDataAdapter mda = new SqlDataAdapter(mcom);
                DataTable dt = new DataTable();
                mda.Fill(dt);
                string mainbalance;
                if (dt.Rows.Count > 0)
                {
                    mainbalance = dt.Rows[0]["TotalCost"].ToString();
                }
                else
                {
                    mainbalance = "0.00";
                }
                return mainbalance;
            }
            catch
            {
                return "";
            }
        }
        public string PayoutTransactionRefund(int userKey, string TransactionID, decimal RefundAmount, string RRN, string AccountNo, string userdetails)
        {
            try
            {
                string Comm = "0.00";

                RefundAmount = Convert.ToDecimal(getPayoutcostprice(TransactionID, userKey.ToString()));

                con.Open();
                string sqlb1 = "Update Wlpayouttxn set Status=@Status,UTRNO=@UTRNO where ClientRefId=@ClientRefId and AccountNo=@AccountNo and UserId=@UserId";
                SqlCommand cmdb1 = new SqlCommand(sqlb1, con);
                cmdb1.Parameters.AddWithValue("@AccountNo", AccountNo);
                cmdb1.Parameters.AddWithValue("@Status", "FAILED");
                cmdb1.Parameters.AddWithValue("@UTRNO", RRN);
                cmdb1.Parameters.AddWithValue("@ClientRefId", TransactionID);
                cmdb1.Parameters.AddWithValue("@UserId", userKey);
                cmdb1.ExecuteNonQuery();
                con.Close();

                decimal Commission = 0;
                decimal.TryParse(Comm, out Commission);
                string balancecredit = CreditBalanceForPayout(Convert.ToInt32(userKey), "Payout Reverse", "Reverse Amount Credit For Payout Services ", RefundAmount, userdetails, AccountNo, TransactionID);
                return "1";
            }
            catch (Exception ex)
            {
                return ex.ToString();
            }
            finally
            {
                con.Close();
            }
        }
        public string PayoutTransactionUpdate(int userKey, string TransactionID,string NewStatus, string RRN, string AccountNo,string ClientRefId)
        {
            try
            {
                con.Open();
                string sqlb1 = "Update Wlpayouttxn set Status=@Status,UTRNO=@UTRNO,TxnId=@TxnId where ClientRefId=@ClientRefId and AccountNo=@AccountNo and UserId=@UserId";
                SqlCommand cmdb1 = new SqlCommand(sqlb1, con);
                cmdb1.Parameters.AddWithValue("@AccountNo", AccountNo);
                cmdb1.Parameters.AddWithValue("@Status", NewStatus);
                cmdb1.Parameters.AddWithValue("@UTRNO", RRN);
                cmdb1.Parameters.AddWithValue("@ClientRefId", ClientRefId);
                cmdb1.Parameters.AddWithValue("@TxnId", TransactionID);
                cmdb1.Parameters.AddWithValue("@UserId", userKey);
                cmdb1.ExecuteNonQuery();
                con.Close();
                return "1";
            }
            catch (Exception ex)
            {
                return ex.ToString();
            }
            finally
            {
                con.Close();
            }
        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            if (txtaccountno.Text == "" || txtamount.Text == "" || txtbankname.Text == "" || txtifsccode.Text == "" || txtmobileno.Text == "")
            {
                Label1.Text = "Please Fill Complete Details";
            }
            else
            {
                decimal amt = Convert.ToDecimal(txtamount.Text);
                if (amt >= 100 && amt <= 50000)
                {
                    string Client_refId = Session["NeoxUID"].ToString() + DateTime.Now.ToString("yyMMddHHmmssfff") + "BU";
                    string aepscontent = PayoutTransactionInsert(Client_refId, Convert.ToDecimal(txtamount.Text), Client_refId, "Pending");
                    if (aepscontent == "1")
                    {
                        string ApiKey = Session["NeoxApikey"].ToString();
                        string password = apipassword(Session["NeoxWLId"].ToString());
                        string APIName = "BANKU";
                        string TXNMode = "IMPS";
                        string Apiresponse = String.Empty;
                        string url = "https://app.banku.co.in/api/PayoutApi";
                        string body = "{\"ApiKey\":\"" + ApiKey + "\",\"password\":\"" + password + "\",\"APIName\":\"" + APIName + "\",\"MobileNo\":\"" + txtmobileno.Text + "\",\"BeneName\":\"" + txtaccountholdername.Text + "\",\"AccountNo\":\"" + txtaccountno.Text + "\",\"Amount\":\"" + txtamount.Text + "\",\"Ifsccode\":\"" + txtifsccode.Text + "\",\"TXNMode\":\"" + TXNMode + "\",\"BankName\":\"" + txtbankname.Text + "\",\"Client_refId\":\"" + Client_refId + "\"}";
                        var client = new RestClient(url);
                        var request = new RestRequest(Method.POST);
                        request.AddHeader("cache-control", "no-cache");
                        request.AddHeader("Accept", "application/json");
                        request.AddHeader("Content-Type", "application/json");
                        request.AddParameter("application/json", body, RestSharp.ParameterType.RequestBody);
                        IRestResponse response = client.Execute(request);
                        Apiresponse = response.Content;

                        JObject jObjects1 = JObject.Parse(Apiresponse);
                        if (jObjects1["Status"].ToString() == "1")
                        {
                            JArray jredmill = JArray.Parse(jObjects1["Data"].ToString());
                            string status = jredmill[0]["Status"].ToString().ToUpper();
                            string message = jObjects1["Message"].ToString();
                            string txnId = jredmill[0]["API_txnId"].ToString();
                            string operator_ref = jredmill[0]["UTRNo"].ToString();
                            if (status.ToUpper() == "SUCCESS")
                            {
                                PayoutTransactionUpdate(Convert.ToInt32(Session["NeoxUID"].ToString()), txnId, status, operator_ref, txtaccountno.Text, Client_refId);
                            }
                            else
                            {
                                PayoutTransactionRefund(Convert.ToInt32(Session["NeoxUID"].ToString()), Client_refId, Convert.ToDecimal(txtamount.Text), operator_ref, txtaccountno.Text, Session["NeoxCName"].ToString());
                            }
                            Response.Redirect("TransactionDone.aspx?crid=" + txnId);
                        }
                        else
                        {
                            Label1.Text = jObjects1["Message"].ToString();
                        }
                    }
                }
                else
                {
                    Label1.Text = "Please Enter Amount between 100 to 50000 ony";
                }
            }
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
        public string PayoutTransactionInsert(string TransactionID, decimal Amount, string ClientRefid, string Status)
        {
            try
            {
                string RetailerCommission = "1";
                decimal Charge = Convert.ToDecimal(RetailerCommission) * Amount / 100;

                decimal BalBefore = Convert.ToDecimal(APIbindbal(Session["NeoxUID"].ToString()));
                decimal gst = Charge * 18 / 100;
                decimal cost = Amount + Charge + gst;
                decimal capping = cost;
                if (BalBefore >= capping)
                {
                    decimal Newbal = BalBefore - cost;
                    con.Open();
                    string sqlb1 = "insert into Wlpayouttxn(Wlid,UserId,UserName,MobileNo,TxnMode,BeneName,AccountNo,IFSCCode,BankName,OldBal,Amount,Charge,GST,TotalCost,NewBal,Status,TxnId,UTRNO,ClientRefId,ReqDate)values(@Wlid,@UserId,@UserName,@MobileNo,@TxnMode,@BeneName,@AccountNo,@IFSCCode,@BankName,@OldBal,@Amount,@Charge,@GST,@TotalCost,@NewBal,@Status,@TxnId,@UTRNO,@ClientRefId,@ReqDate)";
                    SqlCommand cmdb1 = new SqlCommand(sqlb1, con);
                    cmdb1.Parameters.AddWithValue("@TxnMode", "IMPS");
                    cmdb1.Parameters.AddWithValue("@UserId", Session["NeoxUID"].ToString());
                    cmdb1.Parameters.AddWithValue("@Wlid", Session["NeoxWLId"].ToString());
                    cmdb1.Parameters.AddWithValue("@UserName", Session["NeoxCName"].ToString());
                    cmdb1.Parameters.AddWithValue("@MobileNo", txtmobileno.Text);
                    cmdb1.Parameters.AddWithValue("@BeneName", txtaccountholdername.Text);
                    cmdb1.Parameters.AddWithValue("@AccountNo", txtaccountno.Text);
                    cmdb1.Parameters.AddWithValue("@IFSCCode", txtifsccode.Text);
                    cmdb1.Parameters.AddWithValue("@BankName", txtbankname.Text);
                    cmdb1.Parameters.AddWithValue("@OldBal", BalBefore);
                    cmdb1.Parameters.AddWithValue("@Amount", Amount);
                    cmdb1.Parameters.AddWithValue("@Charge", Charge);
                    cmdb1.Parameters.AddWithValue("@GST", gst);
                    cmdb1.Parameters.AddWithValue("@TotalCost", cost);
                    cmdb1.Parameters.AddWithValue("@NewBal", Newbal);
                    cmdb1.Parameters.AddWithValue("@Status", Status);
                    cmdb1.Parameters.AddWithValue("@TxnId", TransactionID);
                    cmdb1.Parameters.AddWithValue("@UTRNO", "");
                    cmdb1.Parameters.AddWithValue("@ClientRefId", ClientRefid);
                    cmdb1.Parameters.AddWithValue("@ReqDate", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss.fff"));
                    cmdb1.ExecuteNonQuery();
                    con.Close();

                    string balancedebit = DebitBalanceForPayout(Convert.ToInt32(Session["NeoxUID"]), "Payout Payment", "Amount Debit For Payout Rs" + Amount, cost, Session["NeoxCName"].ToString(), txtaccountno.Text, TransactionID);
                    // string commissionCredit = CreditBalanceForServices(UserKey, "Recharge Commission", "Commission Amount Credit For Recharge", comm, CustomerNumber);
                    return "1";
                }
                else
                {
                    return "Insufficient Amount.";
                }
            }
            catch (Exception ex)
            {
                return ex.ToString();
            }
            finally
            {
                con.Close();
            }
        }

        public string DebitBalanceForPayout(int ToUserKey, string transaction_type, string remarks, decimal amount, string Username, string Accountno, string Pay_Ref_id)
        {
            try
            {

                decimal oldbalance = Convert.ToDecimal(APIbindbal(ToUserKey.ToString()));

                decimal newbal = oldbalance - amount;
                string rem = transaction_type + " For Account No " + Accountno + "| Debit by Services | " + remarks + " ";

                string sqlb1 = "insert into WlUserWallet(Wlid,UserId,Old_Bal,Amount,New_Bal,TxnType,Remarks,Txn_Date,Ip_Address,Cr_Dr_Type,Pay_Ref_id)values(@Wlid,@UserId,@Old_Bal,@Amount,@New_Bal,@TxnType,@Remarks,@Txn_Date,@Ip_Address,@Cr_Dr_Type,@Pay_Ref_id)";
                SqlCommand cmdb1 = new SqlCommand(sqlb1, con);
                //,,,,,,,,,
                cmdb1.Parameters.AddWithValue("@Wlid", Session["NeoxWLId"].ToString());
                cmdb1.Parameters.AddWithValue("@Pay_Ref_id", Pay_Ref_id);
                cmdb1.Parameters.AddWithValue("@UserId", ToUserKey);
                cmdb1.Parameters.AddWithValue("@Old_Bal", oldbalance);
                cmdb1.Parameters.AddWithValue("@New_Bal", newbal);
                cmdb1.Parameters.AddWithValue("@TxnType", transaction_type);
                cmdb1.Parameters.AddWithValue("@Txn_Date", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss.fff"));
                cmdb1.Parameters.AddWithValue("@Ip_Address", "000");
                cmdb1.Parameters.AddWithValue("@Cr_Dr_Type", "Debit");
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

        public string CreditBalanceForPayout(int ToUserKey, string transaction_type, string remarks, decimal amount, string Username, string Accountno, string Pay_Ref_id)
        {
            try
            {

                decimal oldbalance = Convert.ToDecimal(APIbindbal(ToUserKey.ToString()));

                decimal newbal = oldbalance + amount;
                string rem = transaction_type + " For Account No " + Accountno + "| Credit by Services | " + remarks + " ";

                string sqlb1 = "insert into WlUserWallet(Wlid,UserId,Old_Bal,Amount,New_Bal,TxnType,Remarks,Txn_Date,Ip_Address,Cr_Dr_Type,Pay_Ref_id)values(@Wlid,@UserId,@Old_Bal,@Amount,@New_Bal,@TxnType,@Remarks,@Txn_Date,@Ip_Address,@Cr_Dr_Type,@Pay_Ref_id)";
                SqlCommand cmdb1 = new SqlCommand(sqlb1, con);
                //,,,,,,,,,
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
    }
}