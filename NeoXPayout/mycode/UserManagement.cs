using Newtonsoft.Json.Linq;
using RestSharp;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;


    
    public class UserManagement
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString);
        public UserManagement()
        {
            //
            // TODO: Add constructor logic here
            //
        }

    public string signupotp(string MobileNo)
    {
        try
        {
            if (MobileNo != "-1")
            {

                Random ran = new Random();
                string OTP = ran.Next(1000, 9999).ToString();
                string mm2 = "" + OTP + " is your OTP from BankU India to authenticate. Never share your OTP or account details with anyone.";
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

    public string ApproveMsg(string MobileNo, string Request, string Name, string ReqId )
    {
        try
        {
            if (MobileNo != "-1")
            {

                Random ran = new Random();
               
                string mm2 = $"Dear {Name}, your request for {Request} Request ID: {ReqId} has been successfully approved. You can now access this service via your dashboard. – BankU India | help@banku.co.in";
                string smsstatus = sendsmsApprove(MobileNo, mm2);

                return "1";

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

    public string RejectMsg(string MobileNo, string Request, string Name, string ReqId)
    {
        try
        {
            if (MobileNo != "-1")
            {

                Random ran = new Random();

                string mm2 = $"Dear {Name}, your request for {Request} Request ID: {ReqId} has been rejected due to incomplete regional documentation or unclear service purpose. Please re-apply with correct details. – BankU India | help@banku.co.in";
                string smsstatus = sendsmsReject(MobileNo, mm2);

                return "1";

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

    public string ProcessMsg(string MobileNo, string Request, string Name, string ReqId)
    {
        try
        {
            if (MobileNo != "-1")
            {

                Random ran = new Random();

                string mm2 = $"Dear{Name}, your request for {Request} Request ID: {ReqId} has been received and is under review. We will notify you once the process is completed. – BankU India | help@banku.co.in";
                string smsstatus = sendsmsProcess(MobileNo, mm2);

                return "1";

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
    public string GetBalance(string UserId) 
    {
       
        string url = "https://partner.banku.co.in/api/GetUserBalance";
        string body = "{\"UserId\":\"" + UserId + "\",\"Apiversion\":\"" + "1.0" + "\"}";
        string Apiresponse = String.Empty;
        var client = new RestClient(url);
        var request = new RestRequest(Method.POST);
        request.AddHeader("cache-control", "no-cache");
        request.AddHeader("Accept", "application/json");
        request.AddHeader("Content-Type", "application/json");
        request.AddParameter("application/json", body, RestSharp.ParameterType.RequestBody);
        IRestResponse response = client.Execute(request);
        Apiresponse = response.Content;

        try
        {
            JObject jObject = JObject.Parse(Apiresponse);
            string scode = jObject["Status"]?.ToString();

            // ✅ Safe check before accessing "Data"
            if (scode == "SUCCESS" && jObject["Data"] != null && jObject["Data"].Type == JTokenType.Array)
            {
                JArray dataArray = (JArray)jObject["Data"];

                if (dataArray.Count > 0)
                {
                    string currentBalance = dataArray[0]["CurrentBalance"]?.ToString();
                   
                    return currentBalance;
                }
            }

            // ⚠️ If no data or unsuccessful
           
            return "0.00";
        }
        catch
        {
            return "0.00";
        }
    }
    public string sendsms(string MobileNo, string msg)
    {
        try
        {
            //WBTXSL
            string Message = msg.ToString().Trim();
            string MobileNumber = MobileNo;
            //string strUrl = "http://sms.webtextsolution.com/sms-panel/api/http/index.php?username=INTSALITE&apikey=90852-AB6E3&apirequest=Text&sender=BANKUI&mobile=" + MobileNumber + "&message=" + Message + "&route=TRANS&TemplateID=1707175178872908463&format=JSON";
            string strUrl = "http://123.108.46.13/sms-panel/api/http/index.php?username=INTSALITE&apikey=90852-AB6E3&apirequest=Text&sender=BANKUI&mobile=" + MobileNumber + "&message=" + Message + "&route=TRANS&TemplateID=1707175178872908463&format=JSON";
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
    public string sendsmsApprove(string MobileNo, string msg)
    {
        try
        {
            //WBTXSL
            string Message = msg.ToString().Trim();
            string MobileNumber = MobileNo;
            //string strUrl = "http://sms.webtextsolution.com/sms-panel/api/http/index.php?username=INTSALITE&apikey=90852-AB6E3&apirequest=Text&sender=BANKUI&mobile=" + MobileNumber + "&message=" + Message + "&route=TRANS&TemplateID=1707175179547827518&format=JSON";
            string strUrl = "http://123.108.46.13/sms-panel/api/http/index.php?username=INTSALITE&apikey=90852-AB6E3&apirequest=Text&sender=BANKUI&mobile=" + MobileNumber + "&message=" + Message + "&route=TRANS&TemplateID=1707175179547827518&format=JSON";
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
    public string sendsmsReject(string MobileNo, string msg)
    {
        try
        {
            //WBTXSL
            string Message = msg.ToString().Trim();
            string MobileNumber = MobileNo;
            string strUrl = "http://123.108.46.13/sms-panel/api/http/index.php?username=INTSALITE&apikey=90852-AB6E3&apirequest=Text&sender=BANKUI&mobile=" + MobileNumber + "&message=" + Message + "&route=TRANS&TemplateID=1707175179570153301&format=JSON";
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
    public string sendsmsProcess(string MobileNo, string msg)
    {
        try
        {
            //WBTXSL
            string Message = msg.ToString().Trim();
            string MobileNumber = MobileNo;
            string strUrl = "http://123.108.46.13/sms-panel/api/http/index.php?username=INTSALITE&apikey=90852-AB6E3&apirequest=Text&sender=BANKUI&mobile=" + MobileNumber + "&message=" + Message + "&route=TRANS&TemplateID=1707175179578398999&format=JSON";
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

    public void LogApiCall(string userId, string request, string response, string apiType)
    {
        using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString))
        {
            string query = @"INSERT INTO APILOGS (UserId, Request, Responce, ApiType, RequestDate)
                         VALUES (@UserId, @Request, @Responce, @ApiType, GETDATE())";

            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@UserId", userId);
                cmd.Parameters.AddWithValue("@Request", request);
                cmd.Parameters.AddWithValue("@Responce", response);
                cmd.Parameters.AddWithValue("@ApiType", apiType);

                con.Open();
                cmd.ExecuteNonQuery();
            }
        }
    }

    public string CheckDuplicate(string UserMob, string PAN, string Emai)
    {
        string pid;
        string query = "select * from Registration where MobileNo=@UserMob or PANNo=@PAN ";
        SqlCommand mcom = new SqlCommand(query, con);
        mcom.Parameters.AddWithValue("@UserMob", UserMob);
        mcom.Parameters.AddWithValue("@PAN", PAN);
       
        SqlDataAdapter mda = new SqlDataAdapter(mcom);
        DataTable dt = new DataTable();
        mda.Fill(dt);
        if (dt.Rows.Count > 0)
        {
            pid = dt.Rows[0]["RegistrationId"].ToString();
        }
        else
        {
            pid = "0";
        }
        return pid;
    }

    //public int signupuser( string FullName, string MobileNo, string MPIN, string Pan)
    //{

    //    try
    //    {
    //        string sqlfr12 = "insert into onboarding(PANNo,FullName,UserType,MobileNo,MPIN,RegistrationStatus,RegDate,Status)values(@PANNo,@FullName,@UserType,@MobileNo,@MPIN,@RegistrationStatus,@RegDate,@Status);SELECT SCOPE_IDENTITY();";
    //        SqlCommand cmdfr12 = new SqlCommand(sqlfr12, con);
    //        cmdfr12.Parameters.AddWithValue("@PANNo", Pan);
    //        //cmdfr12.Parameters.AddWithValue("@CompanyName", CompanyName);
    //        cmdfr12.Parameters.AddWithValue("@FullName", FullName);
    //        cmdfr12.Parameters.AddWithValue("@UserType", "Retailer");
    //        cmdfr12.Parameters.AddWithValue("@MobileNo", MobileNo);
    //        cmdfr12.Parameters.AddWithValue("@MPIN", MPIN);        
    //        //cmdfr12.Parameters.AddWithValue("@SignupStatus", "DONE");
    //        //cmdfr12.Parameters.AddWithValue("@MobileverifyStatus", "Pending");
    //        //cmdfr12.Parameters.AddWithValue("@PersonalInfoStatus", "Pending");
    //        //cmdfr12.Parameters.AddWithValue("@KycStatus", "Pending");
    //        //cmdfr12.Parameters.AddWithValue("@DocumentStatus", "Pending");
    //        //cmdfr12.Parameters.AddWithValue("@AgrementStatus", "Pending");
    //        //cmdfr12.Parameters.AddWithValue("@businessdetailsstatus", "Pending");
    //        cmdfr12.Parameters.AddWithValue("@RegistrationStatus", "Pending");
    //        cmdfr12.Parameters.AddWithValue("@RegDate", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss.fff"));
    //        cmdfr12.Parameters.AddWithValue("@Status", "1");
    //        con.Open();
    //        int result = Convert.ToInt32(cmdfr12.ExecuteScalar());
    //        // cmdfr12.ExecuteNonQuery();
    //        con.Close();
    //        return result;
    //    }
    //    catch (Exception ex)
    //    {
    //        return 0;
    //    }
    //    finally
    //    {
    //        con.Close();
    //    }
    //}

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

    public string UpdateOtpStatus(string UserId)

    {
        try
        {
            string sqlfr12 = "update onboarding set MobileverifyStatus=@MobileverifyStatus where UserID=@UserID";
            SqlCommand cmdfr12 = new SqlCommand(sqlfr12, con);
            cmdfr12.Parameters.AddWithValue("@UserID", UserId);
            cmdfr12.Parameters.AddWithValue("@SignupStatus", "DONE");
            cmdfr12.Parameters.AddWithValue("@MobileverifyStatus", "DONE");
            con.Open();
            cmdfr12.ExecuteNonQuery();
            con.Close();
            return "1";
        }
        catch (Exception ex)
        {
            return ex.ToString();
        }
        finally
        {
            con.Close();
        }
    }

    public string UpdatePersonalInfo(string VoterCardNo, string AadharNo, string FatherName, string MotherName, string DOB, string Gender, string Userposition, string Address, string State, string Pincode, string Education, string UserID)
    {

        try
        {
            string sqlfr12 = "update onboarding set Education=@Education,Userposition=@Userposition,VoterCardNo=@VoterCardNo,AadharNo=@AadharNo,MotherName=@MotherName,FatherName=@FatherName,Gender=@Gender,DOB=@DOB,Address=@Address,Pincode=@Pincode,State=@State,PersonalInfoStatus=@PersonalInfoStatus where UserID=@UserID";
            SqlCommand cmdfr12 = new SqlCommand(sqlfr12, con);
            cmdfr12.Parameters.AddWithValue("@Education", Education);
            cmdfr12.Parameters.AddWithValue("@VoterCardNo", VoterCardNo);
            cmdfr12.Parameters.AddWithValue("@AadharNo", AadharNo);
            cmdfr12.Parameters.AddWithValue("@Pincode", Pincode);
            cmdfr12.Parameters.AddWithValue("@Userposition", Userposition);
            cmdfr12.Parameters.AddWithValue("@State", State);
            cmdfr12.Parameters.AddWithValue("@Address", Address);
            cmdfr12.Parameters.AddWithValue("@DOB", DOB);
            cmdfr12.Parameters.AddWithValue("@Gender", Gender);
            cmdfr12.Parameters.AddWithValue("@FatherName", FatherName);
            cmdfr12.Parameters.AddWithValue("@MotherName", MotherName);
            cmdfr12.Parameters.AddWithValue("@PersonalInfoStatus", "DONE");
            cmdfr12.Parameters.AddWithValue("@UserID", UserID);
            con.Open();
            cmdfr12.ExecuteNonQuery();
            con.Close();
            return "1";
        }
        catch (Exception ex)
        {
            return ex.ToString();
        }
        finally
        {
            con.Close();
        }
    }


    public string UpdateBusinessInfo(string CompanyName, string companyaddress, string UdyamRegNo, string BusinessType, string BusinessStartOn, string UserId)
    {

        try
        {
            string sqlfr12 = "update onboarding set CompanyName=@CompanyName,companyaddress=@companyaddress,UdyamRegNo=@UdyamRegNo,BusinessType=@BusinessType,BusinessStartOn=@BusinessStartOn,businessdetailsstatus=@businessdetailsstatus where UserID=@UserID";
            SqlCommand cmdfr12 = new SqlCommand(sqlfr12, con);
            cmdfr12.Parameters.AddWithValue("@CompanyName", CompanyName);
            cmdfr12.Parameters.AddWithValue("@companyaddress", companyaddress);
            cmdfr12.Parameters.AddWithValue("@UdyamRegNo", UdyamRegNo);
            cmdfr12.Parameters.AddWithValue("@BusinessType", BusinessType);
            cmdfr12.Parameters.AddWithValue("@BusinessStartOn", BusinessStartOn);
            cmdfr12.Parameters.AddWithValue("@businessdetailsstatus", "DONE");
            cmdfr12.Parameters.AddWithValue("@UserID", UserId);
            con.Open();
            cmdfr12.ExecuteNonQuery();
            con.Close();
            return "1";
        }
        catch (Exception ex)
        {
            return ex.ToString();
        }
        finally
        {
            con.Close();
        }
    }

    public string UpdatebankInfo(string AccountHolderName, string Accountno, string BankName, string IfscCode, string Accounttype, string UserId)
    {

        try
        {
            string sqlfr12 = "update onboarding set AccountHolderName=@AccountHolderName,BankName=@BankName,Accountno=@Accountno,IfscCode=@IfscCode,Accounttype=@Accounttype,Bankaccountstatus=@Bankaccountstatus where UserID=@UserID";
            SqlCommand cmdfr12 = new SqlCommand(sqlfr12, con);
            cmdfr12.Parameters.AddWithValue("@AccountHolderName", AccountHolderName);
            cmdfr12.Parameters.AddWithValue("@BankName", BankName);
            cmdfr12.Parameters.AddWithValue("@Accountno", Accountno);
            cmdfr12.Parameters.AddWithValue("@IfscCode", IfscCode);
            cmdfr12.Parameters.AddWithValue("@Accounttype", Accounttype);
            cmdfr12.Parameters.AddWithValue("@Bankaccountstatus", "DONE");
            cmdfr12.Parameters.AddWithValue("@UserID", UserId);
            con.Open();
            cmdfr12.ExecuteNonQuery();
            con.Close();
            return "1";
        }
        catch (Exception ex)
        {
            return ex.ToString();
        }
        finally
        {
            con.Close();
        }
    }

    public string UpdateKycinfo(string PanUpload, string AadharUpload, string Aadharbackcopy, string VoterCardUpload, string UdyamUpload,string GstUpload,string JioTagPhotoUpload,string PassportSizePhoto, string UserId)
    {

        try
        {
            string sqlfr12 = "update onboarding set PassportSizePhoto=@PassportSizePhoto,JioTagPhotoUpload=@JioTagPhotoUpload,GstUpload=@GstUpload,PanUpload=@PanUpload,AadharUpload=@AadharUpload,Aadharbackcopy=@Aadharbackcopy,VoterCardUpload=@VoterCardUpload,UdyamUpload=@UdyamUpload,KycStatus=@KycStatus where UserID=@UserID";
            SqlCommand cmdfr12 = new SqlCommand(sqlfr12, con);
            cmdfr12.Parameters.AddWithValue("@PanUpload", PanUpload);
            cmdfr12.Parameters.AddWithValue("@AadharUpload", AadharUpload);
            cmdfr12.Parameters.AddWithValue("@Aadharbackcopy", Aadharbackcopy);
            cmdfr12.Parameters.AddWithValue("@VoterCardUpload", VoterCardUpload);
            cmdfr12.Parameters.AddWithValue("@UdyamUpload", UdyamUpload);
            cmdfr12.Parameters.AddWithValue("@KycStatus", "DONE");
            cmdfr12.Parameters.AddWithValue("@GstUpload", GstUpload);
            cmdfr12.Parameters.AddWithValue("@JioTagPhotoUpload", JioTagPhotoUpload);
            cmdfr12.Parameters.AddWithValue("@PassportSizePhoto", PassportSizePhoto);
            cmdfr12.Parameters.AddWithValue("@UserID", UserId);
            con.Open();
            cmdfr12.ExecuteNonQuery();
            con.Close();
            return "1";
        }
        catch (Exception ex)
        {
            return ex.ToString();
        }
        finally
        {
            con.Close();
        }
    }

    public string UpdateDocument(string RegistrationForm, string UserId)
    {

        try
        {
            string sqlfr12 = "update onboarding set RegistrationForm=@RegistrationForm,DocumentStatus=@DocumentStatus where UserID=@UserID";
            SqlCommand cmdfr12 = new SqlCommand(sqlfr12, con);
          
            cmdfr12.Parameters.AddWithValue("@RegistrationForm", RegistrationForm);
            cmdfr12.Parameters.AddWithValue("@DocumentStatus", "DONE");
            cmdfr12.Parameters.AddWithValue("@UserID", UserId);
            con.Open();
            cmdfr12.ExecuteNonQuery();
            con.Close();
            return "1";
        }
        catch (Exception ex)
        {
            return ex.ToString();
        }
        finally
        {
            con.Close();
        }
    }

    public string UpdateAgrement(string AgrementCopy, string UserId)
    {

        try
        {
            string sqlfr12 = "update onboarding set AgrementCopy=@AgrementCopy,OnboardingStatus=@OnboardingStatus where UserID=@UserID";
            SqlCommand cmdfr12 = new SqlCommand(sqlfr12, con);

            cmdfr12.Parameters.AddWithValue("@AgrementCopy", AgrementCopy);
            cmdfr12.Parameters.AddWithValue("@OnboardingStatus", "DONE");
            cmdfr12.Parameters.AddWithValue("@UserID", UserId);
            con.Open();
            cmdfr12.ExecuteNonQuery();
            con.Close();
            return "1";
        }
        catch (Exception ex)
        {
            return ex.ToString();
        }
        finally
        {
            con.Close();
        }
    }

    public string getidbymobile(string UserMob)
    {
        string pid;
        string query = "select * from onboarding where MobileNo=@UserMob";
        SqlCommand mcom = new SqlCommand(query, con);
        mcom.Parameters.AddWithValue("@UserMob", UserMob);
      
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

    public string getPanbyId(string UserID)
    {
        string pid;
        string query = "select * from onboarding where UserID=@UserMob";
        SqlCommand mcom = new SqlCommand(query, con);
        mcom.Parameters.AddWithValue("@UserMob", UserID);

        SqlDataAdapter mda = new SqlDataAdapter(mcom);
        DataTable dt = new DataTable();
        mda.Fill(dt);
        if (dt.Rows.Count > 0)
        {
            pid = dt.Rows[0]["PancardNo"].ToString();
        }
        else
        {
            pid = "0";
        }
        return pid;
    }

    //correct them below imppp
    //public string GetPlan(string uid)
    //{
    //    string query = "select PlanId from  UserDetails where UserKey=@ProductId";
    //    SqlCommand mcom = new SqlCommand(query, con);
    //    mcom.Parameters.AddWithValue("@ProductId", uid);
    //    SqlDataAdapter mda = new SqlDataAdapter(mcom);
    //    DataTable dt = new DataTable();
    //    mda.Fill(dt);
    //    string mainbalance;
    //    if (dt.Rows.Count > 0)
    //    {
    //        mainbalance = dt.Rows[0]["PlanId"].ToString();
    //    }
    //    else
    //    {
    //        mainbalance = "0";
    //    }
    //    return mainbalance;
    //}
    //public string GetCommission(int CPId, int ProdKey, decimal amount)
    //{
    //    try
    //    {
    //        string query = "select *from CommissionSlab where CPId=@CPId and ProdKey=@ProdKey";
    //        SqlCommand mcom = new SqlCommand(query, con);
    //        mcom.Parameters.AddWithValue("@CPId", CPId);
    //        mcom.Parameters.AddWithValue("@ProdKey", ProdKey);
    //        SqlDataAdapter mda = new SqlDataAdapter(mcom);
    //        DataTable dt = new DataTable();
    //        mda.Fill(dt);
    //        string mainbalance;
    //        if (dt.Rows.Count > 0)
    //        {
    //            decimal CommRs = Convert.ToDecimal(dt.Rows[0]["CommRs"].ToString());
    //            decimal CommPer = Convert.ToDecimal(dt.Rows[0]["CommPer"].ToString());
    //            decimal totalcomm = (amount * CommPer / 100) + CommRs;
    //            mainbalance = totalcomm.ToString();
    //        }
    //        else
    //        {
    //            mainbalance = "0.00";
    //        }
    //        return mainbalance;
    //    }
    //    catch
    //    {
    //        return "";
    //    }
    //}
    //public string GetCharge(int CPId, int ProdKey, decimal amount)
    //{
    //    try
    //    {

    //        string query = "select *from CommissionSlab where CPId=@CPId and ProdKey=@ProdKey";
    //        SqlCommand mcom = new SqlCommand(query, con);
    //        mcom.Parameters.AddWithValue("@CPId", CPId);
    //        mcom.Parameters.AddWithValue("@ProdKey", ProdKey);
    //        SqlDataAdapter mda = new SqlDataAdapter(mcom);
    //        DataTable dt = new DataTable();
    //        mda.Fill(dt);
    //        string mainbalance;

    //        if (dt.Rows.Count > 0)
    //        {
    //            decimal CommRs = Convert.ToDecimal(dt.Rows[0]["ChargeRs"].ToString());
    //            decimal CommPer = Convert.ToDecimal(dt.Rows[0]["ChargePer"].ToString());
    //            decimal totalcomm = (amount * CommPer / 100) + CommRs;
    //            mainbalance = totalcomm.ToString();
    //        }
    //        else
    //        {
    //            mainbalance = "0.00";
    //        }
    //        return mainbalance;
    //    }
    //    catch
    //    {
    //        return "";
    //    }
    //}

    public string bindaepsbal(string uid)
    {

        string ProductId = uid;
        string query = "select TOP 1* from  UserMainBalance where ToUserKey=@ProductId order by Id desc";
        SqlCommand mcom = new SqlCommand(query, con);
        mcom.Parameters.AddWithValue("@ProductId", ProductId);
        SqlDataAdapter mda = new SqlDataAdapter(mcom);
        DataTable dt = new DataTable();
        mda.Fill(dt);
        string mainbalance;
        if (dt.Rows.Count > 0)
        {
            mainbalance = dt.Rows[0]["new_bal"].ToString();
        }
        else
        {
            mainbalance = "0.00";
        }
        return mainbalance;
    }

    public string GetCommission(int CPId, int ProdKey, decimal amount)
    {
        try
        {
            string query = "select *from CommissionSlab where CPId=@CPId and ProdKey=@ProdKey";
            SqlCommand mcom = new SqlCommand(query, con);
            mcom.Parameters.AddWithValue("@CPId", CPId);
            mcom.Parameters.AddWithValue("@ProdKey", ProdKey);
            SqlDataAdapter mda = new SqlDataAdapter(mcom);
            DataTable dt = new DataTable();
            mda.Fill(dt);
            string mainbalance;
            if (dt.Rows.Count > 0)
            {
                decimal CommRs = Convert.ToDecimal(dt.Rows[0]["CommRs"].ToString());
                decimal CommPer = Convert.ToDecimal(dt.Rows[0]["CommPer"].ToString());
                decimal totalcomm = (amount * CommPer / 100) + CommRs;
                mainbalance = totalcomm.ToString();
            }
            else
            {
                mainbalance = "0.00";
            }
            return mainbalance;
        }
        catch
        {
            return "";
        }
    }
    public string GetCharge(int CPId, int ProdKey, decimal amount)
    {
        try
        {

            string query = "select *from CommissionSlab where CPId=@CPId and ProdKey=@ProdKey";
            SqlCommand mcom = new SqlCommand(query, con);
            mcom.Parameters.AddWithValue("@CPId", CPId);
            mcom.Parameters.AddWithValue("@ProdKey", ProdKey);
            SqlDataAdapter mda = new SqlDataAdapter(mcom);
            DataTable dt = new DataTable();
            mda.Fill(dt);
            string mainbalance;

            if (dt.Rows.Count > 0)
            {
                decimal CommRs = Convert.ToDecimal(dt.Rows[0]["ChargeRs"].ToString());
                decimal CommPer = Convert.ToDecimal(dt.Rows[0]["ChargePer"].ToString());
                decimal totalcomm = (amount * CommPer / 100) + CommRs;
                mainbalance = totalcomm.ToString();
            }
            else
            {
                mainbalance = "0.00";
            }
            return mainbalance;
        }
        catch
        {
            return "";
        }
    }
    public string GetPlan(string uid)
    {


        string query = "select PlanId from  UserDetails where UserKey=@ProductId";
        SqlCommand mcom = new SqlCommand(query, con);
        mcom.Parameters.AddWithValue("@ProductId", uid);
        SqlDataAdapter mda = new SqlDataAdapter(mcom);
        DataTable dt = new DataTable();
        mda.Fill(dt);
        string mainbalance;
        if (dt.Rows.Count > 0)
        {
            mainbalance = dt.Rows[0]["PlanId"].ToString();
        }
        else
        {
            mainbalance = "0";
        }
        return mainbalance;
    }

    public string AEPSTransactionInsert(int UserKey, string TransactionID, string CustomerNumber, decimal Amount, string ComingFrom, string Status, string ProdKey, string ProdName, string bankiin, string aadhaar_uid, string APIResponse, string ipay_uuid, string opr_id, string orderid)
    {

        try
        {
            string ADKey = "0";
            string ADMargin = "0";
            string SDKey = "0";
            string SDMargin = "0";
            string RMKey = "0";
            string RMMargin = "0";
            string ZBPKey = "0";
            string ZBPMargin = "0";
            string RetailerCommission = "0";
            string RetailerCurrentDeduction = "0";
            string RetailerChargesAmount = "0";

            string query = "select * from  UserDetails where UserKey=@ProductId";
            SqlCommand mcom = new SqlCommand(query, con);
            mcom.Parameters.AddWithValue("@ProductId", UserKey);
            SqlDataAdapter mda = new SqlDataAdapter(mcom);
            DataTable dt = new DataTable();
            mda.Fill(dt);
            string PlanId = "0";
            string userdetails = "0";
            if (dt.Rows.Count > 0)
            {
                ADKey = dt.Rows[0]["ADKey"].ToString();
                SDKey = dt.Rows[0]["SDKey"].ToString();
                RMKey = dt.Rows[0]["RMKey"].ToString();
                ZBPKey = dt.Rows[0]["ZBPKey"].ToString();
                PlanId = dt.Rows[0]["PlanId"].ToString();
                userdetails = dt.Rows[0]["FirstName"].ToString() + "-" + dt.Rows[0]["UserMob"].ToString();
            }
            RetailerCommission = GetCommission(Convert.ToInt32(PlanId), Convert.ToInt32(ProdKey), Amount);
            RetailerChargesAmount = GetCharge(Convert.ToInt32(PlanId), Convert.ToInt32(ProdKey), Amount);
            ADMargin = GetCommission(4, Convert.ToInt32(ProdKey), Amount);
            SDMargin = GetCommission(3, Convert.ToInt32(ProdKey), Amount);
            RMMargin = GetCommission(2, Convert.ToInt32(ProdKey), Amount);

            decimal BalBefore = Convert.ToDecimal(bindaepsbal(UserKey.ToString()));
            decimal comm = Convert.ToDecimal(RetailerCommission);
            decimal charge = Convert.ToDecimal(RetailerChargesAmount);
            decimal Tds = comm * 5 / 100;
            decimal Gst = charge * 18 / 100;
            decimal Newbal = (BalBefore + Amount + (comm - Tds) - (charge + Gst));

            //string Password = ddlusertype.Text + DateTime.Now.ToString("ddmmyyHHmm");
            SqlCommand cmd = new SqlCommand("", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "AEPSTransactionInsert";
            cmd.Parameters.AddWithValue("@UserKey", UserKey);
            cmd.Parameters.AddWithValue("@TransactionID", TransactionID);
            cmd.Parameters.AddWithValue("@CustomerNumber", CustomerNumber);
            cmd.Parameters.AddWithValue("@Aggregator", "INS");
            cmd.Parameters.AddWithValue("@BalBefore", BalBefore);
            cmd.Parameters.AddWithValue("@Amount", Amount);
            cmd.Parameters.AddWithValue("@BalAfter", Newbal);
            cmd.Parameters.AddWithValue("@ComingFrom", ComingFrom);
            cmd.Parameters.AddWithValue("@RetailerCommission", Convert.ToDecimal(RetailerCommission));
            cmd.Parameters.AddWithValue("@RetailerCurrentDeduction", Convert.ToDecimal(RetailerCurrentDeduction));
            cmd.Parameters.AddWithValue("@RetailerChargesAmount", Convert.ToDecimal(RetailerChargesAmount));
            cmd.Parameters.AddWithValue("@ADKey", Convert.ToInt32(ADKey));
            cmd.Parameters.AddWithValue("@ADMargin", Convert.ToDecimal(ADMargin));
            cmd.Parameters.AddWithValue("@SDKey", Convert.ToInt32(SDKey));
            cmd.Parameters.AddWithValue("@SDMargin", Convert.ToDecimal(SDMargin));
            cmd.Parameters.AddWithValue("@RMKey", Convert.ToInt32(RMKey));
            cmd.Parameters.AddWithValue("@RMMargin", Convert.ToDecimal(RMMargin));
            cmd.Parameters.AddWithValue("@ZBPKey", Convert.ToInt32(ZBPKey));
            cmd.Parameters.AddWithValue("@ZBPMargin", Convert.ToDecimal(ZBPMargin));
            cmd.Parameters.AddWithValue("@Status", Status);
            cmd.Parameters.AddWithValue("@NewStatus", Status);
            cmd.Parameters.AddWithValue("@ProdKey", Convert.ToInt32(ProdKey));
            cmd.Parameters.AddWithValue("@ProdName", ProdName);
            cmd.Parameters.AddWithValue("@bankiin", bankiin);
            cmd.Parameters.AddWithValue("@aadhaar_uid", aadhaar_uid);

            cmd.Parameters.AddWithValue("@APIResponse", APIResponse);
            cmd.Parameters.AddWithValue("@ipay_uuid", ipay_uuid);
            cmd.Parameters.AddWithValue("@opr_id", opr_id);
            cmd.Parameters.AddWithValue("@orderid", orderid);
            cmd.CommandTimeout = 0;
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
            return "1";

        }
        catch (Exception ex)
        {
            return ex.ToString();
        }
        finally
        {
            con.Close();
        }
    }
    public string AEPSTransactionUpdate(int userKey, string TransactionID, string APIResponse, string ipay_uuid, string NewStatus, string orderid, string opr_id, string Amount, string ProdKey, string aadhaar_uid)
    {

        try
        {
            //SqlCommand cmd = new SqlCommand("", con);
            //cmd.CommandType = CommandType.StoredProcedure;
            //cmd.CommandText = "AEPSTransactionUpdate";
            //cmd.Parameters.AddWithValue("@userKey", userKey);
            //cmd.Parameters.AddWithValue("@TransactionID", TransactionID);
            //cmd.Parameters.AddWithValue("@APIResponse", APIResponse);
            //cmd.Parameters.AddWithValue("@ipay_uuid", ipay_uuid);
            //cmd.Parameters.AddWithValue("@NewStatus", NewStatus);
            //cmd.Parameters.AddWithValue("@opr_id", opr_id);
            //cmd.Parameters.AddWithValue("@orderid", orderid);
            //cmd.CommandTimeout = 0;
            //con.Open();
            //cmd.ExecuteNonQuery();
            //con.Close();

            if (NewStatus == "SUCCESS")
            {
                string distribute = distrubuteaepscomm(userKey, Convert.ToDecimal(Amount), ProdKey, aadhaar_uid, TransactionID);
            }
            return "1";
        }
        catch (Exception ex)
        {
            return ex.ToString();
        }
        finally
        {
            con.Close();
        }
    }
    public string distrubuteaepscomm(int userkey, decimal Amount, string ProdKey, string aadhaar_uid, string TransactionID)
    {
        try
        {
            string userdetails = GetUsername(userkey);
            string query = "select * from  AEPSTransDetails where UserKey=@UserKey and TransactionID=@TransactionID";
            SqlCommand mcom = new SqlCommand(query, con);
            mcom.Parameters.AddWithValue("@UserKey", userkey);
            mcom.Parameters.AddWithValue("@TransactionID", TransactionID);
            SqlDataAdapter mda = new SqlDataAdapter(mcom);
            DataTable dt = new DataTable();
            mda.Fill(dt);

            ///RetailerCommission,ADKey,ADMargin,SDKey,SDMargin,RMKey,RMMargin
            string RetailerCommission = "0";
            string ADKey = "0";
            string SDKey = "0";
            string RMKey = "0";

            string ADMargin = "0";
            string SDMargin = "0";
            string RMMargin = "0";


            if (dt.Rows.Count > 0)

            {
                ADKey = dt.Rows[0]["ADKey"].ToString();
                SDKey = dt.Rows[0]["SDKey"].ToString();
                RMKey = dt.Rows[0]["RMKey"].ToString();
                ADMargin = dt.Rows[0]["ADMargin"].ToString();
                SDMargin = dt.Rows[0]["SDMargin"].ToString();
                RMMargin = dt.Rows[0]["RMMargin"].ToString();
                RetailerCommission = dt.Rows[0]["RetailerCommission"].ToString();
            }

            string Remarks = "AEPS COMMISSION For Aadhar No:" + aadhaar_uid + " For User:" + userdetails;

            string rtcomm = AEPSBalanceCredit(userkey, "AEPS COMMISSION", Remarks, Convert.ToDecimal(RetailerCommission), aadhaar_uid);

            if (ADKey != "0")
            {
                string adcomm = CreditBalanceForServices(userkey, Convert.ToInt32(ADKey), "AEPS COMMISSION(RT)", Remarks, Convert.ToDecimal(ADMargin), aadhaar_uid);
            }
            //Done
            if (ADKey == "0" && SDKey != "0")
            {
                string sdcomm = CreditBalanceForServices(userkey, Convert.ToInt32(SDKey), "AEPS COMMISSION(SD)", Remarks, Convert.ToDecimal(SDMargin), aadhaar_uid);
                string adcomm = CreditBalanceForServices(userkey, Convert.ToInt32(SDKey), "AEPS COMMISSION(AD)", Remarks, Convert.ToDecimal(ADMargin), aadhaar_uid);
            }

            //Done

            if (ADKey != "0" && SDKey != "0")
            {
                string sdcomm = CreditBalanceForServices(userkey, Convert.ToInt32(SDKey), "AEPS COMMISSION(SD)", Remarks, Convert.ToDecimal(SDMargin), aadhaar_uid);
            }
            //Done

            if (ADKey != "0" && SDKey != "0" && RMKey != "0")
            {
                string rmcomm = CreditBalanceForServices(userkey, Convert.ToInt32(RMKey), "AEPS COMMISSION(RM)", Remarks, Convert.ToDecimal(RMMargin), aadhaar_uid);
            }
            //Done
            if (ADKey == "0" && SDKey == "0" && RMKey != "0")
            {
                string rmcomm = CreditBalanceForServices(userkey, Convert.ToInt32(RMKey), "AEPS COMMISSION(RM)", Remarks, Convert.ToDecimal(RMMargin), aadhaar_uid);
                string sdcomm = CreditBalanceForServices(userkey, Convert.ToInt32(RMKey), "AEPS COMMISSION(SD)", Remarks, Convert.ToDecimal(SDMargin), aadhaar_uid);
                string adcomm = CreditBalanceForServices(userkey, Convert.ToInt32(RMKey), "AEPS COMMISSION(AD)", Remarks, Convert.ToDecimal(ADMargin), aadhaar_uid);
            }

            //done

            if (ADKey != "0" && SDKey == "0" && RMKey != "0")
            {
                string rmcomm = CreditBalanceForServices(userkey, Convert.ToInt32(RMKey), "AEPS COMMISSION(RM)", Remarks, Convert.ToDecimal(RMMargin), aadhaar_uid);
                string sdcomm = CreditBalanceForServices(userkey, Convert.ToInt32(RMKey), "AEPS COMMISSION(SD)", Remarks, Convert.ToDecimal(SDMargin), aadhaar_uid);
            }
            //Done
            if (ADKey == "0" && SDKey != "0" && RMKey != "0")
            {
                string rmcomm = CreditBalanceForServices(userkey, Convert.ToInt32(RMKey), "AEPS COMMISSION(RM)", Remarks, Convert.ToDecimal(RMMargin), aadhaar_uid);
            }
            //Done

            return "1";
        }
        catch (Exception ex)
        {
            return ex.ToString();
        }
        finally
        {
            con.Close();
        }
    }

    public string CreditBalanceForServices(int FromUserKey, int ToUserKey, string transaction_type, string remarks, decimal amount, string Accountno)
    {
        try
        {
            decimal oldbalance = Convert.ToDecimal(bindbal(ToUserKey.ToString()));
            decimal newbal = oldbalance + amount;
            string rem = transaction_type + " For Account No " + Accountno + "| Debit by Services | " + remarks + " ";
            con.Open();
            string sqlb1 = "insert into UserMainBalance(remarks,FromUserKey,ToUserKey,old_bal,new_bal,transaction_type,transaction_date,ip_address,cr_dr_type,amount)values(@remarks,@FromUserKey,@ToUserKey,@old_bal,@new_bal,@transaction_type,@transaction_date,@ip_address,@cr_dr_type,@amount)";
            SqlCommand cmdb1 = new SqlCommand(sqlb1, con);
            cmdb1.Parameters.AddWithValue("@FromUserKey", ToUserKey);
            cmdb1.Parameters.AddWithValue("@ToUserKey", ToUserKey);
            cmdb1.Parameters.AddWithValue("@old_bal", oldbalance);
            cmdb1.Parameters.AddWithValue("@new_bal", newbal);
            cmdb1.Parameters.AddWithValue("@transaction_type", transaction_type);
            cmdb1.Parameters.AddWithValue("@transaction_date", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss.fff"));
            cmdb1.Parameters.AddWithValue("@ip_address", "000");
            cmdb1.Parameters.AddWithValue("@cr_dr_type", "Credit");
            cmdb1.Parameters.AddWithValue("@amount", amount);
            cmdb1.Parameters.AddWithValue("@remarks", rem);
            cmdb1.ExecuteNonQuery();
            con.Close();
            return "1";
        }
        catch
        {
            return "-1";
        }
    }

    public string bindbal(string uid)
    {

        string ProductId = uid;
        string query = "select TOP 1* from  UserMainBalance where ToUserKey=@ProductId order by Id desc";
        SqlCommand mcom = new SqlCommand(query, con);
        mcom.Parameters.AddWithValue("@ProductId", ProductId);
        SqlDataAdapter mda = new SqlDataAdapter(mcom);
        DataTable dt = new DataTable();
        mda.Fill(dt);
        string mainbalance;
        if (dt.Rows.Count > 0)
        {
            mainbalance = dt.Rows[0]["new_bal"].ToString();
        }
        else
        {
            mainbalance = "0.00";
        }
        return mainbalance;
    }
    public string GetUsername(int UserKey)
    {
        try
        {
            string query = "select FirstName+'-('+UserMob+')' as Username from UserDetails where UserKey=@UserKey";
            SqlCommand mcom = new SqlCommand(query, con);
            mcom.Parameters.AddWithValue("@UserKey", UserKey);
            SqlDataAdapter mda = new SqlDataAdapter(mcom);
            DataTable dt = new DataTable();
            mda.Fill(dt);

            if (dt.Rows.Count > 0)
            {
                return dt.Rows[0]["Username"].ToString();

            }
            else
            {
                return "NA";
            }
        }
        catch
        {
            return "";
        }
    }
    public string AEPSBalanceCredit(int ToUserKey, string transaction_type, string remarks, decimal amount, string aadharno)
    {
        try
        {
            decimal oldbalance = Convert.ToDecimal(bindaepsbal(ToUserKey.ToString()));
            decimal newbal = oldbalance + amount;
            string rem = "AEPS Transaction Done On Aadhar No " + aadharno + "| Credited by SELF AEPS | " + remarks + " ";
            con.Open();
            string sqlb1 = "insert into UserMainBalance(remarks,FromUserKey,ToUserKey,old_bal,new_bal,transaction_type,transaction_date,ip_address,cr_dr_type,amount)values(@remarks,@FromUserKey,@ToUserKey,@old_bal,@new_bal,@transaction_type,@transaction_date,@ip_address,@cr_dr_type,@amount)";
            SqlCommand cmdb1 = new SqlCommand(sqlb1, con);
            cmdb1.Parameters.AddWithValue("@FromUserKey", ToUserKey);
            cmdb1.Parameters.AddWithValue("@ToUserKey", ToUserKey);
            cmdb1.Parameters.AddWithValue("@old_bal", oldbalance);
            cmdb1.Parameters.AddWithValue("@new_bal", newbal);
            cmdb1.Parameters.AddWithValue("@transaction_type", transaction_type);
            cmdb1.Parameters.AddWithValue("@transaction_date", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss.fff"));
            cmdb1.Parameters.AddWithValue("@ip_address", "000");
            cmdb1.Parameters.AddWithValue("@cr_dr_type", "Credit");
            cmdb1.Parameters.AddWithValue("@amount", amount);
            cmdb1.Parameters.AddWithValue("@remarks", rem);
            cmdb1.ExecuteNonQuery();
            con.Close();
            return "1";
        }
        catch
        {
            return "-1";
        }
    }

    public string AEPSBalanceDebit(int ToUserKey, string transaction_type, string remarks, decimal amount, string aadharno)
    {
        try
        {
            decimal oldbalance = Convert.ToDecimal(bindaepsbal(ToUserKey.ToString()));
            decimal newbal = oldbalance - amount;
            string rem = "Surcharge For Aadhar Pay Transaction Done On Aadhar No " + aadharno + "| Debited by SELF AEPS | " + remarks + " ";

            con.Open();
            string sqlb1 = "insert into UserMainBalance(remarks,FromUserKey,ToUserKey,old_bal,new_bal,transaction_type,transaction_date,ip_address,cr_dr_type,amount)values(@remarks,@FromUserKey,@ToUserKey,@old_bal,@new_bal,@transaction_type,@transaction_date,@ip_address,@cr_dr_type,@amount)";
            SqlCommand cmdb1 = new SqlCommand(sqlb1, con);
            cmdb1.Parameters.AddWithValue("@FromUserKey", ToUserKey);
            cmdb1.Parameters.AddWithValue("@ToUserKey", ToUserKey);
            cmdb1.Parameters.AddWithValue("@old_bal", oldbalance);
            cmdb1.Parameters.AddWithValue("@new_bal", newbal);
            cmdb1.Parameters.AddWithValue("@transaction_type", transaction_type);
            cmdb1.Parameters.AddWithValue("@transaction_date", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss.fff"));
            cmdb1.Parameters.AddWithValue("@ip_address", "000");
            cmdb1.Parameters.AddWithValue("@cr_dr_type", "Debit");
            cmdb1.Parameters.AddWithValue("@amount", amount);
            cmdb1.Parameters.AddWithValue("@remarks", rem);
            cmdb1.ExecuteNonQuery();
            con.Close();

            return "1";
        }
        catch
        {
            return "-1";
        }
    }
}
