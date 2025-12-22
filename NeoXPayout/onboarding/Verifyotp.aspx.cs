using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NeoXPayout.onboarding
{
    public partial class Verifyotp : System.Web.UI.Page
    {
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
                    lblmobileno.Text = this.Session["BankURTMobileno"].ToString();
                }
            }
        }

      

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            string aepscontent = Um.signupotp(this.Session["BankURTMobileno"].ToString());
            if (aepscontent != "-1")
            {
                string strscript = "<script language='javascript'>alert('OTP Sent Successfully!')</script>";
                Page.RegisterStartupScript("popup", strscript);
                Session["BankURTOtp"] = aepscontent;
            }
        }

        protected void LinkButton2_Click(object sender, EventArgs e)
        {  
                //if (txtotp.Text == Session["BankURTOtp"].ToString())
                //{
                //    string pc = Um.UpdateOtpStatus(lblname.Text, lblmobileno.Text);
                //    if (pc == "1")
                //    {
                //        Session["BankURTOtp"] = null;
                //        string uid = Um.getidbymobile(lblmobileno.Text);
                //        Session["BankURTUID"] = uid;
                //        Response.Redirect("PersonalInformation.aspx");
                //    }
                //}
                //else
                //{
                //    string strscript = "<script language='javascript'>alert('Invalid OTP')</script>";
                //    Page.RegisterStartupScript("popup", strscript);
                //}
            
        }
    }
}