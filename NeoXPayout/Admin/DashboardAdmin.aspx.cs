using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.Services;
using System.Web.Script.Services;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NeoXPayout.Admin
{
    public partial class Dashboard : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString);
        UserManagement Um = new UserManagement();
        SqlCommand com = new SqlCommand();
        SqlDataAdapter da = new SqlDataAdapter();
        SqlDataAdapter da1 = new SqlDataAdapter();
        DataSet ds = new DataSet();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (this.Session["AdminUID"] == null)
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
            string today = DateTime.Now.ToString("yyyy-MM-dd");

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString))
            {
                con.Open();

                // 1. TODAY TRANSACTION AMOUNT

                string queryToday = @"SELECT SUM(Amount) AS TotalTxnAmt 
                              FROM TxnReport 
                              WHERE Status = @Status 
                              AND TxnDate >= @StartDate 
                              AND TxnDate <= @EndDate";

                SqlCommand cmdToday = new SqlCommand(queryToday, con);
                cmdToday.Parameters.AddWithValue("@Status", "SUCCESS");
                cmdToday.Parameters.AddWithValue("@StartDate", today + " 00:00:00");
                cmdToday.Parameters.AddWithValue("@EndDate", today + " 23:59:59");

                object todayResult = cmdToday.ExecuteScalar();

                lblTodayAmount.Text = (todayResult == null || todayResult == DBNull.Value)
                                        ? "0.00"
                                        : Convert.ToDecimal(todayResult).ToString("0.00");
          
                // 2. TOTAL TRANSACTION (ALL DAYS)
              
                string queryTotal = @"SELECT SUM(Amount) AS TotalAmount 
                              FROM TxnReport 
                              WHERE Status = @Status";

                SqlCommand cmdTotal = new SqlCommand(queryTotal, con);
                cmdTotal.Parameters.AddWithValue("@Status", "SUCCESS");

                object totalResult = cmdTotal.ExecuteScalar();

                lblTotalTxn.Text = (totalResult == null || totalResult == DBNull.Value)
                                        ? "0.00"
                                        : Convert.ToDecimal(totalResult).ToString("0.00");

                // 3. TOTAL USERS COUNT
                string queryUsers = @"SELECT COUNT(RegistrationId) FROM Registration";

                SqlCommand cmdUsers = new SqlCommand(queryUsers, con);

                object totalUsers = cmdUsers.ExecuteScalar();

                lblUsers.Text = (totalUsers == null || totalUsers == DBNull.Value)
                                    ? "0"
                                    : totalUsers.ToString();

            }
        }

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static object GetDashboardChartData()
        {
            List<string> last7Days = new List<string>();
            List<int> transactionData = new List<int>();

            // Prepare last 7 days (Date format: dd MMM)
            for (int i = 6; i >= 0; i--)
            {
                last7Days.Add(DateTime.Now.AddDays(-i).ToString("dd MMM"));
            }

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString))
            {
                con.Open();

                // ================== GET LAST 7 DAYS TRANSACTIONS ==================
                string weeklyQuery = @"
            SELECT CONVERT(VARCHAR(10), TxnDate, 120) AS TxnDay,
                   COUNT(*) AS Total
            FROM TxnReport
            WHERE Status='SUCCESS'
            AND TxnDate >= DATEADD(DAY, -6, CAST(GETDATE() AS DATE))
            GROUP BY CONVERT(VARCHAR(10), TxnDate, 120)
            ORDER BY TxnDay ASC";

                SqlCommand cmd = new SqlCommand(weeklyQuery, con);
                SqlDataReader dr = cmd.ExecuteReader();

                Dictionary<string, int> data = new Dictionary<string, int>();
                while (dr.Read())
                {
                    data[Convert.ToString(dr["TxnDay"])] = Convert.ToInt32(dr["Total"]);
                }
                dr.Close();

                // Build dataset for 7 days
                foreach (string dateLabel in last7Days)
                {
                    string dbDate = DateTime.ParseExact(dateLabel, "dd MMM", null).ToString("yyyy-MM-dd");

                    transactionData.Add(data.ContainsKey(dbDate) ? data[dbDate] : 0);
                }

                // ================== LAST 5 MONTH USER GROWTH ==================
                List<string> months = new List<string>();
                List<int> usersData = new List<int>();

                string monthQuery = @"
            SELECT DATENAME(MONTH, RegDate) AS MonthName,
                   COUNT(*) AS TotalUsers,
                   MONTH(RegDate) AS MonthNum
            FROM Registration
            WHERE RegDate >= DATEADD(MONTH, -4, GETDATE())
            GROUP BY DATENAME(MONTH, RegDate), MONTH(RegDate)
            ORDER BY MonthNum";

                SqlCommand cmdMonth = new SqlCommand(monthQuery, con);
                SqlDataReader dr2 = cmdMonth.ExecuteReader();

                while (dr2.Read())
                {
                    months.Add(dr2["MonthName"].ToString());
                    usersData.Add(Convert.ToInt32(dr2["TotalUsers"]));
                }
                dr2.Close();

                return new
                {
                    days = last7Days,       // e.g. ["15 Feb", "16 Feb", ...]
                    transaction = transactionData,
                    months = months,
                    users = usersData
                };
            }
        }



        //public string successtotaltxn()
        //{
        //    string from = DateTime.Now.ToString("yyyy-MM-dd");
        //    con.Open();
        //    string query = "select sum(Amount) as Totaltxnamt from tblpayouttxn where ReqDate>=@TimeStampFrom and ReqDate<=@TimeStamp and Status=@Status and UserId=@UserId";
        //    SqlCommand mcom = new SqlCommand(query, con);
        //    mcom.Parameters.AddWithValue("@TimeStampFrom", from + " 00:00:00.000");
        //    mcom.Parameters.AddWithValue("@TimeStamp", from + " 23:59:59.000");
        //    mcom.Parameters.AddWithValue("@Status", "SUCCESS");
        //    mcom.Parameters.AddWithValue("@UserId", this.Session["AdminNeoxUID"].ToString());
        //    SqlDataAdapter mda = new SqlDataAdapter(mcom);
        //    DataTable dt = new DataTable();
        //    mda.Fill(dt);
        //    string pc;
        //    if (dt.Rows.Count == 0)
        //    {
        //        pc = "0.00";
        //    }
        //    else
        //    {
        //        pc = dt.Rows[0]["Totaltxnamt"].ToString();
        //    }
        //    con.Close();
        //    return pc;
        //}
        //public string GetBalance(string uid)
        //{

        //    string ProductId = uid;
        //    string query = "select TOP 1* from  tblAPIWallet where UserId=@ProductId order by Id desc";
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
        //}
    }
}