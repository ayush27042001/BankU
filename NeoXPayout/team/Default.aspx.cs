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

namespace NeoXPayout.team
{
    public partial class Default : System.Web.UI.Page
    {
        UserManagement Um = new UserManagement();
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString);
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                Session["BUTeamName"] = null;
            }
        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            string query = "select * from  bankuteam where MobileNo=@Username and password=@Password and Status=@Status";
            SqlCommand mcom = new SqlCommand(query, con);
            mcom.Parameters.AddWithValue("@Username", txtemailid.Text);
            mcom.Parameters.AddWithValue("@Password", txtpassword.Text);
            mcom.Parameters.AddWithValue("@Status", "Active");
            SqlDataAdapter mda = new SqlDataAdapter(mcom);
            DataTable dt = new DataTable();
            mda.Fill(dt);

            if (dt.Rows.Count == 0)
            {
                string strscript = "<script language='javascript'>alert('Invalid Details')</script>";
                Page.RegisterStartupScript("popup", strscript);
            }
            else
            {
                
                Session["BUTeamName"] = dt.Rows[0]["Name"].ToString();
                Session["BUTeamID"] = dt.Rows[0]["Id"].ToString();
                Session["BUTeamType"] = dt.Rows[0]["UserRoll"].ToString();
                Response.Redirect("Dashboard.aspx");
            }
            con.Close();
        }
    }
}