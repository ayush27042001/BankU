using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace NeoXPayout.Admin
{
    public partial class EditRm : System.Web.UI.Page
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
                Response.Write("<script>alert('Invalid User ID'); window.location='ViewRm.aspx';</script>");
                return;
            }
            string query = "SELECT * FROM RmDetail WHERE Id = @Id";
            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@Id", ID);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            if (dt.Rows.Count > 0)
            {

                txtfullname.Text = dt.Rows[0]["RmName"].ToString();
                txtmobileno.Text = dt.Rows[0]["RmMobile"].ToString();

                txtPassword.Text = dt.Rows[0]["RmPassword"].ToString();
                ddlStatus.SelectedValue = dt.Rows[0]["Status"].ToString();
            }
            else
            {
                Response.Write("<script>alert('Product not found'); window.location='ViewRm.aspx';</script>");
            }
        }
        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            string ID = Request.QueryString["ID"];
            try
            {

                con.Open();
                string query = "UPDATE RmDetail SET RmName=@RmName, RmMobile=@RmMobile, RmPassword=@RmPassword, Status=@Status WHERE Id = @Id";


                SqlCommand cmd = new SqlCommand(query, con);

                cmd.Parameters.AddWithValue("@RmName", txtfullname.Text);
                cmd.Parameters.AddWithValue("@RmMobile", txtmobileno.Text);
                cmd.Parameters.AddWithValue("@RmPassword", txtPassword.Text);
                cmd.Parameters.AddWithValue("@Status", ddlStatus.SelectedValue);

                cmd.Parameters.AddWithValue("@Id", ID);
                cmd.ExecuteNonQuery();
                con.Close();
                Response.Redirect("ViewRm.aspx");
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
                string sql = "DELETE FROM RmDetail WHERE Id =@ID";
                SqlCommand cmd = new SqlCommand(sql, con);
                cmd.Parameters.AddWithValue("@ID", productId);
                cmd.ExecuteNonQuery();
                Response.Write("<script>alert('Product Deleted Successfully'); window.location='ViewRm.aspx';</script>");
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