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
    public partial class ViewFeatureMap : System.Web.UI.Page
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
                string query = "SELECT * FROM SERVICE_PROVIDER_FEATURE_MAP";
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
            int Id = Convert.ToInt32(gvRequests.DataKeys[e.RowIndex].Value);
            GridViewRow row = gvRequests.Rows[e.RowIndex];

            string ProviderCode = ((TextBox)row.FindControl("txtProviderCode")).Text;
            string ServiceCode = ((TextBox)row.FindControl("txtServiceCode")).Text;
            string FeatureCode = ((TextBox)row.FindControl("txtFeatureCode")).Text;
            bool isEnabled = Convert.ToBoolean(((DropDownList)row.FindControl("ddlIsEnabled")).SelectedValue);

            using (SqlConnection con = new SqlConnection(connStr))
            {
                con.Open();
                string query = @"UPDATE SERVICE_PROVIDER_FEATURE_MAP SET ProviderCode = @ProviderCode, ServiceCode = @ServiceCode,FeatureCode=@FeatureCode,  IsEnabled = @IsEnabled WHERE Id = @Id";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@ProviderCode", ProviderCode);
                    cmd.Parameters.AddWithValue("@ServiceCode", ServiceCode);
                    cmd.Parameters.AddWithValue("@FeatureCode", FeatureCode);
                    cmd.Parameters.AddWithValue("@IsEnabled", isEnabled);
                    cmd.Parameters.AddWithValue("@Id", Id);
                    cmd.ExecuteNonQuery();
                }
            }

            gvRequests.EditIndex = -1;
            LoadRequests();
        }
        protected void gvRequests_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int Id = Convert.ToInt32(gvRequests.DataKeys[e.RowIndex].Value);

            using (SqlConnection con = new SqlConnection(connStr))
            {
                con.Open();
                string query = "DELETE FROM SERVICE_PROVIDER_FEATURE_MAP WHERE Id = @Id";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@Id", Id);
                    cmd.ExecuteNonQuery();
                }
            }

            gvRequests.EditIndex = -1;
            LoadRequests();
        }

    }
}