using RestSharp;
using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace BankUIndia
{
    internal class UserManagement
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString);
        public string signupotp(string MobileNo)
        {
            try
            {
                if (MobileNo != "-1")
                {

                    Random ran = new Random();
                    string OTP = ran.Next(1000, 9999).ToString();
                    string mm2 = ""+OTP+" is your OTP from BankU India to authenticate. Never share your OTP or account details with anyone.";
                    string smsstatus = sendsms(MobileNo, mm2);

                    return OTP;

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
        public string sendsms(string MobileNo, string msg)
        {
            try
            {
                //WBTXSL
                string Message = msg.ToString().Trim();
                string MobileNumber = MobileNo;
                string strUrl = "http://sms.webtextsolution.com/sms-panel/api/http/index.php?username=INTSALITE&apikey=90852-AB6E3&apirequest=Text&sender=BANKUI&mobile=" + MobileNumber + "&message=" + Message + "&route=TRANS&TemplateID=1707175178872908463&format=JSON";
                var client = new RestSharp.RestClient(strUrl);
                var request = new RestRequest(Method.GET);
                IRestResponse response = client.Execute(request);
                var content = response.Content;
                return "1";
            }
            catch
            {
                return "-1";
            }
        }
        public string CheckDuplicate(string UserMob, string PAN, string Email)
        {
            string pid;
            string query = "select * from onboarding where MobileNo=@UserMob or PancardNo=@PAN or EmailId=@Email";
            SqlCommand mcom = new SqlCommand(query, con);
            mcom.Parameters.AddWithValue("@UserMob", UserMob);
            mcom.Parameters.AddWithValue("@PAN", PAN);
            mcom.Parameters.AddWithValue("@Email", Email);
            SqlDataAdapter mda = new SqlDataAdapter(mcom);
            DataTable dt = new DataTable();
            mda.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                pid = dt.Rows[0]["UserID"].ToString();
            }
            else
            {
                pid = "0";
            }
            return pid;
        }

        public int signupuser(string CompanyName, string FullName, string MobileNo, string EmailId, string Password, string pancard)
        {

            try
            {
                string sqlfr12 = "insert into onboarding(OnboardingStatus,businessdetailsstatus,PancardNo,CompanyName,UserType,FullName,MobileNo,EmailId,Password,SignupStatus,MobileverifyStatus,PersonalInfoStatus,KycStatus,DocumentStatus,AgrementStatus,RegDate,Status)values(@OnboardingStatus,@businessdetailsstatus,@PancardNo,@CompanyName,@UserType,@FullName,@MobileNo,@EmailId,@Password,@SignupStatus,@MobileverifyStatus,@PersonalInfoStatus,@KycStatus,@DocumentStatus,@AgrementStatus,@RegDate,@Status);SELECT SCOPE_IDENTITY();";
                SqlCommand cmdfr12 = new SqlCommand(sqlfr12, con);
                cmdfr12.Parameters.AddWithValue("@PancardNo", pancard);
                cmdfr12.Parameters.AddWithValue("@CompanyName", CompanyName);
                cmdfr12.Parameters.AddWithValue("@FullName", FullName);
                cmdfr12.Parameters.AddWithValue("@UserType", "Retailer");
                cmdfr12.Parameters.AddWithValue("@MobileNo", MobileNo);
                cmdfr12.Parameters.AddWithValue("@EmailId", EmailId);
                cmdfr12.Parameters.AddWithValue("@Password", Password);
                cmdfr12.Parameters.AddWithValue("@SignupStatus", "DONE");
                cmdfr12.Parameters.AddWithValue("@MobileverifyStatus", "Pending");
                cmdfr12.Parameters.AddWithValue("@PersonalInfoStatus", "Pending");
                cmdfr12.Parameters.AddWithValue("@KycStatus", "Pending");
                cmdfr12.Parameters.AddWithValue("@DocumentStatus", "Pending");
                cmdfr12.Parameters.AddWithValue("@AgrementStatus", "Pending");
                cmdfr12.Parameters.AddWithValue("@businessdetailsstatus", "Pending");
                cmdfr12.Parameters.AddWithValue("@OnboardingStatus", "Pending");
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
    }
}