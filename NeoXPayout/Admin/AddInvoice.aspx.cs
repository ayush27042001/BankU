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
    public partial class AddInvoice : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString;
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

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            string InvoiceType = txtType.Text.Trim();
            string StartDate = txtStartDate.Text.Trim();
            string Enddate = txtEndDate.Text.Trim();
            string UserId = ddlUserId.SelectedValue;
            string InvId = txtInvId.Text.Trim();


            string iconPath = "";

            if (fuInvoice.HasFile)
            {
                string folderPath = Server.MapPath("~/uploadfile/");
                if (!Directory.Exists(folderPath))
                    Directory.CreateDirectory(folderPath);

                string fileName = Guid.NewGuid().ToString() + Path.GetExtension(fuInvoice.FileName); // unique filename
                string savePath = Path.Combine(folderPath, fileName);

                fuInvoice.SaveAs(savePath);

                // store relative path in DB
                iconPath = "~/uploadfile/" + fileName;
            }
            else
            {
                lblFileError.Text = "Please select a file.";
                return;
            }

            string connectionString = ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString;
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();
                
                string query = @"INSERT INTO UserInvoice 
                    (InvoiceType,InvoiceId, StartDate, Enddate, FilePath,UserId) 
                    VALUES (@InvoiceType,@InvoiceId, @StartDate, @Enddate, @FilePath,@UserId)";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@InvoiceType", InvoiceType);
                    cmd.Parameters.AddWithValue("@InvoiceId", InvId);
                    cmd.Parameters.AddWithValue("@StartDate", StartDate);
                    cmd.Parameters.AddWithValue("@Enddate", Enddate);
                    cmd.Parameters.AddWithValue("@FilePath", iconPath);
                    cmd.Parameters.AddWithValue("@UserId", UserId);
                    cmd.ExecuteNonQuery();
                }

                con.Close();
            }

            ScriptManager.RegisterStartupScript(
                this,
                this.GetType(),
                "successModal",
                "var myModal = new bootstrap.Modal(document.getElementById('successModal')); myModal.show();", true);

            txtType.Text = "";
            txtStartDate.Text = "";
            txtEndDate.Text = "";
            txtInvId.Text = "";
        }
    }
}