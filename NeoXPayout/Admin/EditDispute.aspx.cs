using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI.WebControls;

namespace NeoXPayout.Admin
{
    public partial class EditDispute : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString);
        protected void Page_Load(object sender, EventArgs e)
        {
            if (this.Session["AdminName"] == null)
            {
                Response.Redirect("Default.aspx");
            }
            else
            {

                if (!IsPostBack)
                {
                    BindUsers();
                    Getdetails();
                }
            }
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
        protected void Getdetails()
        {
            string id = Request.QueryString["Id"];

            if (string.IsNullOrEmpty(id))
            {
                Response.Redirect("ViewDispute.aspx");
                return;
            }

            string query = "SELECT * FROM tblDisputes WHERE Id = @Id";

            using (SqlConnection con = new SqlConnection(
                ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@Id", id);

                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    if (dt.Rows.Count == 0)
                    {
                        Response.Redirect("ViewDispute.aspx");
                        return;
                    }

                    DataRow row = dt.Rows[0];

                    txtDisputeType.Text = row["DisputeType"].ToString();
                    txtTransactionId.Text = row["TransactionId"].ToString();
                    ddlUserId.SelectedValue = row["UserId"].ToString();
                    txtDescription.Text = row["Description"].ToString();
                    ddlStatus.SelectedValue = row["Status"].ToString();

                    string proofPath = row["ProofPath"].ToString();

                    if (!string.IsNullOrEmpty(proofPath))
                    {
                        hiddenOldFilePath.Value = proofPath;
                        hlCurrentFile.NavigateUrl = proofPath;
                        hlCurrentFile.Text = "📄 View Uploaded Proof";
                        hlCurrentFile.Visible = true;
                    }
                }
            }
        }
        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            string id = Request.QueryString["Id"];
            if (string.IsNullOrEmpty(id))
                return;

            string proofPath = hiddenOldFilePath.Value;

            // If new proof uploaded
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

            try
            {
                using (SqlConnection con = new SqlConnection(
                    ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString))
                {
                    con.Open();

                    string query = @"
                UPDATE tblDisputes SET
                    DisputeType   = @DisputeType,
                    TransactionId= @TransactionId,
                    UserId        = @UserId,
                    Description   = @Description,
                    Status        = @Status,
                    ProofPath     = @ProofPath
                WHERE Id = @Id";

                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@DisputeType", txtDisputeType.Text.Trim());
                        cmd.Parameters.AddWithValue("@TransactionId", txtTransactionId.Text.Trim());
                        cmd.Parameters.AddWithValue("@UserId", ddlUserId.SelectedValue);
                        cmd.Parameters.AddWithValue("@Description", txtDescription.Text.Trim());
                        cmd.Parameters.AddWithValue("@Status", ddlStatus.SelectedValue);
                        cmd.Parameters.AddWithValue("@ProofPath", proofPath);
                        cmd.Parameters.AddWithValue("@Id", id);

                        cmd.ExecuteNonQuery();
                    }
                }

                Response.Redirect("ViewDispute.aspx");
            }
            catch (Exception ex)
            {
                Label1.Text = ex.Message;
            }
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            string productId = Request.QueryString["Id"];
            if (string.IsNullOrEmpty(productId))
            {
                Response.Write("<script>alert('Invalid Dispute ID');</script>");
                return;
            }

            try
            {
                con.Open();
                string sql = "DELETE FROM tblDisputes WHERE Id=@ID";
                SqlCommand cmd = new SqlCommand(sql, con);
                cmd.Parameters.AddWithValue("@ID", productId);
                cmd.ExecuteNonQuery();
                Response.Write("<script>alert('Dispute Deleted Successfully'); window.location='ViewDispute.aspx';</script>");
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error: " + ex.Message + "');</script>");
            }
            finally
            {
                con.Close();
            }
        }
    }

}