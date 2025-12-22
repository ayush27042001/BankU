using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.IO;
using System.Configuration;

namespace NeoXPayout.Admin
{
    public partial class ManageBlogs : System.Web.UI.Page
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

                    //Getdetails();
                }
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
            return fileName_n;
        }
        protected void btnAdd_Click(object sender, EventArgs e)
        {
            string PP = "NA";
            if (FileUpload1.HasFile == true)
            {
                PP = UploadRC1();
                con.Open();
                string sql = "insert into BankUBlog (Picture,Heading,Details,LongDescription,Category,DateTime,Status)values(@Picture,@Heading,@Details,@LongDescription,@Category,@DateTime,@Status)";
                SqlCommand cmd = new SqlCommand(sql, con);
                cmd.Parameters.AddWithValue("@Picture", PP);
                cmd.Parameters.AddWithValue("@Heading", txtheading.Text);
                cmd.Parameters.AddWithValue("@Details", txtcontent.Text);
                cmd.Parameters.AddWithValue("@LongDescription", Ckeditorcontrol4.Text);
                cmd.Parameters.AddWithValue("@Category", Ckeditorcontrol3.Text);
                cmd.Parameters.AddWithValue("@DateTime", txtDateTime.Text);
                cmd.Parameters.AddWithValue("@Status", ddlstatus.Text);
                cmd.ExecuteNonQuery();
                con.Close();
                Response.Redirect("ViewBlogs.aspx");
            }
            else
            {
                string strscript = "<script language='javascript'>alert('Please Upload  Images')</script>";
                Page.RegisterStartupScript("popup", strscript);
            }
        }
    }
}