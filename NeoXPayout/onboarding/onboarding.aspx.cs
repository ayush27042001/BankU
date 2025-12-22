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

namespace NeoXPayout.onboarding
{
    public partial class onboarding : System.Web.UI.Page
    {
        string fileName_n;
        UserManagement Um = new UserManagement();
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString);
        protected void Page_Load(object sender, EventArgs e)
        {
            if (this.Session["BankURTName"] == null)
            {
                Response.Redirect("../Login.aspx");
            }
            else
            {
                if (!IsPostBack)
                {
                    lblname.Text = this.Session["BankURTName"].ToString();
                    lblid.Text = this.Session["BankURTUID"].ToString();
                    //lblmobileno.Text = this.Session["BankURTMobileno"].ToString();
                    getpaymentdetails();
                    getstatus();
                }
            }
        }
        public void getstatus()
        {
            hfcreateaccount.Value = "status-process";
            hfbusinessdetails.Value = "status-process";
            hfpersonaldetails.Value = "status-process";
            hfbankaccount.Value = "status-process";
            hfkycdoc.Value = "status-process";
            hfcompleteonboarding.Value = "status-process";
            hffinalagrement.Value = "status-process";

            if (hfSignupStatus.Value == "DONE" && hfMobileverifyStatus.Value == "DONE")
            {
                otpbox.Visible = false;
                LinkButton1.Visible = false;
                hfcreateaccount.Value = "status-success";
            }

            if (hfbusinessdetailsstatus.Value == "DONE")
            {
                LinkButton2.Visible = false;
                hfbusinessdetails.Value = "status-success";
            }
            if (hfPersonalInfoStatus.Value == "DONE")
            {
                LinkButton3.Visible = false;
                hfpersonaldetails.Value = "status-success";
            }
            if (hfBankaccountstatus.Value == "DONE")
            {
                LinkButton4.Visible = false;
                hfbankaccount.Value = "status-success";
            }
            if (hfKycStatus.Value == "DONE")
            {
                LinkButton5.Visible = false;
                hfkycdoc.Value = "status-success";
            }

            if (hfDocumentStatus.Value == "DONE")
            {
                LinkButton22.Visible = false;
                hfcompleteonboarding.Value = "status-success";
            }

            if (hfOnboardingStatus.Value == "DONE")
            {
                LinkButton14.Visible = false;
                hffinalagrement.Value = "status-success";
            }
        }

