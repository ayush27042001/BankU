using NeoXPayout.Models;
using Newtonsoft.Json.Linq;
using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.Text;
using System.Web.Http;

namespace NeoXPayout.Controllers
{
    public class UserLoginController : ApiController
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString);

        [HttpPost]

        public LoginModel GetData(JObject obj)
        {
            string a = obj.ToString();
            string username = "", password = "", latitude = "", longitude = "", deviceid = "";

            try
            {
                username = obj["UserName"].ToString();
                password = obj["Password"].ToString();
                string appversion = obj["newmobileappversion"].ToString();
                try
                {
                    latitude = obj["latitude"].ToString();
                    longitude = obj["longitude"].ToString();
                    deviceid = obj["deviceid"].ToString();
                }
                catch
                {

                }
                //if (appversion == GetMobileAppVersion())
                //{
                    //saveLocation(username, password, deviceid, latitude, longitude);
                string ProductId = username;
                string ProductId1 = password;
                string query = "select * from  onboarding where MobileNo=@Username and Password=@Password and Status=@Status";
                SqlCommand mcom = new SqlCommand(query, con);
                mcom.Parameters.AddWithValue("@Username", username);
                mcom.Parameters.AddWithValue("@Password", password);
                mcom.Parameters.AddWithValue("@Status", "1");
                SqlDataAdapter mda = new SqlDataAdapter(mcom);
                DataTable dt = new DataTable();
                mda.Fill(dt);
                if (dt.Rows.Count > 0)
                    {
                        LoginModel Name = new LoginModel();
                        Name.Status = "SUCCESS";
                        Name.Message = "Login Successfully";
                        Name.Data = dt;
                        return Name;
                    }
                    else
                    {
                        LoginModel Name = new LoginModel();
                        Name.Status = "ERR";
                        Name.Message = "Login Failed.";
                        Name.Data = "You Have Entered Wrong Password!";
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
                Name.Data = "You Have Entered Wrong Password!";
                return Name;
            }
        }

        public static string Encrypt(string text)
        {
            string key = "Orbit2022";
            using (var md5 = new MD5CryptoServiceProvider())
            {
                using (var tdes = new TripleDESCryptoServiceProvider())
                {
                    tdes.Key = md5.ComputeHash(UTF8Encoding.UTF8.GetBytes(key));
                    tdes.Mode = CipherMode.ECB;
                    tdes.Padding = PaddingMode.PKCS7;

                    using (var transform = tdes.CreateEncryptor())
                    {
                        byte[] textBytes = UTF8Encoding.UTF8.GetBytes(text);
                        byte[] bytes = transform.TransformFinalBlock(textBytes, 0, textBytes.Length);
                        return Convert.ToBase64String(bytes, 0, bytes.Length);
                    }
                }
            }
        }

        public static string Decrypt(string cipher)
        {
            string key = "Orbit2022";
            using (var md5 = new MD5CryptoServiceProvider())
            {
                using (var tdes = new TripleDESCryptoServiceProvider())
                {
                    tdes.Key = md5.ComputeHash(UTF8Encoding.UTF8.GetBytes(key));
                    tdes.Mode = CipherMode.ECB;
                    tdes.Padding = PaddingMode.PKCS7;

                    using (var transform = tdes.CreateDecryptor())
                    {
                        byte[] cipherBytes = Convert.FromBase64String(cipher);
                        byte[] bytes = transform.TransformFinalBlock(cipherBytes, 0, cipherBytes.Length);
                        return UTF8Encoding.UTF8.GetString(bytes);
                    }
                }
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

        //public int saveLocation(string userid, string password, string deviceid, string latitude, string longitude)
        //{
        //    SqlCommand cmd = new SqlCommand("insert into Tbl_LoginActivity(UserId,Password,DeviceId,Latitude,Longitude,CreatedOn) values(@UserId,@Password,@DeviceId,@Latitude,@Longitude,GETDATE())", con);
        //    cmd.Parameters.AddWithValue("@UserId", userid);
        //    cmd.Parameters.AddWithValue("@Password", password);
        //    cmd.Parameters.AddWithValue("@DeviceId", deviceid);
        //    cmd.Parameters.AddWithValue("@Latitude", latitude);
        //    cmd.Parameters.AddWithValue("@Longitude", longitude);
        //    con.Open();
        //    int i = cmd.ExecuteNonQuery();
        //    con.Close();
        //    return i;
        //}
    }
}