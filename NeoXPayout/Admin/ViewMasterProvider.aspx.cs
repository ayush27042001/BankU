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
    public partial class ViewMasterProvider : System.Web.UI.Page
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
                string query = "SELECT * FROM MASTER_PROVIDER";
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
        protected void gvRequests_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvRequests.EditIndex = e.NewEditIndex;
            LoadRequests();
        }
        protected void gvRequests_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvRequests.EditIndex = -1;
            LoadRequests();
        }


        protected void gvRequests_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int ProviderId = Convert.ToInt32(gvRequests.DataKeys[e.RowIndex].Value);
            GridViewRow row = gvRequests.Rows[e.RowIndex];

            string ProviderCode = ((TextBox)row.FindControl("txtProviderCode")).Text;
            string ProviderName = ((TextBox)row.FindControl("txtProviderName")).Text;
            bool isEnabled = Convert.ToBoolean(((DropDownList)row.FindControl("ddlIsEnabled")).SelectedValue);
          
            using (SqlConnection con = new SqlConnection(connStr))
            {
                con.Open();
                string query = @"UPDATE MASTER_PROVIDER SET ProviderCode = @ProviderCode, ProviderName = @ProviderName,  IsEnabled = @IsEnabled WHERE ProviderId = @ProviderId";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@ProviderCode", ProviderCode);
                    cmd.Parameters.AddWithValue("@ProviderName", ProviderName);
                    cmd.Parameters.AddWithValue("@IsEnabled", isEnabled);
                    cmd.Parameters.AddWithValue("@ProviderId", ProviderId);
                    cmd.ExecuteNonQuery();
                }
            }

            gvRequests.EditIndex = -1;
            LoadRequests();
        }
        protected void gvRequests_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int ProviderId = Convert.ToInt32(gvRequests.DataKeys[e.RowIndex].Value);

            using (SqlConnection con = new SqlConnection(connStr))
            {
                con.Open();
                string query = "DELETE FROM MASTER_PROVIDER WHERE ProviderId = @ProviderId";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@ProviderId", ProviderId);
                    cmd.ExecuteNonQuery();
                }
            }

            gvRequests.EditIndex = -1;
            LoadRequests();
        }

    }
}