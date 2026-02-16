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
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString);
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
                    LoadAddress();
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

            SqlCommand mcom = new SqlCommand(query, con);
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

            con.Close();
        }
        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            con.Open();
            string userId = Session["BankURTUID"]?.ToString();
            string sql = "insert into AddContact(UserId,ContactType,ContactPersonName,CompanyName,PhoneNumber,Email)values(@UserId,@ContactType,@ContactPersonName,@CompanyName,@PhoneNumber,@Email)";
            SqlCommand cmd = new SqlCommand(sql, con);
            cmd.Parameters.AddWithValue("@UserId", userId);
            cmd.Parameters.AddWithValue("@ContactType", ddlcontacttype.SelectedValue);
            cmd.Parameters.AddWithValue("@ContactPersonName", txtcontactperson.Text);
            cmd.Parameters.AddWithValue("@CompanyName", txtcompanyname.Text);
            cmd.Parameters.AddWithValue("@PhoneNumber", txtphone.Text);
            cmd.Parameters.AddWithValue("@Email", txtemail.Text);
            cmd.ExecuteNonQuery();
            con.Close();
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

                if (data.Length > 0 && !string.IsNullOrWhiteSpace(data[0]))
                {
                    string fullName = data[0].Trim();

                    var names = fullName.Split(new char[] { ' ' }, StringSplitOptions.RemoveEmptyEntries);

                    string initials = "";

                    foreach (var name in names)
                    {
                        initials += name[0];
                    }

                    lblAvatar.InnerText = initials.ToUpper();
                }


                getdetails1();
                getdetails2();
                getdetails3();
                LoadAddress();
            }
        }

        protected void LinkButton2_Click(object sender, EventArgs e)
        {
            string paymentMethod = ddlPaymentMethod.SelectedValue;
            if (string.IsNullOrEmpty(HiddenField1.Value))
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert",
                    "alert('User ID not found! Please select a contact first.');", true);
                return;
            }
            string Id = HiddenField1.Value;
            string contactname = getcontactname(HiddenField1.Value);
            string number = getcontactNumber(HiddenField1.Value);
            string UserId = Session["BankURTUID"].ToString();

            using (con)
            {
                con.Open();

                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;

                if (paymentMethod == "UPI")
                {
                    cmd.CommandText = @"INSERT INTO PaymentAccounts (VendorId, PaymentMethod, UPIID) VALUES (@VendorId, @PaymentMethod, @UPIID)";
                    cmd.Parameters.AddWithValue("@VendorId", Id);
                    cmd.Parameters.AddWithValue("@PaymentMethod", "UPI");
                    cmd.Parameters.AddWithValue("@UPIID", txtUpiId.Text.Trim());
                }
                else if (paymentMethod == "Bank")
                {
                    if (Um.verifyBankAccount(txtAccountNumber.Text.Trim(), txtIFSC.Text.Trim(), contactname, number, UserId) == "SUCCESS")
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
                        ShowMessage("Payment account added successfully!", true);
                        getdetails1();
                    }
                    else 
                    {
                        ShowMessage("Invalid Bank Account or name mismatch.", false);
                        return;
                    }
                }

                cmd.ExecuteNonQuery();
            }
           
            return;
           
        }

        public void getdetails1()
        {
            string Id = HiddenField1.Value;
            string query = "select * from  PaymentAccounts where VendorId = @VendorId";

            SqlCommand mcom = new SqlCommand(query, con);
            mcom.Parameters.AddWithValue("@VendorId", Id);
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

            con.Close();
        }

        protected void LinkButton3_Click(object sender, EventArgs e)
        {
            try
            {
                if (string.IsNullOrEmpty(HiddenField1.Value))
                {
                    ShowMessage("User ID not found!", false);
                    return;
                }

                if (Session["BankURTUID"] == null)
                {
                    ShowMessage("Session expired.", false);
                    return;
                }

                int userId;
                if (!int.TryParse(HiddenField1.Value, out userId))
                {
                    ShowMessage("Invalid User ID.", false);
                    return;
                }

                string externalRef = "BankU" + DateTime.Now.ToString("yyyyMMddHHmmss");
                string UserId = Session["BankURTUID"].ToString();
                string contactname = getcontactname(HiddenField1.Value);

                if (string.IsNullOrWhiteSpace(txtPAN.Text) &&
                    string.IsNullOrWhiteSpace(txtCIN.Text) &&
                    string.IsNullOrWhiteSpace(txtGSTIN.Text))
                {
                    ShowMessage("Please enter at least one field (PAN, CIN or GSTIN).", false);
                    return;
                }
                using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString))
                {
                    con.Open();

                    bool anySuccess = false;

                    // 🔹 Get existing values from DB (IMPORTANT)
                    string query = "SELECT PAN, CIN, GSTIN FROM AddContact WHERE ID=@ID";
                    SqlCommand checkCmd = new SqlCommand(query, con);
                    checkCmd.Parameters.AddWithValue("@ID", userId);

                    SqlDataReader reader = checkCmd.ExecuteReader();

                    string dbPAN = "", dbCIN = "", dbGSTIN = "";

                    if (reader.Read())
                    {
                        dbPAN = reader["PAN"].ToString();
                        dbCIN = reader["CIN"].ToString();
                        dbGSTIN = reader["GSTIN"].ToString();
                    }
                    reader.Close();

                    // ================= PAN =================
                    if (!string.IsNullOrEmpty(txtPAN.Text.Trim()))
                    {
                        if (!string.IsNullOrEmpty(dbPAN))
                        {
                            // Already exists → skip
                        }
                        else
                        {
                            string panflag = Um.verifyPanCF(txtPAN.Text.Trim(), UserId);

                            if (panflag != "-1" &&
                                panflag.Equals(contactname, StringComparison.OrdinalIgnoreCase))
                            {
                                UpdateField(con, "PAN", txtPAN.Text.Trim(), userId);
                                anySuccess = true;
                            }
                            else
                            {
                                ShowMessage("PAN verification failed.", false);
                                return;
                            }
                        }
                    }

                    // ================= CIN =================
                    if (!string.IsNullOrEmpty(txtCIN.Text.Trim()))
                    {
                        if (!string.IsNullOrEmpty(dbCIN))
                        {
                            // skip
                        }
                        else
                        {
                            string cinflag = Um.verifyCIN(externalRef, txtCIN.Text.Trim(), UserId, contactname);

                            if (cinflag == "1")
                            {
                                UpdateField(con, "CIN", txtCIN.Text.Trim(), userId);
                                anySuccess = true;
                            }
                            else
                            {
                                ShowMessage("Invalid CIN", false);
                                return;
                            }
                        }
                    }

                    // ================= GSTIN =================
                    if (!string.IsNullOrEmpty(txtGSTIN.Text.Trim()))
                    {
                        if (!string.IsNullOrEmpty(dbGSTIN))
                        {
                            // skip
                        }
                        else
                        {
                            UpdateField(con, "GSTIN", txtGSTIN.Text.Trim(), userId);
                            anySuccess = true;
                        }
                    }

                    // ================= FINAL =================
                    if (anySuccess)
                    {
                        ShowMessage("Details added successfully", true);
                        getdetails2();
                    }
                    else
                    {
                        getdetails2();
                        ShowMessage("Nothing new to update (already added)", false);
                    }
                }
            }
            catch (Exception ex)
            {
                ShowMessage("Error: " + ex.Message, false);
            }
        }

        private void UpdateField(SqlConnection con, string field, string value, int userId)
        {
            string query = $"UPDATE AddContact SET {field}=@value WHERE ID=@UserId";

            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@value", value);
                cmd.Parameters.Add("@UserId", SqlDbType.Int).Value = userId;
                cmd.ExecuteNonQuery();
            }
        }
        private void ShowMessage(string message, bool isSuccess)
        {
            lblErr.Text = message;
            lblErr.CssClass = isSuccess ? "text-success" : "text-danger";
        }

        public string getcontactname(string contactid)
        {
            string name = "";

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString))
            {
                string query = "SELECT ContactPersonName FROM AddContact WHERE ID = @ID";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.Add("@ID", SqlDbType.VarChar).Value = contactid;

                    con.Open();
                    object result = cmd.ExecuteScalar();

                    if (result != null)
                    {
                        name = result.ToString().ToUpper();
                    }
                }
            }

            return name;
        }

        public string getcontactNumber(string contactid)
        {
            string number = "";

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString))
            {
                string query = "SELECT PhoneNumber FROM AddContact WHERE ID = @ID";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.Add("@ID", SqlDbType.VarChar).Value = contactid;

                    con.Open();
                    object result = cmd.ExecuteScalar();

                    if (result != null)
                    {
                        number = result.ToString().ToUpper();
                    }
                }
            }

            return number;
        }

        public void getdetails2()
        {
            string Id = HiddenField1.Value;
            string query = "select * from  AddContact where ID = @ID";

            SqlCommand mcom = new SqlCommand(query, con);
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
                bool isExists =
               !string.IsNullOrEmpty(txtPAN.Text) &&
               !string.IsNullOrEmpty(txtCIN.Text) &&
               !string.IsNullOrEmpty(txtGSTIN.Text);

                if (isExists)
                {
                    LinkButton3.Enabled = false;
                    LinkButton3.Text = "Already Added";
                   
                }
                else
                {
                    LinkButton3.Enabled = true;
                    LinkButton3.Text = "ADD";
                }
            }
        }

        protected void LinkButton4_Click(object sender, EventArgs e)
        {
           
            if (string.IsNullOrEmpty(HiddenField1.Value))
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert",
                    "alert('User ID not found! Please select a contact first.');", true);
                return;
            }
            int userId = Convert.ToInt32(HiddenField1.Value); 
            using (con)
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
                LoadAddress();
                ShowMessage("Address Added Successfully.", true);

            }
        }
        public void LoadAddress()
        {
            if (string.IsNullOrEmpty(HiddenField1.Value)) return;

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString))
            {
                string query = "SELECT FullName, Phone, Address, Pincode FROM AddContact WHERE ID=@ID";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@ID", HiddenField1.Value);

                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.Read())
                {
                    string name = dr["FullName"].ToString();

                    if (!string.IsNullOrEmpty(name))
                    {
                        // ✅ Show Address
                        pnlAddressEmpty.Visible = false;
                        pnlAddressDisplay.Visible = true;

                        Label1.Text = name;
                        Label2.Text = dr["Phone"].ToString();
                        lblAddress.Text = dr["Address"].ToString();
                        lblPincode.Text = dr["Pincode"].ToString();
                    }
                    else
                    {
                        // ❌ No Address
                        pnlAddressEmpty.Visible = true;
                        pnlAddressDisplay.Visible = false;
                    }
                }
            }
        }

        protected void LinkButton5_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(HiddenField1.Value))
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert",
                    "alert('User ID not found! Please select a contact first.');", true);
                return;
            }
            int userId = Convert.ToInt32(HiddenField1.Value);
            using (con)
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

            SqlCommand mcom = new SqlCommand(query, con);
            mcom.Parameters.AddWithValue("@ID", Id);
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
            if (string.IsNullOrEmpty(HiddenField1.Value)) return;
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
            //string mobile = TextBox1.Text.Trim();

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

                //Session["mobileno"] = mobile;
                if (string.IsNullOrEmpty(HiddenField1.Value)) return;
                int ID = Convert.ToInt32(HiddenField1.Value);
             
                using (con)
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