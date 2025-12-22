using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NeoXPayout.EmployeeDex
{
    public partial class userInfo : System.Web.UI.Page
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

                    getdetails();

                }
            }
        }

        public void getdetails()
        {
            if (Session["AdminMobile"].ToString() == "8861003651")
            {
                string query = "SELECT RegistrationId, FullName, MobileNo,Email,RegDate,RegistrationStatus,AccountType,MPIN, AccountType FROM Registration WHERE AccountType IN('Distributor', 'Business & APIs') ORDER BY RegistrationId DESC; ";
                SqlCommand mcom = new SqlCommand(query, con);

                SqlDataAdapter mda = new SqlDataAdapter(mcom);
                DataTable dt = new DataTable();
                mda.Fill(dt);

                if (dt.Rows.Count == 0)
                {
                    rptProduct.Visible = false;
                }
                else
                {
                    rptProduct.Visible = true;
                    rptProduct.DataSource = dt;
                    rptProduct.DataBind();
                }

                con.Close();
            }
            else if (Session["AdminMobile"].ToString() == "7979804478")
            {
                string query = "SELECT RegistrationId, FullName, MobileNo,Email,RegDate,RegistrationStatus,AccountType,MPIN, AccountType FROM Registration WHERE AccountType IN('BankU Seva Kendra') ORDER BY RegistrationId DESC; ";
                SqlCommand mcom = new SqlCommand(query, con);

                SqlDataAdapter mda = new SqlDataAdapter(mcom);
                DataTable dt = new DataTable();
                mda.Fill(dt);

                if (dt.Rows.Count == 0)
                {
                    rptProduct.Visible = false;
                }
                else
                {
                    rptProduct.Visible = true;
                    rptProduct.DataSource = dt;
                    rptProduct.DataBind();
                }

                con.Close();
            }

        }
    }
}