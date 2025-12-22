using System;
using System.Web.UI;
using Newtonsoft.Json.Linq;
using RestSharp;

namespace NeoXPayout
{
    public partial class WebForm5 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
       

        public string verifyFace(string imageRelativePath)
        {
            try
            {
                string verificationId = "cf_" + Guid.NewGuid().ToString("N").Substring(0, 16);
                string url = "https://api.cashfree.com/verification/face-liveness";
                string filePath = Server.MapPath(imageRelativePath);

                var client = new RestClient(url);
                var request = new RestRequest(Method.POST);

                request.AddHeader("x-client-id", "CF898769D0DKQJG3BM1S73FBE6OG");
                request.AddHeader("x-client-secret", "cfsk_ma_prod_7a7157c5ac1ae3a067ec8c23080ff94d_e50a26d4");
                request.AddHeader("x-api-version", "2024-12-01");
                request.AddHeader("Accept", "multipart/form-data");
                request.AlwaysMultipartFormData = true;

                request.AddParameter("verification_id", verificationId);
                request.AddFile("image", filePath);

                IRestResponse response = client.Execute(request);
                string apiResponse = response.Content;

                JObject json = JObject.Parse(apiResponse);
                string status = json["status"]?.ToString();
                return status == "SUCCESS" ? "1" : "-1";
            }
            catch (Exception ex)
            {
                lblStatus.Text = "API Error: " + ex.Message;
                return "-1";
            }
        }
        protected void btnVerifyFace_Click(object sender, EventArgs e)
        {
            string imagePath = hdnImagePath.Value; // Get image path from hidden field
            string result = verifyFace(imagePath);

            if (result == "1")
            {
                lblStatus.Text = "Face verification successful!";
            }
            else
            {
                lblStatus.Text = "Face verification failed.";
            }
        }


    }
}