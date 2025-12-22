using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.IO;

namespace NeoXPayout.Admin
{
    public partial class EditBlogs : System.Web.UI.Page
    {
        string fileName_n;
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

            string query = "select * from  BankUBlog where id=@ProductId ";

            SqlCommand mcom = new SqlCommand(query, con);
            mcom.Parameters.AddWithValue("@ProductId", ProductId);
            SqlDataAdapter mda = new SqlDataAdapter(mcom);
            DataTable dt = new DataTable();
            mda.Fill(dt);

            if (dt.Rows.Count > 0)
            {
                //,,,,,,,,Status
                Label1.Text = dt.Rows[0]["picture"].ToString();
                HiddenField1.Value = dt.Rows[0]["id"].ToString();
                txtheading.Text = dt.Rows[0]["Heading"].ToString();
                txtcontent.Text = dt.Rows[0]["Details"].ToString();
                txtDateTime.Text = dt.Rows[0]["DateTime"].ToString();
                ddlstatus.Text = dt.Rows[0]["Status"].ToString();
            }
        }

        public string UploadRC1()
        {
            string s = "./productpic/";
            DateTime dtNow = DateTime.Now;
            Random r = new Random();
            string n = r.Next(1, 1000).ToString();
            string path = s;
            HttpFileCollection uploadFileCol = Request.Files;
            HttpPostedFile file = uploadFileCol[0];
            string fileExt = Path.GetExtension(file.FileName);
            string fileName = n + Path.GetFileName(file.FileName);
            file.SaveAs(Server.MapPath("../productpic/") + fileName);
            fileName_n = ("/productpic/") + fileName;
            //fileName_n = ("http://sn.apipartner.co.in/productpic/") + fileName;
            return fileName_n;
        }
        protected void btnAdd_Click(object sender, EventArgs e)
        {
            string PP = Label1.Text;
            if (FileUpload1.HasFile == true)
            {
                PP = UploadRC1();
            }
            string sql = "Update BankUBlog set Heading=@Heading,Picture=@Picture,Details=@Details,DateTime=@DateTime,Status=@Status where id=@id";
            SqlCommand cmd = new SqlCommand(sql, con);
            cmd.Parameters.AddWithValue("@Heading", txtheading.Text);
            cmd.Parameters.AddWithValue("@Details", txtcontent.Text);
            cmd.Parameters.AddWithValue("@DateTime", txtDateTime.Text);
            cmd.Parameters.AddWithValue("@Status", "ACTIVE");
            cmd.Parameters.AddWithValue("@picture", PP);
            cmd.Parameters.AddWithValue("@id", HiddenField1.Value);
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
            Response.Redirect("ViewBlogs.aspx");
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
                string sqldelete = "delete from BankUBlog where id=@Id";
                SqlCommand cmd1 = new SqlCommand(sqldelete, con);
                cmd1.Parameters.AddWithValue("@id", HiddenField1.Value);
                cmd1.ExecuteNonQuery();
                con.Close();
                Response.Redirect("ViewBlogs.aspx");
            }
        }
    }
}