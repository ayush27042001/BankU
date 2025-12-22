using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Security.Cryptography;
using System.Configuration;

namespace NeoXPayout.Models
{

    public class Getbalance
    {
        public string Transaction { get; set; }
        public string Data { get; set; }
    }

    public class NsdlResponse
    {
        public object statuscode { get; set; }
        public object txnid { get; set; }
        public object message { get; set; }
    }

    public class PayoutTxn
    {

        public string AccountNo { get; set; }
        public string BeneName { get; set; }
        public string BankName { get; set; }
        public string Amount { get; set; }
        public string SurCharge { get; set; }

        public string CurrentBalance { get; set; }
        public string Status { get; set; }
        public string TxnID { get; set; }
        public string TxnDate { get; set; }


    }

    public class MoveToWallet
    {

        public string Amount { get; set; }
        public string SurCharge { get; set; }
        public string CurrentAEPSBalance { get; set; }
        public string CurrentMAINBalance { get; set; }
        public string Status { get; set; }
        public string TxnID { get; set; }
        public string TxnDate { get; set; }


    }

    public class MoveToInvestment
    {
        public string Amount { get; set; }
        public string InvestmentBalance { get; set; }
        public string CurrentMAINBalance { get; set; }
        public string Status { get; set; }
        public string TxnID { get; set; }
        public string TxnDate { get; set; }
    }

    public class MoveTodistributor
    {
        public string TransferTo { get; set; }
        public string Amount { get; set; }
        public string SurCharge { get; set; }
        public string CurrentBalance { get; set; }
       
        public string Status { get; set; }
        public string TxnID { get; set; }
        public string TxnDate { get; set; }


    }

    public class RechargeTransaction
    {

        public string MobileNo { get; set; }
        public string Operator { get; set; }
        public string Amount { get; set; }
        public string Commission { get; set; }
        public string CurrentBalance { get; set; }
        public string Status { get; set; }
        public string TxnID { get; set; }
        public string TxnDate { get; set; }


    }

    public class PanTransaction
    {

        public string MobileNo { get; set; }
        public string Operator { get; set; }
        public string Amount { get; set; }
        
        public string CurrentBalance { get; set; }
        public string Status { get; set; }
        public string TxnID { get; set; }
        public string TxnDate { get; set; }


    }

    public class BBPSTransaction
    {

        public string MobileNo { get; set; }
        public string CustomerName { get; set; }
        public string AccountNo { get; set; }
        public string Operator { get; set; }
        public string Amount { get; set; }
        public string Commission { get; set; }
        public string CurrentBalance { get; set; }
        public string Status { get; set; }
        public string TxnID { get; set; }
        public string TxnDate { get; set; }


    }

    public class DMTTransaction
    {

        public string AccountNo { get; set; }
        public string BeneName { get; set; }
        public string BankName { get; set; }
        public string Amount { get; set; }
        public string SurCharge { get; set; }

        public string CurrentBalance { get; set; }
        public string Status { get; set; }
        public string TxnID { get; set; }
        public string TxnDate { get; set; }


    }
    public class BBPSBILL
    {

        public string billamount { get; set; }
        public string billnumber { get; set; }
        public string billperiod { get; set; }
        public string duedate { get; set; }
        public string customerName { get; set; }

        public string billerResponse { get; set; }
        public string inputParams { get; set; }
        public string reqid { get; set; }
        public string ainfo { get; set; }


    }

    public class AEPSOutletReg
    {

        public string aadhaarno { get; set; }
        public string otpReferenceID { get; set; }
        public string hash { get; set; }
    }

    public class AEPSOutletdetails
    {

        public string outletId { get; set; }
        public string name { get; set; }
        public string dateOfBirth { get; set; }
        public string pincode { get; set; }
        public string state { get; set; }
        public string districtName { get; set; }
        public string address { get; set; }
        public string ipay_uuid { get; set; }
        public string orderid { get; set; }
        public string timestamp { get; set; }
    }

    public class GetUser
    {
        public string Data
        {
            get;set;
        }

    }

    public class Billavenuedmtsenderquiry  
    { 
        public string responsecode { get; set; }
        public string responsemessage { get; set; }         
        public string additionalRegData { get; set; }
        public string respDesc { get; set; }
        public string senderMobileNumber { get; set; }
        public string sendername { get; set; }
        public string availablelimit { get; set; }
        public string transactions { get; set; }

    }

    public class aepsresponse
    {
        public object status { get; set; }
        public object orderstatus { get; set; }
        public object txntype { get; set; }
        public object orderamount { get; set; }
        public object acamount { get; set; }
        public object agentid { get; set; }
        public object bankrefno { get; set; }
        public object xmllist { get; set; }
        public object OldBalance { get; set; }
        public object NewBalance { get; set; }
        public object Commission { get; set; }
    }

    public class BillavenueResendOTP
    {
        public string responseCode { get; set; }
        public string respDesc { get; set; }
        public string responseReason { get; set; }
        public string senderMobileNumber { get; set; }
        public string additionalRegData { get; set; }
       

    }

