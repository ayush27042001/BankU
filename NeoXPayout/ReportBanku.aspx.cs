using Newtonsoft.Json.Linq;
using RestSharp;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NeoXPayout
{
    public partial class ReportBanku : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString);
        SqlCommand com = new SqlCommand();
        SqlDataAdapter da = new SqlDataAdapter();
        SqlDataAdapter da1 = new SqlDataAdapter();
        DataSet ds = new DataSet();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (this.Session["BankURTName"] == null || !(Session["IsMPINVerified"] is bool isVerified && isVerified))
            {
                Response.Redirect("Login.aspx");
            }
            else
            {
            if (!IsPostBack)
            {
                txtfrom.Text = DateTime.Now.ToString("yyyy-MM-dd");
                txtto.Text = DateTime.Now.ToString("yyyy-MM-dd");
                getdetails();

            }

            }

        }
        protected void rptProduct_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "ShowDetails")
            {
                string[] data = e.CommandArgument.ToString().Split('|');

                payAccount.Text = data[0];      // AccountNo
                                                // IFSC not shown, skip data[1]
                payAmount.Text = data[2];       // Amount
                payDate.Text = data[3];         // TxnDate
                payCommission.Text = data[5];   // Commission
                Label4.Text = data[2];          // Total = Amount (again)
                Label5.Text = data[6];          // TotalCost
                payCurrBal.Text = data[7];      // NewBal
                lblheader.Text = data[9];       // ServiceName
                payOperator.Text = data[10];    // Operator
                payName.Text = data[11];        // UserName
                LabelTxnStatus.Text = data[8];         // Status
                Label12.Text = "Thank you for using BankU.";
                ClientScript.RegisterStartupScript(this.GetType(), "Pop", "$(document).ready(function(){$('#PayModal').modal('show');});", true);
            }
        }

        public void getdetails()
        {
            string Service = ddlServiceName.SelectedValue;
            string User = this.Session["BankURTUID"].ToString();
            string url = "https://partner.banku.co.in/api/TxnReport";
            string body = "{\"UserId\":\"" + User + "\",\"Apiversion\":\"" + "1.0" + "\",\"ServiceName\":\"" + Service + "\",\"DateFrom\":\"" + "2025-06-01" + "\",\"DateTo\":\"" + "2025-06-12" + "\"}";
            string Apiresponse = String.Empty;
            var client = new RestClient(url);
            var request = new RestRequest(Method.POST);
            request.AddHeader("cache-control", "no-cache");
            request.AddHeader("Accept", "application/json");
            request.AddHeader("Content-Type", "application/json");
            request.AddParameter("application/json", body, RestSharp.ParameterType.RequestBody);
            IRestResponse response = client.Execute(request);
            Apiresponse = response.Content;

            JObject jObjects = JObject.Parse(Apiresponse);
            string scode = jObjects["Status"].ToString();
            if (scode == "SUCCESS")
            {
                JArray dataArray = (JArray)jObjects["Data"];
                if (dataArray != null && dataArray.Count > 0)
                {
                    DataTable dt = new DataTable();
                    dt.Columns.Add("UserName");
                    dt.Columns.Add("AccountNo");
                    dt.Columns.Add("IFSCCode");
                    dt.Columns.Add("Amount", typeof(decimal));
                    dt.Columns.Add("TxnDate");
                    dt.Columns.Add("Surcharge", typeof(decimal));
                    dt.Columns.Add("Commission", typeof(decimal));
                    dt.Columns.Add("TotalCost", typeof(decimal));
                    dt.Columns.Add("NewBal", typeof(decimal));
                    dt.Columns.Add("Status");
                    dt.Columns.Add("ServiceName");
                    dt.Columns.Add("OperatorName");
                   
                    Label1.Text = "";
                    
                    foreach (var item in dataArray)
                    {
                        DataRow row = dt.NewRow();
                        row["UserName"] = item["UserName"]?.ToString();
                        row["AccountNo"] = item["AccountNo"]?.ToString();
                        row["IFSCCode"] = item["IFSCCode"]?.ToString();
                        row["Amount"] = Convert.ToDecimal(item["Amount"] ?? "0");
                        row["TxnDate"] = item["TxnDate"]?.ToString();
                        row["Surcharge"] = Convert.ToDecimal(item["Surcharge"] ?? "0");
                        row["Commission"] = Convert.ToDecimal(item["Commission"] ?? "0");
                        row["TotalCost"] = Convert.ToDecimal(item["TotalCost"] ?? "0");
                        row["NewBal"] = Convert.ToDecimal(item["NewBal"] ?? "0");
                        row["Status"] = item["Status"]?.ToString();
                        row["ServiceName"] = item["ServiceName"]?.ToString();
                        row["OperatorName"] = item["OperatorName"]?.ToString();       
                        dt.Rows.Add(row);
                    }

                    rptProduct.DataSource = dt;
                    rptProduct.DataBind();
                }
            }
            else
            {
                Label1.Text = "No data found.";
            }
        }
        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            getdetails();
        }
    }
}
