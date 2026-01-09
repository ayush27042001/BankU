using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NeoXPayout.Admin
{
    public partial class ManageFeature : System.Web.UI.Page
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
               
            }

        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            string config = txtDiscription.Text.Trim();
            string FCode = txtFeatureCode.Text.Trim();
            string FName = txtFeatureName.Text.Trim();
            string OrderId = txtOrder.Text.Trim();
            string Service = txtService.Text.Trim();
            string iconPath = "";

            if (fuIcon.HasFile)
            {
                string folderPath = Server.MapPath("~/uploadfile/");
                if (!Directory.Exists(folderPath))
                    Directory.CreateDirectory(folderPath);

                string fileName = Path.GetExtension(fuIcon.FileName); 
                string savePath = Path.Combine(folderPath, fileName);

                fuIcon.SaveAs(savePath);

                // store relative path in DB
                iconPath = "~/uploadfile/" + fileName;
            }
            else
            {
                lblError.Text = "Please select a file.";
                return;
            }
            using (SqlConnection con = new SqlConnection(connStr))
            {
                con.Open();

                string query = "INSERT INTO MASTER_FEATURE (ServiceCode, FeatureCode, FeatureName,Icon, ExtraConfig, IsEnabled, DisplayOrder) VALUES (@ServiceCode, @FeatureCode,@FeatureName,@Icon,@ExtraConfig,@IsEnabled,@DisplayOrder)";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@ServiceCode", Service);
                    cmd.Parameters.AddWithValue("@FeatureCode", FCode);
                    cmd.Parameters.AddWithValue("@FeatureName", FName);
                    cmd.Parameters.AddWithValue("@Icon", iconPath);
                    cmd.Parameters.AddWithValue("@ExtraConfig", config);
                    cmd.Parameters.AddWithValue("@IsEnabled", true);
                    cmd.Parameters.AddWithValue("@DisplayOrder", OrderId);
                    cmd.ExecuteNonQuery();
                }

                con.Close();
            }

            ScriptManager.RegisterStartupScript(
                this,
                this.GetType(),
                "successModal",
                "var myModal = new bootstrap.Modal(document.getElementById('successModal')); myModal.show();",
                true
            );
            txtDiscription.Text = "";
            txtFeatureCode.Text = "";
            txtFeatureName.Text = "";
            txtOrder.Text = "";
            txtService.Text = "";
        }
    }
}