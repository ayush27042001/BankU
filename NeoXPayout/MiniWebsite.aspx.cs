using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NeoXPayout
{
    public partial class MiniWebsite : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (this.Session["BankURTName"] == null || !(Session["IsMPINVerified"] is bool isVerified && isVerified))
            {
                Response.Redirect("LoginBankU.aspx");
              
            }
            LoadRequests();
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            string connStr = ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString;
            string UserId = Session["BankURTUID"].ToString();
            // File save paths
            string logoPath = SaveFile(fuLogo, "Uploads/");
            string gallery1 = SaveFile(fuGallery1, "Uploads/");
            string gallery2 = SaveFile(fuGallery2, "Uploads/");
            string gallery3 = SaveFile(fuGallery3, "Uploads/");
            string gallery4 = SaveFile(fuGallery4, "Uploads/");

            using (SqlConnection con = new SqlConnection(connStr))
            {
                string query = @"INSERT INTO CompanyInfo
            (UserId,CompanyName, CompanyNumber, Email, Location, LogoImage, AboutUs,
             Facebook, Twitter, Instagram, LinkedIn,Status,
             GalleryImage1, GalleryImage2, GalleryImage3, GalleryImage4)
            VALUES
            (@UserId,@CompanyName, @CompanyNumber, @Email, @Location, @LogoImage, @AboutUs,
             @Facebook, @Twitter, @Instagram, @LinkedIn,@Status,
             @Gallery1, @Gallery2, @Gallery3, @Gallery4)";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@UserId", UserId);
                    cmd.Parameters.AddWithValue("@CompanyName", txtCompanyName.Text.Trim());
                    cmd.Parameters.AddWithValue("@CompanyNumber", txtCompanyNumber.Text.Trim());
                    cmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
                    cmd.Parameters.AddWithValue("@Location", txtLocation.Text.Trim());
                    cmd.Parameters.AddWithValue("@LogoImage", (object)logoPath ?? DBNull.Value);
                    cmd.Parameters.AddWithValue("@AboutUs", txtAboutUs.Text.Trim());

                    cmd.Parameters.AddWithValue("@Facebook", txtFacebook.Text.Trim());
                    cmd.Parameters.AddWithValue("@Twitter", txtTwitter.Text.Trim());
                    cmd.Parameters.AddWithValue("@Instagram", txtInstagram.Text.Trim());
                    cmd.Parameters.AddWithValue("@LinkedIn", txtLinkedIn.Text.Trim());
                    cmd.Parameters.AddWithValue("@Status","Processing");

                    cmd.Parameters.AddWithValue("@Gallery1", (object)gallery1 ?? DBNull.Value);
                    cmd.Parameters.AddWithValue("@Gallery2", (object)gallery2 ?? DBNull.Value);
                    cmd.Parameters.AddWithValue("@Gallery3", (object)gallery3 ?? DBNull.Value);
                    cmd.Parameters.AddWithValue("@Gallery4", (object)gallery4 ?? DBNull.Value);

                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                }
                LoadRequests();
                ClearForm();
                ScriptManager.RegisterStartupScript(
               this,
               this.GetType(),
               "successModal",
               "var myModal = new bootstrap.Modal(document.getElementById('successModal')); myModal.show();",
               true
           );
            }
        }

        private void ClearForm()
        {
            txtCompanyName.Text = "";
            txtCompanyNumber.Text = "";
            txtEmail.Text = "";
            txtLocation.Text = "";
            txtAboutUs.Text = "";
            txtFacebook.Text = "";
            txtTwitter.Text = "";
            txtInstagram.Text = "";
            txtLinkedIn.Text = "";

            
            fuLogo.Attributes.Clear();
            fuGallery1.Attributes.Clear();
            fuGallery2.Attributes.Clear();
            fuGallery3.Attributes.Clear();
            fuGallery4.Attributes.Clear();
        }

        private void LoadRequests()
        {
            string UserId = Session["BankURTUID"].ToString();
            using (SqlConnection con = new SqlConnection(connStr))
            {
                string query = "SELECT CompanyName, CompanyNumber, Location, CreatedAt, Status " +
                               "FROM CompanyInfo WHERE UserId = @UserId ORDER BY CreatedAt DESC";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@UserId", UserId); 

                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    if (!reader.HasRows)
                    {
                        rptLogs.Visible = false;
                        lblNoLogs.Visible = true;
                    }
                    else
                    {
                        rptLogs.Visible = true;
                        lblNoLogs.Visible = false;
                        rptLogs.DataSource = reader;
                        rptLogs.DataBind();
                    }
                }
            }
        }

        private string SaveFile(System.Web.UI.WebControls.FileUpload fileUpload, string folderPath)
        {
            if (fileUpload.HasFile)
            {
                string folder = Server.MapPath("~/" + folderPath);
                if (!Directory.Exists(folder))
                {
                    Directory.CreateDirectory(folder);
                }
                string fileName = Guid.NewGuid().ToString() + Path.GetExtension(fileUpload.FileName);
                string filePath = Path.Combine(folder, fileName);
                fileUpload.SaveAs(filePath);
                return folderPath + fileName; // relative path for DB
            }
            return null;
        }
        
    }
}