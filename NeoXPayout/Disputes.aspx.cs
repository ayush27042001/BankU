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
    public partial class Disputes : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (this.Session["BankURTName"] == null || !(Session["IsMPINVerified"] is bool isVerified && isVerified))
            {
                Response.Redirect("LoginBankU.aspx");

            }
            if (!IsPostBack) // only check on first load
            {
                LoadDisputes();
           
            }
        }

        private void LoadDisputes()
        {
            string UserId = Session["BankURTUID"].ToString();
            using (SqlConnection con = new SqlConnection(
                ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString))
            {
                SqlCommand cmd = new SqlCommand(
                    "SELECT Id, UserId, TransactionId, DisputeType, Description, Status, CreatedAt FROM tblDisputes WHERE UserId = @UserId ORDER BY CreatedAt DESC", con);
                cmd.Parameters.AddWithValue("@UserId", UserId);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
               
                DataTable dt = new DataTable();
                da.Fill(dt);

                if (dt.Rows.Count > 0)
                {
                    rptDisputes.Visible = true;
                    lblError.Visible = false;

                    rptDisputes.DataSource = dt;
                    rptDisputes.DataBind();
                }
                else
                {
                    rptDisputes.Visible = false;
                    lblError.Visible = true;
                }
            }
        }

        protected void rptDisputes_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int disputeId = Convert.ToInt32(e.CommandArgument);
            string newStatus = "";

            if (e.CommandName == "Resolve")
                newStatus = "Resolved";
            else if (e.CommandName == "Reject")
                newStatus = "Rejected";

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["con"].ConnectionString))
            {
                SqlCommand cmd = new SqlCommand(
                    "UPDATE tblDisputes SET Status=@Status WHERE Id=@Id", con);

                cmd.Parameters.AddWithValue("@Status", newStatus);
                cmd.Parameters.AddWithValue("@Id", disputeId);

                con.Open();
                cmd.ExecuteNonQuery();
            }

            lblMsg.Text = "Dispute status updated successfully.";
            LoadDisputes();
        }
    }
}