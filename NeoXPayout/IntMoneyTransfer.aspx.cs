using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NeoXPayout
{
    public partial class IntMoneyTransfer : System.Web.UI.Page
    {
        UserManagement um = new UserManagement();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["BankURTName"] == null ||
                !(Session["IsMPINVerified"] is bool isVerified && isVerified))
            {
                Response.Redirect("LoginBankU.aspx");
            }

            if (!IsPostBack)
            {
                //CheckServiceStatus("International Money Transfer", btnActivateInternational);
                CheckServiceStatus("Nepal Money Transfer", btnActivateNepal);
                CheckServiceStatus("USA Money Transfer", btnActivateUSA);
            }
        }

        private void CheckServiceStatus(string serviceType, Button btn)
        {
            string cs = ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString;
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"SELECT COUNT(1)
                         FROM ServiceActivation
                         WHERE UserID = @UserID AND ServiceType = @ServiceType";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@UserID", Session["BankURTUID"].ToString());
                    cmd.Parameters.AddWithValue("@ServiceType", serviceType);

                    con.Open();
                    int exists = Convert.ToInt32(cmd.ExecuteScalar());

                    if (exists > 0)
                    {
                        btn.Text = "⏳ Processing...";
                        btn.BackColor = System.Drawing.Color.White;
                        btn.ForeColor = System.Drawing.Color.Orange;
                        btn.Enabled = false;
                    }
                }
            }
        }
        protected void btnSaveActivation_Click(object sender, EventArgs e)
        {
            string UserId = Session["BankURTUID"].ToString();
            if (Page.IsValid)
            {
                string serviceType = hdnServiceType.Value;
                decimal amount = 1298;

                decimal balance = 0;
                decimal.TryParse(um.GetBalance(UserId), out balance);
                if (amount > balance)
                {
                    lblError.Text = "Error: Insufficient balance for your account.";
                    lblError.Attributes["class"] = "text-danger";
                    return;
                }
                else
                {
                    Decimal NewBalance = balance - amount;
                    string con = ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString;
                    using (SqlConnection conn = new SqlConnection(con))
                    {

                        string query = "insert into tbluserbalance(Old_Bal,Amount,New_Bal,TxnType,crDrType,UserId,Remarks,TxnDatetime)values(@Old_Bal,@Amount,@New_Bal,@TxnType,@crDrType,@UserId,@Remarks,GETDATE());";
                        using (SqlCommand cmd = new SqlCommand(query, conn))
                        {
                            cmd.Parameters.AddWithValue("@Old_Bal", balance);
                            cmd.Parameters.AddWithValue("@Amount", amount);
                            cmd.Parameters.AddWithValue("@New_Bal", NewBalance);
                            cmd.Parameters.AddWithValue("@TxnType", serviceType+" Request");
                            cmd.Parameters.AddWithValue("@crDrType", "Debit");
                            cmd.Parameters.AddWithValue("@UserId", UserId);
                            cmd.Parameters.AddWithValue("@Remarks", "Amount Debitted from user");

                            conn.Open();
                            cmd.ExecuteNonQuery();
                        }
                    }
                }
             
                string userMessage = txtUseCase.Text.Trim();

                string cs = ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString;
                using (SqlConnection con = new SqlConnection(cs))
                {
                    string query = @"INSERT INTO ServiceActivation
                             (ServiceType, UserID, UserMessage, Status, CreatedAt)
                             VALUES (@ServiceType, @UserID, @UserMessage, 'Pending', GETDATE())";

                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@ServiceType", serviceType);
                        cmd.Parameters.AddWithValue("@UserMessage", userMessage);
                        cmd.Parameters.AddWithValue("@UserID", Session["BankURTUID"].ToString());

                        con.Open();
                        cmd.ExecuteNonQuery();
                    }
                }
              
                //CheckServiceStatus("International Money Transfer", btnActivateInternational);
                CheckServiceStatus("Nepal Money Transfer", btnActivateNepal);
                CheckServiceStatus("USA Money Transfer", btnActivateUSA);
                ScriptManager.RegisterStartupScript(this,GetType(),"showSuccessModal", "showSuccessModal();",true );

            }
        }

    }
}