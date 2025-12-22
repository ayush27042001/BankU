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

namespace NeoXPayout.Admin
{
    public partial class SettlementReport : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString);
        SqlCommand com = new SqlCommand();
        SqlDataAdapter da = new SqlDataAdapter();
        SqlDataAdapter da1 = new SqlDataAdapter();
        DataSet ds = new DataSet();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (this.Session["AdminName"] == null)
            {
                Response.Redirect("Default.aspx");
            }
            else
            {
                if (!IsPostBack)
                {
                    txtfrom.Text = DateTime.Now.ToString("yyyy-MM-dd");
                    txtto.Text = DateTime.Now.ToString("yyyy-MM-dd");
                    getdetails();
                    txtUser.Text = this.Session["AdminUID"].ToString();
                }
            }
        }

        public void getdetails()
        {
            string datefrom = txtfrom.Text;
            string dateto = txtto.Text;
            string Service = ddlServiceName.SelectedValue;
            string User = txtUser.Text;
            string url = "https://partner.banku.co.in/api/TxnReport";
            string body = "{\"UserId\":\"" + User + "\",\"Apiversion\":\"" + "1.0" + "\",\"ServiceName\":\"" + Service + "\",\"DateFrom\":\"" + datefrom + "\",\"DateTo\":\"" + dateto + "\"}";
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