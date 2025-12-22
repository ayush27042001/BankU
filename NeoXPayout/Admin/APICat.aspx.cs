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
    public partial class APICat : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString;
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString);
        protected void Page_Load(object sender, EventArgs e)
        {
            if (this.Session["AdminName"] == null)
            {
                Response.Redirect("Default.aspx");
            }
            if (!IsPostBack)
            {
                LoadRequests();
                
            }

        }
        private void LoadRequests()
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                string query = "SELECT * FROM APICategory";
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


                    string updateQuery = "UPDATE APICategory SET Status = @Status WHERE Id = @Id";
                    using (SqlCommand cmd = new SqlCommand(updateQuery, con))
                    {
                        cmd.Parameters.AddWithValue("@Status", ddlStatus.SelectedValue);
                        cmd.Parameters.AddWithValue("@Id", id);
                        cmd.ExecuteNonQuery();
                    }
                }
                ScriptManager.RegisterStartupScript(this, this.GetType(), "showalert",
                 "alert('Status updated successfully!');", true);
                 LoadRequests();
            }
            else if (e.CommandName == "EditRow")
            {
                int id = Convert.ToInt32(e.CommandArgument);
                ScriptManager.RegisterStartupScript(
                   this,
                   this.GetType(),
                   "EditAPI",
                   "var myModal = new bootstrap.Modal(document.getElementById('EditAPI')); myModal.show();",
                   true
                   );
                hdnAPIId.Value = id.ToString();
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    string query = "SELECT * FROM APICategory WHERE Id = @id";
                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@id", id);
                        using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                        {
                            DataTable dt = new DataTable();
                            da.Fill(dt);

                            if (dt.Rows.Count > 0)
                            {
                                txtCategory.Text = dt.Rows[0]["Category"].ToString();
                            }
                        }
                    }
                }
            }
            else if (e.CommandName == "DeleteRow")
            {
                int id = Convert.ToInt32(e.CommandArgument);
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    con.Open();
                    string updateQuery = "Delete from APICategory WHERE Id = @Id";
                    using (SqlCommand cmd = new SqlCommand(updateQuery, con))
                    {
                        cmd.Parameters.AddWithValue("@Id", id);
                        cmd.ExecuteNonQuery();
                    }
                }
                ScriptManager.RegisterStartupScript(this, this.GetType(), "showalert",
                "alert('Category deleted successfully!');", true);
                LoadRequests();
            }
        }

        protected void btnEdit_Click(object sender, EventArgs e)
        {
            string id = hdnAPIId.Value;
           
            
            try
            {

                con.Open();
                string query = "UPDATE APICategory SET Category=@Category WHERE Id = @ID";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@Category", txtCategory.Text);
                cmd.Parameters.AddWithValue("@Id", id);
                cmd.ExecuteNonQuery();
                con.Close();

            }
            catch (Exception ex)
            {
                Label1.Text = "Error occurred";
            }
            finally
            {
                con.Close();
                LoadRequests();
                ScriptManager.RegisterStartupScript(this, this.GetType(), "showalert",
                   "alert('Category updated successfully!');", true);
            }
        }
        
    }
}