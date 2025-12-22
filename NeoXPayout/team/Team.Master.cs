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
    public partial class Team : System.Web.UI.MasterPage
    {
        UserManagement Um = new UserManagement();
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString);
        protected void Page_Load(object sender, EventArgs e)
        {
            if (this.Session["BUTeamName"] == null)
            {
                Response.Redirect("Default.aspx");
            }
            else
            {
                if (!IsPostBack)
                {
                    Label1.Text = this.Session["BUTeamName"].ToString();
                   // lblmainwallet.Text = APIbindbal(this.Session["AdminNeoxUID"].ToString());
                  
                        HiddenField1.Value = "../bankulogo.png";
                    
                }
            }
        }

       
    }
}