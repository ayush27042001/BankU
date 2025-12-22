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
    public partial class ManageAPIDocument : System.Web.UI.Page
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
            string apiName = txtname.Text.Trim();
            string apiDesc = txtDiscription.Text.Trim();
            string apiCategory = ddlCategory.SelectedValue;
                     

            string connectionString = ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString;
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();

                // ✅ Check for duplicate API Name
                string checkQuery = "SELECT COUNT(*) FROM APIDocument WHERE ApiName = @ApiName";
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
                string query = "INSERT INTO APIDocument (ApiName, Link, Category,ApiType, Discription, HeaderPara, RequestPara, SampleReq, ResponsePara, SampleResponse, Status) " +
                    "VALUES (@APIName, @Link,@Category,@ApiType,@Discription,@HeaderPara,@RequestPara, @SampleReq,@ResponsePara,@SampleResponse,@Status)";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@ApiName", txtname.Text.Trim());
                    cmd.Parameters.AddWithValue("@Link", txtLink.Text.Trim());
                    cmd.Parameters.AddWithValue("@Category", ddlCategory.SelectedValue);
                    cmd.Parameters.AddWithValue("@ApiType", ddltype.SelectedValue);
                    cmd.Parameters.AddWithValue("@Discription", txtDiscription.Text.Trim());
                    cmd.Parameters.AddWithValue("@HeaderPara", txtHeaderParam.Text);
                    cmd.Parameters.AddWithValue("@RequestPara", Ckeditorcontrol1.Text);
                    cmd.Parameters.AddWithValue("@SampleReq", Ckeditorcontrol2.Text);
                    cmd.Parameters.AddWithValue("@ResponsePara", Ckeditorcontrol3.Text);
                    cmd.Parameters.AddWithValue("@SampleResponse", Ckeditorcontrol4.Text);
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

            
            txtname.Text = "";
            txtDiscription.Text = "";
        }

        protected void GetCategory()
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                string query = "SELECT  Category FROM APICategory where Status='Active'"; 
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