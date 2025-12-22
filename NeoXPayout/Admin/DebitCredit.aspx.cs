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

namespace NeoXPayout.Admin
{
    public partial class DebitCredit : System.Web.UI.Page
    {
        string fileName_n;
        SqlConnection con = new SqlConnection("Server=198.38.81.244,1232;DataBase=Intsalitefinserv_Db;uid=Intsalitefinserv_Db;pwd=Chandan#@80100");
        SqlCommand com = new SqlCommand();
        SqlDataAdapter da = new SqlDataAdapter();
        SqlDataAdapter da1 = new SqlDataAdapter();
        DataSet ds = new DataSet();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (this.Session["AdminNeoxName"] == null)
            {
                Response.Redirect("Default.aspx");
            }
            else
            {
                if (!IsPostBack)
                {
                    bindetails();
                    Label2.Text = APIbindbal(HiddenField1.Value);
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
        public void bindetails()
        {
            string query = "select * from  WlUsers where UserId=@ProductId and Id=@Uid order by Id desc";
            SqlCommand mcom = new SqlCommand(query, con);
            mcom.Parameters.AddWithValue("@ProductId", Session["AdminNeoxUID"].ToString());
            mcom.Parameters.AddWithValue("@Uid", Request.QueryString["id"]);

            SqlDataAdapter mda = new SqlDataAdapter(mcom);
            DataTable dt = new DataTable();
            mda.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                txtcompanyname.Text = dt.Rows[0]["CompanyName"].ToString();
                txtfullname.Text = dt.Rows[0]["FullName"].ToString();
                HiddenField1.Value = dt.Rows[0]["Id"].ToString();
            }
            else
            {
                Response.Redirect("dashboard.aspx");
            }

        }
        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            if(txtamount.Text!="")
            {
                decimal amt = Convert.ToDecimal(txtamount.Text);
                if(amt<=0)
                {
                    Label1.Text = "Please Enter Valid Amount";
                }
                else
                {
                    if(DropDownList1.Text.ToUpper()=="CREDIT")
                    {
                        CreditBalanceForPayout(Convert.ToInt32(HiddenField1.Value),amt,txtcompanyname.Text);
                    }
                    else
                    {
                        DebitBalanceForPayout(Convert.ToInt32(HiddenField1.Value), amt, txtcompanyname.Text);
                    }

                    Response.Redirect("ViewUser.aspx");
                }
            }
        }

        public string DebitBalanceForPayout(int ToUserKey,decimal amount, string Username)
        {
            try
            {
                string Pay_Ref_id = "DR" + DateTime.Now.ToString("yyMMddHHmmssfff");
                decimal oldbalance = Convert.ToDecimal(APIbindbal(ToUserKey.ToString()));

                decimal newbal = oldbalance - amount;
                string rem = "Wallet Debit By Admin of amount " + amount + " To User " + Username;

                string sqlb1 = "insert into WlUserWallet(Wlid,UserId,Old_Bal,Amount,New_Bal,TxnType,Remarks,Txn_Date,Ip_Address,Cr_Dr_Type,Pay_Ref_id)values(@Wlid,@UserId,@Old_Bal,@Amount,@New_Bal,@TxnType,@Remarks,@Txn_Date,@Ip_Address,@Cr_Dr_Type,@Pay_Ref_id)";
                SqlCommand cmdb1 = new SqlCommand(sqlb1, con);
                //,,,,,,,,,
                cmdb1.Parameters.AddWithValue("@Wlid", Session["AdminNeoxUID"].ToString());
                cmdb1.Parameters.AddWithValue("@Pay_Ref_id", Pay_Ref_id);
                cmdb1.Parameters.AddWithValue("@UserId", ToUserKey);
                cmdb1.Parameters.AddWithValue("@Old_Bal", oldbalance);
                cmdb1.Parameters.AddWithValue("@New_Bal", newbal);
                cmdb1.Parameters.AddWithValue("@TxnType", "Wallet Debit By Admin");
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

        public string CreditBalanceForPayout(int ToUserKey, decimal amount, string Username)
        {
            try
            {
                string Pay_Ref_id = "DR" + DateTime.Now.ToString("yyMMddHHmmssfff");
                decimal oldbalance = Convert.ToDecimal(APIbindbal(ToUserKey.ToString()));

                decimal newbal = oldbalance + amount;
                string rem = "Wallet Credit By Admin of amount "+amount+ " To User "+Username;

                string sqlb1 = "insert into WlUserWallet(Wlid,UserId,Old_Bal,Amount,New_Bal,TxnType,Remarks,Txn_Date,Ip_Address,Cr_Dr_Type,Pay_Ref_id)values(@Wlid,@UserId,@Old_Bal,@Amount,@New_Bal,@TxnType,@Remarks,@Txn_Date,@Ip_Address,@Cr_Dr_Type,@Pay_Ref_id)";
                SqlCommand cmdb1 = new SqlCommand(sqlb1, con);
                //,,,,,,,,,
                cmdb1.Parameters.AddWithValue("@Wlid", Session["AdminNeoxUID"].ToString());
                cmdb1.Parameters.AddWithValue("@Pay_Ref_id", Pay_Ref_id);
                cmdb1.Parameters.AddWithValue("@UserId", ToUserKey);
                cmdb1.Parameters.AddWithValue("@Old_Bal", oldbalance);
                cmdb1.Parameters.AddWithValue("@New_Bal", newbal);
                cmdb1.Parameters.AddWithValue("@TxnType", "Wallet Credit By Admin");
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