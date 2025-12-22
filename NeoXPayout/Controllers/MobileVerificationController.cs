
using NeoXPayout.Models;
using Newtonsoft.Json.Linq;
using RestSharp;
using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.Http;

namespace NeoXPayout.Controllers
{
    public class MobileVerificationController : ApiController
    {
        [HttpPost]

        public LoginModel GetData(JObject obj)
        {
            string a = obj.ToString();
            string UserId;
           
            UserManagement Um = new UserManagement();
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString);
            try
            {

                UserId = obj["UserId"].ToString();
              
               
                string appversion = obj["newmobileappversion"].ToString();
                //if (appversion == GetMobileAppVersion())
                //{
                string pc = Um.UpdateOtpStatus(UserId);
                if (pc == "1")
                {
                    LoginModel Name = new LoginModel();
                    Name.Status = "SUCCESS";
                    Name.Message = "OTP Verification Done Successfully! Please Login to Continue!";
                    Name.Data = "OTP Verification Done Successfully! Please Login to Continue!";
                    return Name;
                }
                else
                {
                    LoginModel Name = new LoginModel();
                    Name.Status = "ERR";
                    Name.Message = "Please Try Again!";
                    Name.Data = "Please Try Again!";
                    return Name;
                }

              

                //}
                //else
                //{
                //    LoginModel Name = new LoginModel();
                //    Name.Status = "ERR";
                //    Name.Message = "Login Failed.";
                //    Name.Data = "Please update your app";
                //    return Name;
                //}
            }
            catch (Exception ex)
            {
                LoginModel Name = new LoginModel();
                Name.Status = "ERR";
                Name.Message = "Login Failed.";
                Name.Data = ex.ToString();
                return Name;
            }
        }

    }
}