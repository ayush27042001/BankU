using Newtonsoft.Json.Linq;
using RestSharp;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NeoXPayout.onboarding
{
    public partial class signup : System.Web.UI.Page
    {
         UserManagement Um = new UserManagement();
          SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString);
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
            }
            
        }

        public string verifyPanCF(string pan)
        {
            try
            {
                string Apiresponse = String.Empty;
                string url = "https://api.cashfree.com/verification/pan";
                string body = "{\"pan\":\"" + pan + "\",\"name\":\"Gurav\"}";
                var client = new RestClient(url);
                var request = new RestRequest(Method.POST);
                request.AddHeader("x-client-id", "CF898769D0DKQJG3BM1S73FBE6OG");
                request.AddHeader("x-client-secret", "cfsk_ma_prod_7a7157c5ac1ae3a067ec8c23080ff94d_e50a26d4");
                request.AddHeader("cache-control", "no-cache");
                request.AddHeader("Accept", "application/json");
                request.AddHeader("Content-Type", "application/json");
                request.AddParameter("application/json", body, RestSharp.ParameterType.RequestBody);
                IRestResponse response = client.Execute(request);
                Apiresponse = response.Content;
                return Apiresponse;
            }
            catch
            {
                return "-1";
            }
        }

        public string verifyPan(string pan, string externalRef, string latitude, string longitude)
        {
            try
            {
                string Apiresponse = String.Empty;
                string url = "https://api.instantpay.in/identity/verifyPanPlus";
                string body = "{\"pan\":\"" + pan + "\",\"consent\":\"Y\",\"externalRef\":\"" + externalRef + "\",\"latitude\":\"" + latitude + "\",\"longitude\":\"" + longitude + "\"}";
                var client = new RestClient(url);
                var request = new RestRequest(Method.POST);
                request.AddHeader("X-Ipay-Auth-Code", "1");
                request.AddHeader("X-Ipay-Client-Id", "YWY3OTAzYzNlM2ExZTJlObfzvic/bTaahaNPYnBJ8UI=");
                request.AddHeader("X-Ipay-Client-Secret", "a0cf47b2ffd39a4ab3ab337a00dfea7dcb82db71e84831d862622687353e2eff");
                request.AddHeader("X-Ipay-Endpoint-Ip", "103.159.45.153");
                //request.AddHeader("X-Ipay-Outlet-Id", outletid);
                request.AddHeader("cache-control", "no-cache");
                request.AddHeader("Accept", "application/json");
                request.AddHeader("Content-Type", "application/json");
                request.AddParameter("application/json", body, RestSharp.ParameterType.RequestBody);
                IRestResponse response = client.Execute(request);
                Apiresponse = response.Content;
                return Apiresponse;
            }
            catch
            {
                return "-1";
            }
        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            if (txtemail.Text == "" || txtmobileno.Text == "" || txtpancardno.Text == "" || txtpassword.Text == "")
            {
                string strscript = "<script language='javascript'>alert('Please Fill All Details Carefully!')</script>";
                Page.RegisterStartupScript("popup", strscript);
            }
            else
            {
                string checkdata = Um.CheckDuplicate(txtmobileno.Text, txtpancardno.Text, txtemail.Text);
                if (checkdata == "0")
                {
                    //  string externalRef = DateTime.Now.ToString("ddmmyyHHmmssfff");
                    string content = verifyPanCF(txtpancardno.Text);
                    JObject jObjects = JObject.Parse(content);

                    if (content.Contains("registered_name"))
                    {
                        string firstname = jObjects["registered_name"].ToString();

                        string status = jObjects["valid"].ToString();
                        if (status.ToLower() == "true")
                        {
                            int userreg = Um.signupuser("", firstname, txtmobileno.Text, txtemail.Text, txtpassword.Text, txtpancardno.Text);
                            if (userreg >=1)
                            {
                                Session["BankURTName"] = firstname;
                                Session["BankURTMobileno"] = txtmobileno.Text;
                                Session["BankURTUID"] = userreg;

                                Session["SignupStatus"] = "DONE";
                                Session["PersonalInfoStatus"] = "Pending";
                                Session["KycStatus"] = "Pending";
                                Session["DocumentStatus"] = "Pending";
                                Session["MobileverifyStatus"] = "Pending";
                                Session["businessdetailsstatus"] = "Pending";
                                Session["OnboardingStatus"] = "Pending";

                                string aepscontent = Um.signupotp(txtmobileno.Text);
                                if (aepscontent != "-1")
                                {
                                    Session["BankURTOtp"] = aepscontent;
                                }
                                Response.Redirect("onboarding.aspx");
                            }
                            else
                            {
                                string strscript = "<script language='javascript'>alert('something went wrong! Please try after some time')</script>";
                                Page.RegisterStartupScript("popup", strscript);
                            }
                        }
                        else
                        {
                            string strscript = "<script language='javascript'>alert('" + jObjects["message"].ToString() + "')</script>";
                            Page.RegisterStartupScript("popup", strscript);

                        }
                    }
                    else
                    {
                        string strscript = "<script language='javascript'>alert('" + jObjects["message"].ToString() + "')</script>";
                        Page.RegisterStartupScript("popup", strscript);
                    }

                }
                else
                {
                    string strscript = "<script language='javascript'>alert('Your Details Already Registered With Us!')</script>";
                    Page.RegisterStartupScript("popup", strscript);
                }
            }

        }
    }
}