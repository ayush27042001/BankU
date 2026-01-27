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

namespace NeoXPayout
{
    public partial class Registration : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString);
        UserManagement Um = new UserManagement();
        protected void Page_Load(object sender, EventArgs e)
        {
            string mobile = Session["mobileno"]?.ToString();
            string regStatus = Session["RegistrationStatus"]?.ToString();
            if (string.IsNullOrEmpty(mobile))
            {
                Response.Redirect("LoginBankU.aspx");
            }
             if (!IsPostBack)
            {

                mvSteps.ActiveViewIndex = 0;
                LinkButton1.Text = "NEXT";
                
                switch (regStatus)
                {
                    case "Pan":
                        mvSteps.ActiveViewIndex = 1;  // View for PAN step
                        break;

                    case "Email":
                        mvSteps.ActiveViewIndex = 2;  // View for Email step
                        break;

                    case "Bussiness":
                        mvSteps.ActiveViewIndex = 3;  // View for Business step
                        break;

                    case "Bank":
                        mvSteps.ActiveViewIndex = 4;  // View for Bank step
                        break;

                    case "Aadhar":
                        mvSteps.ActiveViewIndex = 5;  // View for Aadhar step
                        break;

                    default:
                        mvSteps.ActiveViewIndex = 0;  // Default to first step if null or unknown
                        break;
                }
            }

        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            int step = mvSteps.ActiveViewIndex;
           
            if (LinkButton1.Text == "Dashboard")
            {
                
                Response.Redirect("LoginBankU.aspx"); 
                return;
            }
            switch (step)
            {
                case 0:
                    if (ValidateStep1())
                    {
                       
                        mvSteps.ActiveViewIndex = 1;
                    }
                    break;

                case 1:
                    if (ValidateStep2())
                    {
                        string accType = ddlAccType.SelectedValue;
                      
                        if (accType == "BankU Seva Kendra" || accType == "Distributor")
                        {
                            mvSteps.ActiveViewIndex = 3; 
                        }
                        else
                        {
                            mvSteps.ActiveViewIndex = 2; 
                        }
                    }
                    break;

                case 2:
                    if (ValidateStep3())
                    {
                        
                        mvSteps.ActiveViewIndex = 3;
                       
                    }
                    break;

                case 3:
                    if (ValidateStep4())
                    {
                        bool isSubmitted = SubmitFinalForm();

                        if (isSubmitted)
                        {
                          
                            mvSteps.ActiveViewIndex = 4; 
                        }
                    }
                    break;
                case 4:
                    LinkButton1.Enabled = false;
                    btnBack.Enabled = false;
                    break;

            }
        }

        private bool ValidateStep1()
        {
            string pan = TextBox1.Text.Trim().ToUpper();
            string mpin = txtMPIN.Text.Trim();
            string confmpin = txtConfMPIN.Text.Trim();
            string mobile = Session["mobileno"]?.ToString();
            lblError.Text = "";
            if (string.IsNullOrEmpty(pan) || string.IsNullOrEmpty(mpin) || string.IsNullOrEmpty(confmpin))
            {
                lblError.Text = "Please fill all PAN and MPIN fields.";
                return false;
            }
            if (mpin != confmpin)
            {
                lblError.Text = "MPIN and Confirm MPIN must match.";
                return false;
            }
            if (!System.Text.RegularExpressions.Regex.IsMatch(pan, @"^[A-Z]{5}[0-9]{4}[A-Z]{1}$"))
            {
                lblError.Text = "Please enter a valid PAN number.";
                return false;
            }
            lblError.Text = "";
           
            string checkdata = Um.CheckDuplicate(mobile, TextBox1.Text, "");
            if (checkdata == "0")
            {
                string panResult = verifyPanCF(pan);
                string firstname = "";
                if (panResult == "-1")  
                {
                    lblError.Text = "PAN verification failed. Enter Valid Individual Pan Only.";
                    return false;
                }
                else
                {

                    JObject jObjects = JObject.Parse(panResult);

                    if (panResult.Contains("registered_name"))
                    {
                        firstname = jObjects["registered_name"].ToString();
                        Session["PanNumber"] = pan;
                        Session["PanName"] = firstname;
                        lblPanName.Text = "<i>Hi</i> <span style='color: purple; font-weight: bold; font-style: italic;'>" + firstname.ToUpper() + "!</span>";
                        string status = jObjects["valid"].ToString();
                        if (status.ToLower() == "true")
                        {
                            int userreg = signupuser1( firstname, mobile, mpin, pan);
                            if (userreg >= 1)
                            {
                                Session["BankURTName"] = firstname;
                                Session["BankURTMobileno"] = mobile;
                                Session["BankURTUID"] = userreg;

                                Session["SignupStatus"] = "DONE";
                                //Session["PersonalInfoStatus"] = "Pending";
                                //Session["KycStatus"] = "Pending";
                                //Session["DocumentStatus"] = "Pending";
                                //Session["MobileverifyStatus"] = "Pending";
                                //Session["businessdetailsstatus"] = "Pending";
                                //Session["RegistrationStatus"] = "Pending";

                                //string aepscontent = Um.signupotp(mobile);
                                //if (aepscontent != "-1")
                                //{
                                //    Session["BankURTOtp"] = aepscontent;
                                //}
                                return true;
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
                    lblError.CssClass = " text-success";
                    lblError.Text = "PAN verification successfull. ";
                    lblPanName.Text = "Hii " + firstname;
                   
                    return true;
                }
            }

            else
            {
                string strscript = "<script language='javascript'>alert('Your Details Already Registered With Us!')</script>";
                Page.RegisterStartupScript("popup", strscript);
                return false;
            }
           
        }
        private bool ValidateStep2()
        {
            string bankUrtuId = Session["BankURTUID"].ToString();

            if (ddlAccType.SelectedIndex == 0 || ddlBusinessType.SelectedIndex == 0 || string.IsNullOrWhiteSpace(txtEmail.Text))
            {
                lblError.Text = "Please fill all business details.";
                return false;
            }
            lblError.Text = "";
            string status = "Email";
            string accType = ddlAccType.SelectedValue;

            // Skip Step-3 for specific account types
            if (accType == "BankU Seva Kendra" || accType == "Distributor")
            {
                status = "Bussiness";
            }
            else
            {
                status = "Bussiness";
            }
            try
            {
                
                //string query = "select * from Registration where Email=@Email";
                //SqlCommand mcom = new SqlCommand(query, con);
                //mcom.Parameters.AddWithValue("@Email", txtEmail.Text);
               

                //SqlDataAdapter mda = new SqlDataAdapter(mcom);
                //DataTable dt = new DataTable();
                //mda.Fill(dt);
                //if (dt.Rows.Count > 0)
                //{
                //    lblError.Text = "This Email is already Registered Please enter another.";
                //    return false;
                //}
                //else
                //{
                    
                    string sqlfr12 = "UPDATE Registration SET AccountType = @AccountType, Email = @Email, BusinessType = @BusinessType, RegistrationStatus=@RegistrationStatus WHERE RegistrationId = @RegistrationId";
                    SqlCommand cmdfr12 = new SqlCommand(sqlfr12, con);
                    cmdfr12.Parameters.AddWithValue("@AccountType", ddlAccType.SelectedValue);
                    cmdfr12.Parameters.AddWithValue("@Email", txtEmail.Text);
                    cmdfr12.Parameters.AddWithValue("@BusinessType", ddlBusinessType.SelectedValue);
                    cmdfr12.Parameters.AddWithValue("@RegistrationId", bankUrtuId);
                    cmdfr12.Parameters.AddWithValue("@RegistrationStatus", status);
                    con.Open();
                    int rowsAffected = cmdfr12.ExecuteNonQuery();
                    con.Close();

                    if (rowsAffected > 0)
                    {
                        return true;
                    }
                    else
                    {
                        string strscript = "<script language='javascript'>alert('Something went wrong! Please try after some time.');</script>";
                        Page.RegisterStartupScript("popup", strscript);
                        return false;
                    }
                //}

            }
            catch (Exception)
            {
                con.Close(); // Ensure connection is closed in case of error
                string strscript = "<script language='javascript'>alert('Something went wrong! Please try after some time.');</script>";
                Page.RegisterStartupScript("popup", strscript);
                return false;
            }
        }
        private bool ValidateStep3()
        {
            string bankUrtuId = Session["BankURTUID"]?.ToString();      
            string latitude = hdnLatitude.Value;
            string longitude = hdnLongitude.Value;
            string externalRef = "UDYAM" + Session["BankURTUID"].ToString() + new Random().Next(100000, 999999);


            if (ddlBusiProof.SelectedIndex == 0 || ddlNature.SelectedIndex == 0 || string.IsNullOrWhiteSpace(txtBusiPan.Text))
            {
                lblError.Text = "Please fill all business details.";
                return false;
            }


            //  Validate Business PAN via API
            string businessType = ddlBusinessType.SelectedValue;
            bool shouldValidatePAN = !(businessType == "Proprietorship" || businessType == "PSU / Govt. Entitie");

            if (shouldValidatePAN)
            {
                string panResponse = verifyBusinessPan(txtBusiPan.Text.Trim().ToUpper());
                if (panResponse == "-1")
                {
                    lblError.Text = "Invalid or non-company PAN. Please provide a valid company PAN.";
                    return false;
                }
            }

            string proofNumber = "";
            switch (ddlBusiProof.SelectedValue)
            {
                case "GST":
                    if (verifyGST(txtGSt.Text, txtBussName.Text)=="-1")
                    {
                        lblError.Text = "Invalid GST details.";
                        ScriptManager.RegisterClientScriptBlock(
                            this,
                            this.GetType(),
                            "showGSTBoxScript",
                            "setTimeout(function(){ showGSTBox(); }, 200);",
                            true
                        );
                        return false;
                    }
                    proofNumber = txtGSt.Text;
                    break;

                case "UDYAM":
                    //if (verifyUdyam(txtUdyam.Text, externalRef, latitude, longitude) == "-1")
                    //{
                    //    lblError.Text = "Invalid Udyam details.";
                    //    ScriptManager.RegisterClientScriptBlock(
                    //       this,
                    //       this.GetType(),
                    //       "showUDYAMBoxScript",
                    //       "setTimeout(function(){ showUDYAMBox(); }, 200);",
                    //       true
                    //   );
                    //    return false;
                    //}
                    proofNumber = txtUdyam.Text;
                    break;

                case "CIN":
                    if (verifyCIN(externalRef, txtCIN.Text) =="-1")
                    {
                       
                        lblError.Text = "Invalid CIN details.";
                        ScriptManager.RegisterClientScriptBlock(
                            this,
                            this.GetType(),
                            "showCINBoxScript",
                            "setTimeout(function(){ showCINBox(); }, 200);",
                            true
                        );
                        return false;
                    }
                    proofNumber = txtCIN.Text;
                    break;
            }

            lblError.Text = "";

            try
            {
                string sqlfr12 = "UPDATE Registration SET BusinessProof = @BusinessProof, BusinessProofNo = @BusinessProofNo, NatureOfBusiness = @NatureOfBusiness, BusinessPAN = @BusinessPAN, RegistrationStatus=@RegistrationStatus  WHERE RegistrationId = @RegistrationId";
                SqlCommand cmdfr12 = new SqlCommand(sqlfr12, con);
                cmdfr12.Parameters.AddWithValue("@BusinessProof", ddlBusiProof.SelectedValue);
                cmdfr12.Parameters.AddWithValue("@NatureOfBusiness", ddlNature.SelectedValue);
                cmdfr12.Parameters.AddWithValue("@BusinessProofNo", proofNumber);
                cmdfr12.Parameters.AddWithValue("@BusinessPAN", txtBusiPan.Text);
                cmdfr12.Parameters.AddWithValue("@RegistrationId", bankUrtuId);
                cmdfr12.Parameters.AddWithValue("@RegistrationStatus", "Bussiness");
                con.Open();
                int rowsAffected = cmdfr12.ExecuteNonQuery();
                con.Close();

                if (rowsAffected > 0)
                {
                    return true;
                }
                else
                {
                    string strscript = "<script>alert('Something went wrong! Please try after some time.');</script>";
                    Page.RegisterStartupScript("popup", strscript);
                    return false;
                }
            }
            catch (Exception)
            {
                con.Close();
                string strscript = "<script>alert('Something went wrong! Please try after some time.');</script>";
                Page.RegisterStartupScript("popup", strscript);
                return false;
            }
        }
    
        private bool ValidateStep4()
        {
            string bankUrtuId = Session["BankURTUID"]?.ToString();
            if (string.IsNullOrWhiteSpace(bankUrtuId))
            {
                lblError.Text = "Session expired. Please login again.";
                return false;
            }

            string aadhaar = txtAadhar.Text.Trim();
            //string voterId = txtVoter.Text.Trim();
            string otp = txtOtp.Text.Trim();

            if (string.IsNullOrWhiteSpace(aadhaar))
            {
                lblError.Text = "Please enter your Aadhaar number.";
                return false;
            }

            //if (!string.IsNullOrWhiteSpace(voterId))
            //{
            //    string verifyCode = "test" + new Random().Next(1000, 999999).ToString();
            //    if (verifyVoterID(verifyCode, voterId) == "-1")
            //    {
            //        lblError.Text = "Invalid Voter ID details.";
            //        return false;
            //    }
            //}
            try
            {
                using (SqlConnection conCheck = new SqlConnection(ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString))
                {
                    string sqlCheck = "SELECT COUNT(*) FROM Registration WHERE AadharNo = @AadharNo AND RegistrationId <> @RegistrationId";
                    SqlCommand cmdCheck = new SqlCommand(sqlCheck, conCheck);
                    cmdCheck.Parameters.AddWithValue("@AadharNo", aadhaar);
                    cmdCheck.Parameters.AddWithValue("@RegistrationId", bankUrtuId);

                    conCheck.Open();
                    int count = (int)cmdCheck.ExecuteScalar();
                    conCheck.Close();

                    if (count > 0)
                    {
                        lblError.Text = "This Aadhaar number is already registered.";
                        return false;
                    }
                }
            }
            catch (Exception ex)
            {
                lblError.Text = "Database error (duplicate check): " + ex.Message;
                return false;
            }


            if (string.IsNullOrWhiteSpace(otp))
            {
                lblError.Text = "Please enter the Aadhaar OTP.";
                return false;
            }

            string refId = hdnAadhaarRefId.Value;
            if (string.IsNullOrWhiteSpace(refId))
            {
                lblError.Text = "Missing Aadhaar reference. Please resend OTP.";
                return false;
            }
            string code = VerifyAadhaar(otp, refId);
            if (code == "-1")
            {
                lblError.Text = Session["AadhaarErrorMessage"]?.ToString()
                                ?? "Aadhaar OTP verification failed.";
                return false;
            }
            else if (code == "-2")
            {
                lblError.Text = "The name on Aadhaar does not match the name on PAN.";
                return false;
            }

            //  Update Registration table
            try
            {
                string Address = hdnAddress.Value;
                string Gender = hdnGender.Value;
                string DOB = hdnDOB.Value;
                string careOf = hdnFatherName.Value;
                string State = hdnstate.Value;
                string Pincode = hdnpostal.Value;
                string sql = "UPDATE Registration SET AadharNo = @AadharNo, AddressUser=@AddressUser, Gender=@Gender, DOB=@DOB,careOf=@careOf,State=@State,Postal=@Postal,RegistrationStatus=@RegistrationStatus WHERE RegistrationId = @RegistrationId";
                SqlCommand cmd = new SqlCommand(sql, con);          
                cmd.Parameters.AddWithValue("@AadharNo", aadhaar);
                //cmd.Parameters.AddWithValue("@VoterIDCard", 
                //string.IsNullOrWhiteSpace(voterId) ? (object)DBNull.Value : voterId);
                cmd.Parameters.AddWithValue("@RegistrationId", bankUrtuId);
                cmd.Parameters.AddWithValue("@AddressUser", Address);
                cmd.Parameters.AddWithValue("@Gender", Gender);
                cmd.Parameters.AddWithValue("@DOB", DOB);
                cmd.Parameters.AddWithValue("@careOf", careOf);
                cmd.Parameters.AddWithValue("@State", State);
                cmd.Parameters.AddWithValue("@Postal", Pincode);
                cmd.Parameters.AddWithValue("@RegistrationStatus", "Aadhar");
                con.Open();
                int rows = cmd.ExecuteNonQuery();
                con.Close();

                if (rows > 0)
                {
                    lblError.Text = "";
                    return true;
                }
                else
                {
                    lblError.Text = "Something went wrong. Try again.";
                    return false;
                }
                
            }
            catch (Exception ex)
            {
                if (con.State == ConnectionState.Open)
                    con.Close();

                lblError.Text = "Database error: " + ex.Message;
                return false;
            }

        }

        private bool ValidateStep5() 
        {

            return SubmitFinalForm();


        }
        private bool SubmitFinalForm()
        {

            try
            {
                
                string ip = GetClientIp(Request);

                // Get lat/lng from hidden fields
                string latitude = hdnLatitude.Value;
                string longitude = hdnLongitude.Value;

               
                string address = hdnAddress.Value;
                if (string.IsNullOrWhiteSpace(address))
                {
                    address = "Unknown Address";
                }

                // Unique verification ID (you can use GUID or registration ID)
                string verificationId = Guid.NewGuid().ToString();

                // Call Cashfree GeoCoding API
                string geoResult = verifyGeoCoding(verificationId, address, "IN", latitude, longitude);

                // Save to database
                string regId = Session["BankURTUID"]?.ToString();
                string sql = "UPDATE Registration SET IPAddress = @IP, Latitude = @Lat, Longitude = @Lng, GeoVerification = @GeoJson,FaceVerificationResult=@FaceVerificationResult, RegistrationStatus = @RegistrationStatus WHERE RegistrationId = @RegId";
                using (SqlCommand cmd = new SqlCommand(sql, con))
                {
                    cmd.Parameters.AddWithValue("@IP", ip);
                    cmd.Parameters.AddWithValue("@Lat", latitude);
                    cmd.Parameters.AddWithValue("@Lng", longitude);
                    cmd.Parameters.AddWithValue("@GeoJson", geoResult);
                    cmd.Parameters.AddWithValue("@RegId", regId);
                    cmd.Parameters.AddWithValue("@FaceVerificationResult", "true");
                    cmd.Parameters.AddWithValue("@RegistrationStatus", "Done");
                   
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                }

                lblError.CssClass = "text-success";
                lblError.Text = "Form successfully submitted.";
                return true;
            }
            catch (Exception ex)
            {
                con.Close();
                lblError.CssClass = "text-danger";
                lblError.Text = "Error in final submission: " + ex.Message;
                return false;
            }
        }

        //protected void ddlBusiProof_SelectedIndexChanged(object sender, EventArgs e)
        //{        
        //    txtGSt.Visible = false;
        //    txtUdyam.Visible = false;
        //    txtCIN.Visible = false;
        //    txtBussName.Visible = false;  
        //    switch (ddlBusiProof.SelectedValue)
        //    {
        //        case "GST":
        //            txtGSt.Visible = true;
        //            txtBussName.Visible = true;
        //            break;

        //        case "UDYAM":
        //            txtUdyam.Visible = true;
        //            break;

        //        case "CIN":
        //            txtCIN.Visible = true;
        //            break;
        //    }
        //}
        public string verifyPanCF(string pan)
        {
            string bankUrtuId = !string.IsNullOrEmpty(Session["BankURTUID"]?.ToString())
             ? Session["BankURTUID"].ToString()
             : Session["mobileno"]?.ToString();

            try
            {
                string Apiresponse = string.Empty;
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
                Um.LogApiCall(bankUrtuId, body, Apiresponse, "VerifyPan");
             
                var json = JObject.Parse(Apiresponse);
                string valid = json["valid"]?.ToString();
                string type=json["type"]?.ToString().ToUpper();
                if (valid == "True"&& type == "INDIVIDUAL")
                {
                    
                    return Apiresponse;
                }
                else
                {
                    return "-1";
                }
            }
            catch
            {
                return "-1";
            }
        }

        public string verifyBusinessPan(string pan)
        {
            string bankUrtuId = Session["BankURTUID"]?.ToString();
            try
            {
                string Apiresponse = string.Empty;
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
                Um.LogApiCall(bankUrtuId, body, Apiresponse, "verifyBusinessPan");
                // Parse the response to get reference_id
                var json = JObject.Parse(Apiresponse);
                string valid = json["valid"]?.ToString();
                Session["BusiPanName"] = json["registered_name"]?.ToString();
                string type = json["type"]?.ToString().ToUpper();
                if (valid == "True" && type == "COMPANY")
                {
                    
                    return Apiresponse;
                }
                else
                {
                    return "-1";
                }
            }
            catch
            {
                return "-1";
            }
        }
        public string verifyVoterID(string Verify ,string VoterID)
        {
            string bankUrtuId = Session["BankURTUID"]?.ToString();
            try
            {
                string Apiresponse = string.Empty;
                string url = "https://api.cashfree.com/verification/voter-id";
                string body = "{\"verification_id\":\""+Verify+"\",\"epic_number\":\"" + VoterID + "\",\"name\":\"Gurav\"}";

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
                Um.LogApiCall(bankUrtuId, body, Apiresponse, "verifyVoterID");
              
                var json = JObject.Parse(Apiresponse);
                string status = json["status"]?.ToString();

                if (status == "VALID")
                {
                    return "1";
                }
                else
                {
                    return "-1";
                }
            }
            catch
            {
                return "-1";
            }
        }
        public string verifyGST(string GST, string bussName)
        {
            string bankUrtuId = Session["BankURTUID"]?.ToString();
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
                Um.LogApiCall(bankUrtuId, body, Apiresponse, "verifyGST");
                // Parse the response to get reference_id
                var json = JObject.Parse(Apiresponse);
                string valid = json["valid"]?.ToString();
                
                if (valid == "True")
                {
                    Session["legalName"] = json["legal_name_of_business"]?.ToString();
                    Session["TradeName"] = json["trade_name_of_business"]?.ToString();
                    return "1";
                }
                else
                {
                    return "-1";
                }
            }
            catch
            {
                return "-1";
            }

        }
        public string verifyCIN(string VerfID, string CIN)
        {
            string bankUrtuId = Session["BankURTUID"]?.ToString();
            try
            {
                string Apiresponse = string.Empty;
                string url = "https://api.cashfree.com/verification/cin";
                string body = "{\"verification_id\":\"" + VerfID + "\",\"cin\":\"" + CIN + "\"}";

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
                Um.LogApiCall(bankUrtuId, body, Apiresponse, "verifyCIN");
                var json = JObject.Parse(Apiresponse);
                string status = json["status"]?.ToString()?.ToUpper();

                
                if (status != "VALID")
                {
                    return "-1";
                }

                string panName = Session["PanName"]?.ToString()?.ToUpper();
                Session["CompanyName"] = json["company_name"]?.ToString();
               
                JArray directors = (JArray)json["director_details"];
                foreach (var director in directors)
                {
                    string directorName = director["name"]?.ToString()?.ToUpper();
                    if (directorName == panName)
                    {
                        return "1";  
                    }
                }

                return "-1";  
            }
            catch
            {
                return "-1"; 
            }
        }
        public string verifyBankAccount(string BankAcc, string IFSC, string Name, string Phone)
        {
            string bankUrtuId = Session["BankURTUID"]?.ToString();
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
                Um.LogApiCall(bankUrtuId, body, Apiresponse, "verifyBankAccount");
                // Parse the response to get reference_id
                var json = JObject.Parse(Apiresponse);
                string status = json["account_status"]?.ToString();
                string legalName = Session["legalName"]?.ToString()?.ToUpper();             
                string TradeName = Session["TradeName"]?.ToString()?.ToUpper();
                string CompanyName = Session["CompanyName"]?.ToString()?.ToUpper();
                string UdyamName = Session["UdyamName"]?.ToString()?.ToUpper();
                string BusipanName = Session["BusiPanName"]?.ToString()?.ToUpper();
                string AccHolder = json["name_at_bank"]?.ToString().ToUpper();
                if (status == "VALID" && (legalName == AccHolder || BusipanName == AccHolder || TradeName == AccHolder || CompanyName == AccHolder || UdyamName == AccHolder))
                {
                    string AccHolderName = json["name_at_bank"]?.ToString();
                    string BankName = json["bank_name"]?.ToString();
                    hdnBankName.Value = BankName;
                    hdnAccHolderName.Value = AccHolderName;
                    return "SUCCESS";
                }
                else
                {                   
                   
                    return "-1";
                }
            }
            catch
            {
                return "-1";
            }
        }
        public string SendAadhaar(string Aadhar)
        {
            string bankUrtuId = Session["BankURTUID"]?.ToString();
            try
            {
                string Apiresponse = string.Empty;
                string url = "https://api.cashfree.com/verification/offline-aadhaar/otp";
                string body = "{\"aadhaar_number\":\"" + Aadhar + "\"}";


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
                Um.LogApiCall(bankUrtuId, body, Apiresponse, "SendAadhaar");
                // Parse the response to get reference_id
                var json = JObject.Parse(Apiresponse);
                string status = json["status"]?.ToString();
                string Message = json["message"]?.ToString();
                if (status == "SUCCESS")
                {
                    string refId = json["ref_id"]?.ToString();
                    hdnAadhaarRefId.Value = refId;  
                    return "SUCCESS";
                }
                else
                {
                    return Message;
                }
            }
            catch
            {
                return "-1";
            }

        }
        public string VerifyAadhaar(string otp, string reff)
        {
            string bankUrtuId = Session["BankURTUID"]?.ToString();
            try
            {
                string Apiresponse = string.Empty;
                string url = "https://api.cashfree.com/verification/offline-aadhaar/verify";
                string body = "{\"otp\":\"" + otp + "\", \"ref_id\":\"" + reff + "\"}";


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
                Um.LogApiCall(bankUrtuId, body, Apiresponse, "VerifyAadhaar");
                // Parse the response
                var json = JObject.Parse(Apiresponse);
                string status = json["status"]?.ToString();
                string Message = json["message"]?.ToString();
                Session["AadhaarErrorMessage"] = Message;

                string panName = Session["PanName"]?.ToString();

                if (string.IsNullOrWhiteSpace(panName))
                {
                    panName = GetPanNameFromDB();
                    Session["PanName"] = panName; 
                }
                panName = panName?.ToUpper();

                string name = json["name"]?.ToString().ToUpper();
                if (status == "VALID")
                {
                    if(panName == name)
                    {
                        string Address = json["address"]?.ToString();
                        string DOB = json["dob"]?.ToString();
                        string Gender = json["gender"]?.ToString();
                        string careOf = json["care_of"]?.ToString();
                        //string fatherName = careOf?.Replace("S/O", "").Trim();
                        string state = json["split_address"]?["state"]?.ToString();
                        string pincode = json["split_address"]?["pincode"]?.ToString();
                        string Image = json["photo_link"]?.ToString();
                        hdnAddress.Value = Address;
                        hdnGender.Value = Gender;
                        hdnDOB.Value = DOB;
                        hdnFatherName.Value = careOf;
                        hdnstate.Value = state;
                        hdnpostal.Value = pincode;
                        hdnImage.Value = Image;
                        return "SUCCESS";
                    }
                    else 
                    {
                        return "-2";
                    }
                   
                }
                else
                {
                    return "-1";
                }
            }
            catch
            {
                Session["AadhaarErrorMessage"] = "Something went wrong. Please try again.";
                return "-1";
            }

        }
        public string verifyUdyam(string udmNo, string ExRef, string lat, string lon)
        {
            string bankUrtuId = Session["BankURTUID"]?.ToString();
            try
            {
                string Apiresponse = string.Empty;
                string url = "https://api.instantpay.in/identity/udyam";
                string body = "{\"udyamNumber\":\"" + udmNo + "\", \"externalRef\":\"" + ExRef + "\", \"latitude\":\"" + lat + "\", \"longitude\":\"" + lon + "\", \"consent\":\"Y\"}";


                var client = new RestClient(url);
                var request = new RestRequest(Method.POST);
                // Change header data according to Instantpay

                request.AddHeader("X-Ipay-Auth-Code", "1");
                request.AddHeader("X-Ipay-Client-Id", "YWY3OTAzYzNlM2ExZTJlObfzvic/bTaahaNPYnBJ8UI=");
                request.AddHeader("X-Ipay-Client-Secret", "a0cf47b2ffd39a4ab3ab337a00dfea7dcb82db71e84831d862622687353e2eff");
                request.AddHeader("X-Ipay-Endpoint-Ip", "103.159.45.153");
                request.AddHeader("cache-control", "no-cache");
                request.AddHeader("Accept", "application/json");
                request.AddHeader("Content-Type", "application/json");
                request.AddParameter("application/json", body, RestSharp.ParameterType.RequestBody);

                IRestResponse response = client.Execute(request);
                Apiresponse = response.Content;
                Um.LogApiCall(bankUrtuId, body, Apiresponse, "verifyUdyam");

                var json = JObject.Parse(Apiresponse);
                string status = json["status"]?.ToString();


                if (status == "Transaction Successful")
                {
                   
                    string enterpriseName = json["data"]?["udyamDetails"]?["nameOfEnterprise"]?.ToString();

                 
                    if (!string.IsNullOrEmpty(enterpriseName))
                    {
                        Session["UdyamName"] = enterpriseName.Trim();
                    }
                    return "1";
                }
                else
                {
                    return "-1";
                }
            }
            catch
            {
                return "-1";
            }

        }
        public string verifyGeoCoding(string verif_id,string address ,string country_code, string latitude, string longitude)
        {
            string bankUrtuId = Session["BankURTUID"]?.ToString();
            try
            {
                string Apiresponse = string.Empty;
                string url = "https://api.cashfree.com/verification/geocoding";
                string body = "{\"verification_id\":\"" + verif_id + "\", \"address\":\"" + address + "\" , \"country_code\":\"" + country_code + "\", \"latitude\":\"" + latitude + "\", \"longitude\":\"" + longitude + "\", \"consent\":\" Y \"}";


                var client = new RestClient(url);
                var request = new RestRequest(Method.POST);
                // Change header data according to Instantpay

                request.AddHeader("x-client-id", "CF898769D0DKQJG3BM1S73FBE6OG");
                request.AddHeader("x-api-version", "2024-12-01");            
                request.AddHeader("x-client-secret", "cfsk_ma_prod_7a7157c5ac1ae3a067ec8c23080ff94d_e50a26d4");
                request.AddHeader("cache-control", "no-cache");
                request.AddHeader("Accept", "application/json");
                request.AddHeader("Content-Type", "application/json");
                request.AddParameter("application/json", body, RestSharp.ParameterType.RequestBody);

                IRestResponse response = client.Execute(request);
                Apiresponse = response.Content;
                Um.LogApiCall(bankUrtuId, body, Apiresponse, "verifyGeoCoding");
                // Parse the response to get reference_id
                var json = JObject.Parse(Apiresponse);
                string status = json["status"]?.ToString();

                if (status == "VALID")
                {
                    return "1";
                }
                else
                {
                    return "-1";
                }
            }
            catch
            {
                return "-1";
            }

        }
        public static string GetClientIp(HttpRequest request)
        {
            string ip = request.ServerVariables["HTTP_X_FORWARDED_FOR"];
            if (string.IsNullOrEmpty(ip))
            {
                ip = request.ServerVariables["REMOTE_ADDR"];
            }
            return ip;
        }
        public int signupuser1(string FullName, string MobileNo, string MPIN, string Pan)
        {      
            try
            {
                string sqlfr12 = "insert into Registration(PANNo,FullName,UserType,MobileNo,MPIN,RegistrationStatus,RegDate,Status)values(@PANNo,@FullName,@UserType,@MobileNo,@MPIN,@RegistrationStatus,@RegDate,@Status);SELECT SCOPE_IDENTITY();";
                SqlCommand cmdfr12 = new SqlCommand(sqlfr12, con);
                cmdfr12.Parameters.AddWithValue("@PANNo", Pan);               
                cmdfr12.Parameters.AddWithValue("@FullName", FullName);
                cmdfr12.Parameters.AddWithValue("@UserType", "Retailer");
                cmdfr12.Parameters.AddWithValue("@MobileNo", MobileNo);
                cmdfr12.Parameters.AddWithValue("@MPIN", MPIN);             
                cmdfr12.Parameters.AddWithValue("@RegistrationStatus", "Pan");
                cmdfr12.Parameters.AddWithValue("@RegDate", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss.fff"));
                cmdfr12.Parameters.AddWithValue("@Status", "1");
                con.Open();
                int result = Convert.ToInt32(cmdfr12.ExecuteScalar());
                // cmdfr12.ExecuteNonQuery();
                con.Close();
                return result;
            }
            catch (Exception ex)
            {
                return 0;
            }
            finally
            {
                con.Close();
            }
        }
        protected void sendAadharOTP_Click(object sender, EventArgs e)
        {
            string result = SendAadhaar(txtAadhar.Text.Trim());
            if (result == "SUCCESS")
            {
                txtOtp.Visible = true;
                lblError.Text = "OTP sent to Aadhaar-linked mobile.";
            }
            else
            {
                lblError.Text = "Failed to send OTP. Please check your Aadhaar number. "+ result;
            }
        }

        public string verifyFace(string Image)
        {
            try
            {
                string verificationId = "cf_" + Guid.NewGuid().ToString("N").Substring(0, 16);

                string Apiresponse = string.Empty;
                string url = "https://api.cashfree.com/verification/face-liveness";

                var client = new RestClient(url);
                var request = new RestRequest(Method.POST);

                request.AddHeader("x-client-id", "CF898769D0DKQJG3BM1S73FBE6OG");
                request.AddHeader("x-client-secret", "cfsk_ma_prod_7a7157c5ac1ae3a067ec8c23080ff94d_e50a26d4");
                request.AddHeader("x-api-version", "2024-12-01");
                request.AddHeader("Accept", "application/json");
                request.AddHeader("Content-Type", "multipart/form-data");
                request.AlwaysMultipartFormData = true;

                // Add form fields
                request.AddParameter("verification_id", verificationId);

                // Add file
                string filePath = Server.MapPath(Image); 
                request.AddFile("image", filePath);

                // Execute
                IRestResponse response = client.Execute(request);
                Apiresponse = response.Content;

                // Parse the response to get reference_id
                var json = JObject.Parse(Apiresponse);
                string status = json["status"]?.ToString();

                if (status == "SUCCESS")
                {
                    return "1";
                }
                else
                {
                    return "-1";
                }
            }
            catch
            {
                return "-1";
            }

        }
        protected void btnVerifyFace_Click(object sender, EventArgs e)
        {
            //string imagePath = hdnImagePath.Value; 

            //string result = verifyFace(imagePath); 

            //if (result == "1")
            //{
            //    Session["FaceVerified"] = true;
            //    lblError.Text = "Face verification successful!";



            //    SubmitFinalForm();
            //    mvSteps.ActiveViewIndex = 6;
            //    LinkButton1.Text = "PROCEED";
            //}
            //else
            //{
            //    Session["FaceVerified"] = false;
            //    lblError.Text = "Face verification failed.";
            //}
        }

        protected void ddlBusinessType_SelectedIndexChanged(object sender, EventArgs e)
        {
            string selected = ddlBusinessType.SelectedValue;
            string pan = Session["PanNumber"]?.ToString();

            
            if (string.IsNullOrWhiteSpace(pan))
            {
                pan = GetPanFromDB();
                Session["PanNumber"] = pan;
            }

            if (selected == "Proprietorship" || selected == "PSU / Govt. Entitie")
            {
                txtBusiPan.Text = pan;
                txtBusiPan.ReadOnly = true;
            }
            else
            {
                txtBusiPan.Text = "";
                txtBusiPan.ReadOnly = false;
            }
        }
        private string GetPanFromDB()
        {
            string pan = "";
            string regId = Session["BankURTUID"]?.ToString();

            if (string.IsNullOrEmpty(regId))
                return "";

            try
            {
                using (SqlConnection con = new SqlConnection(
                    ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString))
                {
                    string sql = "SELECT PANNO FROM Registration WHERE RegistrationId = @RegistrationId";
                    using (SqlCommand cmd = new SqlCommand(sql, con))
                    {
                        cmd.Parameters.AddWithValue("@RegistrationId", regId);
                        con.Open();
                        object result = cmd.ExecuteScalar();
                        con.Close();

                        if (result != null)
                            pan = result.ToString();
                    }
                }
            }
            catch
            {
                // Optional: log error
                pan = "";
            }

            return pan;
        }
        private string GetPanNameFromDB()
        {
            string panName = "";
            string regId = Session["BankURTUID"]?.ToString();

            if (string.IsNullOrEmpty(regId))
                return "";

            try
            {
                using (SqlConnection con = new SqlConnection(
                    ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString))
                {
                    string sql = "SELECT FullName FROM Registration WHERE RegistrationId = @RegistrationId";
                    using (SqlCommand cmd = new SqlCommand(sql, con))
                    {
                        cmd.Parameters.AddWithValue("@RegistrationId", regId);
                        con.Open();
                        object result = cmd.ExecuteScalar();
                        con.Close();

                        if (result != null)
                            panName = result.ToString();
                    }
                }
            }
            catch
            {
                // Optional: log error
                panName = "";
            }

            return panName;
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            int step = mvSteps.ActiveViewIndex;

            switch (step)
            {
                case 1:
                  
                    break;

                case 2:
                    mvSteps.ActiveViewIndex = 1;
                    break;

                case 3:
                    // Step-3 → Step-2
                    mvSteps.ActiveViewIndex = 1;
                    break;

                case 4:
                    string accType = ddlAccType.SelectedValue;

                    // If Step-3 was skipped, go back to Step-2
                    if (accType == "BankU Seva Kendra" || accType == "Distributor")
                    {
                        mvSteps.ActiveViewIndex = 1;
                    }
                    else
                    {
                        mvSteps.ActiveViewIndex = 2;
                    }
                    break;

                case 5:
                 
                    break;
            }
        }
        private void ToggleBackButton()
        {
            int step = mvSteps.ActiveViewIndex;

           
            btnBack.Visible = !(step == 0 || step == 4);
        }


    }

}