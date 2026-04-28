using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
namespace NeoXPayout.Admin
{
    public partial class ViewUser : System.Web.UI.Page
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
                    LoadCounts();
                    SetActiveFilter();
                }
            }
        }

        public void getdetails()
        {
            string filterType = Request.QueryString["type"];
            string filterValue = Request.QueryString["value"];

            string query = "SELECT * FROM Registration WHERE 1=1";

            if (!string.IsNullOrEmpty(filterType) && !string.IsNullOrEmpty(filterValue))
            {
                if (filterType == "account")
                {
                    query += " AND AccountType = @value";
                }
                else if (filterType == "kyc")
                {
                    if (filterValue.ToLower() == "pending")
                        query += " AND (KycStatus IS NULL OR KycStatus = '' OR KycStatus = 'Pending')";
                    else
                        query += " AND KycStatus = @value";
                }
            }

            query += " ORDER BY RegistrationId DESC";

            SqlCommand cmd = new SqlCommand(query, con);

            if (!string.IsNullOrEmpty(filterValue))
                cmd.Parameters.AddWithValue("@value", filterValue);

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            rptProduct.DataSource = dt;
            rptProduct.DataBind();
        }
        public void LoadCounts()
        {
            string query = @"
    SELECT 
        COUNT(*) AS Total,

        -- ACCOUNT TYPE
        SUM(CASE WHEN AccountType = 'BankU Seva Kendra' THEN 1 ELSE 0 END) AS Seva,
        SUM(CASE WHEN AccountType = 'Business & APIs' THEN 1 ELSE 0 END) AS Business,
        SUM(CASE WHEN AccountType = 'Distributor' THEN 1 ELSE 0 END) AS Distributor,

        -- KYC
        SUM(CASE WHEN KycStatus IS NULL OR KycStatus = '' OR KycStatus = 'Pending' THEN 1 ELSE 0 END) AS Pending,
        SUM(CASE WHEN KycStatus = 'Review' THEN 1 ELSE 0 END) AS Review,
        SUM(CASE WHEN KycStatus = 'Approved' THEN 1 ELSE 0 END) AS Approved,
        SUM(CASE WHEN KycStatus = 'Rejected' THEN 1 ELSE 0 END) AS Rejected

    FROM Registration";

            SqlCommand cmd = new SqlCommand(query, con);
            con.Open();

            SqlDataReader dr = cmd.ExecuteReader();

            if (dr.Read())
            {
                sevaCount.InnerText = dr["Seva"].ToString();
                businessCount.InnerText = dr["Business"].ToString();
                distributorCount.InnerText = dr["Distributor"].ToString();

                pendingCount.InnerText = dr["Pending"].ToString();
                reviewCount.InnerText = dr["Review"].ToString();
                approvedCount.InnerText = dr["Approved"].ToString();
                rejectedCount.InnerText = dr["Rejected"].ToString();
            }

            con.Close();
        }
        public void SetActiveFilter()
        {
            string type = Request.QueryString["type"];
            string value = Request.QueryString["value"];

            if (!string.IsNullOrEmpty(type) && !string.IsNullOrEmpty(value))
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "highlight",
                    $"console.log('Active Filter: {type} - {value}');", true);
            }
        }
    }
}