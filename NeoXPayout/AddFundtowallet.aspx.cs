using Newtonsoft.Json.Linq;
using RestSharp;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NeoXPayout
{
    public partial class AddFundtowallet : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection("Server=198.38.81.244,1232;DataBase=Intsalitefinserv_Db;uid=Intsalitefinserv_Db;pwd=Chandan#@80100");
        SqlCommand com = new SqlCommand();
        SqlDataAdapter da = new SqlDataAdapter();
        SqlDataAdapter da1 = new SqlDataAdapter();
        DataSet ds = new DataSet();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (this.Session["NeoxName"] == null || !(Session["IsMPINVerified"] is bool isVerified && isVerified))
            {
                Response.Redirect("Default.aspx");
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
        public string CreateUPIOrder(string order_id, int txn_amount,string APIName)
        {
            try
            {
                string customer_name = Session["NeoxName"].ToString();
                string customer_mobile = Session["NeoxMobile"].ToString();
                string customer_email = Session["NeoxEmailid"].ToString();
                string password = apipassword(Session["NeoxWLId"].ToString());
                string ApiKey = Session["NeoxApikey"].ToString();
                string callback_url = "https://neox.business/TransactionDone.aspx";
                string Apiresponse = String.Empty;
                string url = "https://app.banku.co.in/api/CreatePGLinkApi";
                string body = "{ \"ApiKey\":\"" + ApiKey + "\",\"password\":\"" + password + "\",\"APIName\":\"" + APIName + "\",\"MobileNo\":\"" + customer_mobile + "\",\"Amount\":\"" + txn_amount + "\",\"CustomerName\":\"" + customer_name + "\",\"Emailid\":\"" + customer_email + "\",\"CallbackURL\":\"" + callback_url + "\",\"Client_refId\":\"" + order_id + "\"}";
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
        protected void LinkButton1_Click(object sender, EventArgs e)
        {if (txtamount.Text == "")
            {
                Label1.Text = "Please Enter Amount";

            }
            else
            {
                string orderid = "WL" + Session["NeoxUID"].ToString() + "M" + DateTime.Now.ToString("yyyyMMddHHmmssfff");
                string content = CreateUPIOrder(orderid, Convert.ToInt32(txtamount.Text), "BANKUP2");
                JObject jObject = JObject.Parse(content);
                if (jObject["Status"].ToString() == "1")
                {
                    JArray jredmill = JArray.Parse(jObject["Data"].ToString());
                    string txn_id = jredmill[0]["txn_Id"].ToString();
                    string flink = jredmill[0]["payment_url"].ToString();
                    string urllink = jredmill[0]["payment_url"].ToString();
                    string sqlfr = "insert into Wlapionlinepayment(Wlid,UserId,UserName,Amount,ClientRefId,TxnId,Status,ReqDate,Reqlogs)values(@Wlid,@UserId,@UserName,@Amount,@ClientRefId,@TxnId,@Status,@ReqDate,@Reqlogs)";
                    SqlCommand cmdfr = new SqlCommand(sqlfr, con);
                    cmdfr.Parameters.AddWithValue("@Wlid", Session["NeoxWLId"].ToString());
                    cmdfr.Parameters.AddWithValue("@UserId", Session["NeoxUID"].ToString());
                    cmdfr.Parameters.AddWithValue("@UserName", Session["NeoxCName"].ToString());
                    cmdfr.Parameters.AddWithValue("@Amount", txtamount.Text);
                    cmdfr.Parameters.AddWithValue("@TxnId", txn_id);
                    cmdfr.Parameters.AddWithValue("@Status", "Pending");
                    cmdfr.Parameters.AddWithValue("@Reqlogs", content);
                    cmdfr.Parameters.AddWithValue("@ReqDate", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss.fff"));
                    cmdfr.Parameters.AddWithValue("@ClientRefId", orderid);
                    con.Open();
                    cmdfr.ExecuteNonQuery();
                    con.Close();
                    Response.Redirect(urllink);
                }
                else
                {
                    Label1.Text = jObject["Message"].ToString();
                }
            }
        }
    }
}