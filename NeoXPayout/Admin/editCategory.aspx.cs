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
    public partial class editCategory : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString);
        SqlCommand com = new SqlCommand();
        SqlDataAdapter da = new SqlDataAdapter();
        SqlDataAdapter da1 = new SqlDataAdapter();
        DataSet ds = new DataSet();
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

                    bind();
                }
            }
        }
        public void bind()
        {

            string ProductId = Request.QueryString["id"];

            string query = "select * from  blogCategory where Id=@ProductId ";

            SqlCommand mcom = new SqlCommand(query, con);
            mcom.Parameters.AddWithValue("@ProductId", ProductId);
            SqlDataAdapter mda = new SqlDataAdapter(mcom);
            DataTable dt = new DataTable();
            mda.Fill(dt);

            if (dt.Rows.Count > 0)
            {

                HiddenField1.Value = dt.Rows[0]["Id"].ToString();
                txtcategoryname.Text = dt.Rows[0]["CategoryName"].ToString();
                ddlstatus.Text = dt.Rows[0]["Status"].ToString();
            }
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            string sql = "Update blogCategory set CategoryName=@CategoryName,Status=@Status where id=@id";
            SqlCommand cmd = new SqlCommand(sql, con);
            cmd.Parameters.AddWithValue("@CategoryName", txtcategoryname.Text);
            cmd.Parameters.AddWithValue("@Status", "ACTIVE");
            cmd.Parameters.AddWithValue("@id", HiddenField1.Value);
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
            Response.Redirect("blogCategory.aspx");
        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            if (HiddenField1.Value == "")
            {
                string strscript = "<script language='javascript'>alert('Please Enter ID')</script>";
                Page.RegisterStartupScript("popup", strscript);
            }
            else
            {
                con.Open();
                string sqldelete = "delete from blogCategory where id=@Id";
                SqlCommand cmd1 = new SqlCommand(sqldelete, con);
                cmd1.Parameters.AddWithValue("@id", HiddenField1.Value);
                cmd1.ExecuteNonQuery();
                con.Close();
                Response.Redirect("blogCategory.aspx");
            }
        }
    }
}