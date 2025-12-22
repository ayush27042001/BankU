
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
    public class RTSignUpController : ApiController
    {
        [HttpPost]

        public SignUpModel GetData(JObject obj)
        {
            string a = obj.ToString();
            string MobileNO;
           
            string Email;
         
            string Pancard;
           
            string Password;
            UserManagement Um = new UserManagement();
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString);
            try
            {
               
                MobileNO = obj["MobileNo"].ToString();
              
                Email = obj["Email"].ToString();
                Password = obj["Password"].ToString();

                Pancard = obj["Pancard"].ToString();
            
                string appversion = obj["newmobileappversion"].ToString();
                //if (appversion == GetMobileAppVersion())
                //{


                string checkdata = Um.CheckDuplicate(MobileNO, Pancard, Email);
                if (checkdata == "0")
                {
                    //  string externalRef = DateTime.Now.ToString("ddmmyyHHmmssfff");
                    string content = verifyPanCF(Pancard);
                    JObject jObjects = JObject.Parse(content);

                    if (content.Contains("registered_name"))
                    {
                        string firstname = jObjects["registered_name"].ToString();

                        string status = jObjects["valid"].ToString();
                        if (status.ToLower() == "true")
                        {
                            int userreg = Um.signupuser("", firstname, MobileNO, Email, Password, Pancard);
                            if (userreg >= 1)
                            {
                                string aepscontent = Um.signupotp(MobileNO);
                                if (aepscontent != "-1")
                                {
                                    SignUpModel Name = new SignUpModel();
                                    Name.Status = "SUCCESS";
                                    Name.Message = "Verification OTP Sent to Register Mobile";
                                    Name.Data = "Verification OTP Sent to Register Mobile";
                                    Name.OTP = aepscontent;
                                    Name.UserId = userreg;
                                    return Name;
                                }
                                else
                                {
                                    SignUpModel Name = new SignUpModel();
                                    Name.Status = "SUCCESS";
                                    Name.Message = "Verification OTP Sent to Register Mobile";
                                    Name.Data = "9999";
                                    return Name;
                                }
                            }
                            else
                            {
                                SignUpModel Name = new SignUpModel();
                                Name.Status = "ERR";
                                Name.Message = "something went wrong! Please try after some time";
                                Name.Data = "something went wrong! Please try after some time";
                                return Name;
                              
                            }
                        }
                        else
                        {
                            SignUpModel Name = new SignUpModel();
                            Name.Status = "ERR";
                            Name.Message = jObjects["message"].ToString();
                            Name.Data = jObjects["message"].ToString();
                            return Name;
                            

                        }
                    }
                    else
                    {
                        SignUpModel Name = new SignUpModel();
                        Name.Status = "ERR";
                        Name.Message = jObjects["message"].ToString();
                        Name.Data = jObjects["message"].ToString();
                        return Name;
                       
                    }

                }
                else
                {
                    SignUpModel Name = new SignUpModel();
                    Name.Status = "ERR";
                    Name.Message = "Your Details Already Registered With Us!";
                    Name.Data = "Your Details Already Registered With Us!";
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
                SignUpModel Name = new SignUpModel();
                Name.Status = "ERR";
                Name.Message = "Login Failed.";
                Name.Data = "something went wrong";
                return Name;
            }
        }


        public string verifyPanCF(string pan)
        {
            try
            {
                string Apiresponse = String.Empty;
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
                return Apiresponse;
            }
            catch
            {
                return "-1";
            }
        }
        //public string GetMobileAppVersion()
        //{
        //    string pid = "NA";
        //    string query = "select * from MobileAppVersion";
        //    SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["OrbitStepConnectionString"].ConnectionString);
        //    SqlCommand mcom = new SqlCommand(query, con);
        //    SqlDataAdapter mda = new SqlDataAdapter(mcom);
        //    DataTable dt = new DataTable();
        //    mda.Fill(dt);
        //    if (dt.Rows.Count > 0)
        //    {
        //        pid = dt.Rows[0]["AppVer"].ToString();
        //    }
        //    return pid;
        //}
    }
}