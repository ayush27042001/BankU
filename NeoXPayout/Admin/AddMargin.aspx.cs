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
    public partial class AddMargin : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (this.Session["AdminName"] == null)
            {
                Response.Redirect("Default.aspx");
            }    
        }
       
        protected void btnAdd_Click(object sender, EventArgs e)
        {
            string ServiceName = txtName.Text.Trim();
            string Operatorname = txtOperator.Text.Trim();
            string IPShare = txtIPShare.Text.Trim();
            string WlShare = txtWLShare.Text.Trim();
            string ComType = txtComtype.Text.Trim();

            

            string connectionString = ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString;
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();

                string query = @"INSERT INTO MarginSetting 
                    (ServiceName, Operatorname, IPShare, WlShare,CommissionType) 
                    VALUES (@ServiceName, @Operatorname, @IPShare, @WlShare,@CommissionType)";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@ServiceName", ServiceName);
                    cmd.Parameters.AddWithValue("@Operatorname", Operatorname);
                    cmd.Parameters.AddWithValue("@IPShare", IPShare);
                    cmd.Parameters.AddWithValue("@WlShare", WlShare);
                    cmd.Parameters.AddWithValue("@CommissionType", ComType);
                    cmd.ExecuteNonQuery();
                }

                con.Close();
            }

            ScriptManager.RegisterStartupScript(
                this,
                this.GetType(),
                "successModal",
                "var myModal = new bootstrap.Modal(document.getElementById('successModal')); myModal.show();", true);

            txtName.Text = "";
            txtOperator.Text = "";
            txtIPShare.Text = "";
            txtWLShare.Text = "";
            txtComtype.Text = "";
        }
    }
}