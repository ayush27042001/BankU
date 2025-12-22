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

namespace NeoXPayout
{
    public partial class paymentrequest : System.Web.UI.Page
    {
        string fileName_n;
        SqlConnection con = new SqlConnection("Server=198.38.81.244,1232;DataBase=Intsalitefinserv_Db;uid=Intsalitefinserv_Db;pwd=Chandan#@80100");
        SqlCommand com = new SqlCommand();
        SqlDataAdapter da = new SqlDataAdapter();
        SqlDataAdapter da1 = new SqlDataAdapter();
        DataSet ds = new DataSet();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (this.Session["NeoxName"] == null)
            {
                Response.Redirect("LoginBankU.aspx");
            }
            else
            {
                if (!IsPostBack)
                {
                    bindetails();
                }
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
                file.SaveAs(Server.MapPath("./uploadfile/") + fileName);
                fileName_n = ("/uploadfile/") + fileName;
                return fileName_n;
            }
            else
            {
                return "0";
            }


        }
        protected void LinkButton1_Click(object sender, EventArgs e)
        {if (txtamount.Text == "" || txttxnid.Text == "")
            {
                string strscript = "<script language='javascript'>alert('Please enter AMount and TxnId')</script>";
                Page.RegisterStartupScript("popup", strscript);
            }
            else
            {
                string Logo = "";
                if (FileUpload1.HasFile == true)
                {
                    Logo = UploadRC1();
                    try
                    {
                        string ApiKey = Session["NeoxApikey"].ToString();
                        con.Open();
                        string query = "insert into Wlpaymentrequest(Wlid,UserId,paymenttype,Amount,TxnId,Slip,Reqdate,Status,Remark)values(@Wlid,@UserId,@paymenttype,@Amount,@TxnId,@Slip,@Reqdate,@Status,@Remark)";
                        SqlCommand cmd = new SqlCommand(query, con);
                        cmd.Parameters.AddWithValue("@Wlid", Session["NeoxWLId"].ToString());
                        cmd.Parameters.AddWithValue("@UserId", Session["NeoxUID"].ToString());
                        cmd.Parameters.AddWithValue("@paymenttype", ddlpaymenttype.Text);
                        cmd.Parameters.AddWithValue("@Amount", txtamount.Text);
                        cmd.Parameters.AddWithValue("@TxnId", txttxnid.Text);
                        cmd.Parameters.AddWithValue("@Remark", "");
                        cmd.Parameters.AddWithValue("@Slip", Logo);
                        cmd.Parameters.AddWithValue("@Reqdate", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss.fff"));
                        cmd.Parameters.AddWithValue("@Status", "Pending");
                        cmd.ExecuteNonQuery();
                        con.Close();
                        Response.Redirect("paymentrequstreport.aspx");
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
                else
                {
                    string strscript = "<script language='javascript'>alert('Please Upload Slip')</script>";
                    Page.RegisterStartupScript("popup", strscript);
                }
            }


        }

        public void bindetails()
        {
            string query = "select TOP 1* from  Wlpaymentinfo where Wlid=@ProductId order by Id desc";
            SqlCommand mcom = new SqlCommand(query, con);
            mcom.Parameters.AddWithValue("@ProductId", Session["NeoxWLId"].ToString());
            
            SqlDataAdapter mda = new SqlDataAdapter(mcom);
            DataTable dt = new DataTable();
            mda.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                lblbenename.Text = dt.Rows[0]["BeneName"].ToString();
                lblaccountno.Text = dt.Rows[0]["AccountNo"].ToString();
                lblifsccode.Text = dt.Rows[0]["IfscCode"].ToString();
                lblbankname.Text = dt.Rows[0]["BankName"].ToString();
                HiddenField1.Value = dt.Rows[0]["QRcode"].ToString();
            }
            else
            {
                lblbenename.Text = "NA";
                lblaccountno.Text = "NA";
                lblifsccode.Text = "NA";
                lblbankname.Text = "NA";
                HiddenField1.Value = "NA";
            }
            
        }
    }
}