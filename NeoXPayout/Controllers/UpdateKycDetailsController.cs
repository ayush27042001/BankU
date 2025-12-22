
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
    public class UpdateKycDetailsController : ApiController
    {
        [HttpPost]

        public LoginModel GetData(JObject obj)
        {
            string a = obj.ToString();
            string UserId;
            string Pancopy;
            string AadharFront;
            string AadharBack;
            string VoterCard;
            string UdhyamCopy;

            string GstCopy;
            string GeoPhoto;
            string Passportphoto;



            UserManagement Um = new UserManagement();
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString);
            try
            {

                UserId = obj["UserId"].ToString();
                Pancopy = obj["Pancopy"].ToString();
                AadharFront = obj["AadharFront"].ToString();
                AadharBack = obj["AadharBack"].ToString();
                VoterCard = obj["VoterCard"].ToString();
                UdhyamCopy = obj["UdhyamCopy"].ToString();
                GstCopy = obj["GstCopy"].ToString();
                GeoPhoto = obj["GeoPhoto"].ToString();
                Passportphoto = obj["Passportphoto"].ToString();
                string appversion = obj["newmobileappversion"].ToString();
                //if (appversion == GetMobileAppVersion())
                //{
                string pc = Um.UpdateKycinfo(Pancopy, AadharFront, AadharBack, VoterCard, UdhyamCopy, GstCopy, GeoPhoto, Passportphoto, UserId);
                if (pc == "1")
                {
                    LoginModel Name = new LoginModel();
                    Name.Status = "SUCCESS";
                    Name.Message = "Kyc Details Update Successfully!";
                    Name.Data = "Kyc Details Update Successfully!";
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