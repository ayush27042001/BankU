using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NeoXPayout.RMPanel
{
    public partial class DashboardRm : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (this.Session["RmID"] == null)
            {
                Response.Redirect("LoginRm.aspx");
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
            string RmId = Session["RmID"].ToString();
          
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString))
            {
                con.Open();

              
                string queryUsers = @"SELECT COUNT(RegistrationId) FROM Registration where RmId=@RmId";

                SqlCommand cmdUsers = new SqlCommand(queryUsers, con);
                cmdUsers.Parameters.AddWithValue("@RmId", RmId);
                object totalUsers = cmdUsers.ExecuteScalar();

                lblUsers.Text = (totalUsers == null || totalUsers == DBNull.Value)
                                    ? "0"
                                    : totalUsers.ToString();


                string queryTxn = @"
                SELECT ISNULL(SUM(T.Amount), 0)
                FROM TxnReport T
                INNER JOIN Registration R ON T.UserId = R.RegistrationId
                WHERE R.RmId = @RmId AND T.Status=@Status";

                using (SqlCommand cmdTxn = new SqlCommand(queryTxn, con))
                {
                    cmdTxn.Parameters.Add("@RmId", SqlDbType.Int).Value = RmId;
                    cmdTxn.Parameters.AddWithValue("@Status", "SUCCESS");

                    object totalTxn = cmdTxn.ExecuteScalar();

                    lblTotalTxn.Text = (totalTxn == null || totalTxn == DBNull.Value)
                                           ? "0"
                                           : Convert.ToDecimal(totalTxn).ToString("N2"); 
                }
            }

        }
    }
}