        public void getpaymentdetails()
        {
            string query = "select * from  onboarding where UserID=@ProductId and Status=@Status";
            SqlCommand mcom = new SqlCommand(query, con);
            mcom.Parameters.AddWithValue("@ProductId", lblid.Text);
            mcom.Parameters.AddWithValue("@Status", "1");
            SqlDataAdapter mda = new SqlDataAdapter(mcom);
            DataTable dt = new DataTable();
            mda.Fill(dt);

            if (dt.Rows.Count > 0)
            {

                //Create new Account

                txtmobileno.Text = dt.Rows[0]["MobileNo"].ToString();
                txtemailid.Text = dt.Rows[0]["EmailId"].ToString();
                txtfullname.Text = dt.Rows[0]["FullName"].ToString();
                txtpanno.Text = dt.Rows[0]["PancardNo"].ToString();
                hfSignupStatus.Value = dt.Rows[0]["SignupStatus"].ToString();
                hfMobileverifyStatus.Value = dt.Rows[0]["MobileverifyStatus"].ToString();

                //Business Details

                txtbusinessname.Text = dt.Rows[0]["CompanyName"].ToString();
                txtbusinessaddress.Text = dt.Rows[0]["companyaddress"].ToString();
                txtdhyamregistrationnumber.Text = dt.Rows[0]["UdyamRegNo"].ToString();
                ddlbusinesstype.Text = dt.Rows[0]["BusinessType"].ToString();
                if (dt.Rows[0]["BusinessStartOn"].ToString() != "")
                {
                    txtdateofincorportation.Text = Convert.ToDateTime(dt.Rows[0]["BusinessStartOn"]).ToString("yyyy-MM-dd");
                }
                //txtdateofincorportation.Text = dt.Rows[0]["BusinessStartOn"].ToString();
                hfbusinessdetailsstatus.Value = dt.Rows[0]["businessdetailsstatus"].ToString();

                //Personal Details
                txtaadharno.Text = dt.Rows[0]["AadharNo"].ToString();
                txtvoterid.Text = dt.Rows[0]["VoterCardNo"].ToString();
                txtfathername.Text = dt.Rows[0]["FatherName"].ToString();
                txtmothername.Text = dt.Rows[0]["MotherName"].ToString();
                if (dt.Rows[0]["DOB"].ToString() != "")
                {
                    txtdob.Text = Convert.ToDateTime(dt.Rows[0]["DOB"]).ToString("yyyy-MM-dd");
                }
               
                ddlgender.Text = dt.Rows[0]["Gender"].ToString();

                txtpermanentaddress.Text = dt.Rows[0]["Address"].ToString();
                ddlstate.Text = dt.Rows[0]["State"].ToString();
                txtpincode.Text = dt.Rows[0]["Pincode"].ToString();
                ddluserposition.Text = dt.Rows[0]["Userposition"].ToString();
                ddleducation.Text = dt.Rows[0]["Education"].ToString();
                hfPersonalInfoStatus.Value = dt.Rows[0]["PersonalInfoStatus"].ToString();

                //Bank Details

                txtaccountholder.Text = dt.Rows[0]["AccountHolderName"].ToString();
                ddlbank.Text = dt.Rows[0]["BankName"].ToString();
                txtaccountnumber.Text = dt.Rows[0]["Accountno"].ToString();
                txtifsccode.Text = dt.Rows[0]["IfscCode"].ToString();
                ddlaccounttype.Text = dt.Rows[0]["Accounttype"].ToString();
                hfBankaccountstatus.Value = dt.Rows[0]["Bankaccountstatus"].ToString();


                //,,,,Password,,,,,,,,,,,,,,,,,,,,,,,,,RegDate,Status,ApprovedBy,ApprovedDate,AdminRemarks
                //KYC Upload
                lblpancard.Text = dt.Rows[0]["PanUpload"].ToString();
                lblaadharfront.Text = dt.Rows[0]["AadharUpload"].ToString();
                lblaadharback.Text = dt.Rows[0]["Aadharbackcopy"].ToString();
                lblvotercard.Text = dt.Rows[0]["VoterCardUpload"].ToString();
                lbludyamcertificate.Text = dt.Rows[0]["UdyamUpload"].ToString();
                lblgstcertificate.Text = dt.Rows[0]["GstUpload"].ToString();
                lbljiophoto.Text = dt.Rows[0]["JioTagPhotoUpload"].ToString();
                lblpassportsizephoto.Text = dt.Rows[0]["PassportSizePhoto"].ToString();
                hfKycStatus.Value = dt.Rows[0]["KycStatus"].ToString();

                //Registrationform and Additionaldocument
                lblregistrationform.Text = dt.Rows[0]["RegistrationForm"].ToString();
                hfDocumentStatus.Value = dt.Rows[0]["DocumentStatus"].ToString();

                //Agrementcopy
                lblagrementcopy.Text = dt.Rows[0]["AgrementCopy"].ToString();
                hfOnboardingStatus.Value = dt.Rows[0]["OnboardingStatus"].ToString();

                lblremarks.Text = dt.Rows[0]["AdminRemarks"].ToString();
                hfNotificationType.Value = dt.Rows[0]["NotificationType"].ToString();

                if(lblremarks.Text=="")
                {
                    lblremarks.Text = "Complete All Step of Onboarding and Start your Online BankU Outlet!";
                }
            }
            else
            {

            }


        }

