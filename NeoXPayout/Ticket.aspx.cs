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
    public partial class Ticket : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString);
        SqlCommand com = new SqlCommand();
        SqlDataAdapter da = new SqlDataAdapter();
        SqlDataAdapter da1 = new SqlDataAdapter();
        DataSet ds = new DataSet();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (this.Session["BankURTName"] == null || !(Session["IsMPINVerified"] is bool isVerified && isVerified))
            {
                Response.Redirect("LoginBankU.aspx");

            }
            else
            {
                if (!IsPostBack)
                {

                    getdetails();

                }
            }
        }

        public void getdetails()
        {
            string userId = Session["BankURTUID"].ToString();
            string query = "select * from  userTicket where UserId=@UserId  order by Id desc";
            SqlCommand mcom = new SqlCommand(query, con);
            mcom.Parameters.AddWithValue("@UserId", userId);
            SqlDataAdapter mda = new SqlDataAdapter(mcom);
            DataTable dt = new DataTable();
            mda.Fill(dt);

            if (dt.Rows.Count == 0)
            {
                rptProduct.Visible = false;
            }
            else
            {
                rptProduct.Visible = true;
                rptProduct.DataSource = dt;
                rptProduct.DataBind();
            }

            con.Close();
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            string ticketType = ddlService.SelectedValue;
            string transactionId = txtTxn.Text.Trim();
            string userId = Session["BankURTUID"].ToString();
            string description = txtDescription.Text.Trim();


            string connectionString = ConfigurationManager
                .ConnectionStrings["BankUConnectionString"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();

                string query = @"
            INSERT INTO userTicket
            (UserId, TransactionId, Type, Description, Status, CreatedAt)
            VALUES
            (@UserId, @TransactionId, @Type, @Description, @Status, GETDATE())";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@UserId", userId);
                    cmd.Parameters.AddWithValue("@TransactionId", transactionId);
                    cmd.Parameters.AddWithValue("@Type", ticketType);
                    cmd.Parameters.AddWithValue("@Description", description);
                    cmd.Parameters.AddWithValue("@Status", "Pending");
                    cmd.ExecuteNonQuery();
                }
            }

            ScriptManager.RegisterStartupScript(
                this,
                this.GetType(),
                "successModal",
                "var myModal = new bootstrap.Modal(document.getElementById('successModal')); myModal.show();",
                true);

            getdetails();

            ddlService.Text = "";
            txtTxn.Text = "";
            txtDescription.Text = "";

        }
    }
}