    public class Billavenuegetrecipient
    {
        public string responsecode { get; set; }
        public string Data { get; set; }
       
    }

    public class Bankdetails
    {        
        public string ResponseMessage { get; set; }
        public string Data { get; set; }
    }

    public class EmpModel
    {
        public string response_code { get; set; }
        public string response_msg { get; set; }        
        public object transactions { get; set; }     
        public object display_params { get; set; }
    }

    public class aepsreport
    {
        public string resp_msg { get; set;  }
        public string resp_code { get; set; }

    }



    public class LoginModel
    {     

        public string Status { get; set; }
        public string Message { get; set; }
        public object Data { get; set; }
        //public object Amount { get; set; }
        
    }

    public class SignUpModel
    {

        public string Status { get; set; }
        public string Message { get; set; }
        public object Data { get; set; }
        public object OTP { get; set; }
        public object UserId { get; set; }
        //public object Amount { get; set; }

    }

    public class payouttxn
    {

        public string AccountNo { get; set; }
        public string BeneName { get; set; }
        public string Amount { get; set; }
        public string Status { get; set; }
        public string API_txnId { get; set; }
        public string Client_RefNo { get; set; }
        public string UTRNo { get; set; }
        public string txnDate { get; set; }


    }
    public class UpiPayment
    {

        public string order_id { get; set; }
        public string Amount { get; set; }
        //public string payment_url { get; set; }
        public object upi_intent { get; set; }
        public string Client_refId { get; set; }
        public string txn_Id { get; set; }
        public string UTRNo { get; set; }
        public string TxnDatetime { get; set; }


    }

    public class UpiPayment2
    {

        public string order_id { get; set; }
        public string Amount { get; set; }
        public string payment_url { get; set; }
        //public object upi_intent { get; set; }
        public string Client_refId { get; set; }
        public string txn_Id { get; set; }
        public string UTRNo { get; set; }
        public string TxnDatetime { get; set; }


    }

    public class SenderMobile
    {
        public string senderid { get; set; }
        public string name { get; set; }
        public string limit { get; set; }
        public string mobileno { get; set; }
    }

    public class Report
    {
        public string Transaction { get; set; }
        public string Data { get; set; }
    }

    public class Management
    {
       
    }
    public class Item
    {
        public string balance { get; set; }
       
    }

    public class RootObject
    {
        public List<Item> items { get; set; }
    }

    public class Student
    {
        public object userid { get; set; }
        public object ownername { get; set; }
        public object username { get; set; }
        public object usertype { get; set; }
        public object mobileno { get; set; }
        public object pancard { get; set; }
        public object dpimg { get; set; }
        public object aadharcard { get; set; }
        public object status { get; set; }
        public object deviceid { get; set; }
        public object devicestatus { get; set; }
        public object OutletId { get; set; }
        public object WhiteLableId { get; set; }
        public object Logo { get; set; }
        public object isverify { get; set; }
        public object aepsstatus { get; set; }
        public object kycstatus { get; set; }
        public object EmailId { get; set; }
        public object FirmName { get; set; }
        public object Pincode { get; set; }
        public object Address { get; set; }
    }

    public class Billfetch
    {
        public object customerName { get; set; }
        public object billnumber { get; set; }
        public object billperiod { get; set; }
        public object duedate { get; set; }
        public object amount { get; set; }
        public object reference_id { get; set; }
       

    }

    public class InsBiller
    {
        public object is_bbps_enabled { get; set; }
        public object payment_amt_exactness { get; set; }
        public object payment_mode { get; set; }
        public object payment_channel { get; set; }
        public object service_type { get; set; }
        public object service_provider { get; set; }
        public object product_info { get; set; }
        public object provider_key { get; set; }
        public object bill_fetch { get; set; }
        public object is_tup { get; set; }
        public object is_down { get; set; }
        public object params1 { get; set; }
       
    }

    public class UserKyc
    {
        public object UserKey { get; set; }
        public object KYCStatus { get; set; }
        public object AEPSKYCStatus { get; set; }

    }

    public class Balance
    {
        public object BalanceId { get; set; }
        public object UserKey { get; set; }
        public object CurrentBalance { get; set; }
        
    }

    public class apiBalance
    {
        public object BalanceId { get; set; }
        public object CurrentBalance { get; set; }

    }

    public class fund
    {
        public object tdate { get; set; }
        public object closedate { get; set; }
        public object paymode { get; set; }
        public object bank { get; set; }
        public object refno { get; set; }
        public object Amount { get; set; }
        public object msg { get; set; }
    }

    public class Studentinfo
    {
        public string agent_id { get; set; }

    }

    public class ResponseModel
    {
        public string Message { set; get; }
        public bool Status { set; get; }
        public object Data { set; get; }
    }

    public class SequrityKeys
    {
        public string secret_key { get; set; }
        public string secret_key_timestamp { get; set; }
               
    }

}