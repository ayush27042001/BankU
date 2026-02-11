using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace NeoXPayout.Admin
{
    public partial class ViewRm : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString);
        
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

                    getdetails();

                }
            }
        }

        public void getdetails()
        {
           
            using (con)
            {
                string query = "select * from  RmDetail ";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    if (!reader.HasRows)
                    {
                        gvRequests.Visible = false;
                        lblMessage.Text = "No request available";
                        lblMessage.ForeColor = System.Drawing.Color.Red;
                        con.Close();
                    }
                    else
                    {
                        gvRequests.Visible = true;
                        lblMessage.Text = "";
                        DataTable dt = new DataTable();
                        dt.Load(reader);

                        gvRequests.DataSource = dt;
                        gvRequests.DataBind();
                        con.Close();
                    }
                }
            }
        }
        protected void gvRequests_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "EditRow")
            {
                string id = e.CommandArgument.ToString();
                Response.Redirect("EditRm.aspx?ID=" + id);
            }
        }

    }
}