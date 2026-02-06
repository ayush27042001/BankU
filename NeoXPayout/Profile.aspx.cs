using Newtonsoft.Json.Linq;
using RestSharp;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NeoXPayout
{
    public partial class Profile : System.Web.UI.Page
    {


        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString);
        UserManagement Um = new UserManagement();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (this.Session["BankURTName"] == null || !(Session["IsMPINVerified"] is bool isVerified && isVerified))
            {
                Response.Redirect("LoginBankU.aspx");
            }
            if (!IsPostBack)
            {
                getpaymentdetails();
                UserBankDetails();
                getProfileImage();
                LoadPreviousRequests();
            }

        }

        public void getProfileImage()
        {
            string userId = Session["BankURTUID"].ToString();
            string sql = "SELECT ProfileImage FROM Registration WHERE RegistrationId = @RegistrationId";
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand(sql, con);
                cmd.Parameters.AddWithValue("@RegistrationId", userId);
                object imgPath = cmd.ExecuteScalar();
                if (imgPath != DBNull.Value && imgPath != null)
                {
                    imgPreview.Src = imgPath.ToString();
                }
                else
                {
                    imgPreview.Src = "assets/images/user.png";
                }
            }
        }
        public void getpaymentdetails()
        {

            string UserId = this.Session["BankURTUID"].ToString();

            if (string.IsNullOrEmpty(UserId))
            {
                // Optional: Show message or redirect
                return;
            }

            string query = "SELECT * FROM Registration WHERE RegistrationId = @UserId";

            SqlCommand mcom = new SqlCommand(query, con);
            mcom.Parameters.AddWithValue("@UserId", UserId);
            SqlDataAdapter mda = new SqlDataAdapter(mcom);
            DataTable dt = new DataTable();
            mda.Fill(dt);

            if (dt.Rows.Count > 0)
            {
                DataRow row = dt.Rows[0];
                //string businessProof = row["BusinessProof"]?.ToString() ?? "";
                string GSTNo = row["GSTNo"]?.ToString() ?? "";

                //if (businessProof.ToUpper() == "GST"|| !string.IsNullOrEmpty(GSTNo))
                if (!string.IsNullOrEmpty(GSTNo))
                    btnGST.Visible = false;
                else
                    btnGST.Visible = true;

                string VoterIDCard = row["VoterIDCard"]?.ToString()?.Trim();

                if (!string.IsNullOrEmpty(VoterIDCard))
                    btnAddVoter.Visible = false;
                else
                    btnAddVoter.Visible = true;

                lblName.Text = row["FullName"]?.ToString() ?? "";
                lblEmail.Text = row["Email"]?.ToString() ?? "";
                lblDob.Text = row["DOB"] == DBNull.Value ? "" : row["DOB"].ToString();

                lblFather.Text = row["FatherName"]?.ToString() ?? "";
                lblGender.Text = row["Gender"]?.ToString() ?? "";

                lblFullName.Text = row["FullName"]?.ToString() ?? "";
                Email.Text = row["Email"]?.ToString() ?? "";
                DOB.Text = row["DOB"] != DBNull.Value ? row["DOB"].ToString() : "";

                lblPhone.Text = row["MobileNo"]?.ToString() ?? "";
                lblAddress.Text = row["AddressUser"]?.ToString() ?? "";
                lblState.Text = row["State"]?.ToString() ?? "";
                lblPostalCode.Text = row["Postal"]?.ToString() ?? "";
                lblAadhaar.Text = row["AadharNo"]?.ToString() ?? "";
                lblVoter.Text = row["VoterIDCard"]?.ToString() ?? "";
                lblPan.Text = row["PANNo"]?.ToString() ?? "";
                lblBusinessPan.Text = row["BusinessPAN"]?.ToString() ?? "";
                lblBusinessProof.Text = row["BusinessProof"]?.ToString() ?? "";
                //lblProofNo.Text = row["BusinessProofNo"]?.ToString() ?? "";
                lblGSTNo.Text = row["GSTNo"]?.ToString() ?? "";
                lblCompName.Text = row["CompanyName"]?.ToString() ?? "";
                lblCompAddress.Text = row["CompanyAddress"]?.ToString() ?? "";
                lbldate.Text = row["BusinessStartOn"]?.ToString() ?? "";

                lblNature.Text = row["NatureOfBusiness"]?.ToString() ?? "";
                lblBusinessType.Text = row["BusinessType"]?.ToString() ?? "";
                lblAccountHolder.Text = row["AccHolder"]?.ToString() ?? "";
                lblBankName.Text = row["BankName"]?.ToString() ?? "";
                lblBankNameS.Text = row["BankName"]?.ToString() ?? "";
                string account = row["BankAccount"]?.ToString() ?? "";
                lblAccountNumber.Text = account.Length >= 4
                    ? "XXXXXX" + account.Substring(account.Length - 4)
                    : account;
                lblAccountNo.Text = account.Length >= 4
                    ? "XXXXXX" + account.Substring(account.Length - 4)
                    : account;
                lblAccountType.Text = row["AccountHolderType"]?.ToString() ?? "";

               string aadharimg = row["aadharUpload"]?.ToString() ?? "";
               string panimg = row["panUpload"]?.ToString() ?? "";
                string photoimg = row["photoUpload"]?.ToString() ?? "";
                string gstimg = row["gstUpload"]?.ToString() ?? "";

                if (!string.IsNullOrEmpty(aadharimg) && !string.IsNullOrEmpty(panimg) &&  !string.IsNullOrEmpty(photoimg))
                {
                    aadhar.Text = "Uploaded";
                    pan.Text = "Uploaded";
                    img.Text = "Uploaded";

                    if (!string.IsNullOrEmpty(gstimg))
                        gst.Text = "Uploaded";
                    else
                        gst.Text = "Not Uploaded";
                    pnlUpload.Visible = false;  
                    lblKycStatus.Text = "✅ KYC Completed";
                    lblKycStatus.CssClass = "text-success fw-semibold";
                }
                else
                {
                    aadhar.Text = string.IsNullOrEmpty(aadharimg) ? "Not Uploaded" : "Uploaded";
                    pan.Text = string.IsNullOrEmpty(panimg) ? "Not Uploaded" : "Uploaded";
                    img.Text = string.IsNullOrEmpty(photoimg) ? "Not Uploaded" : "Uploaded";
                    gst.Text = string.IsNullOrEmpty(gstimg) ? "Not Uploaded" : "Uploaded";

                    lblKycStatus.Text = "❌ KYC Not Completed";
                    lblKycStatus.CssClass = "text-danger fw-semibold";
                }


                lblIFSC.Text = row["IFSC"]?.ToString() ?? "";
                lblIfsc1.Text = row["IFSC"]?.ToString() ?? "";
                string bankAccount = row["BankAccount"]?.ToString()?.Trim();
                addAccount.Visible = string.IsNullOrEmpty(bankAccount);
                //DOB.Text = Convert.ToDateTime(dt.Rows[0]["DOB"]).ToString("dd-MM-yyyy");
                //lblIncorporationDate.Text = Convert.ToDateTime(dt.Rows[0]["BusinessStartOn"]).ToString("dd-MM-yyyy");
                //lblMother.Text = dt.Rows[0]["MotherName"].ToString();
            }

        }

        protected void AddBank_Click(object sender, EventArgs e)
        {
            string BankAcc = txtAccountNumber.Text;
            string IFSC = txtIFSC.Text;
            string Name = Session["BankURTName"].ToString();
            string Phone = Session["BankURTMobileno"].ToString();
            string Status = verifyBankAccount(BankAcc, IFSC, Name, Phone);
            if (Status == "SUCCESS")
            {
                getpaymentdetails();
                UserBankDetails();
                ScriptManager.RegisterStartupScript(this, this.GetType(),
                     "showSuccessModal", "var myModal = new bootstrap.Modal(document.getElementById('successModal')); myModal.show();", true);
            }
            else
            {
                lblError.Text = "Bank Validation Failed. " + Status;
            }
        }
        public string verifyBankAccount(string BankAcc, string IFSC, string Name, string Phone)
        {
            string UserId = Session["BankURTUID"].ToString();
            string UserName = Session["BankURTName"].ToString().ToUpper();
            try
            {
                string Apiresponse = string.Empty;
                string url = "https://api.cashfree.com/verification/bank-account/sync";
                string body = "{\"bank_account\":\"" + BankAcc + "\",\"ifsc\":\"" + IFSC + "\",\"name\":\"" + Name + "\",\"phone\":\"" + Phone + "\"}";


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
                Um.LogApiCall(UserId, body, Apiresponse, "VerifyBankProfile");
                // Parse the response to get reference_id
                var json = JObject.Parse(Apiresponse);
                string status = json["account_status"]?.ToString();
                string Message = json["account_status_code"]?.ToString();
                string AccHolder = CleanAccountHolderName(json["name_at_bank"]?.ToString());
                if (status == "VALID")
                {
                    if (UserName == AccHolder)
                    {
                        string AccHolderName = CleanAccountHolderName(json["name_at_bank"]?.ToString());
                        string BankName = json["bank_name"]?.ToString();

                        int count = GetUserBankCount(UserId);

                        if (BankAccountAlreadyFilled())
                        {
                            if (count >= 5)
                            {
                                return "MAX_LIMIT";
                            }
                            //string sqlfr12 = "UPDATE Registration SET BankAccount = @BankAccount, IFSC = @IFSC, AccountHolderType = @AccountHolderType, AccHolder=@AccHolder, BankName=@BankName WHERE RegistrationId = @RegistrationId";
                            string sqlfr12 = "INSERT INTO UserBanks (UserId, AccountNo, IFSC, BankName,AccHolder) VALUES(@UserId,@AccountNo,@IFSC,@BankName,@AccHolder)";
                            SqlCommand cmdfr12 = new SqlCommand(sqlfr12, con);

                            cmdfr12.Parameters.AddWithValue("@AccountNo", BankAcc);
                            cmdfr12.Parameters.AddWithValue("@IFSC", IFSC);
                            cmdfr12.Parameters.AddWithValue("@BankName", BankName);
                            cmdfr12.Parameters.AddWithValue("@AccHolder", AccHolderName);
                            cmdfr12.Parameters.AddWithValue("@UserId", UserId);

                            con.Open();
                            int rowsAffected = cmdfr12.ExecuteNonQuery();
                            con.Close();

                            if (rowsAffected > 0)
                            {
                                return "SUCCESS";
                            }
                            else
                            {
                                return "Error updating details. Try again later.";
                            }
                        }
                        else
                        {
                            string sqlfr12 = "UPDATE Registration SET BankAccount = @BankAccount, IFSC = @IFSC, AccountHolderType = @AccountHolderType, AccHolder=@AccHolder, BankName=@BankName WHERE RegistrationId = @RegistrationId";
                            SqlCommand cmdfr12 = new SqlCommand(sqlfr12, con);
                            cmdfr12.Parameters.AddWithValue("@BankAccount", BankAcc);
                            cmdfr12.Parameters.AddWithValue("@IFSC", IFSC);
                            cmdfr12.Parameters.AddWithValue("@AccountHolderType", ddlBankAccType.SelectedValue);
                            cmdfr12.Parameters.AddWithValue("@BankName", BankName);
                            cmdfr12.Parameters.AddWithValue("@AccHolder", AccHolderName);
                            cmdfr12.Parameters.AddWithValue("@RegistrationId", UserId);

                            con.Open();
                            int rowsAffected = cmdfr12.ExecuteNonQuery();
                            con.Close();

                            if (rowsAffected > 0)
                            {
                                return "SUCCESS";
                            }
                            else
                            {
                                return "Error updating details. Try again later.";
                            }
                        }

                    }
                    else
                    {

                        return "Enter only your own account details.";
                    }


                }
                else
                {

                    return Message;
                }
            }
            catch
            {
                return "Error updating details. Try again later.";
            }

        }
        private bool BankAccountAlreadyFilled()
        {
            if (Session["BankURTUID"] == null)
                return false;

            string userId = Session["BankURTUID"].ToString();

            using (SqlConnection con = new SqlConnection(
                ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString))
            {
                string query = @" SELECT COUNT(*) FROM Registration WHERE RegistrationId = @RegistrationId AND ISNULL(BankAccount, '') <> ''";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@RegistrationId", userId);

                    con.Open();
                    int count = Convert.ToInt32(cmd.ExecuteScalar());
                    con.Close();

                    return count > 0;
                }
            }
        }

        private int GetUserBankCount(string userId)
        {
            string sql = "SELECT COUNT(*) FROM UserBanks WHERE UserId = @UserId";
            SqlCommand cmd = new SqlCommand(sql, con);
            cmd.Parameters.AddWithValue("@UserId", userId);

            con.Open();
            int count = Convert.ToInt32(cmd.ExecuteScalar());
            con.Close();

            return count;
        }
        private void UserBankDetails()
        {
            string userId = Session["BankURTUID"].ToString();
            string sql = @"SELECT  BankName,IFSC, AccountNo, REPLICATE('X', LEN(AccountNo) - 4) + RIGHT(AccountNo, 4) AS MaskedAccountNo FROM UserBanks WHERE UserId = @UserId";

            SqlCommand cmd = new SqlCommand(sql, con);
            cmd.Parameters.AddWithValue("@UserId", userId);

            con.Open();
            SqlDataAdapter mda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            mda.Fill(dt);

            if (dt.Rows.Count == 0)
            {
                rptBankAccounts.Visible = false;
            }
            else
            {
                rptBankAccounts.Visible = true;
                rptBankAccounts.DataSource = dt;
                rptBankAccounts.DataBind();
            }

            con.Close();
        }
        private string CleanAccountHolderName(string name)
        {
            if (string.IsNullOrWhiteSpace(name))
                return string.Empty;

            name = name.ToUpper().Trim();

            // Remove prefixes (start of name)
            string[] prefixes =
            {
                "MR ", "MRS ", "MS ", "SHRI ", "SMT ","MR. ", "MRS. ", "MS. ", "SHRI. ", "SMT. "
            };

            foreach (var prefix in prefixes)
            {
                if (name.StartsWith(prefix))
                {
                    name = name.Substring(prefix.Length);
                    break;
                }
            }

            // Remove relations / suffix part (everything after these)
            string[] relations =
            {
                " S/O ", " D/O ", " W/O ", " C/O "
            };

            foreach (var rel in relations)
            {
                int index = name.IndexOf(rel);
                if (index > -1)
                {
                    name = name.Substring(0, index);
                    break;
                }
            }

            // Remove trailing titles if any
            string[] suffixes =
            {
                " MR", " MRS", " MS", " SHRI", " SMT"
            };

            foreach (var suffix in suffixes)
            {
                if (name.EndsWith(suffix))
                {
                    name = name.Substring(0, name.Length - suffix.Length);
                    break;
                }
            }

            // Normalize spaces
            name = Regex.Replace(name, @"\s+", " ").Trim();

            return name;
        }
        protected void SaveImage_Click(object sender, EventArgs e)
        {
            lblMessage.Text = "";
            lblMessage.CssClass = "mt-2 d-block fw-bold";

            if (profileUpload.HasFile)
            {
                string userId = Session["BankURTUID"].ToString();

                // Get original file extension
                string extension = Path.GetExtension(profileUpload.FileName);

                // Generate random file name using GUID
                string fileName = Guid.NewGuid().ToString() + extension;

                string folderPath = Server.MapPath("~/uploads/");
                if (!Directory.Exists(folderPath))
                    Directory.CreateDirectory(folderPath);

                string filePath = Path.Combine(folderPath, fileName);

                // Check file size under 500 KB
                if (profileUpload.PostedFile.ContentLength > 500 * 1024)
                {
                    lblMessage.Text = "⚠️ File size must be less than 500 KB.";
                    lblMessage.CssClass += " text-danger";
                    return;
                }

                try
                {
                    // Save the file
                    profileUpload.SaveAs(filePath);

                    // Update preview
                    imgPreview.Src = "~/uploads/" + fileName;

                    // Save image path to DB
                    string imagePath = "~/uploads/" + fileName;
                    string sql = @"UPDATE Registration 
                           SET ProfileImage = @ProfileImage
                           WHERE RegistrationId = @RegistrationId";

                    using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString))
                    {
                        con.Open();
                        SqlCommand cmd = new SqlCommand(sql, con);
                        cmd.Parameters.AddWithValue("@ProfileImage", imagePath);
                        cmd.Parameters.AddWithValue("@RegistrationId", userId);
                        cmd.ExecuteNonQuery();
                    }
                    getProfileImage();
                    lblMessage.Text = "✅ Profile photo updated successfully!";
                    lblMessage.CssClass += " text-success";
                }
                catch (Exception ex)
                {
                    lblMessage.Text = "❌ Failed to update profile photo. Please try again.";
                    lblMessage.CssClass += " text-danger";
                }
            }
            else
            {
                lblMessage.Text = "⚠️ Please select an image first.";
                lblMessage.CssClass += " text-warning";
            }
        }

        protected void btnADDGST_Click(object sender, EventArgs e)
        {
            string GST = txtGSTNumber.Text;
            string bussName = txtBussName.Text;
            string UserId = Session["BankURTUID"].ToString();
            try
            {
                string Apiresponse = string.Empty;
                string url = "https://api.cashfree.com/verification/gstin";
                string body = "{\"GSTIN\":\"" + GST + "\",\"business_name\":\"" + bussName + "\"}";

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
                Um.LogApiCall(UserId, body, Apiresponse, "VerifyGSTProfile");
                // Parse the response to get reference_id
                var json = JObject.Parse(Apiresponse);
                string valid = json["valid"]?.ToString();

                if (valid == "True")
                {
                    string legalName = json["legal_name_of_business"]?.ToString();
                    string date = json["date_of_registration"]?.ToString();
                    string address = json["principal_place_address"]?.ToString();
                    string sqlfr12 = "UPDATE Registration SET GSTNo = @GSTNo, CompanyName = @CompanyName, BusinessStartOn = @BusinessStartOn,CompanyAddress=@CompanyAddress WHERE RegistrationId = @RegistrationId";
                    SqlCommand cmdfr12 = new SqlCommand(sqlfr12, con);
                    cmdfr12.Parameters.AddWithValue("@GSTNo", GST);
                    cmdfr12.Parameters.AddWithValue("@CompanyName", legalName);
                    cmdfr12.Parameters.AddWithValue("@BusinessStartOn", date);
                    cmdfr12.Parameters.AddWithValue("@CompanyAddress", address);
                    cmdfr12.Parameters.AddWithValue("@RegistrationId", UserId);

                    con.Open();
                    int rowsAffected = cmdfr12.ExecuteNonQuery();
                    con.Close();
                    getpaymentdetails();
                    ScriptManager.RegisterStartupScript(this, this.GetType(),
                    "showSuccessModal", "var myModal = new bootstrap.Modal(document.getElementById('successModal')); myModal.show();", true);
                }
                else
                {
                    lblErrorGst.Text = "Use your valid GST details.";
                }
            }
            catch
            {
                lblErrorGst.Text = "Something went wrong please try again";
            }
        }

        protected void AddVoter_Click(object sender, EventArgs e)
        {
            string verifyCode = "Voter" + new Random().Next(1000, 999999).ToString();
            string VoterID = txtVoterID.Text;
            string UserId = Session["BankURTUID"].ToString();
            string UserName = Session["BankURTName"].ToString().ToUpper();
            try
            {
                string Apiresponse = string.Empty;
                string url = "https://api.cashfree.com/verification/voter-id";
                string body = "{\"verification_id\":\"" + verifyCode + "\",\"epic_number\":\"" + VoterID + "\",\"name\":\"Gurav\"}";

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
                Um.LogApiCall(UserId, body, Apiresponse, "VerifyVoterProfile");
                var json = JObject.Parse(Apiresponse);
                string status = json["status"]?.ToString();
                string VoterName = json["name"]?.ToString().ToUpper();
                if (status == "VALID")
                {
                    if (UserName == VoterName)
                    {
                        string sqlfr12 = "UPDATE Registration SET VoterIDCard = @VoterIDCard WHERE RegistrationId = @RegistrationId";
                        SqlCommand cmdfr12 = new SqlCommand(sqlfr12, con);
                        cmdfr12.Parameters.AddWithValue("@VoterIDCard", VoterID);
                        cmdfr12.Parameters.AddWithValue("@RegistrationId", UserId);

                        con.Open();
                        int rowsAffected = cmdfr12.ExecuteNonQuery();
                        con.Close();
                        getpaymentdetails();
                        ScriptManager.RegisterStartupScript(this, this.GetType(),
                        "showSuccessModal", "var myModal = new bootstrap.Modal(document.getElementById('successModal')); myModal.show();", true);
                    }
                    else
                    {
                        lblVoterErr.Text = "Use your own valid Voter Id.";
                    }
                }
                else
                {
                    lblVoterErr.Text = "Use your valid Voter Id.";
                }
            }
            catch
            {
                lblVoterErr.Text = "Something went wrong please try again";
            }
        }

        protected void btnSubmitUpdate_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;



            string userId = Session["BankURTUID"].ToString();
            string detailType = ddlDetailType.SelectedValue;
            string newValue = txtNewValue.Text.Trim();
            string reason = txtReason.Text.Trim();

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString))
            {
                string query = @"INSERT INTO ProfileUpdateRequests
                        (UserId, DetailType, NewValue, Reason, RequestStatus)
                        VALUES (@UserId, @DetailType, @NewValue, @Reason, 'Pending')";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@UserId", userId);
                cmd.Parameters.AddWithValue("@DetailType", detailType);
                cmd.Parameters.AddWithValue("@NewValue", newValue);
                cmd.Parameters.AddWithValue("@Reason", reason);

                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
            }

            // Clear fields
            ddlDetailType.SelectedIndex = 0;
            txtNewValue.Text = "";
            txtReason.Text = "";
            LoadPreviousRequests();
            ScriptManager.RegisterStartupScript(this, GetType(), "SuccessMsg", @"
                Swal.fire({
                    icon: 'success',
                    title: 'Request Submitted',
                    text: 'Your update request has been sent!',
                    confirmButtonColor: '#6f42c1'
                });
                $('#UpdateModal').modal('hide');
            ", true);
        }

        private void LoadPreviousRequests()
        {

            string userId = Session["BankURTUID"].ToString();

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString))
            {
                string query = @"SELECT DetailType, NewValue, Reason, RequestStatus,
                        CONVERT(VARCHAR(10), RequestDate, 120) AS RequestDate
                        FROM ProfileUpdateRequests 
                        WHERE UserId = @UserId
                        ORDER BY RequestId DESC";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@UserId", userId);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                if (dt.Rows.Count > 0)
                {
                    rptRequests.DataSource = dt;
                    rptRequests.DataBind();
                    lblNoRequests.CssClass = "d-none";
                }
                else
                {
                    lblNoRequests.Text = "No previous requests found.";
                    lblNoRequests.CssClass = "text-muted small d-block";
                }
            }
        }
        public void getkycdetails()
        {

            string UserId = this.Session["BankURTUID"].ToString();

            if (string.IsNullOrEmpty(UserId))
            {
                // Optional: Show message or redirect
                return;
            }

            string query = "SELECT aadharUpload, panUpload, photoUpload, gstUpload FROM Registration WHERE RegistrationId = @UserId";

            SqlCommand mcom = new SqlCommand(query, con);
            mcom.Parameters.AddWithValue("@UserId", UserId);
            SqlDataAdapter mda = new SqlDataAdapter(mcom);
            DataTable dt = new DataTable();
            mda.Fill(dt);

            if (dt.Rows.Count > 0)
            {
                DataRow row = dt.Rows[0];
               
                string aadharimg = row["aadharUpload"]?.ToString() ?? "";
                string panimg = row["panUpload"]?.ToString() ?? "";
                string photoimg = row["photoUpload"]?.ToString() ?? "";
                string gstimg = row["gstUpload"]?.ToString() ?? "";

                if (!string.IsNullOrEmpty(aadharimg) && !string.IsNullOrEmpty(panimg) && !string.IsNullOrEmpty(photoimg))
                {
                    aadhar.Text = "Uploaded";
                    pan.Text = "Uploaded";
                    img.Text = "Uploaded";

                    if (!string.IsNullOrEmpty(gstimg))
                        gst.Text = "Uploaded";
                    else
                        gst.Text = "Not Uploaded";
                    pnlUpload.Visible = false;
                    lblKycStatus.Text = "✅ KYC Completed";
                    lblKycStatus.CssClass = "text-success fw-semibold";
                }
                else
                {
                    aadhar.Text = string.IsNullOrEmpty(aadharimg) ? "Not Uploaded" : "Uploaded";
                    pan.Text = string.IsNullOrEmpty(panimg) ? "Not Uploaded" : "Uploaded";
                    img.Text = string.IsNullOrEmpty(photoimg) ? "Not Uploaded" : "Uploaded";
                    gst.Text = string.IsNullOrEmpty(gstimg) ? "Not Uploaded" : "Uploaded";

                    lblKycStatus.Text = "❌ KYC Not Completed";
                    lblKycStatus.CssClass = "text-danger fw-semibold";
                }

            }

        }
        protected void btnSubmitKyc_Click(object sender, EventArgs e)
        {
            if (!fuAadhaar.HasFile || !fuPan.HasFile || !fuPhoto.HasFile)
            {
                lblKycStatus.Text = "Please upload Aadhaar, PAN and Photo.";
                lblKycStatus.CssClass = "text-danger fw-semibold";
                return;
            }

            string userId = Session["BankURTUID"].ToString(); 
            string folderPath = "~/KYC/";
            string serverPath = Server.MapPath(folderPath);

            if (!Directory.Exists(serverPath))
                Directory.CreateDirectory(serverPath);

            string aadhaarFile = "Aadhaar_" + userId + "_" + DateTime.Now.Ticks + Path.GetExtension(fuAadhaar.FileName);
            string panFile = "PAN_" + userId + "_" + DateTime.Now.Ticks + Path.GetExtension(fuPan.FileName);
            string photoFile = "Photo_" + userId + "_" + DateTime.Now.Ticks + Path.GetExtension(fuPhoto.FileName);
            string gstFile = null;
            
            fuAadhaar.SaveAs(serverPath + aadhaarFile);
            fuPan.SaveAs(serverPath + panFile);
            fuPhoto.SaveAs(serverPath + photoFile);

            if (fuGst.HasFile)
            {
                gstFile = "GST_" + userId + "_" + DateTime.Now.Ticks + Path.GetExtension(fuGst.FileName);
                fuGst.SaveAs(serverPath + gstFile);
            }

           
            string aadhaarUrl = folderPath + aadhaarFile;
            string panUrl = folderPath + panFile;
            string photoUrl = folderPath + photoFile;
            string gstUrl = gstFile != null ? folderPath + gstFile : null;

            // ---- DB Update ----
            using (SqlConnection con = new SqlConnection(
                ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString))
            {
                string query = @"UPDATE Registration SET aadharUpload = @Aadhaar, panUpload = @Pan, photoUpload = @Photo, gstUpload = @Gst WHERE RegistrationId = @UserId";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@Aadhaar", aadhaarUrl);
                    cmd.Parameters.AddWithValue("@Pan", panUrl);
                    cmd.Parameters.AddWithValue("@Photo", photoUrl);
                    cmd.Parameters.AddWithValue("@Gst", (object)gstUrl ?? DBNull.Value);
                    cmd.Parameters.AddWithValue("@UserId", userId);

                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }
            getkycdetails();
            // ---- Success ----
            lblKycStatus.Text = "KYC Completed Successfully";
            lblKycStatus.CssClass = "text-success fw-semibold";
        }
    }
}