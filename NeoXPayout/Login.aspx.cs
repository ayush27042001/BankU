using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NeoXPayout
{
    public partial class Login : System.Web.UI.Page
    {
        UserManagement Um = new UserManagement();
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString);
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Session["BankURTName"] = null;
            }
        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            string query = "select * from  onboarding where MobileNo=@Username and Password=@Password and Status=@Status";
            SqlCommand mcom = new SqlCommand(query, con);
            mcom.Parameters.AddWithValue("@Username", txtemailid.Text);
            mcom.Parameters.AddWithValue("@Password", txtpassword.Text);
            mcom.Parameters.AddWithValue("@Status", "1");
            SqlDataAdapter mda = new SqlDataAdapter(mcom);
            DataTable dt = new DataTable();
            mda.Fill(dt);

            if (dt.Rows.Count == 0)
            {
                string strscript = "<script language='javascript'>alert('Invalid Details')</script>";
                Page.RegisterStartupScript("popup", strscript);
            }
            else
            {
                Session["BankURTName"] = dt.Rows[0]["FullName"].ToString();
                Session["BankURTMobileno"] = dt.Rows[0]["MobileNo"].ToString();
                Session["BankURTUID"] = dt.Rows[0]["UserID"].ToString();
                Session["SignupStatus"] = dt.Rows[0]["SignupStatus"].ToString();
                Session["PersonalInfoStatus"] = dt.Rows[0]["PersonalInfoStatus"].ToString();
                Session["KycStatus"] = dt.Rows[0]["KycStatus"].ToString();
                Session["DocumentStatus"] = dt.Rows[0]["DocumentStatus"].ToString();
                Session["MobileverifyStatus"] = dt.Rows[0]["MobileverifyStatus"].ToString();
                Session["businessdetailsstatus"] = dt.Rows[0]["businessdetailsstatus"].ToString();
                Session["OnboardingStatus"] = dt.Rows[0]["OnboardingStatus"].ToString();
                if (Session["OnboardingStatus"].ToString() == "DONE")
                {
                    Response.Redirect("dashboard.aspx");
                }
                else if (Session["DocumentStatus"].ToString()=="DONE")
                {
                    Response.Redirect("onboarding/onboarding.aspx");
                }
                else if(Session["KycStatus"].ToString() == "DONE")
                {
                    Response.Redirect("onboarding/onboarding.aspx");
                }
                else if (Session["PersonalInfoStatus"].ToString() == "DONE")
                {
                    Response.Redirect("onboarding/onboarding.aspx");
                }
                else if (Session["MobileverifyStatus"].ToString() == "DONE")
                {
                    Response.Redirect("onboarding/onboarding.aspx");
                }
                else if (Session["businessdetailsstatus"].ToString() == "DONE")
                {
                    Response.Redirect("onboarding/onboarding.aspx");
                }
                else
                {
                    string aepscontent = Um.signupotp(this.Session["BankURTMobileno"].ToString());
                    if (aepscontent != "-1")
                    {
                        Session["BankURTOtp"] = aepscontent;
                        Response.Redirect("onboarding/onboarding.aspx");
                    }
                    
                }
                
            }
            con.Close();
        }
    }
}