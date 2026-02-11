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
    public partial class ViewUser : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString);
        
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

                    getdetails();

                }
            }
        }

        public void getdetails()
        {
            if (Session["RmID"] == null)
            {
                Response.Redirect("Default.aspx");
                return;
            }

            string rmId = Session["RmID"].ToString();

            string query = "SELECT * FROM Registration WHERE RmId = @RmId ORDER BY RegistrationId DESC";

            using ( con)
            {
                using (SqlCommand mcom = new SqlCommand(query, con))
                {
                    mcom.Parameters.AddWithValue("@RmId", rmId);

                    using (SqlDataAdapter mda = new SqlDataAdapter(mcom))
                    {
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
                    }
                }
            }
        }

    }
}