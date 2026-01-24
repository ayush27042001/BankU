using Newtonsoft.Json.Linq;
using RestSharp;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NeoXPayout
{
    public partial class DMTNEW : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString;
        UserManagement Um = new UserManagement();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["BankURTName"] == null || !(Session["IsMPINVerified"] is bool isVerified && isVerified))
            {
                Response.Redirect("LoginBankU.aspx");
            }
            string Acctype = (Session["AccountHolderType"]?.ToString() ?? "").Trim().ToUpper();

            if (Acctype != "BANKU SEVA KENDRA")
            {
                Response.Redirect("Dashboard.aspx");
            }
            if (!IsRechargeServiceActive())
            {
                pnlMain.Visible = false;
                pnlError.Visible = true;

                return;
            }
            if (!IsPostBack)
            {
                string UserId = Session["BankURTUID"].ToString();
                hdnUserId.Value= UserId;
            }

        }
        private bool IsRechargeServiceActive()
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {

                string query = "SELECT Status FROM BankUServices WHERE ServiceName = @ServiceName";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@ServiceName", "DMT");
                    con.Open();

                    object statusObj = cmd.ExecuteScalar();
                    if (statusObj == null || statusObj == DBNull.Value)
                        return false;

                    string status = statusObj.ToString();

                    return (status.Equals("Active", StringComparison.OrdinalIgnoreCase) || status == "1");
                }
            }
        }
    }
}