using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NeoXPayout.Admin
{
    public partial class EditWebhook : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString);
        protected void Page_Load(object sender, EventArgs e)
        {
            if (this.Session["AdminName"] == null)
            {
                Response.Redirect("Default.aspx");
            }
            if (!IsPostBack)
            {
               
                Getdetails();
            }
        }
        protected void Getdetails()
        {                
            string query = "SELECT * FROM APIWebhook WHERE Id = @ID";
            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@ID", '1');
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            if (dt.Rows.Count > 0)
            {
             
                txtLink.Text = dt.Rows[0]["Link"].ToString();
                txtReq.Text = dt.Rows[0]["ReqPara"].ToString();

            }
            else
            {
                Response.Write("<script>alert('Product not found'); window.location='DashboardAdmin.aspx';</script>");
            }
        }
        protected void btnUpdate_Click(object sender, EventArgs e)
        {
   
            string connectionString = ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString;
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();


                string query = "UPDATE APIWebhook SET  Link=@Link, ReqPara=@ReqPara WHERE Id = @ID";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {   
                    cmd.Parameters.AddWithValue("@Link", txtLink.Text.Trim());
                    cmd.Parameters.AddWithValue("@ReqPara", txtReq.Text.Trim());                  
                    cmd.Parameters.AddWithValue("@Id", '1');
                    cmd.ExecuteNonQuery();
                }

                con.Close();
            }
            Response.Redirect("DashboardAdmin.aspx");
        }
    }
}