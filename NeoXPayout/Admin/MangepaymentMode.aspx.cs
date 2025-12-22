using Newtonsoft.Json.Linq;
using RestSharp;
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
    public partial class MangepaymentMode : System.Web.UI.Page
    {
        string fileName_n;
        SqlConnection con = new SqlConnection("Server=198.38.81.244,1232;DataBase=Intsalitefinserv_Db;uid=Intsalitefinserv_Db;pwd=Chandan#@80100");
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
                    bindetails();
                }
            }
        }

        public void bindetails()
        {
            string query = "select TOP 1* from  Wlpaymentinfo where Wlid=@ProductId order by Id desc";
            SqlCommand mcom = new SqlCommand(query, con);
            mcom.Parameters.AddWithValue("@ProductId", Session["AdminNeoxUID"].ToString());

            SqlDataAdapter mda = new SqlDataAdapter(mcom);
            DataTable dt = new DataTable();
            mda.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                txtbenename.Text = dt.Rows[0]["BeneName"].ToString();
                txtaccountno.Text = dt.Rows[0]["AccountNo"].ToString();
                txtifsccode.Text = dt.Rows[0]["IfscCode"].ToString();
                txtbankname.Text = dt.Rows[0]["BankName"].ToString();
                HiddenField1.Value = dt.Rows[0]["QRcode"].ToString();
            }
            else
            {
                
            }

        }
        public string UploadRC1()
        {
            string s = "./uploadfile/";
            DateTime dtNow = DateTime.Now;
            Random r = new Random();
            string n = r.Next(1, 1000).ToString();
            string path = s;
            HttpFileCollection uploadFileCol = Request.Files;
            HttpPostedFile file = uploadFileCol[0];
            string fileExt = Path.GetExtension(file.FileName);
            string fileName = n + Path.GetFileName(file.FileName);
            if (fileExt == ".Png" || fileExt == ".png" || fileExt == ".PNG" || fileExt == ".jpg" || fileExt == ".Jpg" || fileExt == ".jpeg" || fileExt == ".JPG" || fileExt == ".JPEG" || fileExt == ".Jpeg")
            {
                file.SaveAs(Server.MapPath("../uploadfile/") + fileName);
                fileName_n = ("/uploadfile/") + fileName;
                return fileName_n;
            }
            else
            {
                return "0";
            }


        }
        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            string Logo =HiddenField1.Value;
            if (FileUpload1.HasFile == true)
            {
                Logo = UploadRC1();
            }
                try
                {
                    string ApiKey = Session["AdminNeoxApikey"].ToString();
                    con.Open();
                    string query = "update Wlpaymentinfo set BeneName=@BeneName,AccountNo=@AccountNo,IfscCode=@IfscCode,BankName=@BankName,QRcode=@QRcode where Wlid=@Wlid";
                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@Wlid", Session["AdminNeoxUID"].ToString());
                    cmd.Parameters.AddWithValue("@BeneName", txtbenename.Text);
                    cmd.Parameters.AddWithValue("@AccountNo", txtaccountno.Text);
                    cmd.Parameters.AddWithValue("@IfscCode", txtifsccode.Text);
                    cmd.Parameters.AddWithValue("@BankName",txtbankname.Text);
                    cmd.Parameters.AddWithValue("@QRcode", Logo);
                
                    cmd.ExecuteNonQuery();
                    con.Close();
                    Response.Redirect("Dashboard.aspx");
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
    }
}