using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NeoXPayout.Admin
{
    public partial class AddDispute : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (this.Session["AdminName"] == null)
            {
                Response.Redirect("Default.aspx");

            }
            BindUsers();
        }
        private void BindUsers()
        {
            DataTable dt = new DataTable();

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["BankUConnectionString"].ToString()))
            {
                using (SqlCommand cmd = new SqlCommand("SELECT RegistrationId, FullName FROM Registration ORDER BY RegistrationId DESC", con))
                {
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    da.Fill(dt);
                }
            }

            // Add formatted display column MobileNo (RegistrationId)
            dt.Columns.Add("MobileDisplay", typeof(string));
            foreach (DataRow row in dt.Rows)
            {
                row["MobileDisplay"] = $"{row["FullName"]} ({row["RegistrationId"]})";
            }

            ddlUserId.DataSource = dt;
            ddlUserId.DataTextField = "MobileDisplay";
            ddlUserId.DataValueField = "RegistrationId";
            ddlUserId.DataBind();

            ddlUserId.Items.Insert(0, new ListItem("-- Select User --", ""));
        }

        protected void btnAddDispute_Click(object sender, EventArgs e)
        {
            string disputeType = txtDisputeType.Text.Trim();
            string transactionId = txtTransactionId.Text.Trim();
            string userId = ddlUserId.SelectedValue;
            string description = txtDescription.Text.Trim();

            string proofPath = "";
            // Mandatory proof validation
            if (!fuProof.HasFile)
            {
                lblFileError.Text = "Please upload proof document.";
                lblFileError.Visible = true;
                return;
            }


            if (fuProof.HasFile)
            {
                string folderPath = Server.MapPath("~/uploadfile/disputes/");
                if (!Directory.Exists(folderPath))
                    Directory.CreateDirectory(folderPath);

                string fileName = Guid.NewGuid().ToString() + Path.GetExtension(fuProof.FileName);
                string savePath = Path.Combine(folderPath, fileName);

                fuProof.SaveAs(savePath);
                proofPath = "~/uploadfile/disputes/" + fileName;
            }
            string ext = Path.GetExtension(fuProof.FileName).ToLower();
            string[] allowedExt = { ".jpg", ".jpeg", ".png", ".pdf" };

            if (!allowedExt.Contains(ext))
            {
                lblFileError.Text = "Only JPG, PNG or PDF files are allowed.";
                lblFileError.Visible = true;
                return;
            }
            string connectionString = ConfigurationManager
                .ConnectionStrings["BankUConnectionString"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();

                string query = @"
            INSERT INTO tblDisputes
            (UserId, TransactionId, DisputeType, Description, ProofPath, Status, CreatedAt)
            VALUES
            (@UserId, @TransactionId, @DisputeType, @Description, @ProofPath, 'Pending', GETDATE())";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@UserId", userId);
                    cmd.Parameters.AddWithValue("@TransactionId", transactionId);
                    cmd.Parameters.AddWithValue("@DisputeType", disputeType);
                    cmd.Parameters.AddWithValue("@Description", description);
                    cmd.Parameters.AddWithValue("@ProofPath", proofPath);

                    cmd.ExecuteNonQuery();
                }
            }

            // Show success modal
            ScriptManager.RegisterStartupScript(
                this,
                this.GetType(),
                "successModal",
                "var myModal = new bootstrap.Modal(document.getElementById('successModal')); myModal.show();",
                true);

            // Clear form
            txtDisputeType.Text = "";
            txtTransactionId.Text = "";
            txtDescription.Text = "";
            ddlUserId.SelectedIndex = 0;
        }
    }
}