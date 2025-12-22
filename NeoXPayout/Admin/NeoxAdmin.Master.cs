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
    public partial class NeoxAdmin : System.Web.UI.MasterPage
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString);
        UserManagement Um = new UserManagement();
        
        protected void Page_Load(object sender, EventArgs e)
        {
            if (this.Session["AdminName"] == null)
            {
                Response.Redirect("Default.aspx");
            }
            else
            {
                if (!IsPostBack)
                {
                    Label1.Text = this.Session["AdminName"].ToString();
                    //lblmainwallet.Text = Um.GetBalance(this.Session["AdminUID"].ToString());
                    
                }
            }
        }

        public string APIbindbal(string uid)
        {

            string ProductId = uid;
            string query = "select TOP 1* from  tblAPIWallet where UserId=@ProductId order by Id desc";
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
    }
}