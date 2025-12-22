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
    public partial class Dashboard : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString);
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
                    pnlbutton.Visible = true;
                }
                else
                {
                    pnlbutton.Visible = true;
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
                string url = "https://partner.banku.co.in/api/GetUserBalance";
                string body = "{\"UserId\":\"" + UserID + "\",\"Apiversion\":\"" + "1.0" + "\"}";
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

                 
                    if (scode == "SUCCESS" && jObject["Data"] != null && jObject["Data"].Type == JTokenType.Array)
                    {
                        JArray dataArray = (JArray)jObject["Data"];

                        if (dataArray.Count > 0)
                        {
                            string currentBalance = dataArray[0]["CurrentBalance"]?.ToString();
                            //lblsuccess.Text = currentBalance;
                            Label3.Text = currentBalance;
                            return;
                        }
                    }

                    //lblsuccess.Text = "0.00";
                    Label3.Text = "0.00";
                }
                catch
                {

                    //lblsuccess.Text = "0.00";
                    Label3.Text = "0.00";
                }


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
            string conStr = "Data Source=103.205.142.34,1433;Initial Catalog=BankUIndia_db;Persist Security Info=True;User ID=BankUIndia_db;Password=Chandan@80100";

            using (SqlConnection con = new SqlConnection(conStr))
            {
                con.Open();


                using (SqlCommand cmd = new SqlCommand("SELECT ISNULL(SUM(Amount),0) FROM tbluserbalance WHERE CrDrType='Credit' AND UserId=@UserID AND TxnType = 'Fund Added By User'", con))
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