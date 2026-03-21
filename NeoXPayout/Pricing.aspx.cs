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
    public partial class Pricing : System.Web.UI.Page
    {
        string conStr = ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (this.Session["BankURTName"] == null || !(Session["IsMPINVerified"] is bool isVerified && isVerified))
            {
                Response.Redirect("LoginBankU.aspx");

            }

            if (!IsPostBack)
            {
                LoadCommission();

            }
        }
        public void LoadCommission()
        {
            string accountType = Session["AccountHolderType"].ToString();
            int planId = GetPlanId();
            string userType = "";
            if (accountType == "Distributor")
            {
                userType = "AD";
            }
            else 
            {
                userType = "Retailer";               
            }
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString))
            {
                string query = @"SELECT 
                        cp.PlanName,
                        ch.ServiceId,
                        ISNULL(ch.OperatorId,'-') AS OperatorId,
                        cs.FromAmount,
                        cs.ToAmount,
                        cd.CommissionValue,
                        cd.CommissionType
                    FROM CommissionHeader ch
                    INNER JOIN CommissionPlan cp
                        ON ch.PlanId = cp.PlanId
                    INNER JOIN CommissionSlabs cs 
                        ON ch.CommissionRuleId = cs.CommissionRuleId
                    INNER JOIN CommissionDistribution cd 
                        ON cs.CommissionSlabId = cd.CommissionSlabId
                    WHERE ch.PlanId=@PlanId
                    AND ch.IsActive=1
                     AND cd.UserType = @UserType";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@PlanId", planId);
                cmd.Parameters.AddWithValue("@UserType", userType);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                if (dt.Rows.Count > 0)
                {
                    lblPlanName.Text = dt.Rows[0]["PlanName"].ToString();
                }
                rptMargin.DataSource = dt;
                rptMargin.DataBind();
            }
        }
        public int GetPlanId()
        {
            int planId = 1;
            string userId = Session["BankURTUID"].ToString();

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString))
            {
                string query = "SELECT CommissionPlanId FROM Registration WHERE RegistrationId = @UserId";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@UserId", userId);

                con.Open();

                object result = cmd.ExecuteScalar();

                if (result != null && result != DBNull.Value && result.ToString() != "")
                {
                    planId = Convert.ToInt32(result);
                }

                con.Close();
            }

            return planId;
        }
        protected void rptMargin_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                TextBox txtMyShare = (TextBox)e.Item.FindControl("txtMyShare");

                decimal value = Convert.ToDecimal(DataBinder.Eval(e.Item.DataItem, "CommissionValue"));
                int type = Convert.ToInt32(DataBinder.Eval(e.Item.DataItem, "CommissionType"));

                if (type == 1)
                {
                    txtMyShare.Text = value + " ₹";
                }
                else
                {
                    txtMyShare.Text = value + " %";
                }
            }
        }

    }
}