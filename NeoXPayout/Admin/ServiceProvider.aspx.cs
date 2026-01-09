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
    public partial class ServiceProvider : System.Web.UI.Page
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
            string service = txtService.Text.Trim();
            string provider = txtProvider.Text.Trim();



            using (SqlConnection con = new SqlConnection(connStr))
            {
                con.Open();

                string query = "INSERT INTO SERVICE_PROVIDER (ServiceCode, ProviderCode,IsEnabled) VALUES (@ServiceCode, @ProviderCode,@IsEnabled)";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@ServiceCode", service);
                    cmd.Parameters.AddWithValue("@ProviderCode", provider);


                    cmd.Parameters.AddWithValue("@IsEnabled", true);

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
            txtProvider.Text = "";

            txtService.Text = "";
        }
    }
}