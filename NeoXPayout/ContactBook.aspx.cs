using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.IO;
using System.Configuration;

namespace NeoXPayout
{
    public partial class ContactBook : System.Web.UI.Page
    {
        SqlConnection cn = new SqlConnection("Data Source=103.205.142.34,1433;Initial Catalog=BankUIndia_db;Persist Security Info=True;User ID=BankUIndia_db;Password=Chandan@80100");
        SqlCommand com = new SqlCommand();
        SqlDataAdapter da = new SqlDataAdapter();
        UserManagement Um = new UserManagement();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (this.Session["BankURTName"] == null)
            {
                Response.Redirect("LoginBankU.aspx");
            }
            else
            {
                if (!IsPostBack)
                {
                    getdetails();
                    FillBankNames();
                    getdetails1();
                    getdetails3();
                }
            }
        }
        private void FillBankNames()
        {
            List<string> banks = new List<string>()
    {
        "-- Select Bank --",
        "State Bank of India (SBI)",
        "Punjab National Bank (PNB)",
        "Bank of Baroda",
        "Canara Bank",
        "Union Bank of India",
        "Central Bank of India",
        "Indian Bank",
        "Indian Overseas Bank",
        "UCO Bank",
        "Bank of Maharashtra",
        "Punjab & Sind Bank",
        "Bank of India",
        "HDFC Bank",
        "ICICI Bank",
        "Axis Bank",
        "Kotak Mahindra Bank",
        "IndusInd Bank",
        "Yes Bank",
        "Bandhan Bank",
        "IDBI Bank",
        "Federal Bank",
        "South Indian Bank",
        "Tamilnad Mercantile Bank",
        "Karnataka Bank",
        "Karur Vysya Bank",
        "Lakshmi Vilas Bank",
        "Dhanlaxmi Bank",
        "RBL Bank",
        "Jammu & Kashmir Bank",
        "City Union Bank"
    };

            ddlBankName.DataSource = banks;
            ddlBankName.DataBind();
        }
        public void getdetails()
        {
            string Id = Session["BankURTUID"]?.ToString();
            string query = "select * from  AddContact where UserId = @UserId";

            SqlCommand mcom = new SqlCommand(query, cn);
            mcom.Parameters.AddWithValue("@UserId", Id);
            //mcom.Parameters.AddWithValue("@TimeStampFrom", txtfrom.Text + " 00:00:00.000");
            //mcom.Parameters.AddWithValue("@TimeStamp", txtto.Text + " 23:59:59.000");
            //mcom.Parameters.AddWithValue("@Status", "PENDING");
            SqlDataAdapter mda = new SqlDataAdapter(mcom);
            DataTable dt = new DataTable();
            mda.Fill(dt);

            if (dt.Rows.Count == 0)
            {
                rptProduct.Visible = false;
            }
            else
            {
                rptProduct.Visible = true;
                rptProduct.DataSource = dt;
                rptProduct.DataBind();
            }

            cn.Close();
        }
        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            cn.Open();
            string userId = Session["BankURTUID"]?.ToString();
            string sql = "insert into AddContact(UserId,ContactType,ContactPersonName,CompanyName,PhoneNumber,Email)values(@UserId,@ContactType,@ContactPersonName,@CompanyName,@PhoneNumber,@Email)";
            SqlCommand cmd = new SqlCommand(sql, cn);
            cmd.Parameters.AddWithValue("@UserId", userId);
            cmd.Parameters.AddWithValue("@ContactType", ddlcontacttype.SelectedValue);
            cmd.Parameters.AddWithValue("@ContactPersonName", txtcontactperson.Text);
            cmd.Parameters.AddWithValue("@CompanyName", txtcompanyname.Text);
            cmd.Parameters.AddWithValue("@PhoneNumber", txtphone.Text);
            cmd.Parameters.AddWithValue("@Email", txtemail.Text);
            cmd.ExecuteNonQuery();
            cn.Close();
            Response.Redirect("Dashboard.aspx");

        }

        protected void rptProduct_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "ShowProfile")
            {
                string[] data = e.CommandArgument.ToString().Split('|');

                lblName.Text = data[0];
                lblType.Text = data[1];
                lblPhone.Text = data[2];
                lblEmail.Text = data[3];
                HiddenField1.Value = data[4];

                // Avatar = initials (first letters of name)
                if (!string.IsNullOrEmpty(data[0]))
                {
                    var names = data[0].Split(' ');
                    string initials = string.Join("", names.Select(n => n[0])).ToUpper();
                    lblAvatar.InnerText = initials;
                }
                getdetails1();
                getdetails2();
                getdetails3();
            }
        }

        protected void LinkButton2_Click(object sender, EventArgs e)
        {
            string paymentMethod = ddlPaymentMethod.SelectedValue;
            string connStr = "Data Source=103.205.142.34,1433;Initial Catalog=BankUIndia_db;Persist Security Info=True;User ID=BankUIndia_db;Password=Chandan@80100";

            // 👇  Current vendor id/email session se lo
            string Id = HiddenField1.Value;
            //  or  string vendorId = Session["CurrentVendorId"].ToString();

            using (SqlConnection con = new SqlConnection(connStr))
            {
                con.Open();

                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;

                if (paymentMethod == "UPI")
                {
                    cmd.CommandText = @"INSERT INTO PaymentAccounts
                (VendorId, PaymentMethod, UPIID)
                VALUES (@VendorId, @PaymentMethod, @UPIID)";
                    cmd.Parameters.AddWithValue("@VendorId", Id);
                    cmd.Parameters.AddWithValue("@PaymentMethod", "UPI");
                    cmd.Parameters.AddWithValue("@UPIID", txtUpiId.Text.Trim());
                }
                else if (paymentMethod == "Bank")
                {
                    cmd.CommandText = @"INSERT INTO PaymentAccounts
                (VendorId, PaymentMethod, AccountNumber, BankName, IFSC, BeneficiaryName)
                VALUES (@VendorId, @PaymentMethod, @AccountNumber, @BankName, @IFSC, @BeneficiaryName)";
                    cmd.Parameters.AddWithValue("@VendorId", Id);
                    cmd.Parameters.AddWithValue("@PaymentMethod", "Bank");
                    cmd.Parameters.AddWithValue("@AccountNumber", txtAccountNumber.Text.Trim());
                    cmd.Parameters.AddWithValue("@BankName", ddlBankName.SelectedValue);
                    cmd.Parameters.AddWithValue("@IFSC", txtIFSC.Text.Trim());
                    cmd.Parameters.AddWithValue("@BeneficiaryName", txtBeneficiaryName.Text.Trim());
                }

                cmd.ExecuteNonQuery();
            }

            ScriptManager.RegisterStartupScript(this, GetType(),
                "alert", "alert('Payment account added successfully!');", true);
        }

        public void getdetails1()
        {
            string Id = HiddenField1.Value;
            string query = "select * from  PaymentAccounts where VendorId = @VendorId";

            SqlCommand mcom = new SqlCommand(query, cn);
            mcom.Parameters.AddWithValue("@VendorId", Id);
            //mcom.Parameters.AddWithValue("@TimeStampFrom", txtfrom.Text + " 00:00:00.000");
            //mcom.Parameters.AddWithValue("@TimeStamp", txtto.Text + " 23:59:59.000");
            //mcom.Parameters.AddWithValue("@Status", "PENDING");
            SqlDataAdapter mda = new SqlDataAdapter(mcom);
            DataTable dt = new DataTable();
            mda.Fill(dt);

            if (dt.Rows.Count == 0)
            {
                rptPaymentAccounts.Visible = false;
            }
            else
            {
                rptPaymentAccounts.Visible = true;
                rptPaymentAccounts.DataSource = dt;
                rptPaymentAccounts.DataBind();
            }

            cn.Close();
        }

        protected void LinkButton3_Click(object sender, EventArgs e)
        {
            int userId = Convert.ToInt32(HiddenField1.Value); // ✅ string → int

            string connStr = "Data Source=103.205.142.34,1433;Initial Catalog=BankUIndia_db;Persist Security Info=True;User ID=BankUIndia_db;Password=Chandan@80100";

            using (SqlConnection con = new SqlConnection(connStr))
            {
                con.Open();

                string query = @"UPDATE AddContact 
                         SET PAN=@PAN, CIN=@CIN, GSTIN=@GSTIN, TAN=@TAN, UDYAM=@UDYAM 
                         WHERE ID=@UserId";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.Add("@UserId", SqlDbType.Int).Value = userId;
                cmd.Parameters.AddWithValue("@PAN", txtPAN.Text);
                cmd.Parameters.AddWithValue("@CIN", txtCIN.Text);
                cmd.Parameters.AddWithValue("@GSTIN", txtGSTIN.Text);
                cmd.Parameters.AddWithValue("@TAN", txtTAN.Text);
                cmd.Parameters.AddWithValue("@UDYAM", txtUDYAM.Text);

                cmd.ExecuteNonQuery();

            }
        }

        public void getdetails2()
        {
            string Id = HiddenField1.Value;
            string query = "select * from  AddContact where ID = @ID";

            SqlCommand mcom = new SqlCommand(query, cn);
            mcom.Parameters.AddWithValue("@ID", Id);
            //mcom.Parameters.AddWithValue("@TimeStampFrom", txtfrom.Text + " 00:00:00.000");
            //mcom.Parameters.AddWithValue("@TimeStamp", txtto.Text + " 23:59:59.000");
            //mcom.Parameters.AddWithValue("@Status", "PENDING");
            SqlDataAdapter mda = new SqlDataAdapter(mcom);
            DataTable dt = new DataTable();
            mda.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                //,,,,,,,,Status
                HiddenField1.Value = dt.Rows[0]["id"].ToString();
                txtPAN.Text = dt.Rows[0]["PAN"].ToString();
                txtCIN.Text = dt.Rows[0]["CIN"].ToString();
                txtGSTIN.Text = dt.Rows[0]["GSTIN"].ToString();
                txtTAN.Text = dt.Rows[0]["TAN"].ToString();
                txtUDYAM.Text = dt.Rows[0]["UDYAM"].ToString();
            }
        }

        protected void LinkButton4_Click(object sender, EventArgs e)
        {
            int userId = Convert.ToInt32(HiddenField1.Value); // ✅ string → int

            string connStr = "Data Source=103.205.142.34,1433;Initial Catalog=BankUIndia_db;Persist Security Info=True;User ID=BankUIndia_db;Password=Chandan@80100";

            using (SqlConnection con = new SqlConnection(connStr))
            {
                con.Open();

                string query = @"UPDATE AddContact 
                         SET FullName=@FullName, Phone=@Phone, Address=@Address, Pincode=@Pincode 
                         WHERE ID=@UserId";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.Add("@UserId", SqlDbType.Int).Value = userId;
                cmd.Parameters.AddWithValue("@FullName", txtFullName.Text);
                cmd.Parameters.AddWithValue("@Phone", TextBox1.Text);
                cmd.Parameters.AddWithValue("@Address", txtAddress.Text);
                cmd.Parameters.AddWithValue("@Pincode", txtPincode.Text);

                cmd.ExecuteNonQuery();
                ScriptManager.RegisterStartupScript(this, this.GetType(),
        "OpenOffcanvas", "var myOffcanvas = new bootstrap.Offcanvas(document.getElementById('addAddressSidebar')); myOffcanvas.show();", true);
            }
        }

        protected void LinkButton5_Click(object sender, EventArgs e)
        {
            int userId = Convert.ToInt32(HiddenField1.Value); // ✅ string → int

            string connStr = "Data Source=103.205.142.34,1433;Initial Catalog=BankUIndia_db;Persist Security Info=True;User ID=BankUIndia_db;Password=Chandan@80100";

            using (SqlConnection con = new SqlConnection(connStr))
            {
                con.Open();

                string query = @"UPDATE AddContact 
                         SET ContactType=@ContactType, ContactPersonname=@ContactPersonname, CompanyName=@CompanyName, PhoneNumber=@PhoneNumber, Email=@Email 
                         WHERE ID=@UserId";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.Add("@UserId", SqlDbType.Int).Value = userId;
                cmd.Parameters.AddWithValue("@ContactType", DropDownList1.SelectedValue);
                cmd.Parameters.AddWithValue("@ContactPersonname", txtcontactpersonname.Text);
                cmd.Parameters.AddWithValue("@CompanyName", txtcompany.Text);
                cmd.Parameters.AddWithValue("@PhoneNumber", txtphn.Text);
                cmd.Parameters.AddWithValue("@Email", txtemailid.Text);
                cmd.ExecuteNonQuery();
            }
        }

        public void getdetails3()
        {
            string Id = HiddenField1.Value;
            string query = "select * from  AddContact where ID = @ID";

            SqlCommand mcom = new SqlCommand(query, cn);
            mcom.Parameters.AddWithValue("@ID", Id);
            //mcom.Parameters.AddWithValue("@TimeStampFrom", txtfrom.Text + " 00:00:00.000");
            //mcom.Parameters.AddWithValue("@TimeStamp", txtto.Text + " 23:59:59.000");
            //mcom.Parameters.AddWithValue("@Status", "PENDING");
            SqlDataAdapter mda = new SqlDataAdapter(mcom);
            DataTable dt = new DataTable();
            mda.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                //,,,,,,,,Status
                HiddenField1.Value = dt.Rows[0]["id"].ToString();
                DropDownList1.SelectedValue = dt.Rows[0]["ContactType"].ToString();
                txtcontactpersonname.Text = dt.Rows[0]["ContactPersonname"].ToString();
                txtcompany.Text = dt.Rows[0]["CompanyName"].ToString();
                txtphn.Text = dt.Rows[0]["PhoneNumber"].ToString();
                txtemailid.Text = dt.Rows[0]["Email"].ToString();
            }
        }

        protected void LinkButton6_Click(object sender, EventArgs e)
        {
            string Mobile = Session["BankURTMobileno"] as string;
            SendOTP(Mobile);

            string script = "var myModal = new bootstrap.Modal(document.getElementById('otpModal')); myModal.show();";
            ClientScript.RegisterStartupScript(this.GetType(), "ShowModal", script, true);
        }

        private void SendOTP(string number)
        {
            string otp = Um.signupotp(number); // Assuming this returns a string OTP or "-1" if failed

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

        protected void LinkButton7_Click(object sender, EventArgs e)
        {
            VerifyOTPFlow();
        }

        private void VerifyOTPFlow()
        {
            string enteredOtp = TextBox2.Text;
            string storedOtp = Session["OTP"] as string;
            string mobile = TextBox1.Text.Trim();

            if (string.IsNullOrEmpty(storedOtp))
            {
                lblOTPStatus.CssClass = "text-danger";
                lblOTPStatus.Text = "OTP expired. Please click Resend OTP.";
                return;
            }
            if (enteredOtp == storedOtp)
            {
                lblOTPStatus.CssClass = "text-success";
                lblOTPStatus.Text = "OTP verified! Logging you in…";

                Session["mobileno"] = mobile;
                int ID = Convert.ToInt32(HiddenField1.Value);
                string connStr = "Data Source=103.205.142.34,1433;Initial Catalog=BankUIndia_db;Persist Security Info=True;User ID=BankUIndia_db;Password=Chandan@80100";
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    con.Open();
                    string query = "DELETE FROM AddContact WHERE ID = @ID";
                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@ID", ID);
                        cmd.ExecuteNonQuery();
                    }
                }

                Response.Redirect("Dashboard.aspx");
            }
            else
            {
                lblOTPStatus.CssClass = "text-danger";
                lblOTPStatus.Text = "Incorrect OTP. Please try again.";
            }
        }
    }
}