        protected void LinkButton15_Click(object sender, EventArgs e)
        {
            string aepscontent = Um.signupotp(this.Session["BankURTMobileno"].ToString());
            if (aepscontent != "-1")
            {
                string strscript = "<script language='javascript'>alert('OTP Sent Successfully!')</script>";
                Page.RegisterStartupScript("popup", strscript);
                Session["BankURTOtp"] = aepscontent;
            }
        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            if (Session["BankURTOtp"] == null)
            {
                string strscript = "<script language='javascript'>alert('OTP Expired Please Resend OTP')</script>";
                Page.RegisterStartupScript("popup", strscript);
            }
            else
            {
                if (txtotp.Text == Session["BankURTOtp"].ToString())
                {
                    string pc = Um.UpdateOtpStatus(Session["BankURTUID"].ToString());
                    if (pc == "1")
                    {
                        Session["BankURTOtp"] = null;
                        getpaymentdetails();
                        getstatus();
                    }
                }
                else
                {
                    string strscript = "<script language='javascript'>alert('Invalid OTP')</script>";
                    Page.RegisterStartupScript("popup", strscript);
                }
            }
        }

        protected void LinkButton2_Click(object sender, EventArgs e)
        {
            if (txtbusinessaddress.Text == "" || txtbusinessname.Text == "" || txtdhyamregistrationnumber.Text == "" || ddlbusinesstype.Text == "Select Type" || txtdateofincorportation.Text == "")
            {
                string strscript = "<script language='javascript'>alert('Please Fill All Business Information!')</script>";
                Page.RegisterStartupScript("popup", strscript);
            }
            else
            {
                string pc = Um.UpdateBusinessInfo(txtbusinessname.Text, txtbusinessaddress.Text, txtdhyamregistrationnumber.Text, ddlbusinesstype.Text, txtdateofincorportation.Text, this.Session["BankURTUID"].ToString());
                if (pc == "1")
                {
                    getpaymentdetails();
                    getstatus();
                }
            }
        }

        protected void LinkButton3_Click(object sender, EventArgs e)
        {
            if (txtvoterid.Text == "" || txtaadharno.Text == "" || txtfathername.Text == "" || txtmothername.Text == "" || txtdob.Text == ""||  txtpermanentaddress.Text==""|| ddlstate.Text== "Select State" || txtpincode.Text=="")
            {
                string strscript = "<script language='javascript'>alert('Please Fill All Personal Information!')</script>";
                Page.RegisterStartupScript("popup", strscript);
            }
            else
            {
                string pc = Um.UpdatePersonalInfo(txtvoterid.Text, txtaadharno.Text, txtfathername.Text, txtmothername.Text, txtdob.Text, ddlgender.Text, ddluserposition.Text, txtpermanentaddress.Text, ddlstate.Text, txtpincode.Text, ddleducation.Text, this.Session["BankURTUID"].ToString());
                if (pc == "1")
                {
                    getpaymentdetails();
                    getstatus();
                }
            }
        }

        protected void LinkButton4_Click(object sender, EventArgs e)
        {
            if (txtaccountholder.Text == "" || txtaccountnumber.Text == "" || ddlbank.Text == "" || txtifsccode.Text == "" || ddlaccounttype.Text == "")
            {
                string strscript = "<script language='javascript'>alert('Please Fill All Bank Details!')</script>";
                Page.RegisterStartupScript("popup", strscript);
            }
            else
            {
                string pc = Um.UpdatebankInfo(txtaccountholder.Text, txtaccountnumber.Text, ddlbank.Text, txtifsccode.Text, ddlaccounttype.Text,  this.Session["BankURTUID"].ToString());
                if (pc == "1")
                {
                    getpaymentdetails();
                    getstatus();
                }
            }
        }

