using Newtonsoft.Json.Linq;
using RestSharp;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI.WebControls;

namespace NeoXPayout.RMPanel
{
    public partial class TxnReport : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString;
        SqlCommand com = new SqlCommand();
        SqlDataAdapter da = new SqlDataAdapter();
        SqlDataAdapter da1 = new SqlDataAdapter();
        DataSet ds = new DataSet();
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
                    txtfrom.Text = "";
                    getdetails(true);

                }

            }

        }

        public void getdetails(bool reset = false)
        {
            if (Session["RmID"] == null)
            {
                Response.Redirect("LoginRm.aspx");
                return;
            }
            string rmId = Session["RmID"].ToString();
            using (SqlConnection con = new SqlConnection(connStr))
            {

                string query;

                if (reset)
                {
                    query = @"SELECT T.*  FROM TxnReport T INNER JOIN Registration R ON T.UserId = R.RegistrationId  WHERE R.RmId = @RmId ";
                }
                else
                {
                    string datefrom = txtfrom.Text;
                    if (string.IsNullOrEmpty(datefrom))
                    {
                        Label1.Text = "Please select a date.";
                        rptProduct.Visible = false;
                        return;
                    }
                query = @"SELECT T.*  FROM TxnReport T INNER JOIN Registration R ON T.UserId = R.RegistrationId  WHERE R.RmId = @RmId AND (@SearchDate IS NULL OR CONVERT(date, T.TxnDate) = @SearchDate) ";

                }

                using (SqlCommand cmd = new SqlCommand(query, con))
                {

                    cmd.Parameters.AddWithValue("@RmId", rmId);
                    if (!reset)
                        cmd.Parameters.AddWithValue("@SearchDate", txtfrom.Text);

                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    if (!reader.HasRows)
                    {
                        rptProduct.Visible = false;
                        Label1.Text = "No records found!";
                    }
                    else
                    {
                        Label1.Text = "";
                        rptProduct.Visible = true;
                        rptProduct.DataSource = reader;
                        rptProduct.DataBind();
                    }
                }
            }
        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            getdetails(false);
        }
        protected void btnReset_Click(object sender, EventArgs e)
        {
            txtfrom.Text = "";
            getdetails(true);
        }

    }
}