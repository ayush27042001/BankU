using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI.WebControls;

namespace NeoXPayout.Admin
{
    public partial class EditInvoice : System.Web.UI.Page
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
            string ID = Request.QueryString["Id"];
            if (string.IsNullOrEmpty(ID))
            {
                Response.Write("<script>alert('Invalid Invoice ID'); window.location='ViewInvoice.aspx';</script>");
                return;
            }
            string query = "SELECT * FROM UserInvoice WHERE Id = @ID";
            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@ID", ID);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            if (dt.Rows.Count > 0)
            {
                txtType.Text = dt.Rows[0]["InvoiceType"].ToString();
                txtInvId.Text = dt.Rows[0]["InvoiceId"].ToString();
                ddlUserId.SelectedValue = dt.Rows[0]["UserId"].ToString();
                txtStartDate.Text = dt.Rows[0]["StartDate"].ToString();
                txtEndDate.Text = dt.Rows[0]["EndDate"].ToString();
                ddlStatus.SelectedValue = dt.Rows[0]["Status"].ToString();
                string filePath = dt.Rows[0]["FilePath"].ToString();


                if (!string.IsNullOrEmpty(filePath))
                {
                    hiddenOldFilePath.Value = dt.Rows[0]["FilePath"].ToString();

                    hlCurrentFile.NavigateUrl = filePath;
                    hlCurrentFile.Text = "📄 View Uploaded File";
                    hlCurrentFile.Visible = true;
                }
            }
            else
            {
                Response.Write("<script>alert('Product not found'); window.location='ViewInvoice.aspx';</script>");
            }
        }
        protected void btnupdate_Click(object sender, EventArgs e)
        {
            string ID = Request.QueryString["Id"];
            string filePath = "";

            if (fuInvoice.HasFile)
            {
                string fileName = Path.GetFileName(fuInvoice.FileName);
                string fileSavePath = Server.MapPath("~/uploadfile/") + fileName;
                fuInvoice.SaveAs(fileSavePath);

                filePath = "~/uploadfile/" + fileName; 
            }
            else
            {
                filePath = hiddenOldFilePath.Value; 
            }

            try
            {

                con.Open();
                string query = "UPDATE UserInvoice SET InvoiceType=@InvoiceType,InvoiceId=@InvoiceId, StartDate=@StartDate, EndDate=@EndDate, UserId=@UserId, " +
                        "FilePath=@FilePath ,Status=@Status WHERE Id = @ID";


                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@InvoiceType", txtType.Text);
                cmd.Parameters.AddWithValue("@InvoiceId", txtInvId.Text);
                cmd.Parameters.AddWithValue("@StartDate", txtStartDate.Text);
                cmd.Parameters.AddWithValue("@EndDate", txtEndDate.Text);
                cmd.Parameters.AddWithValue("@UserId", ddlUserId.SelectedValue);
                cmd.Parameters.AddWithValue("@FilePath", filePath);
                cmd.Parameters.AddWithValue("@Status", ddlStatus.SelectedValue);
                cmd.Parameters.AddWithValue("@Id", ID);
                cmd.ExecuteNonQuery();
                con.Close();
                Response.Redirect("ViewInvoice.aspx");
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
            string productId = Request.QueryString["Id"];
            if (string.IsNullOrEmpty(productId))
            {
                Response.Write("<script>alert('Invalid Product ID');</script>");
                return;
            }

            try
            {
                con.Open();
                string sql = "DELETE FROM UserInvoice WHERE Id=@ID";
                SqlCommand cmd = new SqlCommand(sql, con);
                cmd.Parameters.AddWithValue("@ID", productId);
                cmd.ExecuteNonQuery();
                Response.Write("<script>alert('Invoice Deleted Successfully'); window.location='ViewInvoice.aspx';</script>");
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