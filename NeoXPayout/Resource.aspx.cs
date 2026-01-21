using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.IO;
using Newtonsoft.Json.Linq;
using System.Web.UI;

namespace NeoXPayout
{
    public partial class Resource : System.Web.UI.Page
    {
        SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString);
        SqlCommand com = new SqlCommand();
        SqlDataAdapter da = new SqlDataAdapter();
        SqlDataAdapter da1 = new SqlDataAdapter();
        DataSet ds = new DataSet();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (this.Session["BankURTUID"] == null || !(Session["IsMPINVerified"] is bool isVerified && isVerified))
            {
                Response.Redirect("LoginBankU.aspx");
            }
            else
            {
                if (!IsPostBack)
                {
                    getdetails();
                   
                   
                }
            }
        }
        public void getdetails()
        {
            string accountHolderType = Session["AccountHolderType"] != null
                ? Session["AccountHolderType"].ToString().ToUpper()
                : "";

            string query = "SELECT * FROM Registration WHERE RegistrationId = @RegistrationId";

            SqlCommand mcom = new SqlCommand(query, cn);
            mcom.Parameters.AddWithValue("@RegistrationId", Session["BankURTUID"]?.ToString());

            SqlDataAdapter mda = new SqlDataAdapter(mcom);
            DataTable dt = new DataTable();
            mda.Fill(dt);

            if (dt.Rows.Count == 0)
                return;

            DataRow row = dt.Rows[0];

            //Run validation ONLY for BANKU SEVA KENDRA
            if (accountHolderType == "BANKU SEVA KENDRA")
            {
                List<string> missingFields = new List<string>();

                if (string.IsNullOrWhiteSpace(row["CompanyName"].ToString()))
                    missingFields.Add("Company Name");

                if (string.IsNullOrWhiteSpace(row["FullName"].ToString()))
                    missingFields.Add("Full Name");

                if (string.IsNullOrWhiteSpace(row["MobileNo"].ToString()))
                    missingFields.Add("Mobile Number");

                if (string.IsNullOrWhiteSpace(row["PANNo"].ToString()))
                    missingFields.Add("PAN Number");

                if (string.IsNullOrWhiteSpace(row["companyaddress"].ToString()))
                    missingFields.Add("Company Address");

                if (string.IsNullOrWhiteSpace(row["ProfileImage"].ToString()))
                    missingFields.Add("Profile Photo");

                if (row["BusinessStartOn"] == DBNull.Value)
                    missingFields.Add("Business Start Date");

              
                if (missingFields.Count > 0)
                {
                    string message =
                        "Your profile is incomplete. Please update the following details to continue:\\n\\n• " +
                        string.Join("\\n• ", missingFields);

                    ScriptManager.RegisterStartupScript(
                        this,
                        GetType(),
                        "profileAlert",
                        $"alert('{message}'); window.location='Profile.aspx';",
                        true
                    );
                    return;
                }
            }

            // Assign values (for ALL account types)
            HiddenField1.Value = row["CompanyName"].ToString();
            HiddenField2.Value = row["RegistrationId"].ToString();
            HiddenField3.Value = row["DOB"].ToString();

            string imgPath = row["ProfileImage"].ToString();
            HiddenField7.Value = ResolveUrl(imgPath);

            HiddenField4.Value = row["MobileNo"].ToString();
            HiddenFieldShop.Value = row["CompanyName"].ToString();
            HiddenPan.Value = row["PANNo"].ToString();
            HiddenFieldDate.Value = Convert.ToDateTime(row["BusinessStartOn"]).ToString("dd-MM-yyyy");
            HiddenField5.Value = row["FullName"].ToString();
            HiddenField8.Value = row["companyaddress"].ToString();
            //HiddenField6.Value = dt.Rows[0]["companyaddress"].ToString();
        }
    }
}