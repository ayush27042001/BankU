using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NeoXPayout.onboarding
{
    public partial class KYCDetails : System.Web.UI.Page
    {
        string fileName_n;
        UserManagement Um = new UserManagement();
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString);
        protected void Page_Load(object sender, EventArgs e)
        {
            if (this.Session["BankURTUID"] == null)
            {
                Response.Redirect("../Login.aspx");
            }
            else
            {
                if (!IsPostBack)
                {
                    Label1.Text = this.Session["BankURTName"].ToString();
                    txtpancardno.Text = Um.getPanbyId(this.Session["BankURTUID"].ToString());
                    //lblmobileno.Text = this.Session["BankURTMobileno"].ToString();
                }
            }
        }

        public string UploadPan()
        {
            string s = "./kycdoc/";
            DateTime dtNow = DateTime.Now;
            Random r = new Random();
            string n = r.Next(1, 1000).ToString();
            string path = s;
            HttpFileCollection uploadFileCol = Request.Files;
            HttpPostedFile file = uploadFileCol[0];
            string fileExt = Path.GetExtension(file.FileName);
            string fileName = n + Path.GetFileName(file.FileName);

            file.SaveAs(Server.MapPath("../kycdoc/") + fileName);
            fileName_n = ("./kycdoc/") + fileName;
            return fileName_n;
        }
        public string UploadAadhar()
        {
            string s = "./kycdoc/";
            DateTime dtNow = DateTime.Now;
            Random r = new Random();
            string n = r.Next(1, 1000).ToString();
            string path = s;
            HttpFileCollection uploadFileCol = Request.Files;
            HttpPostedFile file = uploadFileCol[1];
            string fileExt = Path.GetExtension(file.FileName);
            string fileName = n + Path.GetFileName(file.FileName);

            file.SaveAs(Server.MapPath("../kycdoc/") + fileName);
            fileName_n = ("./kycdoc/") + fileName;
            return fileName_n;
        }
        public string UploadVotor()
        {
            string s = "./kycdoc/";
            DateTime dtNow = DateTime.Now;
            Random r = new Random();
            string n = r.Next(1, 1000).ToString();
            string path = s;
            HttpFileCollection uploadFileCol = Request.Files;
            HttpPostedFile file = uploadFileCol[2];
            string fileExt = Path.GetExtension(file.FileName);
            string fileName = n + Path.GetFileName(file.FileName);

            file.SaveAs(Server.MapPath("../kycdoc/") + fileName);
            fileName_n = ("./kycdoc/") + fileName;
            return fileName_n;
        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            //string pancopy = "NA";
            //string aadharcopy = "NA";
            //string votercopy = "NA";
            //if (FileUpload1.HasFile == true && FileUpload2.HasFile == true && FileUpload3.HasFile == true)
            //{
            //    pancopy = UploadPan();
            //    aadharcopy = UploadAadhar();
            //    votercopy = UploadVotor();
            //    string pc = Um.UpdateKycinfo(txtaadharcard.Text, txtvoterid.Text, pancopy, aadharcopy, votercopy, this.Session["BankURTUID"].ToString());
            //    if (pc == "1")
            //    {
            //        Response.Redirect("UploadFinalForm.aspx");
            //    }
            //}
            //else
            //{
            //    string strscript = "<script language='javascript'>alert('Please Upload All File!')</script>";
            //    Page.RegisterStartupScript("popup", strscript);
            //}
        }
    }
}