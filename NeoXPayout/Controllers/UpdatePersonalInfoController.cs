
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
    public class UpdatePersonalInfoController : ApiController
    {
        [HttpPost]

        public LoginModel GetData(JObject obj)
        {
            string a = obj.ToString();
            string UserId;
            string VoterId;
            string AadharNo;
            string FatherName;
            string MotherName;
            string DOB;
            string Gender;
            string UserPosition;
            string PermanantAddress;
            string State;
            string Pincode;
            string Education;


            UserManagement Um = new UserManagement();
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString);
            try
            {

                UserId = obj["UserId"].ToString();
                VoterId = obj["VoterId"].ToString();
                AadharNo = obj["AadharNo"].ToString();
                FatherName = obj["FatherName"].ToString();
                MotherName = obj["MotherName"].ToString();
                DOB = obj["DOB"].ToString();
                Gender = obj["Gender"].ToString();
                UserPosition = obj["UserPosition"].ToString();
                PermanantAddress = obj["PermanantAddress"].ToString();
                State = obj["State"].ToString();
                Pincode = obj["Pincode"].ToString();
                Education = obj["Education"].ToString();


                string appversion = obj["newmobileappversion"].ToString();
                //if (appversion == GetMobileAppVersion())
                //{
                string pc = Um.UpdatePersonalInfo(VoterId, AadharNo, FatherName, MotherName, DOB, Gender, UserPosition, PermanantAddress, State, Pincode, Education, UserId);
                if (pc == "1")
                {
                    LoginModel Name = new LoginModel();
                    Name.Status = "SUCCESS";
                    Name.Message = "Personal Details Update!";
                    Name.Data = "Personal Details Update!";
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