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
    public partial class ViewFeature : System.Web.UI.Page
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
                string query = "SELECT * FROM MASTER_FEATURE";
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
            int featureId = Convert.ToInt32(gvRequests.DataKeys[e.RowIndex].Value);
            GridViewRow row = gvRequests.Rows[e.RowIndex];

            string serviceCode = ((TextBox)row.FindControl("txtServiceCode")).Text;
            string featureCode = ((TextBox)row.FindControl("txtFeatureCode")).Text;
            bool isEnabled = Convert.ToBoolean(((DropDownList)row.FindControl("ddlIsEnabled")).SelectedValue);
            string extraConfig = ((TextBox)row.FindControl("txtExtraConfig")).Text;
            int displayOrder = Convert.ToInt32(((TextBox)row.FindControl("txtDisplayOrder")).Text);

            using (SqlConnection con = new SqlConnection(connStr))
            {
                con.Open();
                string query = @"UPDATE MASTER_FEATURE SET ServiceCode = @ServiceCode, FeatureCode = @FeatureCode,  IsEnabled = @IsEnabled, ExtraConfig = @ExtraConfig, DisplayOrder = @DisplayOrder WHERE FeatureId = @FeatureId";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@ServiceCode", serviceCode);
                    cmd.Parameters.AddWithValue("@FeatureCode", featureCode);
                    cmd.Parameters.AddWithValue("@IsEnabled", isEnabled);
                    cmd.Parameters.AddWithValue("@ExtraConfig", extraConfig);
                    cmd.Parameters.AddWithValue("@DisplayOrder", displayOrder);
                    cmd.Parameters.AddWithValue("@FeatureId", featureId);
                    cmd.ExecuteNonQuery();
                }
            }

            gvRequests.EditIndex = -1;
            LoadRequests();
        }

    }
}