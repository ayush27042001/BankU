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
    public partial class Test : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["BankURTName"] == null || !(Session["IsMPINVerified"] is bool isVerified && isVerified))
            {
                Response.Redirect("LoginBankU.aspx");
            }
        }
        protected void lnkSaveFingerprint_Click(object sender, EventArgs e)
        {
            try
            {
                string pidXml = hdnPidData.Value;

                if (string.IsNullOrEmpty(pidXml) || !pidXml.Contains("<PidData"))
                {
                    throw new Exception("Invalid fingerprint data");
                }

                SaveFingerprintToDatabase(pidXml);

                // Optional success message
                ScriptManager.RegisterStartupScript(
                    this, GetType(),
                    "msg",
                    "alert('Fingerprint stored successfully');",
                    true
                );
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(
                    this, GetType(),
                    "err",
                    $"alert('Error saving fingerprint: {ex.Message}');",
                    true
                );
            }
        }
        private void SaveFingerprintToDatabase(string pidXml)
        {
            if (string.IsNullOrEmpty(pidXml) || !pidXml.Contains("<PidData"))
            {
                throw new Exception("Invalid PID XML");
            }

            using (SqlConnection con = new SqlConnection(
                ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand(
                    @"INSERT INTO tblFingerprintLog
              (UserId, PidXml, CreatedDate, IPAddress)
              VALUES
              (@UserId, @PidXml, GETDATE(), @IP)", con))
                {
                    cmd.Parameters.AddWithValue("@UserId", Session["BankURTUID"]);
                    cmd.Parameters.AddWithValue("@PidXml", pidXml);
                    cmd.Parameters.AddWithValue("@IP", Request.UserHostAddress);

                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }
        }

    }
}