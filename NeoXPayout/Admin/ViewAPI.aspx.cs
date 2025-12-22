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
    public partial class ViewAPI : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString;
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString);
        protected void Page_Load(object sender, EventArgs e)
        {
            if (this.Session["AdminName"] == null)
            {
                Response.Redirect("Default.aspx");
            }
            if (!IsPostBack)
            {
                LoadRequests();
                GetCategory();
            }
            
        }
        private void LoadRequests()
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                string query = "SELECT * FROM APIList";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    if (!reader.HasRows)
                    {
                        gvRequests.Visible = false;
                        lblMessage.Text = "No request available";
                        lblMessage.ForeColor = System.Drawing.Color.Red;
                    }
                    else
                    {
                        gvRequests.Visible = true;
                        gvRequests.DataSource = reader;
                        gvRequests.DataBind();
                        lblMessage.Text = "";
                    }
                }
            }
        }

        protected void gvRequests_RowCommand(object sender, System.Web.UI.WebControls.GridViewCommandEventArgs e)
        {
            if (e.CommandName == "UpdateStatus")
            {
                int id = Convert.ToInt32(e.CommandArgument);
                GridViewRow row = ((System.Web.UI.Control)e.CommandSource).NamingContainer as GridViewRow;
                DropDownList ddlStatus = (DropDownList)row.FindControl("ddlStatus");

                using (SqlConnection con = new SqlConnection(connStr))
                {
                    con.Open();


                    string updateQuery = "UPDATE APIList SET Status = @Status WHERE Id = @Id";
                    using (SqlCommand cmd = new SqlCommand(updateQuery, con))
                    {
                        cmd.Parameters.AddWithValue("@Status", ddlStatus.SelectedValue);
                        cmd.Parameters.AddWithValue("@Id", id);
                        cmd.ExecuteNonQuery();
                    }
                }
                ScriptManager.RegisterStartupScript(this, this.GetType(), "showalert",
          "alert('Status updated successfully!');", true);
                LoadRequests();
            }
            else if (e.CommandName == "EditRow")
            {
                int id = Convert.ToInt32(e.CommandArgument);
                ScriptManager.RegisterStartupScript(
                   this,
                   this.GetType(),
                   "EditAPI",
                   "var myModal = new bootstrap.Modal(document.getElementById('EditAPI')); myModal.show();",
                   true
                   );
                hdnAPIId.Value = id.ToString();
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    string query = "SELECT * FROM APIList WHERE Id = @id";
                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@id", id);
                        using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                        {
                            DataTable dt = new DataTable();
                            da.Fill(dt);

                            if (dt.Rows.Count > 0)
                            {
                                txtAPIname.Text = dt.Rows[0]["ApiName"].ToString();
                                ddlCategory.Text = dt.Rows[0]["Category"].ToString();
                                txtDisc.Text = dt.Rows[0]["ApiDesc"].ToString();
                                txtPrice.Text = dt.Rows[0]["Amount"].ToString();
                                string iconPath = dt.Rows[0]["ApiIcon"].ToString(); 
                                if (!string.IsNullOrEmpty(iconPath))
                                {
                                    imgApiIcon.ImageUrl = iconPath; 
                                }
                               
                            }
                        }
                    }
                }
            }
            else if (e.CommandName == "DeleteRow")
            {
                int id = Convert.ToInt32(e.CommandArgument);
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    con.Open();
                    string updateQuery = "Delete from APIList WHERE Id = @Id";
                    using (SqlCommand cmd = new SqlCommand(updateQuery, con))
                    {       
                        cmd.Parameters.AddWithValue("@Id", id);
                        cmd.ExecuteNonQuery();
                    }
                }
                ScriptManager.RegisterStartupScript(this, this.GetType(), "showalert",
                "alert('API deleted successfully!');", true);
                LoadRequests();
            }
        }

        protected void btnEdit_Click(object sender, EventArgs e)
        {
            string id = hdnAPIId.Value;
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
           
            try
            {

                con.Open();
                string query = "UPDATE APIList SET ApiName=@ApiName, ApiDesc=@ApiDesc, Category=@Category, Amount=@Amount,ApiIcon=@ApiIcon WHERE Id = @ID";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@ApiName", txtAPIname.Text);
                cmd.Parameters.AddWithValue("@ApiDesc", txtDisc.Text);
                cmd.Parameters.AddWithValue("@Category", ddlCategory.SelectedValue);
                cmd.Parameters.AddWithValue("@Amount", txtPrice.Text);
                // If no new icon uploaded, keep old icon from DB
                if (string.IsNullOrEmpty(iconPath))
                {
                    
                    string oldIcon = "";
                    SqlCommand cmdOld = new SqlCommand("SELECT ApiIcon FROM APIList WHERE Id=@Id", con);
                    cmdOld.Parameters.AddWithValue("@Id", id);
                    var reader = cmdOld.ExecuteReader();
                    if (reader.Read()) oldIcon = reader["ApiIcon"].ToString();
                    reader.Close();

                    cmd.Parameters.AddWithValue("@ApiIcon", oldIcon);
                }
                else
                {
                    cmd.Parameters.AddWithValue("@ApiIcon", iconPath);
                }


                cmd.Parameters.AddWithValue("@Id", id);
                cmd.ExecuteNonQuery();
                con.Close();
               
            }
            catch (Exception ex)
            {
                Label1.Text = "Error occurred";
            }
            finally
            {
                con.Close();
                LoadRequests();
                ScriptManager.RegisterStartupScript(this, this.GetType(), "showalert",
           "alert('API updated successfully!');", true);
            }
        }

        protected void GetCategory()
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                string query = "SELECT  Category FROM APICategory"; // choose correct column names
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    if (reader.HasRows)
                    {
                        ddlCategory.DataSource = reader;
                        ddlCategory.DataTextField = "Category";   // what user sees
                        ddlCategory.DataValueField = "Category";   // actual value (can also be CategoryName if no ID column)
                        ddlCategory.DataBind();
                    }

                    reader.Close();
                }
            }

            // Insert a default option at the top
            ddlCategory.Items.Insert(0, new ListItem("-- Select API Category --", ""));
        }
    }
}