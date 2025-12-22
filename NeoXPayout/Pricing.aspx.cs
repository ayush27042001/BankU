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
                BindRepeater();

            }
        }
       private void BindRepeater()
        {
            using (SqlConnection con = new SqlConnection(conStr))
            {
                SqlDataAdapter da = new SqlDataAdapter("SELECT * FROM MarginSetting", con);
                DataTable dt = new DataTable();
                da.Fill(dt);
                rptMargin.DataSource = dt;
                rptMargin.DataBind();
            }
        }
        protected void rptMargin_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                string userType = Session["AccountHolderType"]?.ToString() ?? "";

                TextBox txtMyShare = (TextBox)e.Item.FindControl("txtMyShare");

                string ipShare = DataBinder.Eval(e.Item.DataItem, "IPShare").ToString();
                string wlShare = DataBinder.Eval(e.Item.DataItem, "WLShare").ToString();

                if (userType == "Distributor")
                {
                    txtMyShare.Text = ipShare;  
                }
                else
                {
                    txtMyShare.Text = wlShare;  
                }
            }
        }

    }
}