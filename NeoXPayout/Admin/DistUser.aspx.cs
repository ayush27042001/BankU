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
    public partial class DistUser : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (this.Session["AdminName"] == null)
            {
                Response.Redirect("Default.aspx");
            }
            if (!IsPostBack)
            {
                //LoadRequests();
                LoadRequests1();
            }
        }
        //private void LoadRequests()
        //{
        //    using (SqlConnection con = new SqlConnection(connStr))
        //    {
        //        string query = "SELECT * FROM Registration where AccountType='Distributor' ORDER BY RegistrationId Asc";
        //        using (SqlCommand cmd = new SqlCommand(query, con))
        //        {
        //            con.Open();
        //            SqlDataReader reader = cmd.ExecuteReader();

        //            if (!reader.HasRows)
        //            {
        //                ddlDist.Items.Clear(); 
        //                lblMessage.Text = "No request available";
        //                lblMessage.ForeColor = System.Drawing.Color.Red;
        //                gvRequests.Visible = false;
        //            }
        //            else
        //            {
                      
        //                ddlDist.DataSource = reader;
        //                ddlDist.DataTextField = "FullName";     
        //                ddlDist.DataValueField = "RegistrationId"; 
        //                ddlDist.DataBind();

                        
        //                ddlDist.Items.Insert(0, new ListItem("--Select Distributor--", ""));

                       
        //                lblMessage.Text = "";
        //            }
        //        }
        //    }
        //}

        
        protected void gvRequests_RowCommand(object sender, System.Web.UI.WebControls.GridViewCommandEventArgs e)
        {
            if (e.CommandName == "UpdateStatus")
            {
                int id = Convert.ToInt32(e.CommandArgument);
                GridViewRow row = ((System.Web.UI.Control)e.CommandSource).NamingContainer as GridViewRow;
                DropDownList ddlStatus = (DropDownList)row.FindControl("ddlStatus");

                using (SqlConnection con = new SqlConnection(connStr))
                {
                    con.Open();


                    string updateQuery = "UPDATE DistUserAdd SET Status = @Status WHERE Id = @Id";
                    using (SqlCommand cmd = new SqlCommand(updateQuery, con))
                    {
                        cmd.Parameters.AddWithValue("@Status", ddlStatus.SelectedValue);
                        cmd.Parameters.AddWithValue("@Id", id);
                        cmd.ExecuteNonQuery();
                    }
                }
                LoadRequests1();
            }
        }
        private void LoadRequests1() 
        {
            //string UserId = ddlDist.SelectedValue;
            using (SqlConnection con = new SqlConnection(connStr))
            {
                string query = "SELECT * FROM DistUserAdd";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    con.Open();
                   
                    SqlDataReader reader = cmd.ExecuteReader();

                    if (!reader.HasRows)
                    {
                        gvRequests.Visible = false;
                        lblMessage.Text = "No request available";
                        lblMessage.ForeColor = System.Drawing.Color.Red;
                    }
                    else
                    {
                        gvRequests.Visible = true;
                        gvRequests.DataSource = reader;
                        gvRequests.DataBind();
                        lblMessage.Text = "";
                    }
                }
            }
        }
        //protected void btnSearch_Click(object sender, EventArgs e)
        //{
        //    //string UserId = ddlDist.SelectedValue;
        //    using (SqlConnection con = new SqlConnection(connStr))
        //    {
        //        string query = "SELECT * FROM DistUserAdd where UserId= @UserId";
        //        using (SqlCommand cmd = new SqlCommand(query, con))
        //        {
        //            con.Open();
        //            cmd.Parameters.AddWithValue("@UserId", UserId);
        //            SqlDataReader reader = cmd.ExecuteReader();

        //            if (!reader.HasRows)
        //            {
        //                gvRequests.Visible = false;
        //                lblMessage.Text = "No User available";
        //                lblMessage.ForeColor = System.Drawing.Color.Red;
        //            }
        //            else
        //            {
        //                gvRequests.Visible = true;
        //                gvRequests.DataSource = reader;
        //                gvRequests.DataBind();
        //                lblMessage.Text = "";
        //            }
        //        }
        //    }
        //}
    }
}