using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NeoXPayout.Admin
{
    public partial class EditAPIDocument : System.Web.UI.Page
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
                GetCategory();
                Getdetails();
            }

        }
        protected void Getdetails()
        {
            string ID = Request.QueryString["ID"];
            if (string.IsNullOrEmpty(ID))
            {
                Response.Write("<script>alert('Invalid User ID'); window.location='ViewAPIDocument.aspx';</script>");
                return;
            }
            string query = "SELECT * FROM APIDocument WHERE Id = @ID";
            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@ID", ID);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            if (dt.Rows.Count > 0)
            {
                txtname.Text = dt.Rows[0]["APIName"].ToString();
                txtLink.Text = dt.Rows[0]["Link"].ToString();
                ddlCategory.Text = dt.Rows[0]["Category"].ToString();
                txtDiscription.Text = dt.Rows[0]["Discription"].ToString();
                txtHeaderParam.Text = dt.Rows[0]["HeaderPara"].ToString();
                Ckeditorcontrol1.Text = dt.Rows[0]["RequestPara"].ToString();
                Ckeditorcontrol2.Text = dt.Rows[0]["SampleReq"].ToString();
                Ckeditorcontrol3.Text = dt.Rows[0]["ResponsePara"].ToString();
                Ckeditorcontrol4.Text = dt.Rows[0]["SampleResponse"].ToString();
            

            }
            else
            {
                Response.Write("<script>alert('Product not found'); window.location='ViewAPIDocument.aspx';</script>");
            }
        }
        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            string ID = Request.QueryString["ID"];


            string connectionString = ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString;
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();


                string query = "UPDATE APIDocument SET ApiName=@ApiName, Link=@Link, Category=@Category, Discription=@Discription, " +
                       " HeaderPara=@HeaderPara, RequestPara=@RequestPara, SampleReq=@SampleReq, ResponsePara=@ResponsePara, SampleResponse=@SampleResponse, Status=@Status WHERE Id = @ID";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@ApiName", txtname.Text.Trim());
                    cmd.Parameters.AddWithValue("@Link", txtLink.Text.Trim());
                    cmd.Parameters.AddWithValue("@Category", ddlCategory.SelectedValue);
                    cmd.Parameters.AddWithValue("@Discription", txtDiscription.Text.Trim());
                    cmd.Parameters.AddWithValue("@HeaderPara", txtHeaderParam.Text);
                    cmd.Parameters.AddWithValue("@RequestPara", Ckeditorcontrol1.Text);
                    cmd.Parameters.AddWithValue("@SampleReq", Ckeditorcontrol2.Text);
                    cmd.Parameters.AddWithValue("@ResponsePara", Ckeditorcontrol3.Text);
                    cmd.Parameters.AddWithValue("@SampleResponse", Ckeditorcontrol4.Text);
                    cmd.Parameters.AddWithValue("@Status", "Active");
                    cmd.Parameters.AddWithValue("@Id", ID);
                    cmd.ExecuteNonQuery();
                }

                con.Close();
            }
            Response.Redirect("ViewAPIDocument.aspx");


           
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
                string sql = "DELETE FROM APIDocument WHERE Id=@ID";
                SqlCommand cmd = new SqlCommand(sql, con);
                cmd.Parameters.AddWithValue("@ID", productId);
                cmd.ExecuteNonQuery();
                Response.Write("<script>alert('Product Deleted Successfully'); window.location='ViewAPIDocument.aspx';</script>");
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

            ddlCategory.Items.Insert(0, new ListItem("-- Select API Category --", ""));
        }
    }
}