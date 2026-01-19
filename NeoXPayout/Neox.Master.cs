using Newtonsoft.Json.Linq;
using RestSharp;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NeoXPayout
{
    public partial class Neox : System.Web.UI.MasterPage
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString);
        SqlCommand com = new SqlCommand();
        SqlDataAdapter da = new SqlDataAdapter();
        SqlDataAdapter da1 = new SqlDataAdapter();
        DataSet ds = new DataSet();
        UserManagement Um = new UserManagement();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (this.Session["BankURTName"] == null)
            {
                Response.Redirect("LoginBankU.aspx");
            }
            else
            {
                if (!IsPostBack)
                {
                    //lblName.Text = Session["BankURTName"].ToString();
                    lblUpiAmount.Text = this.Session["mobileno"].ToString();
                    if (Session["RegistrationStatus"].ToString() == "Done")
                    {
                        Showmenu();
                        Label1.Text = this.Session["BankURTName"].ToString();
                        string UserID = this.Session["BankURTUID"].ToString();
                        /* lblmainwallet.Text = "0.00";*/
                        HiddenField1.Value = "BankULogo1.png";

                        string url = "https://partner.banku.co.in/api/GetUserBalance";
                        string body = "{\"UserId\":\"" + UserID + "\",\"Apiversion\":\"" + "1.0" + "\"}";
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

                            // ✅ Check for success and valid Data array
                            if (scode == "SUCCESS" && jObject["Data"] != null && jObject["Data"].Type == JTokenType.Array)
                            {
                                JArray dataArray = (JArray)jObject["Data"];

                                if (dataArray.Count > 0)
                                {
                                    string currentBalance = dataArray[0]["CurrentBalance"]?.ToString();
                                    lblWalletBalance.Text = "₹" + currentBalance;
                                }
                                else
                                {
                                    lblWalletBalance.Text = "₹0.00";
                                }
                            }
                            else
                            {
                                lblWalletBalance.Text = "₹0.00";
                            }
                        }
                        catch
                        {
                            lblWalletBalance.Text = "₹0.00";
                        }
                        getdetails();
                    }
                    
                }
            }

            //public string APIbindbal(string uid)
            //{

            //    string ProductId = uid;
            //    string query = "select TOP 1* from  WlUserWallet where Userid=@ProductId order by Id desc";
            //    SqlCommand mcom = new SqlCommand(query, con);
            //    mcom.Parameters.AddWithValue("@ProductId", ProductId);
            //    SqlDataAdapter mda = new SqlDataAdapter(mcom);
            //    DataTable dt = new DataTable();
            //    mda.Fill(dt);
            //    string mainbalance;
            //    if (dt.Rows.Count > 0)
            //    {
            //        mainbalance = dt.Rows[0]["New_Bal"].ToString();
            //    }
            //    else
            //    {
            //        mainbalance = "0.00";
            //    }
            //    return mainbalance;
        }
        //protected void Page_PreRender(object sender, EventArgs e)
        //{
        //    if (Session["RequireMPIN"] != null && (bool)Session["RequireMPIN"] == true)
        //    {
        //        ScriptManager.RegisterStartupScript(
        //            this,
        //            GetType(),
        //            "ShowMPINModal",
        //            "setTimeout(function(){ new bootstrap.Modal(document.getElementById('mpinModal')).show(); }, 300);",
        //            true
        //        );
        //    }
        //}


        private void Showmenu()
        {
            string Acctype = (Session["AccountHolderType"]?.ToString() ?? "").Trim().ToUpper();

            // Hide the menu if account type is "Developer"
            if (Acctype == "BANKU SEVA KENDRA")
            {
                liBS_Kendra.Visible = true;
            }
            if (Acctype == "DISTRIBUTOR") 
            {
                liuser.Visible = true;
                liOffering.Visible = true;
            }
            if (Acctype == "BUSINESS & APIS")
            {
                liDeveloper.Visible = true;
            }
        }
        public void getdetails()
        {
            string query = "select * from Registration where RegistrationId=@RegistrationId";

            SqlCommand mcom = new SqlCommand(query, con);
            mcom.Parameters.AddWithValue("@RegistrationId", this.Session["BankURTUID"].ToString());

            SqlDataAdapter mda = new SqlDataAdapter(mcom);
            DataTable dt = new DataTable();
            mda.Fill(dt);

            if (dt.Rows.Count > 0)
            {
                string accountNumber = dt.Rows[0]["BankAccount"].ToString();
                string RmId = dt.Rows[0]["RmId"].ToString();
                if (!string.IsNullOrEmpty(RmId))
                {
                    SetRM(RmId);
                }
                if (!string.IsNullOrEmpty(accountNumber) && accountNumber.Length > 4)
                {
                    
                    string masked = new string('*', accountNumber.Length - 4) + accountNumber.Substring(accountNumber.Length - 4);
                    lblAccountNumber.Text = masked;
                }
                else
                {
                    lblAccountNumber.Text = accountNumber;
                }
            }
        }
        public void SetRM(string RmId)
        {
            string query = "select RmName,RmMobile from RmDetail where Id=@Id AND Status=@Status";

            SqlCommand mcom = new SqlCommand(query, con);
            mcom.Parameters.AddWithValue("@Id", RmId);
            mcom.Parameters.AddWithValue("@Status", "Active");
            SqlDataAdapter mda = new SqlDataAdapter(mcom);
            DataTable dt = new DataTable();
            mda.Fill(dt);

            if (dt.Rows.Count > 0)
            {
                string mobile = dt.Rows[0]["RmMobile"].ToString();

                rmName.InnerText = dt.Rows[0]["RmName"].ToString();
                rmPhone.InnerText = mobile;
                rmPhoneLink.HRef = "tel:" + mobile;

            }
            else
            {
                rmPhone.InnerText = "";
                rmName.InnerText = "";
                rmPhoneLink.HRef ="";
            }
        }
        protected void btnReload_Click(object sender, EventArgs e)
        {
            string UserID = this.Session["BankURTUID"].ToString();
            lblWalletBalance.Text = Um.GetBalance(UserID);
            ScriptManager.RegisterStartupScript(this, GetType(), "OpenSidebar",
            "document.getElementById('bankuModalBackdrop').style.display='flex';", true);
        }
    }
}


