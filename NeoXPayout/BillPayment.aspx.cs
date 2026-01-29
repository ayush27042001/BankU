using Newtonsoft.Json.Linq;
using RestSharp;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NeoXPayout
{
    public partial class BillPayment : System.Web.UI.Page
    {
        string con = ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString;
        UserManagement Um = new UserManagement();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (this.Session["BankURTName"] == null || !(Session["IsMPINVerified"] is bool isVerified && isVerified))
            {
                Response.Redirect("LoginBankU.aspx");
            }
            if (!IsRechargeServiceActive())
            {
                pnlMain.Visible = false;
                pnlError.Visible = true;
                return;
            }
            if (!IsPostBack)
            {
                LoadBillPayments();
                ddlOperatorBill.Items.Clear();
                ddlOperatorBill.Items.Add(new ListItem("-- Select Operator --", ""));
            }       
        }

        private bool IsRechargeServiceActive()
        {
            using (SqlConnection CT = new SqlConnection(con))
            {

                string query = "SELECT Status FROM BankUServices WHERE ServiceName = @ServiceName";
                using (SqlCommand cmd = new SqlCommand(query, CT))
                {
                    cmd.Parameters.AddWithValue("@ServiceName", "BillPay");
                    CT.Open();

                    object statusObj = cmd.ExecuteScalar();
                    if (statusObj == null || statusObj == DBNull.Value)
                        return false;

                    string status = statusObj.ToString();

                    return (status.Equals("Active", StringComparison.OrdinalIgnoreCase) || status == "1");
                }
            }
        }

        protected void LoadBillPayments()
        {
            string UserId= Session["BankURTUID"].ToString();
            string cs = ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString;
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = "SELECT * FROM TxnReport WHERE UserId = @UserId AND ServiceName='BillPay' ORDER BY TxnDate DESC";
                SqlCommand cmd = new SqlCommand(query, con);
                con.Open();
                cmd.Parameters.AddWithValue("@UserId", UserId);
                rptBillPayments.DataSource = cmd.ExecuteReader();
                rptBillPayments.DataBind();
            }
        }
        protected void btnPayBill_Click(object sender, EventArgs e)
        {
            string billType = hfBillType.Value;
            string UserId = Session["BankURTUID"].ToString();
            string accountNo = txtAccountNo.Text.Trim();          
            string mobile = txtMobileBill.Text.Trim();             
            string operatorCode = hfOperatorText.Value;           
            string orderid = Guid.NewGuid().ToString("N").Substring(0, 12); 
           
            string username = "6200361373";
            string token = "e34173d9f32d5e44d2c5e6061867374d";

            string url = $"https://connect.ekychub.in/v3/verification/bill_fetch?" +
                         $"username={username}&token={token}&consumer_id={accountNo}&opcode={operatorCode}&orderid={orderid}";

            var client = new RestClient(url);
            var request = new RestRequest(Method.GET);
            request.AddHeader("Accept", "application/json");

            IRestResponse response = client.Execute(request);
            string apiResponse = response.Content;
            Um.LogApiCall(UserId, url, apiResponse, "BBPSBillFetch");
            JObject json = JObject.Parse(apiResponse);
            string status = json["status"]?.ToString();

            // Show modal
          

            if (status == "Success")
            {
                JArray dataArray = (JArray)json["data"];

                if (dataArray != null && dataArray.Count > 0)
                {
                    var d = dataArray[0];
                    string script = "var m = new bootstrap.Modal(document.getElementById('editModal')); m.show();";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowModal", script, true);
                    lblName.Text = d["userName"]?.ToString();
                    lblBillAmount.Text = d["billAmount"]?.ToString();
                    lblBillNo.Text = d["cellNumber"]?.ToString();
                    lblReqID.Text = orderid;
                    lblNumber.Text = mobile;
                    lblbillerResponse.Text = json["message"]?.ToString();

                
                    string dueDate = d["dueDate"]?.ToString();
                    if (!string.IsNullOrEmpty(dueDate))
                        lblDueDate.Text = Convert.ToDateTime(dueDate).ToString("dd-MM-yyyy");

                    editModalLabel.Text = "Bill Fetch Successfully";
                    editModalLabel.CssClass = "modal-title text-success";

                  
                    HiddenField1.Value = d["billAmount"]?.ToString();
                    HiddenField2.Value = d["userName"]?.ToString();
                    HiddenField3.Value = json["message"]?.ToString();
                    HiddenField4.Value = d["cellNumber"]?.ToString();
                    HiddenField5.Value = orderid;
                    HiddenField6.Value = d["billnetamount"]?.ToString();
                }
            }
            else
            {
              
                ErrHeader.CssClass = "modal-title";
                ErrHeader.Text = "Bill fetch failed!";
                lblErrorMessage.Text= json["message"]?.ToString() ?? "Bill fetch failed!";
                ErrMobile.Text = mobile;
                ErrId.Text = json["orderid"]?.ToString() ?? orderid;
                ScriptManager.RegisterStartupScript( this, GetType(),"ShowErrorModal", "var m = new bootstrap.Modal(document.getElementById('ErrorModal')); m.show();",  true );
            }

            LoadBillPayments();
        
        }
        protected void btnPayNow_Click(object sender, EventArgs e)
        {
            string Amount = HiddenField1.Value;
            string Name = HiddenField2.Value;
            string billerResponse = HiddenField3.Value;
            string inputParams = HiddenField4.Value;
            string reqid = HiddenField5.Value;
            string ainfo = HiddenField6.Value;
            string selectedOperatorId = hfOperatorText.Value;
            string getid = getoperatorid(selectedOperatorId);
            if (getid == null)
            {
                lblMessage1.Text = "Operator Not Found";
            }
           
            string MobileNo1 = txtMobileBill.Text;
            string servicename = hfBillType.Value;
            string orderId = hfOrderId.Value;
         
            payMobile.Text = MobileNo1;
            string Accountno = HiddenField4.Value;
            string UserId = this.Session["BankURTUID"].ToString();

          
            string urlBill = "https://partner.banku.co.in/api/BillPay";
            string bodyBill = "{\"UserId\":\"" + UserId + "\",\"Apiversion\":\"" + "1.0" + "\",\"ServiceName\":\"" + servicename + "\",\"OperatorId\":\"" + getid + "\",\"Accountno\":\"" + Accountno + "\",\"MobileNo\":\"" + MobileNo1 + "\",\"Amt\":\"" + Amount + "\",\"CustomerName\":\"" + Name + "\",\"billerResponse\":\"" + billerResponse + "\",\"inputParams\":\"" + inputParams + "\",\"reqid\":\"" + reqid + "\",\"ainfo\":\"" + ainfo + "\"}";
            string ApiresponseBill = String.Empty;
            var clientBill = new RestClient(urlBill);
            var requestBill = new RestRequest(Method.POST);
            requestBill.AddHeader("cache-control", "no-cache");
            requestBill.AddHeader("Accept", "application/json");
            requestBill.AddHeader("Content-Type", "application/json");
            requestBill.AddParameter("application/json", bodyBill, RestSharp.ParameterType.RequestBody);
            IRestResponse responseBill = clientBill.Execute(requestBill);
            ApiresponseBill = responseBill.Content;
            Um.LogApiCall(UserId, bodyBill, ApiresponseBill, "BBPSBillPay");
            JObject jObjectsBill = JObject.Parse(ApiresponseBill);
            string scode = jObjectsBill["Status"].ToString();

            if (scode == "SUCCESS")
            {
                JObject jObjectBill = JObject.Parse(ApiresponseBill);
                JArray dataArrayBill = (JArray)jObjectBill["Data"];

                string script = "var p = new bootstrap.Modal(document.getElementById('PayModal')); p.show();";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowPayModal", script, true);

                if (dataArrayBill != null && dataArrayBill.Count > 0)
                {
                    payName.Text = dataArrayBill[0]["CustomerName"]?.ToString();
                    payAccount.Text = dataArrayBill[0]["AccountNo"]?.ToString();
                    payOperator.Text = dataArrayBill[0]["Operator"]?.ToString();
                    decimal amount = 0;
                    decimal commission = 0;

                    decimal.TryParse(dataArrayBill[0]["Amount"]?.ToString(), out amount);
                    decimal.TryParse(dataArrayBill[0]["Commission"]?.ToString(), out commission);

                    payAmount.Text = amount.ToString("0.00");
                    payCommission.Text = commission.ToString("0.00");

                    decimal total = amount + commission;
                    lblTotal.Text = total.ToString("0.00");


                    payCurrBal.Text = dataArrayBill[0]["CurrentBalance"]?.ToString();
                    PayTxnID.Text = dataArrayBill[0]["TxnID"]?.ToString();
                    payDate.Text = Convert.ToDateTime(dataArrayBill[0]["TxnDate"]).ToString("dd-MM-yyyy");
                    lblheader.Text = "Bill Paid Successfully";
                    lblheader.CssClass = "modal-title text-success";
                    LoadBillPayments();
                   
                }
            }
            else
            {
                LoadBillPayments();
               

                ErrHeader.CssClass = "modal-title";
                ErrHeader.Text = "Bill Payment failed or invalid response!";
                lblErrorMessage.Text = jObjectsBill["Message"]?.ToString() ?? "Bill Payment failed or invalid response.";
                ErrMobile.Text = MobileNo1;
                ErrId.Text = Accountno;
                ScriptManager.RegisterStartupScript(this, GetType(), "ShowErrorModal", "var m = new bootstrap.Modal(document.getElementById('ErrorModal')); m.show();", true);
            }
        }
        public string getoperatorid(string spkey)
        {
            using (SqlConnection CT = new SqlConnection(con))
            {
                string query = "SELECT Id FROM tbloperator WHERE SPkey = @SPkey";

                using (SqlCommand cmd = new SqlCommand(query, CT))
                {
                    cmd.Parameters.AddWithValue("@SPkey", spkey);
                    CT.Open();

                    object result = cmd.ExecuteScalar();

                    if (result == null || result == DBNull.Value)
                        return null; 

                    return result.ToString(); 
                }
            }
        }


        [System.Web.Services.WebMethod]
        [System.Web.Script.Services.ScriptMethod(ResponseFormat = System.Web.Script.Services.ResponseFormat.Json)]
        public static object GetOperators(string billType)
        {
            string url = "https://partner.banku.co.in/api/GetOperator";
            string body = "{\"UserId\":\"1000\",\"Apiversion\":\"1.0\",\"ServiceName\":\"" + billType + "\"}";

            var client = new RestClient(url);
            var request = new RestRequest(Method.POST);
            request.AddHeader("Accept", "application/json");
            request.AddHeader("Content-Type", "application/json");
            request.AddParameter("application/json", body, RestSharp.ParameterType.RequestBody);
            IRestResponse response = client.Execute(request);

            JObject jObjects = JObject.Parse(response.Content);
            string scode = jObjects["Status"].ToString();

            if (scode == "SUCCESS")
            {
                JArray dataArray = (JArray)jObjects["Data"];
                var operators = dataArray.Select(item => new
                {
                    Id = item["SPkey"]?.ToString(),
                    OperatorName = item["OperatorName"]?.ToString()
                }).ToList();

                return new { Status = "SUCCESS", Data = operators };
            }
            else
            {

                return new { Status = "FAILED", Message = "Operator Not Added" };
            }
        }

      
        //public void GetOperators()
        //{
        //    string billType = hfBillType.Value;
        //    string User = this.Session["BankURTUID"].ToString();
        //    string url = "https://partner.banku.co.in/api/GetOperator";
        //    string body = "{\"UserId\":\"" + "1000" + "\",\"Apiversion\":\"" + "1.0" + "\",\"ServiceName\":\"" + billType + "\"}";
        //    string Apiresponse = String.Empty;
        //    var client = new RestClient(url);
        //    var request = new RestRequest(Method.POST);
        //    request.AddHeader("cache-control", "no-cache");
        //    request.AddHeader("Accept", "application/json");
        //    request.AddHeader("Content-Type", "application/json");
        //    request.AddParameter("application/json", body, RestSharp.ParameterType.RequestBody);
        //    IRestResponse response = client.Execute(request);
        //    Apiresponse = response.Content;

        //    JObject jObjects = JObject.Parse(Apiresponse);
        //    string scode = jObjects["Status"].ToString();
        //    if (scode == "SUCCESS")
        //    {
        //        lblerror.InnerText = "";
        //        JObject jObject = JObject.Parse(Apiresponse);


        //        JArray dataArray = (JArray)jObject["Data"];



        //        if (dataArray != null && dataArray.Count > 0 && scode == "SUCCESS")
        //        {

        //            ddlOperatorBill.Items.Clear();
        //            ddlOperatorBill.Items.Add(new ListItem("-- Select Operator --", ""));

        //            foreach (var item in dataArray)
        //            {
        //                string operatorName = item["OperatorName"]?.ToString();
        //                string id = item["Id"]?.ToString();

        //                if (!string.IsNullOrEmpty(operatorName))
        //                {
        //                    ddlOperatorBill.Items.Add(new ListItem(operatorName, id));
        //                }
        //            }

        //        }
        //    }
        //    else
        //    {

        //        lblerror.InnerText = "Operator Not Added";

        //    }
        //}
        //protected void btnLoadOperators_Click(object sender, EventArgs e)
        //{
        //    GetOperators();
        //    // Reopen the sidebar only for this action
        //    ScriptManager.RegisterStartupScript(this, this.GetType(),
        //        "showSidebar",
        //        "setTimeout(function(){ var sidebar = new bootstrap.Offcanvas(document.getElementById('billSidebar')); sidebar.show(); }, 300);",
        //        true);
        //}
    }
}