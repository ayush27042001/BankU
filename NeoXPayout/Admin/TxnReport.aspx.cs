using Newtonsoft.Json.Linq;
using RestSharp;
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
    public partial class TxnReport : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString;
        SqlCommand com = new SqlCommand();
        SqlDataAdapter da = new SqlDataAdapter();
        SqlDataAdapter da1 = new SqlDataAdapter();
        DataSet ds = new DataSet();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (this.Session["AdminName"] == null)
            {
                Response.Redirect("Default.aspx");
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
           

            using (SqlConnection con = new SqlConnection(connStr))
            {
                string query;

                if (reset)
                {
                    query = "SELECT * FROM TxnReport ORDER BY TxnDate DESC";
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

                    query = @"SELECT * FROM TxnReport                   
                      AND CONVERT(date, TxnDate) = @SearchDate
                      ORDER BY TxnDate DESC";
                }

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    

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