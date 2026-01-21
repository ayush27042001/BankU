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
    public partial class Default : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString);
        SqlCommand com = new SqlCommand();
        UserManagement Um = new UserManagement();
        SqlDataAdapter da = new SqlDataAdapter();
        SqlDataAdapter da1 = new SqlDataAdapter();
        DataSet ds = new DataSet();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Session["AdminUID"] = null;
            }
        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            if (!pnlOTP.Visible)
            {
                SendOTPFlow();
            }
            else
            {

                VerifyOTPFlow();
            }
           
           
        }
        private void SendOTPFlow()
        {
            string number = txtNumber.Text.Trim();

            if (string.IsNullOrWhiteSpace(number))
            {
                lblError.Text = "Please enter a mobile number.";
                return;
            }

            if (!System.Text.RegularExpressions.Regex.IsMatch(number, @"^\d{10}$"))
            {
                lblError.Text = "Please enter a valid 10-digit mobile number.";
                return;
            }

           
            lblError.Text = "";
            pnlOTP.Visible = true;        
            SendOTP(number);
        }
        private void VerifyOTPFlow()
        {
            string enteredOtp = txtOtp.Text.Trim();
            string storedOtp = Session["OTP"] as string;

            if (string.IsNullOrEmpty(storedOtp))
            {
                lblOTPStatus.CssClass = "text-danger";
                lblOTPStatus.Text = "OTP expired. Please click Resend OTP.";
                return;
            }

            if (enteredOtp == storedOtp)
            {
                using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString))
                {
                    string query = "SELECT * FROM Registration WHERE MobileNo=@MobileNo AND UserType=@UserType";
                    using (SqlCommand mcom = new SqlCommand(query, con))
                    {
                        mcom.Parameters.AddWithValue("@MobileNo", txtNumber.Text);
                        mcom.Parameters.AddWithValue("@UserType", "Admin");

                        SqlDataAdapter mda = new SqlDataAdapter(mcom);
                        DataTable dt = new DataTable();
                        mda.Fill(dt);

                        if (dt.Rows.Count == 0)
                        {
                            ClientScript.RegisterStartupScript(this.GetType(), "popup", "alert('Invalid Details');", true);
                        }
                        else
                        {
                            lblOTPStatus.CssClass = "text-success";
                            lblOTPStatus.Text = "OTP verified! Logging you in…";

                            Session["AdminMobile"] = dt.Rows[0]["MobileNo"].ToString();
                            Session["AdminName"] = dt.Rows[0]["FullName"].ToString();
                            Session["AdminUID"] = dt.Rows[0]["RegistrationId"].ToString();

                            if (txtNumber.Text== "8861003651"|| txtNumber.Text == "7979804478") 
                            {
                                Response.Redirect("~/EmployeeDex/UserInfo.aspx");
                            }
                            else 
                            { 
                                Response.Redirect("DashboardAdmin.aspx");
                            }
                        }
                    }
                }
            }
            else
            {
                lblOTPStatus.CssClass = "text-danger";
                lblOTPStatus.Text = "Incorrect OTP. Please try again.";
            }
        }

        private void SendOTP(string number)
        {
            string otp = Um.signupotp(number);
            //string otp = "1234";
            if (otp != "-1")
            {
                Session["OTP"] = otp;
                lblOTPStatus.CssClass = "text-success";
                lblOTPStatus.Text = "OTP sent successfully!";
            }
            else
            {
                lblOTPStatus.CssClass = "text-danger";
                lblOTPStatus.Text = "Failed to send OTP. Please try again.";
            }
        }
    }
}