        protected void LinkButton5_Click(object sender, EventArgs e)
        {
            if (lblpancard.Text == "" || lblvotercard.Text == "" || lblaadharfront.Text == "" || lblaadharback.Text == "" || lbludyamcertificate.Text == "" || lbljiophoto.Text == "" || lblpassportsizephoto.Text == "")
            {
                string strscript = "<script language='javascript'>alert('Please Upload All File Carefully!')</script>";
                Page.RegisterStartupScript("popup", strscript);
            }
            else
            {
                string pc = Um.UpdateKycinfo(lblpancard.Text, lblaadharfront.Text, lblaadharback.Text, lblvotercard.Text, lbludyamcertificate.Text,lblgstcertificate.Text,lbljiophoto.Text,lblpassportsizephoto.Text, this.Session["BankURTUID"].ToString());
                if (pc == "1")
                {
                    getpaymentdetails();
                    getstatus();
                }
            }
        }

        protected void LinkButton22_Click(object sender, EventArgs e)
        {
            
                if (FileUpload9.HasFile == true)
                {
                    string s = "./kycdoc/";
                    DateTime dtNow = DateTime.Now;
                    Random r = new Random();
                    string n = r.Next(1, 1000).ToString();
                    string path = s;
                    HttpFileCollection uploadFileCol = Request.Files;
                    HttpPostedFile file = uploadFileCol[8];
                    string fileExt = Path.GetExtension(file.FileName);
                    string fileName = n + Path.GetFileName(file.FileName);

                    file.SaveAs(Server.MapPath("../kycdoc/") + fileName);
                    fileName_n = ("./kycdoc/") + fileName;
                    lblregistrationform.Text = fileName_n;

                    string pc = Um.UpdateDocument(lblregistrationform.Text, this.Session["BankURTUID"].ToString());
                    if (pc == "1")
                    {
                        getpaymentdetails();
                        getstatus();
                    }
                }
                else
                {
                    string strscript = "<script language='javascript'>alert('Please Upload Onboarding Form!')</script>";
                    Page.RegisterStartupScript("popup", strscript);
                }
                
            
        }

        protected void LinkButton14_Click(object sender, EventArgs e)
        {
           
                if (FileUpload10.HasFile == true)
                {
                    string s = "./kycdoc/";
                    DateTime dtNow = DateTime.Now;
                    Random r = new Random();
                    string n = r.Next(1, 1000).ToString();
                    string path = s;
                    HttpFileCollection uploadFileCol = Request.Files;
                    HttpPostedFile file = uploadFileCol[9];
                    string fileExt = Path.GetExtension(file.FileName);
                    string fileName = n + Path.GetFileName(file.FileName);

                    file.SaveAs(Server.MapPath("../kycdoc/") + fileName);
                    fileName_n = ("./kycdoc/") + fileName;
                    lblagrementcopy.Text = fileName_n;

                    string pc = Um.UpdateAgrement(lblagrementcopy.Text, this.Session["BankURTUID"].ToString());
                    if (pc == "1")
                    {
                        getpaymentdetails();
                        getstatus();
                    }
                }
                else
                {
                    string strscript = "<script language='javascript'>alert('Please Upload Agrement Copy!')</script>";
                    Page.RegisterStartupScript("popup", strscript);
                }
               
            
        }

