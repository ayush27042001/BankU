using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace NeoXPayout.RMPanel
{
    public partial class LoginRm : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString);
        SqlCommand com = new SqlCommand();
        UserManagement Um = new UserManagement();
        SqlDataAdapter da = new SqlDataAdapter();
        SqlDataAdapter da1 = new SqlDataAdapter();
        DataSet ds = new DataSet();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Session["RmID"] = null;
            }
        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {

            string MobileNo = txtNumber.Text.Trim();
            string password = txtPassword.Text.Trim();

            if (string.IsNullOrEmpty(MobileNo)|| string.IsNullOrEmpty(password))
            {
                lblOTPStatus.CssClass = "text-danger";
                lblOTPStatus.Text = "Please enter Mobile Number and Password.";
                return;
            }       
             using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString))
                {
                    string query = "SELECT * FROM RmDetail WHERE RmMobile=@RmMobile AND RmPassword=@RmPassword AND Status=@Status";
                    using (SqlCommand mcom = new SqlCommand(query, con))
                    {
                        mcom.Parameters.AddWithValue("@RmMobile", MobileNo);
                        mcom.Parameters.AddWithValue("@RmPassword", password);
                        mcom.Parameters.AddWithValue("@Status", "Active");
                        SqlDataAdapter mda = new SqlDataAdapter(mcom);
                        DataTable dt = new DataTable();
                        mda.Fill(dt);

                        if (dt.Rows.Count == 0)
                        {
                            ClientScript.RegisterStartupScript(this.GetType(), "popup", "alert('Invalid Details Please contact admin.');", true);
                        }
                        else
                        {
                            lblOTPStatus.CssClass = "text-success";
                            lblOTPStatus.Text = "Details verifried! Logging you in…";

                            Session["RmMobile"] = dt.Rows[0]["RmMobile"].ToString();
                            Session["RmName"] = dt.Rows[0]["RmName"].ToString();
                            Session["RmID"] = dt.Rows[0]["Id"].ToString();
                         
                                Response.Redirect("DashboardRm.aspx");                            
                        }
                    }
                }           
        }      
    }
}