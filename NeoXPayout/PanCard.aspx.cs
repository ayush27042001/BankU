using Newtonsoft.Json.Linq;
using RestSharp;
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
    public partial class PanCard : System.Web.UI.Page
    {
        UserManagement Um = new UserManagement();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["BankURTName"] == null || !(Session["IsMPINVerified"] is bool isVerified && isVerified))
            {
                Response.Redirect("LoginBankU.aspx");
            }


        }
        protected void btnSaveActivation_Click(object sender, EventArgs e)
        {
            string UserId = Session["BankURTUID"].ToString();
            try
            {
              
                string applicantName = txtApplicantName.Text.Trim();
                string mobile = txtMobile.Text.Trim();
                string mode = ddlPanMode.SelectedValue;
           
                string serviceType = Request.Form["bnk-sidebar-title"];
           
                string prodKey = "5025"; 
                string amount = "107";

                if (serviceType == "PAN Card Creation")
                {
                    prodKey = "5024";
                    amount = "105";
                }

                string url = "https://partner.banku.co.in/api/Pancard";
                string body = "{\"UserId\":\"" + UserId + "\",\"Apiversion\":\"" + "1.0" + "\",\"Amt\":\"" + amount + "\",\"ProdKey\":\"" + prodKey
                    + "\",\"Number\":\"" + mobile + "\",\"CustomerName\":\"" + applicantName + "\",\"Mode\":\"" + mode + "\"}";
                string Apiresponse = String.Empty;
                var client = new RestClient(url);
                var request = new RestRequest(Method.POST);
                request.AddHeader("cache-control", "no-cache");
                request.AddHeader("Accept", "application/json");
                request.AddHeader("Content-Type", "application/json");
                request.AddParameter("application/json", body, RestSharp.ParameterType.RequestBody);
                IRestResponse response = client.Execute(request);
                Apiresponse = response.Content;
                Um.LogApiCall(UserId, body, Apiresponse, "Pancard");
                var json = JObject.Parse(Apiresponse);
                string Message = json["Message"]?.ToString();
                string Status = json["Status"]?.ToString().ToUpper();
                if (Status == "SUCCESS")
                {
                    string redirectUrl = Message;
                    Response.Redirect(redirectUrl, false);

                }
                else
                {
                    string redirectUrl = Message;
                    ShowAlert(redirectUrl);
                }


            }
            catch (Exception ex)
            {
                ShowAlert("Something went wrong. Please try later." + ex);
            }
        }

        private void ShowAlert(string message)
        {
            ClientScript.RegisterStartupScript(
                this.GetType(),
                "alert",
                $"alert('{message.Replace("'", "")}');",
                true
            );
        }
    }
}