        protected void lbnpancard_Click(object sender, EventArgs e)
        {
            if (FileUpload1.HasFile == true)
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
                lblpancard.Text = fileName_n;
            }
            else
            {
                string strscript = "<script language='javascript'>alert('Please Upload Pan Copy!')</script>";
                Page.RegisterStartupScript("popup", strscript);
            }
        }

        protected void lbnvotercard_Click(object sender, EventArgs e)
        {
            if (FileUpload2.HasFile == true)
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
                lblvotercard.Text = fileName_n;
            }
            else
            {
                string strscript = "<script language='javascript'>alert('Please Upload Voter Card Copy!')</script>";
                Page.RegisterStartupScript("popup", strscript);
            }
        }

        protected void lbnaadharfront_Click(object sender, EventArgs e)
        {
            if (FileUpload3.HasFile == true)
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
                lblaadharfront.Text = fileName_n;
            }
            else
            {
                string strscript = "<script language='javascript'>alert('Please Upload AAdhar Front Copy!')</script>";
                Page.RegisterStartupScript("popup", strscript);
            }
        }

        protected void lbnaadharback_Click(object sender, EventArgs e)
        {
            if (FileUpload4.HasFile == true)
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
                lblaadharback.Text = fileName_n;
            }
            else
            {
                string strscript = "<script language='javascript'>alert('Please Upload Aadhar Back Copy!')</script>";
                Page.RegisterStartupScript("popup", strscript);
            }
        }

        protected void lbngst_Click(object sender, EventArgs e)
        {
            if (FileUpload5.HasFile == true)
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
                lblgstcertificate.Text = fileName_n;
            }
            else
            {
                string strscript = "<script language='javascript'>alert('Please Upload GST Copy!')</script>";
                Page.RegisterStartupScript("popup", strscript);
            }
        }

        protected void lbnudyam_Click(object sender, EventArgs e)
        {
            if (FileUpload6.HasFile == true)
            {
                string s = "./kycdoc/";
                DateTime dtNow = DateTime.Now;
                Random r = new Random();
                string n = r.Next(1, 1000).ToString();
                string path = s;
                HttpFileCollection uploadFileCol = Request.Files;
                HttpPostedFile file = uploadFileCol[5];
                string fileExt = Path.GetExtension(file.FileName);
                string fileName = n + Path.GetFileName(file.FileName);

                file.SaveAs(Server.MapPath("../kycdoc/") + fileName);
                fileName_n = ("./kycdoc/") + fileName;
                lbludyamcertificate.Text = fileName_n;
            }
            else
            {
                string strscript = "<script language='javascript'>alert('Please Upload Udyam Certificate Copy!')</script>";
                Page.RegisterStartupScript("popup", strscript);
            }
        }

        protected void lbnjiophoto_Click(object sender, EventArgs e)
        {
            if (FileUpload7.HasFile == true)
            {
                string s = "./kycdoc/";
                DateTime dtNow = DateTime.Now;
                Random r = new Random();
                string n = r.Next(1, 1000).ToString();
                string path = s;
                HttpFileCollection uploadFileCol = Request.Files;
                HttpPostedFile file = uploadFileCol[6];
                string fileExt = Path.GetExtension(file.FileName);
                string fileName = n + Path.GetFileName(file.FileName);

                file.SaveAs(Server.MapPath("../kycdoc/") + fileName);
                fileName_n = ("./kycdoc/") + fileName;
                lbljiophoto.Text = fileName_n;
            }
            else
            {
                string strscript = "<script language='javascript'>alert('Please Upload 3 GEO Phote PDF Copy!')</script>";
                Page.RegisterStartupScript("popup", strscript);
            }
        }

        protected void lbnpassport_Click(object sender, EventArgs e)
        {
            if (FileUpload8.HasFile == true)
            {
                string s = "./kycdoc/";
                DateTime dtNow = DateTime.Now;
                Random r = new Random();
                string n = r.Next(1, 1000).ToString();
                string path = s;
                HttpFileCollection uploadFileCol = Request.Files;
                HttpPostedFile file = uploadFileCol[7];
                string fileExt = Path.GetExtension(file.FileName);
                string fileName = n + Path.GetFileName(file.FileName);

                file.SaveAs(Server.MapPath("../kycdoc/") + fileName);
                fileName_n = ("./kycdoc/") + fileName;
                lblpassportsizephoto.Text = fileName_n;
            }
            else
            {
                string strscript = "<script language='javascript'>alert('Please Upload Passport Size Photo!')</script>";
                Page.RegisterStartupScript("popup", strscript);
            }
        }
    }
}