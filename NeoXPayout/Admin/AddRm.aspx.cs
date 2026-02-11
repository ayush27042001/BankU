using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NeoXPayout.Admin
{
    public partial class AddRm : System.Web.UI.Page
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


                }
            }
        }
        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            try
            {
                con.Open();
                string query = "insert into RmDetail(RmName,RmMobile,RmPassword,Status) values(@RmName,@RmMobile,@RmPassword,@Status)";
                SqlCommand cmd = new SqlCommand(query, con);
              
                cmd.Parameters.AddWithValue("@RmName", txtfullname.Text);
                cmd.Parameters.AddWithValue("@RmMobile", txtmobileno.Text);
                
                cmd.Parameters.AddWithValue("@RmPassword", txtPassword.Text);

              
                cmd.Parameters.AddWithValue("@Status", "Active");
              
                cmd.ExecuteNonQuery();
                con.Close();
                Response.Redirect("ViewRm.aspx");
            }
            catch (Exception ex)
            {
                Label1.Text = ex.ToString();
            }
            finally
            {
                con.Close();
            }
        }
    }
}