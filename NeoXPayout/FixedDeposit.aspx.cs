using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NeoXPayout
{
    public partial class FixedDeposit : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (this.Session["BankURTName"] == null || !(Session["IsMPINVerified"] is bool isVerified && isVerified))
            {
                Response.Redirect("LoginBankU.aspx");

            }
            if (!IsPostBack)
            {
                string cs = ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString;
                using (SqlConnection con = new SqlConnection(cs))
                {
                    string query = "SELECT COUNT(1) FROM ServiceActivation WHERE UserID = @UserID AND ServiceType = @ServiceType";
                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@UserID", Session["BankURTUID"].ToString());
                        cmd.Parameters.AddWithValue("@ServiceType", "FixedDeposit Service Activation");

                        con.Open();
                        int exists = Convert.ToInt32(cmd.ExecuteScalar());

                        if (exists > 0)
                        {
                            // Already requested → set to processing
                            btnActivate.Text = "⏳ Processing...";
                            btnActivate.BackColor = System.Drawing.Color.White;
                            btnActivate.ForeColor = System.Drawing.Color.Orange;
                            btnActivate.Enabled = false;
                        }
                    }
                }
            }
        }
        protected void btnSaveActivation_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                string UserMessage = txtUseCase.Text.Trim();
                string cs = ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString;
                using (SqlConnection con = new SqlConnection(cs))
                {
                    string query = "INSERT INTO ServiceActivation (ServiceType, UserID,UserMessage,status, CreatedAt) VALUES (@ServiceType, @UserID,@UserMessage,@status, GETDATE())";
                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@ServiceType", "FixedDeposit Service Activation");
                        cmd.Parameters.AddWithValue("@UserMessage", UserMessage);
                        cmd.Parameters.AddWithValue("@status", "Pending");
                        cmd.Parameters.AddWithValue("@UserID", Session["BankURTUID"].ToString());

                        con.Open();
                        cmd.ExecuteNonQuery();
                    }
                }
                string script = "var myModal = new bootstrap.Modal(document.getElementById('successModal')); myModal.show();";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "showSuccessModal", script, true);
                // Change button text & disable it
                btnActivate.Text = "⏳ Processing...";
                btnActivate.BackColor = System.Drawing.Color.White;
                btnActivate.ForeColor = System.Drawing.Color.Orange;
                btnActivate.Enabled = false;
            }
        }
    }
}