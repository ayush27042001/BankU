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
    public partial class ProfileRequest : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString;
        UserManagement um = new UserManagement();
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
                string query = "SELECT * FROM ProfileUpdateRequests";
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
                string[] args = e.CommandArgument.ToString().Split('|');
                string reqId = args[0];
                int userId = Convert.ToInt32(args[1]);
                string Type = args[2];
                string NewValue = args[3];

               
                GridViewRow row = ((System.Web.UI.Control)e.CommandSource).NamingContainer as GridViewRow;
                DropDownList ddlStatus = (DropDownList)row.FindControl("ddlStatus");
                string selectedStatus = ddlStatus.SelectedValue;
               
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    con.Open();

                    string updateQuery = "UPDATE ProfileUpdateRequests SET RequestStatus = @RequestStatus WHERE RequestId = @RequestId";
                    using (SqlCommand cmd = new SqlCommand(updateQuery, con))
                    {
                        cmd.Parameters.AddWithValue("@RequestStatus", ddlStatus.SelectedValue);
                        cmd.Parameters.AddWithValue("@RequestId", reqId);
                        cmd.ExecuteNonQuery();
                    }
                }
                if (selectedStatus == "Approved")
                {
                    string conStr = ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString;
                    using (SqlConnection conn = new SqlConnection(conStr))
                    {
                       
                        string updateRegQuery = $"UPDATE Registration SET {Type} = @NewValue WHERE RegistrationId = @UserId";

                        using (SqlCommand cmd = new SqlCommand(updateRegQuery, conn))
                        {
                            cmd.Parameters.AddWithValue("@NewValue", NewValue);
                            cmd.Parameters.AddWithValue("@UserId", userId);

                            conn.Open();
                            cmd.ExecuteNonQuery();
                        }
                    }
                }
                
                LoadRequests();
            }
        }
    }
}