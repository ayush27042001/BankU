using iTextSharp.text;
using iTextSharp.text.pdf;
using Newtonsoft.Json.Linq;
using RestSharp;
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

namespace NeoXPayout
{
    public partial class Agreement : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString);
        SqlCommand com = new SqlCommand();
        SqlDataAdapter da = new SqlDataAdapter();
        SqlDataAdapter da1 = new SqlDataAdapter();
        DataSet ds = new DataSet();
        UserManagement Um = new UserManagement();
        protected void Page_Load(object sender, EventArgs e)
        {
            if(Session["BankURTName"] == null || !(Session["IsMPINVerified"] is bool isVerified && isVerified))
            {
                Response.Redirect("LoginBankU.aspx");
            }
            else
            {
                if (!IsPostBack)
                {
                    getdetails();
                }
            }
        }

        public void getdetails()
        {
            string UserId = Session["BankURTUID"]?.ToString();
            con.Open();
            // ---- 1. Fetch Aadhaar Number from Registration Table ----
            string queryAadhar = "SELECT AadharNo FROM Registration WHERE RegistrationId = @RegistrationId";
            SqlCommand cmdAadhar = new SqlCommand(queryAadhar, con);
            cmdAadhar.Parameters.AddWithValue("@RegistrationId", UserId);

            object aadharObj = cmdAadhar.ExecuteScalar();

            if (aadharObj != null && aadharObj != DBNull.Value)
            {
                Session["AadharNo"] = aadharObj.ToString();
            }
            else
            {
                Session["AadharNo"] = "";
            }

            // ---- 2. Fetch User Agreements ----
            string query = "SELECT * FROM UserAgreement WHERE UserId = @UserId ORDER BY Id DESC";
            SqlCommand mcom = new SqlCommand(query, con);
            mcom.Parameters.AddWithValue("@UserId", UserId);

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


        public void SendAadhaar(string Aadhar)
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
                Um.LogApiCall(bankUrtuId, body, Apiresponse, "SendAadhaarAgreement");

                // Parse the response to get reference_id
                var json = JObject.Parse(Apiresponse);
                string status = json["status"]?.ToString();
                string message= json["message"]?.ToString();
                if (status == "SUCCESS")
                {
                    string refId = json["ref_id"]?.ToString();
                    hdnAadhaarRefId.Value = refId;
                    lblmsg.Text = "OTP Send Successfully";
                    ScriptManager.RegisterStartupScript(
                    this,
                    this.GetType(),
                    "openOtp",
                    "var myModal = new bootstrap.Modal(document.getElementById('otpModal')); myModal.show();",
                    true
                      );
                }
                else
                {
                    lblmsg.Text = "Error "+ message;
                    ScriptManager.RegisterStartupScript(
                this,
                this.GetType(),
                "openOtp",
                "var myModal = new bootstrap.Modal(document.getElementById('otpModal')); myModal.show();",
                true
            );
                }
            }
            catch
            {
                lblmsg.Text = "Database Error";
            }
        }

        protected void btnVerifyOtp_Click(object sender, EventArgs e)
        {
            string userOtp = hdnOtpValue.Value.Trim();
            string RefId = hdnAadhaarRefId.Value;
            string bankUrtuId = Session["BankURTUID"]?.ToString();

            try
            {
                string Apiresponse = string.Empty;
                string url = "https://api.cashfree.com/verification/offline-aadhaar/verify";
                string body = "{\"otp\":\"" + userOtp + "\", \"ref_id\":\"" + RefId + "\"}";

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
                Um.LogApiCall(bankUrtuId, body, Apiresponse, "VerifyAadhaarAgreement");

                var json = JObject.Parse(Apiresponse);
                string status = json["status"]?.ToString();

                string name = json["name"]?.ToString().ToUpper();
                if (status == "VALID")
                {
                    lblmsg.Text = "OTP Verified Successfully";

                // Get agreement ID saved earlier
                string agreementId = Session["CurrentAgreementId"].ToString();

                // Fetch Agreement File Path from DB
                string inputPdf = GetAgreementPdfPath(agreementId);

                // Create Signed PDF
                string signedPdf = AddSignatureToPdf(inputPdf, name);   

                updateStatus(agreementId, name);
                // Download PDF
                DownloadPdf(signedPdf);

            }
                else
                {
                    lblmsg.Text = "OTP Incorrect";
                }
            }
            catch (Exception ex)
            {
                lblmsg.Text = "Error: " + ex.Message;
            }
        }

        protected void rptProduct_ItemCommand1(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "SignIn")
            {
                string agreementId = e.CommandArgument.ToString();

                // Get BOTH status and fullname
                var details = GetAgreementDetails(agreementId);
                string status = details.Status;
                string fullName = details.FullName;

                if (status == "Approved")
                { 
                    string path= GetAgreementPdfPath(agreementId);
                    string signedPdf =AddSignatureToPdf(path, fullName);
                    DownloadPdf(signedPdf);
                }
                else
                { 
                    Session["CurrentAgreementId"] = agreementId;
                    string aadhar = Session["AadharNo"].ToString();
                    SendAadhaar(aadhar);
                }
            }
        }
        protected void rptProduct_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                DataRowView row = (DataRowView)e.Item.DataItem;

                string status = row["Status"].ToString();

                LinkButton btnSignIn = (LinkButton)e.Item.FindControl("btnSignIn");

                if (status == "Approved")
                {
                    btnSignIn.Text = "Download";
                }
                else
                {
                    btnSignIn.Text = "Sign Now";
                }
            }
        }


        private (string Status, string FullName) GetAgreementDetails(string agreementId)
        {
            string status = "";
            string fullName = "";

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand(
                    "SELECT Status, FullName FROM UserAgreement WHERE AgreementId=@AgreementId", con);

                cmd.Parameters.AddWithValue("@AgreementId", agreementId);

                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    status = dr["Status"]?.ToString();
                    fullName = dr["FullName"]?.ToString();
                }
            }

            return (status, fullName);
        }

        public string GetAgreementPdfPath(string agreementId)
        {
            string pdfPath = "";

            con.Open();
            SqlCommand cmd = new SqlCommand("SELECT FilePath FROM UserAgreement WHERE AgreementId=@AgreementId", con);
            cmd.Parameters.AddWithValue("@AgreementId", agreementId);

            object result = cmd.ExecuteScalar();
            con.Close();

            if (result != null)
            {
               
                pdfPath = Server.MapPath(result.ToString());
            }

            return pdfPath;
        }


        public void updateStatus(string agreementId, string name)
        {
          con.Open();
                SqlCommand cmdUpdate = new SqlCommand(@"UPDATE UserAgreement SET Status = 'Approved', fullName   = @fullName WHERE AgreementId = @AgreementId", con);

                cmdUpdate.Parameters.AddWithValue("@fullName", name);
                cmdUpdate.Parameters.AddWithValue("@AgreementId", agreementId);
                cmdUpdate.ExecuteNonQuery();
                con.Close();    
        }

        public void DownloadPdf(string filePath)
        {
            FileInfo file = new FileInfo(filePath);
            Response.ContentType = "application/pdf";
            Response.AppendHeader("Content-Disposition", "attachment; filename=" + file.Name);
            Response.WriteFile(file.FullName);
            Response.End();
        }

        public string AddSignatureToPdf(string inputPdfPath, string signerName)
        {
            string outputPdfPath = Server.MapPath("~/SignedDocs/Signed_" + Guid.NewGuid() + ".pdf");


            string timeStamp = DateTime.Now.ToString("dd MMM yyyy 'at' HH:mm:ss");

            using (PdfReader reader = new PdfReader(inputPdfPath))
            {
                using (FileStream fs = new FileStream(outputPdfPath, FileMode.Create))
                {
                    using (PdfStamper stamper = new PdfStamper(reader, fs))
                    {
                        int totalPages = reader.NumberOfPages;

        
                        var nameFont = new iTextSharp.text.Font(iTextSharp.text.Font.FontFamily.HELVETICA, 12, iTextSharp.text.Font.BOLD);
                        var smallFont = new iTextSharp.text.Font(iTextSharp.text.Font.FontFamily.HELVETICA, 9, iTextSharp.text.Font.NORMAL);

                        for (int i = 1; i <= totalPages; i++)
                        {
                            PdfContentByte cb = stamper.GetOverContent(i);

                            float xRight = reader.GetPageSize(i).Right - 40;
                            float yBottom = reader.GetPageSize(i).Bottom + 50;

                
                            // 1. Name (Bold Large)
               
                            ColumnText.ShowTextAligned(
                                cb, Element.ALIGN_RIGHT,
                                new Phrase(signerName, nameFont),
                                xRight, yBottom + 40, 0
                            );

                 
                            // 2. Underlined Timestamp
               
                            ColumnText.ShowTextAligned(
                                cb, Element.ALIGN_LEFT,
                                new Phrase(timeStamp, smallFont),
                                xRight - 150, yBottom + 25, 0
                            );

             
                            cb.MoveTo(xRight - 150, yBottom + 23);
                            cb.LineTo(xRight, yBottom + 23);
                            cb.Stroke();

                          
                            // 3. Aadhaar eSign Text
                       
                            ColumnText.ShowTextAligned(
                                cb, Element.ALIGN_RIGHT,
                                new Phrase("eSign", smallFont),
                                xRight, yBottom + 25, 0
                            );
                        }
                    }
                }
            }

            return outputPdfPath;
        }


    }
}