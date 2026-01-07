using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NeoXPayout.Admin
{
    public partial class Complain : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (this.Session["AdminName"] == null)
            {
                Response.Redirect("Default.aspx");
            }
            if (!IsPostBack)
            {
                LoadDisputes();

            }
        }

        private void LoadDisputes()
        {

            using (SqlConnection con = new SqlConnection(
                ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString))
            {
                SqlCommand cmd = new SqlCommand(
                    "SELECT Id, UserId, TransactionId, Type, Description, Status, CreatedAt FROM userTicket  ORDER BY CreatedAt DESC", con);

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

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString))
            {
                SqlCommand cmd = new SqlCommand(
                    "UPDATE userTicket SET Status=@Status WHERE Id=@Id", con);

                cmd.Parameters.AddWithValue("@Status", newStatus);
                cmd.Parameters.AddWithValue("@Id", disputeId);

                con.Open();
                cmd.ExecuteNonQuery();
            }

            lblMsg.Text = "Complain status updated successfully.";
            LoadDisputes();
        }
    }
}