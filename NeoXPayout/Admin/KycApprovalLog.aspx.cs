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
    public partial class KycApprovalLog : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(
           ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString);

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindLogs();
            }
        }

        void BindLogs()
        {
            SqlDataAdapter da = new SqlDataAdapter(
                "SELECT * FROM KycApprovalLog ORDER BY ApprovedDate DESC", con);

            DataTable dt = new DataTable();

            da.Fill(dt);

            rptLogs.DataSource = dt;
            rptLogs.DataBind();
        }

 
    }
}