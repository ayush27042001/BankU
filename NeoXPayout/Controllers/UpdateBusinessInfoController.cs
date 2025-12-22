
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
    public class UpdateBusinessInfoController : ApiController
    {
        [HttpPost]

        public LoginModel GetData(JObject obj)
        {
            string a = obj.ToString();
            string UserId;
            string BusinessName;
            string BusinessAddress;
            string UdhyamNo;
            string BusinessType;
            string DateofIncorporation;
         

            UserManagement Um = new UserManagement();
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString);
            try
            {
                UserId = obj["UserId"].ToString();
                BusinessName = obj["BusinessName"].ToString();
                BusinessAddress = obj["BusinessAddress"].ToString();
                UdhyamNo = obj["UdhyamNo"].ToString();
                BusinessType = obj["BusinessType"].ToString();
                DateofIncorporation = obj["DateofIncorporation"].ToString();
                
                string appversion = obj["newmobileappversion"].ToString();
                //if (appversion == GetMobileAppVersion())
                //{
                string pc = Um.UpdateBusinessInfo(BusinessName, BusinessAddress, UdhyamNo, BusinessType, DateofIncorporation, UserId);
                if (pc == "1")
                {
                    LoginModel Name = new LoginModel();
                    Name.Status = "SUCCESS";
                    Name.Message = "Business Details Update!";
                    Name.Data = "Business Details Update!";
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