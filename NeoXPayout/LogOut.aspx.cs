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
    public partial class LogOut : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                // Make sure the user is logged in
                if (Session["BankURTMobileno"] != null)
                {
                    string mobile = Session["BankURTMobileno"].ToString();

                    // Delete from DB
                    DeleteLoginRecord(mobile);
                }
            }
            catch (Exception ex)
            {
                // Optional: Log the error
            }
            finally
            {
                // Clear session
                Session.Clear();
                Session.Abandon();

                Response.Redirect("LoginBankU.aspx");
            }
        }

        private void DeleteLoginRecord(string mobile)
        {
            string connStr = ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "DELETE FROM LoginDoc WHERE UserID = @MobileNumber";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@MobileNumber", mobile);
                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
            }
        }
    }
}