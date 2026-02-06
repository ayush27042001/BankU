using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NeoXPayout
{
    public partial class ForgetMpin : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString);
        UserManagement um = new UserManagement();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (this.Session["BankURTName"] == null)
            {
                Response.Redirect("LoginBankU.aspx");
            }
        }

        protected void btnOTP_Click(object sender, EventArgs e)
        {
            string otp = string.Empty;
            string number = "";
            string last4Digits = "";
            if (Session["BankURTMobileno"] != null)
            {
                number = Session["BankURTMobileno"].ToString();

                if (number.Length >= 4)
                {
                    last4Digits = number.Substring(number.Length - 4);
                }
            }
            else
            {
                Response.Redirect("LoginBankU.aspx");
            }
            if (string.IsNullOrWhiteSpace(txtNewMPIN.Text) || string.IsNullOrWhiteSpace(txtConfirmMPIN.Text))
            {

                lblerror.Text = "MPIN and Confirm MPIN are required.";
                return;
            }

            if (txtNewMPIN.Text == txtConfirmMPIN.Text)
            {
                otp = um.signupotp(number);
                if (otp != "-1")
                {
                    Session["OTP"] = otp;
                    Session["MPIN"] = txtNewMPIN.Text;
                    lblmsg.CssClass = "text-success";
                    lblmsg.Text = "OTP sent successfully to your registered mobile number:- XXXXXX" + last4Digits;
                  
                    ScriptManager.RegisterStartupScript(
                         this, this.GetType(),"OpenOtpModal", @"setTimeout(function () {  var modalEl = document.getElementById('otpModal');  if (modalEl) {var myModal = new bootstrap.Modal(modalEl);myModal.show(); }}, 300); ",
                         true );

                }
                else
                {

                    lblerror.Text = "Failed to send OTP. Please try again.";
                }
            }
            else
            {
                lblerror.Text = "Please enter same MPIN.";
            }
        }

        protected void btnsubmit_Click(object sender, EventArgs e)
        {
            string otp = Session["OTP"].ToString();
            string mpin = Session["MPIN"].ToString();
            string UserId = Session["BankURTUID"].ToString();
            string enteredOTP = txtOTP.Text;
            if (otp == enteredOTP)
            {
                using (con)
                {
                    string updateQuery = @" UPDATE Registration SET MPIN = @MPIN  WHERE RegistrationId = @RegistrationId";

                    using (SqlCommand cmd = new SqlCommand(updateQuery, con))
                    {
                        cmd.Parameters.AddWithValue("@RegistrationId", UserId);
                        cmd.Parameters.AddWithValue("@MPIN", mpin);
                        con.Open();
                        cmd.ExecuteNonQuery();
                    }
                   
                    ScriptManager.RegisterStartupScript(
                     this, this.GetType(), "OpenthankModal", @"setTimeout(function () {  var modalEl = document.getElementById('thankYouModal');  if (modalEl) {var myModal = new bootstrap.Modal(modalEl);myModal.show(); }}, 300); ",
                     true);

                }
            }
            else 
            {
                lblmsg.CssClass = "text-danger";
                lblmsg.Text = "Wrong OTP try again!";
            }
        }

 
    }
}