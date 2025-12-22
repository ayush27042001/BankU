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
    public partial class PersonalInformation : System.Web.UI.Page
    {
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
                    //lblname.Text = this.Session["BankURTName"].ToString();
                    //lblmobileno.Text = this.Session["BankURTMobileno"].ToString();
                }
            }
        }

        //protected void Button1_Click(object sender, EventArgs e)
        //{
        //    string pc = Um.UpdatePersonalInfo(txtaddress.Text, txtmothername.Text,txtdob.Text,ddlgender.Text,txtfathername.Text,ddlstate.Text,txtpincode.Text, this.Session["BankURTUID"].ToString());
        //    if (pc == "1")
        //    {
        //        //Session["BankURTOtp"] = null;
        //        //string uid = Um.getidbymobile(lblmobileno.Text);
        //        //Session["BankURTUID"] = uid;
        //        Response.Redirect("KYCDetails.aspx");
        //    }
        //}

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            //string pc = Um.UpdatePersonalInfo(txtaddress.Text, txtmothername.Text, txtdob.Text, ddlgender.Text, txtfathername.Text, ddlstate.Text, txtpincode.Text, this.Session["BankURTUID"].ToString());
            //if (pc == "1")
            //{
            //    //Session["BankURTOtp"] = null;
            //    //string uid = Um.getidbymobile(lblmobileno.Text);
            //    //Session["BankURTUID"] = uid;
            //    Response.Redirect("KYCDetails.aspx");
            //}
        }
    }
}