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
    public partial class AddNewUser : System.Web.UI.Page
    {
        UserManagement Um = new UserManagement();
     protected void Page_Load(object sender, EventArgs e)
        {
            string Acctype = (Session["AccountHolderType"]?.ToString() ?? "").Trim().ToUpper();
            if (Session["BankURTName"] == null || !(Session["IsMPINVerified"] is bool isVerified && isVerified))
            {
                Response.Redirect("LoginBankU.aspx");
            }
            if (Acctype != "DISTRIBUTOR")
            {
                Response.Redirect("Dashboard.aspx");
            }
            getdetails();
        }
        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            string mobileNumber = txtMobile.Text.Trim();


            if (string.IsNullOrEmpty(mobileNumber) || mobileNumber.Length != 10 || !mobileNumber.All(char.IsDigit))
            {
                Label1.Text = "Enter Correct Mobile Number";
                return;
            }

            VerifyOtp();
        }
        private bool SendOtp(string mobileNumber)
        {
            string otp = Um.signupotp(mobileNumber);

            if (otp != "-1")
            {
                Session["OTPUser"] = otp;
                pnlOtpSection.Visible = true;
                return true;
            }
            else
            {
                return false;
            }
        }
        private void InsertUserData()
        {
            string userId = Session["BankURTUID"]?.ToString() ?? "UnknownUser";
            string mobileNumber = txtMobile.Text.Trim();
            string status = "Active";
            string reqDate = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");

            string query = @"
        -- Step 1: Check if mobile exists in Registration table
        IF EXISTS (SELECT 1 FROM Registration WHERE MobileNo = @Number)
        BEGIN
            -- Step 2: Only insert if not already in DistUserAdd
            IF NOT EXISTS (SELECT 1 FROM DistUserAdd WHERE UserId = @UserId AND Number = @Number)
            BEGIN
                INSERT INTO DistUserAdd (UserId, Number, Status, ReqDate) 
                VALUES (@UserId, @Number, @Status, @ReqDate)
            END
        END
    ";

            string connStr = ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connStr))
            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                cmd.Parameters.AddWithValue("@UserId", userId);
                cmd.Parameters.AddWithValue("@Number", mobileNumber);
                cmd.Parameters.AddWithValue("@Status", status);
                cmd.Parameters.AddWithValue("@ReqDate", reqDate);

                try
                {
                    conn.Open();
                    int rowsAffected = cmd.ExecuteNonQuery();
                    if (rowsAffected > 0)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('User data saved successfully.');", true);
                    }
                    else
                    {
                        // This could mean either user not registered or already added
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Mobile not registered or already added.');", true);
                    }
                }
                catch (Exception ex)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Error saving data: " + ex.Message.Replace("'", "\\'") + "');", true);
                }
            }
            getdetails();
        }


        protected void VerifyOtp()
        {
            string enteredOtp = txtOTP.Text.Trim();
            string sessionOtp = Session["OTPUser"] as string;

            if (string.IsNullOrEmpty(sessionOtp))
            {
                Label1.Text = "OTP expired or not sent. Please request OTP again.";
                return;
            }

            if (enteredOtp == sessionOtp)
            {
                // ✅ OTP success alert
                ScriptManager.RegisterStartupScript(this, this.GetType(), "otpSuccess",
                    "alert('OTP verified successfully.');", true);

                InsertUserData(); // call your method
            }
            else
            {
                Label1.Text = "Incorrect OTP. Please try again.";
            }
        }
        protected void lnkSendOtp_Click(object sender, EventArgs e)
        {
            string mobileNumber = txtMobile.Text.Trim();

            if (string.IsNullOrEmpty(mobileNumber) || mobileNumber.Length != 10 || !mobileNumber.All(char.IsDigit))
            {
                Label1.Text = "Enter Correct Mobile Number";
                return;
            }

            try
            {
                bool otpSent = SendOtp(mobileNumber);

                if (otpSent)
                {
                    Label2.Text = "OTP Sent Successfully";
                    pnlOtpSection.Visible = true;
                    Label1.Text = "";

                    // ✅ Bootstrap 5 modal open script
                    string script = "var myModal = new bootstrap.Modal(document.getElementById('otpModal')); myModal.show();";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", script, true);
                }
                else
                {
                    Label1.Text = "Error sending OTP";
                }
            }
            catch (Exception ex)
            {
                Label1.Text = "Error sending OTP: " + ex.Message;
            }
        }

        public void getdetails()
        {
            string registrationId = Session["BankURTUID"]?.ToString();
            string connStr = ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connStr))
            {
                string query = @"
            SELECT 
                r.RegistrationId,
                r.MobileNo, 
                r.FullName,
                r.Email,
                r.PanNo,
                r.AadharNo,
                r.Status
            FROM DistUserAdd d
            INNER JOIN Registration r ON d.Number = r.MobileNo
            WHERE d.UserId = @UserId";

                SqlCommand mcom = new SqlCommand(query, con);
                mcom.Parameters.AddWithValue("@UserId", registrationId);

                SqlDataAdapter mda = new SqlDataAdapter(mcom);
                DataTable dt = new DataTable();
                mda.Fill(dt);

                rptProduct.Visible = dt.Rows.Count > 0;
                rptProduct.DataSource = dt;
                rptProduct.DataBind();
            }
        }



        //public void getdetails()
        //{
        //    string userId = Session["BankURTUID"].ToString();
        //    string connStr = ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString;
        //    SqlConnection con = new SqlConnection(connStr);

        //    string query = "SELECT * FROM DistUserAdd WHERE UserId = @UserId ORDER BY Id ASC";
        //    SqlCommand mcom = new SqlCommand(query, con);

        //    mcom.Parameters.AddWithValue("@UserId", userId);

        //    SqlDataAdapter mda = new SqlDataAdapter(mcom);
        //    DataTable dt = new DataTable();
        //    mda.Fill(dt);

        //    if (dt.Rows.Count == 0)
        //    {
        //        rptError.Text = "No User Added";
        //        rptuser.Visible = false;
        //    }
        //    else
        //    {
        //        rptuser.Visible = true;
        //        rptuser.DataSource = dt;
        //        rptuser.DataBind();
        //    }
        //}
    }
}