using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.IO;
using Newtonsoft.Json.Linq;

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
            string query = "select * from  Registration where RegistrationId=@RegistrationId";

            SqlCommand mcom = new SqlCommand(query, cn);
            mcom.Parameters.AddWithValue("@RegistrationId", this.Session["BankURTUID"].ToString());

            SqlDataAdapter mda = new SqlDataAdapter(mcom);
            DataTable dt = new DataTable();
            mda.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                HiddenField1.Value = dt.Rows[0]["CompanyName"].ToString();
                HiddenField2.Value = dt.Rows[0]["RegistrationId"].ToString();
                
                HiddenField3.Value = dt.Rows[0]["BusinessType"].ToString();
                //HiddenField7.Value = dt.Rows[0]["PassportSizePhoto"].ToString();
                HiddenField4.Value = dt.Rows[0]["MobileNo"].ToString();
                HiddenFieldShop.Value = dt.Rows[0]["CompanyName"].ToString();
                HiddenPan.Value = dt.Rows[0]["PANNo"].ToString();
                //HiddenFieldDate.Value = Convert.ToDateTime(dt.Rows[0]["BusinessStartOn"]).ToString("yyyy-MM-dd");
                HiddenField5.Value = dt.Rows[0]["FullName"].ToString();
                
                //HiddenField6.Value = dt.Rows[0]["companyaddress"].ToString();
                
            }   
        }
    }
}