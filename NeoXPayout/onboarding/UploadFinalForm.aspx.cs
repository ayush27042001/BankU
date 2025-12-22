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
    public partial class UploadFinalForm : System.Web.UI.Page
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
                    //txtpancardno.Text = Um.getPanbyId(this.Session["BankURTUID"].ToString());
                    //lblmobileno.Text = this.Session["BankURTMobileno"].ToString();
                }
            }
        }

        public string UdyamUpload()
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
        public string GstUpload()
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
        public string JioTagPhotoUpload()
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
        public string PassportSizePhoto()
        {
            string s = "./kycdoc/";
            DateTime dtNow = DateTime.Now;
            Random r = new Random();
            string n = r.Next(1, 1000).ToString();
            string path = s;
            HttpFileCollection uploadFileCol = Request.Files;
            HttpPostedFile file = uploadFileCol[3];
            string fileExt = Path.GetExtension(file.FileName);
            string fileName = n + Path.GetFileName(file.FileName);

            file.SaveAs(Server.MapPath("../kycdoc/") + fileName);
            fileName_n = ("./kycdoc/") + fileName;
            return fileName_n;
        }
        public string RegistrationForm()
        {
            string s = "./kycdoc/";
            DateTime dtNow = DateTime.Now;
            Random r = new Random();
            string n = r.Next(1, 1000).ToString();
            string path = s;
            HttpFileCollection uploadFileCol = Request.Files;
            HttpPostedFile file = uploadFileCol[4];
            string fileExt = Path.GetExtension(file.FileName);
            string fileName = n + Path.GetFileName(file.FileName);

            file.SaveAs(Server.MapPath("../kycdoc/") + fileName);
            fileName_n = ("./kycdoc/") + fileName;
            return fileName_n;
        }

       

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            //string Udyam = "NA";
            //string Gst = "NA";
            //string JioTag = "NA";
            //string PassportSize = "NA";
            //string Regform = "NA";
            //if (FileUpload1.HasFile == true && FileUpload2.HasFile == true && FileUpload3.HasFile == true)
            //{
            //    Udyam = UdyamUpload();
            //    Gst = GstUpload();
            //    JioTag = JioTagPhotoUpload();
            //    PassportSize = PassportSizePhoto();
            //    Regform = RegistrationForm();
            //    string pc = Um.UpdateDocument(Udyam, Gst, JioTag, PassportSize, Regform, this.Session["BankURTUID"].ToString());
            //    if (pc == "1")
            //    {
            //        Response.Redirect("AgrementDone.aspx");
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