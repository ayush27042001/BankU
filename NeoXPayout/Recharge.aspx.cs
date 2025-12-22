using Newtonsoft.Json.Linq;
using RestSharp;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NeoXPayout
{
    public partial class Recharge : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString;
        UserManagement Um = new UserManagement();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["BankURTName"] == null || !(Session["IsMPINVerified"] is bool isVerified && isVerified))
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
                getReport();
                BindOperators();
            }
           
        }

        private bool IsRechargeServiceActive()
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {

                string query = "SELECT Status FROM BankUServices WHERE ServiceName = @ServiceName";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@ServiceName", "Recharge");
                    con.Open();

                    object statusObj = cmd.ExecuteScalar();
                    if (statusObj == null || statusObj == DBNull.Value)
                        return false;

                    string status = statusObj.ToString();

                    return (status.Equals("Active", StringComparison.OrdinalIgnoreCase) || status == "1");
                }
            }
        }
        protected void getReport()
        {
            string UserId = Session["BankURTUID"].ToString();

            string datefrom = txtfrom.Text;
            string dateto = txtto.Text;

            //  Default to last 1 month if no input
            if (string.IsNullOrEmpty(datefrom) || string.IsNullOrEmpty(dateto))
            {
                DateTime today = DateTime.Today;
                DateTime oneMonthAgo = today.AddMonths(-1);

                datefrom = oneMonthAgo.ToString("yyyy-MM-dd");
                dateto = today.ToString("yyyy-MM-dd");

                txtfrom.Text = datefrom;
                txtto.Text = dateto;
            }

            string url = "https://partner.banku.co.in/api/TxnReport";
            string body = "{\"UserId\":\"" + UserId + "\",\"Apiversion\":\"1.0\",\"ServiceName\":\"Recharge\",\"DateFrom\":\"" + datefrom + "\",\"DateTo\":\"" + dateto + "\"}";

            var client = new RestClient(url);
            var request = new RestRequest(Method.POST);
            request.AddHeader("cache-control", "no-cache");
            request.AddHeader("Accept", "application/json");
            request.AddHeader("Content-Type", "application/json");
            request.AddParameter("application/json", body, RestSharp.ParameterType.RequestBody);

            IRestResponse response = client.Execute(request);
            string Apiresponse = response.Content;

            JObject jObjects = JObject.Parse(Apiresponse);
            string scode = jObjects["Status"]?.ToString();

            if (scode == "SUCCESS")
            {
                JArray dataArray = (JArray)jObjects["Data"];
                if (dataArray != null && dataArray.Count > 0)
                {
                    DataTable dt = new DataTable();
                    dt.Columns.Add("UserName");
                    dt.Columns.Add("AccountNo");
                    dt.Columns.Add("IFSCCode");
                    dt.Columns.Add("MobileNo");
                    dt.Columns.Add("Amount", typeof(decimal));
                    dt.Columns.Add("TxnDate");
                    dt.Columns.Add("Surcharge", typeof(decimal));
                    dt.Columns.Add("TransID", typeof(decimal));
                    dt.Columns.Add("Commission", typeof(decimal));
                    dt.Columns.Add("TotalCost", typeof(decimal));
                    dt.Columns.Add("NewBal", typeof(decimal));
                    dt.Columns.Add("Status");
                    dt.Columns.Add("ServiceName");
                    dt.Columns.Add("OperatorName");

                    //  Initialize summary counters
                    int rechargeCount = 0, dthCount = 0;
                    decimal rechargeTotal = 0, rechargeAvg = 0, dthTotal = 0;
                    int rechargeSuccessCount = 0;
                    DateTime today = DateTime.Today;

                    foreach (var item in dataArray)
                    {
                        DataRow row = dt.NewRow();
                        row["UserName"] = item["UserName"]?.ToString();
                        row["AccountNo"] = item["AccountNo"]?.ToString();
                        row["MobileNo"] = item["MobileNo"]?.ToString();
                        row["IFSCCode"] = item["IfscCode"]?.ToString();
                        row["Amount"] = Convert.ToDecimal(item["Amount"] ?? "0");
                        row["TxnDate"] = item["TxnDate"]?.ToString();
                        row["Surcharge"] = Convert.ToDecimal(item["Surcharge"] ?? "0");
                        row["TransID"] = Convert.ToDecimal(item["TransID"] ?? "0");
                        row["Commission"] = Convert.ToDecimal(item["Commission"] ?? "0");
                        row["TotalCost"] = Convert.ToDecimal(item["TotalCost"] ?? "0");
                        row["NewBal"] = Convert.ToDecimal(item["NewBal"] ?? "0");
                        row["Status"] = item["Status"]?.ToString();
                        row["ServiceName"] = item["ServiceName"]?.ToString();
                        row["OperatorName"] = item["OperatorName"]?.ToString();
                        dt.Rows.Add(row);

                        // Calculate today’s summary
                        DateTime txnDate;
                        if (DateTime.TryParse(item["TxnDate"]?.ToString(), out txnDate))
                        {
                            if (txnDate.Date == today)
                            {
                                string type = (item["ServiceName"]?.ToString() ?? "").ToUpper();
                                string status = (item["Status"]?.ToString() ?? "").ToUpper();
                                decimal amount = Convert.ToDecimal(item["Amount"] ?? "0");

                                if (type.Contains("RECHARGE"))
                                {
                                    rechargeCount++;
                                    rechargeTotal += amount;
                                    if (status == "SUCCESS") rechargeSuccessCount++;
                                }
                                else if (type.Contains("DTH"))
                                {
                                    dthCount++;
                                    dthTotal += amount;
                                }
                            }
                        }
                    }

                    //  Bind data to table
                    gvRequests.DataSource = dt;
                    gvRequests.DataBind();

                    //  Calculate averages and assign to labels
                    rechargeAvg = rechargeCount > 0 ? rechargeTotal / rechargeCount : 0;

                    lblTxnToday.Text = rechargeCount.ToString();
                    lblTotalValue.Text = "₹" + rechargeTotal.ToString("N2");
                    lblAvgValue.Text = "₹" + rechargeAvg.ToString("N2");

                    DthToday.Text = dthCount.ToString();
                    DthTotal.Text = "₹" + dthTotal.ToString("N2");

                    lblMessage1.Text = "";
                }
                else
                {
                    lblMessage1.Text = "No request available";
                    lblMessage1.ForeColor = System.Drawing.Color.Red;
                }
            }
            else
            {
                lblMessage1.Text = "No request available";
                lblMessage1.ForeColor = System.Drawing.Color.Red;
            }
        }

        protected void BankPayout_Click(object sender, EventArgs e)
        {
            string UserId = Session["BankURTUID"].ToString();
            string Mobile = txtMobile.Text.Trim();
            string Operator = hfOperator.Value;
            string orderId = "ORD" + DateTime.Now.ToString("yyyyMMddHHmmssfff");
            string circle = ddlCircle.SelectedValue;
            decimal amount;
            decimal.TryParse(txtAmount.Text.Trim(), out amount);
            
           
            string urlRecharge = "https://partner.banku.co.in/api/Recharge";
            string bodyRecharge = "{\"UserId\":\"" + UserId + "\",\"Apiversion\":\"" + "1.0" + "\",\"ServiceName\":\"" + "PREPAID" + "\",\"Amt\":\"" + amount + "\",\"OperatorId\":\"" + Operator + "\",\"Number\":\"" + Mobile + "\"}";
            string ApiresponseRecharge = String.Empty;
            var client = new RestClient(urlRecharge);
            var request = new RestRequest(Method.POST);
            request.AddHeader("cache-control", "no-cache");
            request.AddHeader("Accept", "application/json");
            request.AddHeader("Content-Type", "application/json");
            request.AddParameter("application/json", bodyRecharge, RestSharp.ParameterType.RequestBody);
            IRestResponse response = client.Execute(request);
            ApiresponseRecharge = response.Content;
            Um.LogApiCall(UserId, bodyRecharge, ApiresponseRecharge, "Recharge");
            var json = JObject.Parse(ApiresponseRecharge);

            string Message = json["Message"]?.ToString();
            string Status = json["Status"]?.ToString().ToUpper();

           
            var dataArray = json["Data"] as JArray;
            var data = dataArray != null && dataArray.Count > 0 ? dataArray[0] : null;

            if (Status == "SUCCESS" && data != null)
            {
                string mobileNo = data["MobileNo"]?.ToString();
                string txnId = data["TxnID"]?.ToString();
                string OperatorName = data["Operator"]?.ToString();
                string txnDate = data["TxnDate"]?.ToString();
                string currentBal = data["CurrentBalance"]?.ToString();
                string finalMsg = $@"
        <p>{Message}</p>
        <table style='width:100%; border-collapse:collapse; text-align:left;'>
            <tr>
                <td style='padding:6px; width:40%;'><strong>Mobile No:</strong></td>
                <td style='padding:6px;'>{mobileNo}</td>
            </tr>
            <tr>
                <td style='padding:6px;'><strong>Transaction ID:</strong></td>
                <td style='padding:6px;'>{txnId}</td>
            </tr>
            <tr>
                <td style='padding:6px;'><strong>Operator Name:</strong></td>
                <td style='padding:6px;'>{OperatorName}</td>
            </tr>
            <tr>
                <td style='padding:6px;'><strong>Transaction Date:</strong></td>
                <td style='padding:6px;'>{txnDate}</td>
            </tr>
            <tr>
                <td style='padding:6px;'><strong>Current Balance:</strong></td>
                <td style='padding:6px;'>₹{currentBal}</td>
            </tr>
        </table>";

                //string finalMsg = $"{Message}. Your recharge for mobile number {mobileNo} was successful with Transaction ID {txnId} on {txnDate}. Your current balance is ₹{currentBal}.";

                successModalLabel.Text = "Transaction Successful";
                lblSuccessMsg.Text = finalMsg;

                string script = "var myModal = new bootstrap.Modal(document.getElementById('successModal')); myModal.show();";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "showSuccessModal", script, true);
            }
            else if (Status =="FAILED" && data != null)
            {
                string mobileNo = data["MobileNo"]?.ToString();
                string txnId = data["TxnID"]?.ToString();
                string OperatorName = data["Operator"]?.ToString();
                string txnDate = data["TxnDate"]?.ToString();
                string currentBal = data["CurrentBalance"]?.ToString();
                string finalMsg = $@"
            <p>{Message}</p>
            <table style='width:100%; border-collapse:collapse; text-align:left;'>
                <tr>
                    <td style='padding:6px; width:40%;'><strong>Mobile No:</strong></td>
                    <td style='padding:6px;'>{mobileNo}</td>
                </tr>
                <tr>
                    <td style='padding:6px;'><strong>Transaction ID:</strong></td>
                    <td style='padding:6px;'>{txnId}</td>
                </tr>
                <tr>
                    <td style='padding:6px;'><strong>Operator Name:</strong></td>
                    <td style='padding:6px;'>{OperatorName}</td>
                </tr>
                <tr>
                    <td style='padding:6px;'><strong>Transaction Date:</strong></td>
                    <td style='padding:6px;'>{txnDate}</td>
                </tr>
                <tr>
                    <td style='padding:6px;'><strong>Current Balance:</strong></td>
                    <td style='padding:6px;'>₹{currentBal}</td>
                </tr>
            </table>";
               

                errorModalLabel.Text = "Transaction Failed";
                lblmsg.Text = finalMsg;

                string script = "var myModal = new bootstrap.Modal(document.getElementById('errorModal')); myModal.show();";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "showErrorModal", script, true);
            }
            else 
            {
                errorModalLabel.Text = "Transaction Failed";
                lblmsg.Text = Message;
                string script = "var myModal = new bootstrap.Modal(document.getElementById('errorModal')); myModal.show();";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "showErrorModal", script, true);
            }
            getReport();
            //Response.Redirect(Request.Url.AbsolutePath, false);
        }
       
        protected void PlanMobile_Click(object sender, EventArgs e)
        {
            string Operator = hfOperator.Value;
            string op = GetOperatorCode(Operator);
            string circle = ddlCircle.SelectedValue;
            string servicename = "Mobile";
            string content = mplan(circle, op, servicename);
            JObject jObjects = JObject.Parse(content);

            if (jObjects["STATUS"]?.ToString() == "0" && jObjects["RDATA"] is JObject rdataObj)
            {
                StringBuilder htmlBuilder = new StringBuilder();
                string operatorName = jObjects["Operator"]?.ToString() ?? "N/A";

                htmlBuilder.AppendFormat("<p><b>Operator:</b> {0}</p>", operatorName);

                if (servicename == "DTH")
                {
                    // 🔸 Parse DTH response
                    foreach (var category in rdataObj.Properties())
                    {
                        string categoryName = category.Name;
                        JArray plans = (JArray)category.Value;

                        foreach (var item in plans)
                        {
                            string language = item["Language"]?.ToString();
                            htmlBuilder.AppendFormat("<h5 class='mt-3'>{0} - {1}</h5>", categoryName, language);

                            JArray details = (JArray)item["Details"];
                            foreach (var detail in details)
                            {
                                string planName = detail["PlanName"]?.ToString();
                                string channels = detail["Channels"]?.ToString();
                                string paidChannels = detail["PaidChannels"]?.ToString();
                                string hdChannels = detail["HdChannels"]?.ToString();
                                string lastUpdate = detail["last_update"]?.ToString();

                                htmlBuilder.Append("<div class='mb-2'>");
                                htmlBuilder.AppendFormat("<p><b>{0}</b><br/>Channels: {1}, Paid: {2}, HD: {3}<br/>Last Update: {4}</p>", planName, channels, paidChannels, hdChannels, lastUpdate);

                                JArray pricing = (JArray)detail["PricingList"];
                                htmlBuilder.Append("<div class='table-responsive'><table class='table table-bordered'><thead><tr><th>Select</th><th>Amount</th><th>Validity</th></tr></thead><tbody>");
                                foreach (var price in pricing)
                                {
                                    string amount = price["Amount"]?.ToString();
                                    string month = price["Month"]?.ToString();

                                    htmlBuilder.Append("<tr>");
                                    htmlBuilder.AppendFormat("<td><button type='button' class='btn btn-sm btn-primary plan-btn'  data-amount='{0}'\">Select</button></td>", amount.Replace("₹", "").Trim());
                                    htmlBuilder.AppendFormat("<td>{0}</td>", amount);
                                    htmlBuilder.AppendFormat("<td>{0}</td>", month);
                                    htmlBuilder.Append("</tr>");
                                }
                                htmlBuilder.Append("</tbody></table></div></div>");
                            }
                        }
                    }
                }
                else
                {
                    // 🔹 Mobile plan parsing
                    string circleName = jObjects["Circle"]?.ToString() ?? "N/A";
                    htmlBuilder.AppendFormat("<p><b>Circle:</b> {0}</p>", circleName);

                    foreach (var arrayProp in rdataObj.Properties().Where(p => p.Value.Type == JTokenType.Array))
                    {
                        string groupName = arrayProp.Name;
                        JArray planArray = (JArray)arrayProp.Value;

                        if (planArray.Count == 0) continue;

                        htmlBuilder.Append($"<p class='mt-3'><b>{groupName}</b></p>");
                        htmlBuilder.Append("<div class='table-responsive'>");
                        htmlBuilder.Append("<table class='table table-bordered text-center align-middle'>");
                        htmlBuilder.Append("<thead class='table-dark'><tr><th>Select</th><th>Price</th><th>Validity</th><th>Description</th></tr></thead><tbody>");

                        foreach (JObject plan in planArray)
                        {
                            string rs = plan["rs"]?.ToString() ?? "";
                            string validity = plan["validity"]?.ToString() ?? "";
                            string desc = plan["desc"]?.ToString() ?? "";

                            htmlBuilder.Append("<tr>");
                            htmlBuilder.AppendFormat(
                              "<td><button type='button' class='btn btn-sm btn-primary plan-btn' data-amount='{0}'>Select</button></td>",
                              rs
                            );
                            htmlBuilder.AppendFormat("<td>₹{0}</td>", rs);
                            htmlBuilder.AppendFormat("<td>{0}</td>", validity);
                            htmlBuilder.AppendFormat("<td>{0}</td>", desc);
                            htmlBuilder.Append("</tr>");
                        }

                        htmlBuilder.Append("</tbody></table></div>");
                    }
                }

                litPlansHtml.Text = htmlBuilder.ToString();
                ClientScript.RegisterStartupScript(                  
                    this.GetType(),
                    "openPlansSidebar",
                    "setTimeout(function(){ var ps = new bootstrap.Offcanvas(document.getElementById('plansSidebar')); ps.show(); },200);",
                    true
                );
            }
            else
            {
                lblNoPlans.Text = "Invalid response or STATUS not 0.";
                lblNoPlans.Visible = true;
                // Sidebar open karo
                ClientScript.RegisterStartupScript(
                    this.GetType(),
                    "openPlansSidebarError",
                    "setTimeout(function(){ var ps = new bootstrap.Offcanvas(document.getElementById('plansSidebar')); ps.show(); },200);",
                    true
                );
            }
        }
        public string mplan(string Circle, string operatorcode, string serviceName)
        {
            try
            {
                string Apiresponse = string.Empty;
                string url = string.Empty;

                if (serviceName == "DTH")
                {
                    
                    url = $"https://planapi.in/api/Mobile/DthPlans?apimember_id=5758&api_password=AAnn@1122&operatorcode={operatorcode}";
                }
                else
                {
                  
                    url = $"https://planapi.in/api/Mobile/NewMobilePlans?apimember_id=5758&api_password=AAnn@1122&operatorcode={operatorcode}&cricle={Circle}";
                }

                var client = new RestClient(url);
                var request = new RestRequest(Method.GET);
                request.AddHeader("cache-control", "no-cache");
                request.AddHeader("Accept", "application/json");
                request.AddHeader("Content-Type", "application/json");
                IRestResponse response = client.Execute(request);
                Apiresponse = response.Content;
                return Apiresponse;
            }
            catch
            {
                return "-1";
            }
        }
        private string GetOperatorCode(string opid)
        {
            switch (opid)
            {
                case "1": return "2";
                case "3": return "23";
                case "2": return "11";
                case "4": return "5";

                // 🔸 DTH Operators (Add based on planapi.in codes)
                case "5": return "24";
                case "6": return "25";
                case "7": return "29";
                case "8": return "27";
                case "9": return "28";

                default: return string.Empty;
            }
        }
        protected void PlanDth_Click(object sender, EventArgs e)
        {
            string Operator = HiddenField2.Value;
            string op = GetOperatorCode(Operator);
            string circle = ddlCircle.SelectedValue;
            string servicename = "DTH";
            string content = mplan(circle, op, servicename);
            JObject jObjects = JObject.Parse(content);

            if (jObjects["STATUS"]?.ToString() == "0" && jObjects["RDATA"] is JObject rdataObj)
            {
                StringBuilder htmlBuilder = new StringBuilder();
                string operatorName = jObjects["Operator"]?.ToString() ?? "N/A";

                htmlBuilder.AppendFormat("<p><b>Operator:</b> {0}</p>", operatorName);

                if (servicename == "DTH")
                {
                   
                    foreach (var category in rdataObj.Properties())
                    {
                        string categoryName = category.Name;
                        JArray plans = (JArray)category.Value;

                        foreach (var item in plans)
                        {
                            string language = item["Language"]?.ToString();
                            htmlBuilder.AppendFormat("<h5 class='mt-3'>{0} - {1}</h5>", categoryName, language);

                            JArray details = (JArray)item["Details"];
                            foreach (var detail in details)
                            {
                                string planName = detail["PlanName"]?.ToString();
                                string channels = detail["Channels"]?.ToString();
                                string paidChannels = detail["PaidChannels"]?.ToString();
                                string hdChannels = detail["HdChannels"]?.ToString();
                                string lastUpdate = detail["last_update"]?.ToString();

                                htmlBuilder.Append("<div class='mb-2'>");
                                htmlBuilder.AppendFormat("<p><b>{0}</b><br/>Channels: {1}, Paid: {2}, HD: {3}<br/>Last Update: {4}</p>", planName, channels, paidChannels, hdChannels, lastUpdate);

                                JArray pricing = (JArray)detail["PricingList"];
                                htmlBuilder.Append("<div class='table-responsive'><table class='table table-bordered'><thead><tr><th>Select</th><th>Amount</th><th>Validity</th></tr></thead><tbody>");
                                foreach (var price in pricing)
                                {
                                    string amount = price["Amount"]?.ToString();
                                    string month = price["Month"]?.ToString();

                                    htmlBuilder.Append("<tr>");
                                    htmlBuilder.AppendFormat("<td><button type='button' class='btn btn-sm btn-primary plan-btn'  data-amount='{0}'\">Select</button></td>", amount.Replace("₹", "").Trim());
                                    htmlBuilder.AppendFormat("<td>{0}</td>", amount);
                                    htmlBuilder.AppendFormat("<td>{0}</td>", month);
                                    htmlBuilder.Append("</tr>");
                                }
                                htmlBuilder.Append("</tbody></table></div></div>");
                            }
                        }
                    }
                }
                else
                {
                   
                    string circleName = jObjects["Circle"]?.ToString() ?? "N/A";
                    htmlBuilder.AppendFormat("<p><b>Circle:</b> {0}</p>", circleName);

                    foreach (var arrayProp in rdataObj.Properties().Where(p => p.Value.Type == JTokenType.Array))
                    {
                        string groupName = arrayProp.Name;
                        JArray planArray = (JArray)arrayProp.Value;

                        if (planArray.Count == 0) continue;

                        htmlBuilder.Append($"<p class='mt-3'><b>{groupName}</b></p>");
                        htmlBuilder.Append("<div class='table-responsive'>");
                        htmlBuilder.Append("<table class='table table-bordered text-center align-middle'>");
                        htmlBuilder.Append("<thead class='table-dark'><tr><th>Select</th><th>Price</th><th>Validity</th><th>Description</th></tr></thead><tbody>");

                        foreach (JObject plan in planArray)
                        {
                            string rs = plan["rs"]?.ToString() ?? "";
                            string validity = plan["validity"]?.ToString() ?? "";
                            string desc = plan["desc"]?.ToString() ?? "";

                            htmlBuilder.Append("<tr>");
                            htmlBuilder.AppendFormat(
                              "<td><button type='button' class='btn btn-sm btn-primary plan-btn' data-amount='{0}'>Select</button></td>",
                              rs
                            );
                            htmlBuilder.AppendFormat("<td>₹{0}</td>", rs);
                            htmlBuilder.AppendFormat("<td>{0}</td>", validity);
                            htmlBuilder.AppendFormat("<td>{0}</td>", desc);
                            htmlBuilder.Append("</tr>");
                        }

                        htmlBuilder.Append("</tbody></table></div>");
                    }
                }

                litPlansHtml.Text = htmlBuilder.ToString();
                ClientScript.RegisterStartupScript(
                    this.GetType(),
                    "openPlansSidebar",
                    "setTimeout(function(){ var ps = new bootstrap.Offcanvas(document.getElementById('plansSidebar')); ps.show(); },200);",
                    true
                );
            }
            else
            {
                lblNoPlans.Text = "Invalid response or STATUS not 0.";
                lblNoPlans.Visible = true;
                // Sidebar open karo
                ClientScript.RegisterStartupScript(
                    this.GetType(),
                    "openPlansSidebarError",
                    "setTimeout(function(){ var ps = new bootstrap.Offcanvas(document.getElementById('plansSidebar')); ps.show(); },200);",
                    true
                );
            }
        }
        protected void btnDth_Click(object sender, EventArgs e)
        {
            string UserId = Session["BankURTUID"].ToString();
            string Mobile = TextBox1.Text.Trim();
            string Operator = HiddenField2.Value;
            string orderId = "ORD" + DateTime.Now.ToString("yyyyMMddHHmmssfff");
            string circle = DropDownList1.SelectedValue;
            decimal amount;
            decimal.TryParse(TextBox2.Text.Trim(), out amount);        

            string urlRecharge = "https://partner.banku.co.in/api/Recharge";
            string bodyRecharge = "{\"UserId\":\"" + UserId + "\",\"Apiversion\":\"" + "1.0" + "\",\"ServiceName\":\"" + "DTH" + "\",\"Amt\":\"" + amount + "\",\"OperatorId\":\"" + Operator + "\",\"Number\":\"" + Mobile + "\"}";
            string ApiresponseRecharge = String.Empty;
            var client = new RestClient(urlRecharge);
            var request = new RestRequest(Method.POST);
            request.AddHeader("cache-control", "no-cache");
            request.AddHeader("Accept", "application/json");
            request.AddHeader("Content-Type", "application/json");
            request.AddParameter("application/json", bodyRecharge, RestSharp.ParameterType.RequestBody);
            IRestResponse response = client.Execute(request);
            ApiresponseRecharge = response.Content;

            var json = JObject.Parse(ApiresponseRecharge);
            string Message = json["Message"]?.ToString();
            string Status = json["Status"]?.ToString().ToUpper();
            if (Status == "SUCCESS")
            {
                
                string script = "var myModal = new bootstrap.Modal(document.getElementById('successModal')); myModal.show();";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "showSuccessModal", script, true);
            }
            else
            {
                errorModalLabel.Text = Status;
                lblmsg.Text = Message;
                string script = "var myModal = new bootstrap.Modal(document.getElementById('errorModal')); myModal.show();";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "showErrorModal", script, true);
               
            }
            getReport();
            //Response.Redirect(Request.Url.AbsolutePath, false);
        }
        private void BindOperators()
        {
            // Fetch Mobile operators
            var mobileResponse = GetOperators("PREPAID");
            if (mobileResponse != null && mobileResponse.GetType().GetProperty("Status")?.GetValue(mobileResponse)?.ToString() == "SUCCESS")
            {
                var data = mobileResponse.GetType().GetProperty("Data")?.GetValue(mobileResponse);
                rptMobileOperators.DataSource = data;
                rptMobileOperators.DataBind();
            }

            var dthResponse = GetOperators("DTH");
            if (dthResponse != null && dthResponse.GetType().GetProperty("Status")?.GetValue(dthResponse)?.ToString() == "SUCCESS")
            {
                var data = dthResponse.GetType().GetProperty("Data")?.GetValue(dthResponse);
                rptDthOperators.DataSource = data;
                rptDthOperators.DataBind();
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
                    Id = item["Id"]?.ToString(),
                    OperatorName = item["OperatorName"]?.ToString(),
                    OperatorImage = item["OperatorImage"]?.ToString()
                }).ToList();

                return new { Status = "SUCCESS", Data = operators };
            }
            else
            {

                return new { Status = "FAILED", Message = "Operator Not Added" };
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            getReport();
        }
    }
}