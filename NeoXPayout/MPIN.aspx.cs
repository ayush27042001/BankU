using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NeoXPayout
{
    public partial class MPIN : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["BankURTName"] != null)
                    fullname.Text = Session["BankURTName"].ToString();

              
                if (Session["MPINAttempts"] == null)
                    Session["MPINAttempts"] = 0;
            }
        }

        protected void btnSubmitMPIN_Click(object sender, EventArgs e)
        {
            string enteredMPIN = txtMPIN.Text.Trim();
            string correctMPIN = Session["UserMPIN"]?.ToString();

            if (!string.IsNullOrEmpty(correctMPIN) && enteredMPIN == correctMPIN)
            {
                // MPIN correct → unlock session
                Session["IsMPINVerified"] = true;

                // reset wrong attempt count
                Session["MPINAttempts"] = 0;

                // Get last page (either from inactivity or login)
                string lastPage = Session["LastPage"]?.ToString();

                if (!string.IsNullOrEmpty(lastPage))
                {
                    // Clear after use to prevent old redirects
                    Session.Remove("LastPage");
                    Response.Redirect(lastPage);
                }
                else
                {
                    Response.Redirect("Dashboard.aspx");
                }
            }
            else
            {
                //Wrong MPIN → increase attempt count
                int attempts = (Session["MPINAttempts"] != null) ? Convert.ToInt32(Session["MPINAttempts"]) : 0;
                attempts++;
                Session["MPINAttempts"] = attempts;

                if (attempts >= 3)
                { 
                   
                    Response.Redirect("LogOut.aspx");
                    return;
                }

                // Show error message
                lblError.Text = $"Invalid MPIN. Attempt {attempts}/3.";
                lblError.CssClass = "text-danger fw-semibold";
            }
        }

    }
}