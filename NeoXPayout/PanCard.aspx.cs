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
    public partial class PanCard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (this.Session["BankURTName"] == null || !(Session["IsMPINVerified"] is bool isVerified && isVerified))
            {
                Response.Redirect("LoginBankU.aspx");

            }
            if (!IsPostBack) // only check on first load
            {
               
               
            }
        }
        protected void lnkSubmitPan_Click(object sender, EventArgs e)
        {
            string serviceCode = hfPanServiceCode.Value; // 5024 or 5025
            string name = txtName.Text.Trim();
            string mobile = txtMobile.Text.Trim();
            string mode = ddlMode.SelectedValue;

            // Example:
            // 5024 = PAN Creation
            // 5025 = PAN Correction

            // TODO:
            // Save request to DB
            // Call PAN API
            // Redirect or show success modal

            ScriptManager.RegisterStartupScript(this, GetType(),
                "success", "$('#successModal').modal('show');", true);
        }

    }
}