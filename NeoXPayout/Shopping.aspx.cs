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
    public partial class Shopping : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString);
        UserManagement um = new UserManagement();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (this.Session["BankURTUID"] == null || !(Session["IsMPINVerified"] is bool isVerified && isVerified))
            {
                Response.Redirect("LoginBankU.aspx");
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
            string query = "select * from  BankUProduct  order by Id desc";
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
        protected void rptProduct_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                DataRowView row = (DataRowView)e.Item.DataItem;
                string status = row["Status"].ToString().Trim().ToLower();

                LinkButton btnBuy = (LinkButton)e.Item.FindControl("btnBuy");

                if (status == "out of stock")
                {
                    btnBuy.Enabled = false;
                    btnBuy.CssClass = "btn btn-secondary btn-lg rounded-pill shadow";
                }
            }
        }

        protected void btnpay_Click(object sender, EventArgs e)
        {
            string orderId = "ORD" + DateTime.Now.ToString("yyyyMMdd") + "-" + new Random().Next(1000, 9999);
            string UserId = Session["BankURTUID"].ToString();
            lblorderId.InnerText = orderId;
            decimal price;
            decimal.TryParse(hfPrice.Value, out price);
           
            decimal balance = 0;
            decimal.TryParse(um.GetBalance(UserId), out balance);
            if (price > balance)
            {
                lblMessage.Text = "Error: Insufficient balance for your account.";
                lblMessage.Attributes["class"] = "text-danger";
                return;
            }
            else
            {
                Decimal NewBalance = balance - price;
                string con = ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString;
                using (SqlConnection conn = new SqlConnection(con))
                {
                    //string query = "UPDATE tbluserbalance SET New_Bal = @NewBalance WHERE UserId = @UserId";
                    string query = "insert into tbluserbalance(Old_Bal,Amount,New_Bal,TxnType,crDrType,UserId,Remarks,TxnDatetime)values(@Old_Bal,@Amount,@New_Bal,@TxnType,@crDrType,@UserId,@Remarks,GETDATE());";
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@Old_Bal", balance);
                        cmd.Parameters.AddWithValue("@Amount", price);
                        cmd.Parameters.AddWithValue("@New_Bal", NewBalance);
                        cmd.Parameters.AddWithValue("@TxnType", "Product Purchase(Shopping.aspx)");
                        cmd.Parameters.AddWithValue("@crDrType", "Debit");
                        cmd.Parameters.AddWithValue("@UserId", UserId);
                        cmd.Parameters.AddWithValue("@Remarks", "Amount Debitted from user");


                        conn.Open();
                        cmd.ExecuteNonQuery();
                    }
                }
            }

            string connectionString = ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString;
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();
                string query = @"INSERT INTO BankuOrder 
        (ProductName, ProductPrice, Total, Quantity, Address, OrderId, Status) 
        VALUES (@ProductName, @ProductPrice, @Total, @Quantity, @Address, @OrderId, @Status)";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@ProductName", hfProductName.Value);
                    cmd.Parameters.AddWithValue("@ProductPrice", hfPrice.Value);
                    cmd.Parameters.AddWithValue("@Total", hfTotal.Value);

 
                    cmd.Parameters.AddWithValue("@Quantity", txtQuantity.Text.Trim());
                    cmd.Parameters.AddWithValue("@Address", txtAddress.Text.Trim());

                    cmd.Parameters.AddWithValue("@OrderId", orderId);
                    cmd.Parameters.AddWithValue("@Status", "Pending");
                    cmd.ExecuteNonQuery();
                }
            }

            // Show success modal
            ScriptManager.RegisterStartupScript(
                this,
                this.GetType(),
                "successModal",
                "var myModal = new bootstrap.Modal(document.getElementById('successModal')); myModal.show();",
                true);
        }

    }
}