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
    public partial class IntMoneyTransfer : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["BankURTName"] == null ||
                !(Session["IsMPINVerified"] is bool isVerified && isVerified))
            {
                Response.Redirect("LoginBankU.aspx");
            }

            if (!IsPostBack)
            {
                CheckServiceStatus("International Money Transfer", btnActivateInternational);
                CheckServiceStatus("Nepal Money Transfer", btnActivateNepal);
                CheckServiceStatus("USA Money Transfer", btnActivateUSA);
            }
        }

        private void CheckServiceStatus(string serviceType, Button btn)
        {
            string cs = ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString;
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"SELECT COUNT(1)
                         FROM ServiceActivation
                         WHERE UserID = @UserID AND ServiceType = @ServiceType";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@UserID", Session["BankURTUID"].ToString());
                    cmd.Parameters.AddWithValue("@ServiceType", serviceType);

                    con.Open();
                    int exists = Convert.ToInt32(cmd.ExecuteScalar());

                    if (exists > 0)
                    {
                        btn.Text = "⏳ Processing...";
                        btn.BackColor = System.Drawing.Color.White;
                        btn.ForeColor = System.Drawing.Color.Orange;
                        btn.Enabled = false;
                    }
                }
            }
        }
        protected void btnSaveActivation_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                string serviceType = hdnServiceType.Value;
                string userMessage = txtUseCase.Text.Trim();

                string cs = ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString;
                using (SqlConnection con = new SqlConnection(cs))
                {
                    string query = @"INSERT INTO ServiceActivation
                             (ServiceType, UserID, UserMessage, Status, CreatedAt)
                             VALUES (@ServiceType, @UserID, @UserMessage, 'Pending', GETDATE())";

                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@ServiceType", serviceType);
                        cmd.Parameters.AddWithValue("@UserMessage", userMessage);
                        cmd.Parameters.AddWithValue("@UserID", Session["BankURTUID"].ToString());

                        con.Open();
                        cmd.ExecuteNonQuery();
                    }
                }
              
                CheckServiceStatus("International Money Transfer", btnActivateInternational);
                CheckServiceStatus("Nepal Money Transfer", btnActivateNepal);
                CheckServiceStatus("USA Money Transfer", btnActivateUSA);
                ScriptManager.RegisterStartupScript(this,GetType(),"showSuccessModal", "showSuccessModal();",true );

            }
        }

    }
}