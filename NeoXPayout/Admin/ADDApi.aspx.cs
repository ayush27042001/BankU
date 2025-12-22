using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NeoXPayout.Admin
{
    public partial class ADDApi : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (this.Session["AdminName"] == null)
            {
                Response.Redirect("Default.aspx");
            }
            if (!IsPostBack)
            {
                GetCategory();
            }

        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            string apiName = txtcompanyname.Text.Trim();
            string apiDesc = txtfullname.Text.Trim();
            string apiCategory = ddlCategory.SelectedValue;
            decimal amount = 0;
            decimal.TryParse(txtAmount.Text.Trim(), out amount);

            string iconPath = "";

            if (fuApiIcon.HasFile)
            {
                // Check file size
                if (fuApiIcon.PostedFile.ContentLength <= 10240) // 10 KB
                {
                    string folderPath = Server.MapPath("~/Uploads/");
                    if (!Directory.Exists(folderPath))
                        Directory.CreateDirectory(folderPath);

                    string fileName = Guid.NewGuid().ToString() + Path.GetExtension(fuApiIcon.FileName); // unique filename
                    string savePath = Path.Combine(folderPath, fileName);

                    fuApiIcon.SaveAs(savePath);

                    // store relative path in DB
                    iconPath = "~/Uploads/" + fileName;
                }
                else
                {
                    lblFileError.Text = "File size must be less than 10 KB.";
                    return;
                }
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

                // ✅ Check for duplicate API Name
                string checkQuery = "SELECT COUNT(*) FROM APIList WHERE ApiName = @ApiName";
                using (SqlCommand checkCmd = new SqlCommand(checkQuery, con))
                {
                    checkCmd.Parameters.AddWithValue("@ApiName", apiName);
                    int exists = (int)checkCmd.ExecuteScalar();

                    if (exists > 0)
                    {
                        Label1.Text = "This API already exists!";
                        Label1.ForeColor = System.Drawing.Color.Red;
                        return; // stop insert
                    }
                }

                // ✅ Insert if no duplicate
                string query = "INSERT INTO APIList (ApiName, ApiDesc, Amount, ApiIcon,Status,Category) VALUES (@ApiName, @ApiDesc, @Amount, @ApiIcon,@Status,@Category)";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@ApiName", apiName);
                    cmd.Parameters.AddWithValue("@ApiDesc", apiDesc);
                    cmd.Parameters.AddWithValue("@Category", apiCategory);
                    cmd.Parameters.AddWithValue("@Amount", amount);
                    cmd.Parameters.AddWithValue("@ApiIcon", iconPath);
                    cmd.Parameters.AddWithValue("@Status", "Active");
                    cmd.ExecuteNonQuery();
                }

                con.Close();
            }

            ScriptManager.RegisterStartupScript(
                this,
                this.GetType(),
                "successModal",
                "var myModal = new bootstrap.Modal(document.getElementById('successModal')); myModal.show();",
                true
            );

            // reset form
            txtcompanyname.Text = "";
            txtfullname.Text = "";
            txtAmount.Text = "";

        }

        protected void GetCategory()
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                string query = "SELECT  Category FROM APICategory where Status='Active'"; // choose correct column names
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    if (reader.HasRows)
                    {
                        ddlCategory.DataSource = reader;
                        ddlCategory.DataTextField = "Category";  
                        ddlCategory.DataValueField = "Category";  
                        ddlCategory.DataBind();
                    }

                    reader.Close();
                }
            }

            // Insert a default option at the top
            ddlCategory.Items.Insert(0, new ListItem("-- Select API Category --", ""));
        }


        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString;
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();
                string query = "INSERT INTO APICategory (Category, Status) VALUES (@Category, @Status)";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@Category", AddCategory.Text);

                    cmd.Parameters.AddWithValue("@Status", "Active");
                    cmd.ExecuteNonQuery();
                }
                con.Close();
            }
            lblmessage.Text = "Category Added Successfully";
            GetCategory();
        }
    }
}