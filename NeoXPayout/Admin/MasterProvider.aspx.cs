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
    public partial class MasterProvider : System.Web.UI.Page
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
            string Code = txtProviderCode.Text.Trim();
            string Name = txtProviderName.Text.Trim();
          
            using (SqlConnection con = new SqlConnection(connStr))
            {
                con.Open();

                string query = "INSERT INTO MASTER_PROVIDER (ProviderCode, ProviderName, IsEnabled) VALUES (@ProviderCode, @ProviderName, @IsEnabled)";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@ProviderCode", Code);
                    cmd.Parameters.AddWithValue("@ProviderName", Name);
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
            txtProviderCode.Text = "";
            txtProviderName.Text = "";
           
        }
    }
}