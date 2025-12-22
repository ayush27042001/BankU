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
    public partial class AddProduct : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (this.Session["AdminName"] == null)
            {
                Response.Redirect("Default.aspx");
            }
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            string Name = txtname.Text.Trim();
            string Model = txtModel.Text.Trim();
            string Desc = txtDesc.Text.Trim();
            //decimal amount = 0;
            //decimal.TryParse(txtAmount.Text.Trim(), out amount);

            string amount = txtAmount.Text.Trim();
            string iconPath = "";

            if (fuApiIcon.HasFile)
            {                
                string folderPath = Server.MapPath("~/productpic/");
                if (!Directory.Exists(folderPath))
                    Directory.CreateDirectory(folderPath);

                string fileName = Guid.NewGuid().ToString() + Path.GetExtension(fuApiIcon.FileName); // unique filename
                string savePath = Path.Combine(folderPath, fileName);

                fuApiIcon.SaveAs(savePath);

                // store relative path in DB
                iconPath = "~/productpic/" + fileName;             
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
                string checkQuery = "SELECT COUNT(*) FROM BankUProduct WHERE ProductName = @ProductName";
                using (SqlCommand checkCmd = new SqlCommand(checkQuery, con))
                {
                    checkCmd.Parameters.AddWithValue("@ProductName", Name);
                    int exists = (int)checkCmd.ExecuteScalar();

                    if (exists > 0)
                    {
                        Label1.Text = "This Product already exists!";
                        Label1.ForeColor = System.Drawing.Color.Red;
                        return; 
                    }
                }
                string query = @"INSERT INTO BankUProduct 
                    (ProductName, Model, ProductDesc, Amount, ProductPic, Status) 
                    VALUES (@ProductName, @Model, @ProductDesc, @Amount, @ProductPic, @Status)";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@ProductName", Name);
                    cmd.Parameters.AddWithValue("@Model", Model);
                    cmd.Parameters.AddWithValue("@ProductDesc", Desc);
                    cmd.Parameters.AddWithValue("@Amount", amount);
                    cmd.Parameters.AddWithValue("@ProductPic", iconPath);
                    cmd.Parameters.AddWithValue("@Status", "In Stock");
                    cmd.ExecuteNonQuery();
                }

                con.Close();
            }

            ScriptManager.RegisterStartupScript(
                this,
                this.GetType(),
                "successModal",
                "var myModal = new bootstrap.Modal(document.getElementById('successModal')); myModal.show();",true);

            txtname.Text = "";
            txtModel.Text = "";
            txtDesc.Text = "";
            txtAmount.Text = "";

        }       
    }
}