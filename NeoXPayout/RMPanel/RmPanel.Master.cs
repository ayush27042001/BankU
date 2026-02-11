using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NeoXPayout.RMPanel
{
    public partial class RmPanel : System.Web.UI.MasterPage
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString);
        UserManagement Um = new UserManagement();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (this.Session["RmID"] == null)
            {
                Response.Redirect("LoginRm.aspx");
            }
            else
            {
                if (!IsPostBack)
                {
                    Label1.Text = this.Session["RmName"].ToString();
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