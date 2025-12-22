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
    public partial class EditProduct : System.Web.UI.Page
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

                    Getdetails();
                }
            }
        }
        protected void Getdetails()
        {
            string ID = Request.QueryString["ID"];
            if (string.IsNullOrEmpty(ID))
            {
                Response.Write("<script>alert('Invalid User ID'); window.location='ViewUser.aspx';</script>");
                return;
            }
            string query = "SELECT * FROM BankUProduct WHERE Id = @ID";
            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@ID", ID);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            if (dt.Rows.Count > 0)
            {
                txtname.Text = dt.Rows[0]["ProductName"].ToString();
                txtModel.Text = dt.Rows[0]["Model"].ToString();
                txtDesc.Text = dt.Rows[0]["ProductDesc"].ToString();
                txtAmount.Text = dt.Rows[0]["Amount"].ToString();
                string iconPath = dt.Rows[0]["ProductPic"].ToString();
                if (!string.IsNullOrEmpty(iconPath))
                {
                    imgApiIcon.ImageUrl = iconPath;
                }
            }
            else
            {
                Response.Write("<script>alert('Product not found'); window.location='ViewProduct.aspx';</script>");
            }
        }
        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            string ID = Request.QueryString["ID"];
            string iconPath = "";

            if (fuApiIcon.HasFile)
            {
                    string folderPath = Server.MapPath("~/Uploads/");
                    if (!Directory.Exists(folderPath))
                        Directory.CreateDirectory(folderPath);

                    string fileName = Guid.NewGuid().ToString() + Path.GetExtension(fuApiIcon.FileName); // unique filename
                    string savePath = Path.Combine(folderPath, fileName);

                    fuApiIcon.SaveAs(savePath);

                    iconPath = "~/Uploads/" + fileName;            
            }

            try
            {

                con.Open();
                string query = "UPDATE BankUProduct SET ProductName=@ProductName, Model=@Model, ProductDesc=@ProductDesc, Amount=@Amount, " +
                        " Status=@Status, ProductPic=@ProductPic WHERE Id = @Id";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@ProductName", txtname.Text);
                cmd.Parameters.AddWithValue("@Model", txtModel.Text);
                cmd.Parameters.AddWithValue("@ProductDesc", txtDesc.Text);
                cmd.Parameters.AddWithValue("@Amount", txtAmount.Text);              
                cmd.Parameters.AddWithValue("@Status", ddlStatus.SelectedValue);
                if (string.IsNullOrEmpty(iconPath))
                {
                    string oldIcon = "";
                    SqlCommand cmdOld = new SqlCommand("SELECT ProductPic FROM BankUProduct WHERE Id=@Id", con);
                    cmdOld.Parameters.AddWithValue("@Id", ID);
                    var reader = cmdOld.ExecuteReader();
                    if (reader.Read()) oldIcon = reader["ProductPic"].ToString();
                    reader.Close();

                    cmd.Parameters.AddWithValue("@ProductPic", oldIcon);
                }
                else
                {
                    cmd.Parameters.AddWithValue("@ProductPic", iconPath);
                }
                cmd.Parameters.AddWithValue("@Id", ID);
                cmd.ExecuteNonQuery();
                con.Close();
                Response.Write("<script>alert('Product Updated Successfully');</script>");
            }
            catch (Exception ex)
            {
                Label1.Text = ex.ToString();
            }
            finally
            {
                con.Close();
            }
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            string productId = Request.QueryString["ID"];
            if (string.IsNullOrEmpty(productId))
            {
                Response.Write("<script>alert('Invalid Product ID');</script>");
                return;
            }

            try
            {
                con.Open();
                string sql = "DELETE FROM BankUProduct WHERE ID=@ID";
                SqlCommand cmd = new SqlCommand(sql, con);
                cmd.Parameters.AddWithValue("@ID", productId);
                cmd.ExecuteNonQuery();
                Response.Write("<script>alert('Product Deleted Successfully'); window.location='ViewProduct.aspx';</script>");
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