using Newtonsoft.Json.Linq;
using RestSharp;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NeoXPayout
{
    public partial class CreditCardBill : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
            if (Session["BankURTName"] == null)
            {
                Response.Redirect("LoginBankU.aspx");
            }
            if (!IsPostBack)
            {
                LoadRechargeHistory();
                string User = Session["BankURTUID"]?.ToString();
                string body = "{\"UserId\":\"" + User + "\",\"Apiversion\":\"1.0\",\"ServiceName\":\"CREDITCARD\"}";
                string url = "https://partner.banku.co.in/api/GetOperator";
                var client = new RestClient(url);
                var request = new RestRequest(Method.POST);
                request.AddHeader("cache-control", "no-cache");
                request.AddHeader("Accept", "application/json");
                request.AddHeader("Content-Type", "application/json");
                request.AddParameter("application/json", body, ParameterType.RequestBody);

                IRestResponse response = client.Execute(request);
                string Apiresponse = response.Content;

                try
                {
                    JObject jObject = JObject.Parse(Apiresponse);
                    string scode = jObject["Status"]?.ToString();

                    ddlOperator.Items.Clear();
                    ddlOperator.Items.Add(new ListItem("Select", ""));

                    //ddlOperator.Items.Add(new ListItem("hii", "hii"));
                    if (scode == "SUCCESS")
                    {
                        JArray dataArray = (JArray)jObject["Data"];

                        if (dataArray != null && dataArray.Count > 0)
                        {
                            foreach (var item in dataArray)
                            {
                                string operatorName = item["OperatorName"]?.ToString();
                                string id = item["Id"]?.ToString();

                                if (!string.IsNullOrEmpty(operatorName))
                                {
                                    ddlOperator.Items.Add(new ListItem(operatorName, id));
                                }
                            }

                            Operator.Text = ""; // Clear any previous error
                        }
                        else
                        {
                            Operator.Text = "No operators found in response.";
                        }
                    }
                    else
                    {
                        Operator.Text = "API returned status: " + scode;
                    }
                }
                catch (Exception ex)
                {
                    Operator.Text = "Error fetching operators. Try again.";
                }
            }

        }

        private void LoadRechargeHistory()
        {
            try
            {
                // Calculate date range (last 5 days including today)
                string dateTo = DateTime.Now.ToString("yyyy-MM-dd");
                string dateFrom = DateTime.Now.AddDays(-4).ToString("yyyy-MM-dd");

                // --- TEMP OVERRIDE for testing (delete this block after confirming dropdown works)
                //dateFrom = "2025-06-01";
                //dateTo = "2025-06-12";
                string userId = Session["BankURTUID"]?.ToString();
                if (string.IsNullOrEmpty(userId))
                {
                    litRechargeHistory.Text = "<div class='text-danger'>User session expired. Please log in again.</div>";
                    return;
                }

                string url = "https://partner.banku.co.in/api/TxnReport";

                // JSON body with dynamic date range and selected service
                string body = $@"
                    {{
                        ""UserId"": ""{userId}"",
                        ""Apiversion"": ""1.0"",
                        ""ServiceName"": ""CREDIT"",
                        ""DateFrom"": ""{dateFrom}"",
                        ""DateTo"": ""{dateTo}""
                    }}";

                var client = new RestClient(url);
                var request = new RestRequest(Method.POST);
                request.AddHeader("Accept", "application/json");
                request.AddHeader("Content-Type", "application/json");
                request.AddParameter("application/json", body, ParameterType.RequestBody);

                IRestResponse response = client.Execute(request);

                if (response.IsSuccessful)
                {
                    JObject result = JObject.Parse(response.Content);

                    if (result["Status"]?.ToString() == "SUCCESS")
                    {
                        JArray dataArray = result["Data"] as JArray;

                        if (dataArray == null || !dataArray.Any())
                        {
                            litRechargeHistory.Text = "<div class='text-muted'>No transaction history found.</div>";
                            return;
                        }

                        string html = "";

                        foreach (var item in dataArray.Take(5))
                        {
                            string operatorName = item["OperatorName"]?.ToString() ?? "";
                            string mobile = item["MobileNo"]?.ToString() ?? "-";
                            string amount = item["Amount"]?.ToString() ?? "0";
                            string date = Convert.ToDateTime(item["TxnDate"]).ToString("MMM dd, yyyy");
                            string status = item["Status"]?.ToString() ?? "PENDING";

                            string logo = operatorName.ToUpper().Contains("HDFC ") ? "HDFC .jpg" :
                                         operatorName.ToUpper().Contains("ICICI ") ? "ICICI .png" :
                                         operatorName.ToUpper().Contains("SBI") ? "SBI.jpg" :
                                         operatorName.ToUpper().Contains("KOTAK") ? "kotak.png" :                                       
                                         "Rupee.png";

                            string amountColor = status == "SUCCESS" ? "green" : "red";

                            html += $@"
                                    <div class='d-flex align-items-center mb-3'>
                                        <img class='avatar rounded' src='assets/images/xs/{logo}' alt=''>
                                        <div class='flex-fill ms-3'>
                                            <div class='h6 mb-0'>{mobile}</div>
                                            <small class='text-muted'>{operatorName}</small>
                                        </div>
                                        <div class='flex-end flex-column d-flex text-end'>
                                            <small class='fw-medium' style='color:{amountColor};'>₹{amount}</small>
                                            <small class='text-muted'>{date}</small>
                                        </div>
                                    </div>
                                    <hr />";
                        }

                        litRechargeHistory.Text = html;
                    }
                    else
                    {
                        litRechargeHistory.Text = "<div class='text-danger'>No successful data found for the selected type.</div>";
                    }
                }
                else
                {
                    litRechargeHistory.Text = "<div class='text-danger'>Failed to fetch recharge history. Please try again later.</div>";
                }
            }
            catch (Exception ex)
            {
                // Log exception (optional)
                litRechargeHistory.Text = $"<div class='text-danger'>Error: {ex.Message}</div>";
            }
        }
        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            
            string cardNo = txtCard.Text.Trim();
            string mobile = txtMobile.Text.Trim();
            string operatorSelected = ddlOperator.SelectedItem.Text;
            string selectedOperatorId = ddlOperator.SelectedValue;
            if (operatorSelected == "Select" ||  string.IsNullOrWhiteSpace(cardNo) || string.IsNullOrWhiteSpace(mobile))
            {
                Label2.Text = "Fill all the details.";
                return;
            }
            else
            {
                Label2.Text = "";
            }

            if (!decimal.TryParse(cardNo, out _) || !decimal.TryParse(mobile, out _))
            {
                Label1.Text = "Enter Valid Details.";
                return;
            }
            else
            {
                Label1.Text = "";
            }
            
            string UserBill = this.Session["BankURTUID"].ToString();
            string urlBill = "https://partner.banku.co.in/api/BillFetch";
            string bodyBill = "{\"UserId\":\"" + UserBill + "\",\"Apiversion\":\"" + "1.0" + "\",\"ServiceName\":\"" + "CREDITCARD" + "\",\"OperatorId\":\"" + selectedOperatorId + "\",\"Accountno\":\"" + cardNo + "\",\"MobileNo\":\"" + mobile + "\"}";
            string ApiresponseBill = String.Empty;
            var clientBill = new RestClient(urlBill);
            var requestBill = new RestRequest(Method.POST);
            requestBill.AddHeader("cache-control", "no-cache");
            requestBill.AddHeader("Accept", "application/json");
            requestBill.AddHeader("Content-Type", "application/json");
            requestBill.AddParameter("application/json", bodyBill, RestSharp.ParameterType.RequestBody);
            IRestResponse responseBill = clientBill.Execute(requestBill);
            ApiresponseBill = responseBill.Content;

            JObject jObjectsBill = JObject.Parse(ApiresponseBill);

            string scode = jObjectsBill["Status"].ToString();
            if (scode == "SUCCESS")
            {
                JObject jObjectBill = JObject.Parse(ApiresponseBill);


                JArray dataArrayBill = (JArray)jObjectBill["Data"];

                string script = "window.onload = function() { $('#editModal').modal('show'); };";
                ClientScript.RegisterStartupScript(this.GetType(), "ShowModal", script, true);

                if (dataArrayBill != null && dataArrayBill.Count > 0 && scode == "SUCCESS")
                {
                    lblName.Text = dataArrayBill[0]["customerName"]?.ToString();
                    lblBillAmount.Text = dataArrayBill[0]["billamount"]?.ToString();
                    lblBillNo.Text = dataArrayBill[0]["billnumber"]?.ToString();
                    lblReqID.Text = dataArrayBill[0]["reqid"]?.ToString();
                    lblbillerResponse.Text = dataArrayBill[0]["billerResponse"]?.ToString();
                    lblDueDate.Text = Convert.ToDateTime(dataArrayBill[0]["duedate"]).ToString("dd-MM-yyyy");
                    editModalLabel.Text = "Bill Fetch Successfully";
                    editModalLabel.CssClass = "modal-title text-success";
                    lblNumber.Text = cardNo;
                    lblMobile.Text = mobile;
                    HiddenField1.Value = dataArrayBill[0]["billamount"]?.ToString();
                    HiddenField2.Value = dataArrayBill[0]["customerName"]?.ToString();
                    HiddenField3.Value = dataArrayBill[0]["billerResponse"]?.ToString();
                    HiddenField4.Value = dataArrayBill[0]["inputParams"]?.ToString();
                    HiddenField5.Value = dataArrayBill[0]["reqid"]?.ToString();
                    HiddenField6.Value = dataArrayBill[0]["ainfo"]?.ToString();
                }

                else
                {
                    editModalLabel.CssClass = "modal-title text-danger";
                    editModalLabel.Text = jObjectBill["Message"]?.ToString() ?? "Recharge failed or invalid response.";
                    lblNumber.Text = mobile;
                    lblReqID.Text = cardNo;
                }

            }
            else
            {
                Label1.Text = "Something Wenr Wrong";
            }
        }
        protected void btnPayNow_Click(object sender, EventArgs e)
        {

            string Amount = HiddenField1.Value;
            string Name = HiddenField2.Value;
            string billerResponse = HiddenField3.Value;
            string inputParams = HiddenField4.Value;
            string reqid = HiddenField5.Value;
            string ainfo = HiddenField6.Value;
            string selectedOperatorId = ddlOperator.SelectedValue;
            string MobileNo1 = txtMobile.Text.Trim();
            
            payMobile.Text = MobileNo1;
            string cardNo = txtCard.Text.Trim();
            string UserBill = this.Session["BankURTUID"].ToString();
            string urlBill = "https://partner.banku.co.in/api/BillPay";
            string bodyBill = "{\"UserId\":\"" + UserBill + "\",\"Apiversion\":\"" + "1.0" + "\",\"ServiceName\":\"" + "CREDITCARD" + "\",\"OperatorId\":\"" + selectedOperatorId + "\",\"Accountno\":\"" + cardNo + "\",\"MobileNo\":\"" + MobileNo1 + "\",\"Amt\":\"" + Amount + "\",\"CustomerName\":\"" + Name + "\",\"billerResponse\":\"" + billerResponse + "\",\"inputParams\":\"" + inputParams + "\",\"reqid\":\"" + reqid + "\",\"ainfo\":\"" + ainfo + "\"}";
            string ApiresponseBill = String.Empty;
            var clientBill = new RestClient(urlBill);
            var requestBill = new RestRequest(Method.POST);
            requestBill.AddHeader("cache-control", "no-cache");
            requestBill.AddHeader("Accept","application/json");
            requestBill.AddHeader("Content-Type", "application/json");
            requestBill.AddParameter("application/json", bodyBill, RestSharp.ParameterType.RequestBody);
            IRestResponse responseBill = clientBill.Execute(requestBill);
            ApiresponseBill = responseBill.Content;

            JObject jObjectsBill = JObject.Parse(ApiresponseBill);

            string scode = jObjectsBill["Status"].ToString();
            if (scode == "SUCCESS")
            {
                JObject jObjectBill = JObject.Parse(ApiresponseBill);


                JArray dataArrayBill = (JArray)jObjectBill["Data"];

                string script = "window.onload = function() { $('#PayModal').modal('show'); };";
                ClientScript.RegisterStartupScript(this.GetType(), "ShowModal", script, true);

                if (dataArrayBill != null && dataArrayBill.Count > 0 && scode == "SUCCESS")
                {
                    payName.Text = dataArrayBill[0]["CustomerName"]?.ToString();
                    payAccount.Text = dataArrayBill[0]["AccountNo"]?.ToString();
                    payOperator.Text = dataArrayBill[0]["Operator"]?.ToString();
                    payAmount.Text = dataArrayBill[0]["Amount"]?.ToString();
                    payCommission.Text = dataArrayBill[0]["Commission"]?.ToString();
                    payCurrBal.Text = dataArrayBill[0]["CurrentBalance"]?.ToString();
                    PayTxnID.Text = dataArrayBill[0]["TxnID"]?.ToString();
                    payDate.Text = Convert.ToDateTime(dataArrayBill[0]["TxnDate"]).ToString("dd-MM-yyyy");
                    lblheader.Text = "Bill Paid Successfully";
                    lblheader.CssClass = "modal-title text-success";
                }

                else
                {
                    lblheader.CssClass = "modal-title text-danger";
                    lblheader.Text = jObjectBill["Message"]?.ToString() ?? "Recharge failed or invalid response.";
                    lblNumber.Text = MobileNo1;
                    lblReqID.Text = cardNo;
                }

            }
            else
            {
                Label1.Text = "Something Wenr Wrong";
            }
        }
    }
}
