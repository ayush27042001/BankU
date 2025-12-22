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
    public partial class PaymentReqReportBankU : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection("Server=198.38.81.244,1232;DataBase=Intsalitefinserv_Db;uid=Intsalitefinserv_Db;pwd=Chandan#@80100");
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
            else
            {
                if (!IsPostBack)
                {
                    txtfrom.Text = DateTime.Now.ToString("yyyy-MM-dd");
                    txtto.Text = DateTime.Now.ToString("yyyy-MM-dd");
                    getdetails();

                }
            }
        }

        public void getdetails()
        {
            string query = "select * from  Wlpaymentrequest where UserId=@UserId and Wlid=@Wlid and Reqdate>=@TimeStampFrom and Reqdate<=@TimeStamp order by Id desc";
            SqlCommand mcom = new SqlCommand(query, con);
            mcom.Parameters.AddWithValue("@TimeStampFrom", txtfrom.Text + " 00:00:00.000");
            mcom.Parameters.AddWithValue("@TimeStamp", txtto.Text + " 23:59:59.000");
            mcom.Parameters.AddWithValue("@UserId", this.Session["BankURTName"].ToString());
            mcom.Parameters.AddWithValue("@Wlid", this.Session["BankURTName"].ToString());
            SqlDataAdapter mda = new SqlDataAdapter(mcom);
            DataTable dt = new DataTable();
            mda.Fill(dt);

            if (dt.Rows.Count == 0)
            {
                rptProduct.Visible = false;
            }
            else
            {
                rptProduct.Visible = true;
                rptProduct.DataSource = dt;
                rptProduct.DataBind();
            }

            con.Close();
        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            getdetails();
        }
    }
}