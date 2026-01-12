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
    public partial class DMTNEW : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString;
        UserManagement Um = new UserManagement();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["BankURTName"] == null || !(Session["IsMPINVerified"] is bool isVerified && isVerified))
            {
                Response.Redirect("LoginBankU.aspx");
            }
            string Acctype = (Session["AccountHolderType"]?.ToString() ?? "").Trim().ToUpper();

            if (Acctype != "BANKU SEVA KENDRA")
            {
                Response.Redirect("Dashboard.aspx");
            }
            if (!IsRechargeServiceActive())
            {
                pnlMain.Visible = false;
                pnlError.Visible = true;

                return;
            }
            if (!IsPostBack)
            {          
                getServiceStatus();
              
            }

        }

        protected void getServiceStatus()
        {
                string ApiVersion = "1.0";
                string Service = "DMT";


                string url = "https://partner.banku.co.in/api/MasterFeature";
                string body = "{\"Apiversion\":\"" + ApiVersion + "\",\"ServiceName\":\"" + Service + "\"}";

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
                    dt.Columns.Add("Id", typeof(int));
                    dt.Columns.Add("ServiceCode");
                    dt.Columns.Add("FeatureName");
                    dt.Columns.Add("IsEnabled", typeof(bool));
                    dt.Columns.Add("DisplayOrder", typeof(int));


                    foreach (JObject item in dataArray)
                    {
                        if (item["ServiceCode"]?.ToString() == "DMT" &&
                            item["IsEnabled"]?.ToObject<bool>() == true)
                        {
                            dt.Rows.Add(
                                Convert.ToInt32(item["Id"]),
                                item["ServiceCode"],
                                item["FeatureName"],
                                item["IsEnabled"],
                                Convert.ToInt32(item["DisplayOrder"])
                            );
                        }
                    }

                    DataView dv = dt.DefaultView;
                    dv.Sort = "DisplayOrder ASC";

                    rptTransferTabs.DataSource = dv;
                    rptTransferTabs.DataBind();

                }
            }
                else
                {
                    lblMessage1.Text = "No request available";
                    lblMessage1.ForeColor = System.Drawing.Color.Red;
                }
            
        }
        private bool IsRechargeServiceActive()
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {

                string query = "SELECT Status FROM BankUServices WHERE ServiceName = @ServiceName";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@ServiceName", "DMT");
                    con.Open();

                    object statusObj = cmd.ExecuteScalar();
                    if (statusObj == null || statusObj == DBNull.Value)
                        return false;

                    string status = statusObj.ToString();

                    return (status.Equals("Active", StringComparison.OrdinalIgnoreCase) || status == "1");
                }
            }
        }
    }
}