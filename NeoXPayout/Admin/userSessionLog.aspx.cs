using System;
using System.Collections.Generic;
using System.Configuration;

using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NeoXPayout.Admin
{
    public partial class userSessionLog : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString;
        UserManagement um = new UserManagement();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (this.Session["AdminName"] == null)
                Response.Redirect("Default.aspx");

            if (!IsPostBack)
                LoadRequests();
        }

        private void LoadRequests()
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                string query = "SELECT * FROM LoginDoc ORDER BY ID DESC";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    if (!reader.HasRows)
                    {
                        gvRequests.Visible = false;
                        lblMessage.Text = "No request available";
                        lblMessage.ForeColor = System.Drawing.Color.Red;
                    }
                    else
                    {
                        gvRequests.Visible = true;
                        lblMessage.Text = "";
                        DataTable dt = new DataTable();
                        dt.Load(reader);

                        gvRequests.DataSource = dt;
                        gvRequests.DataBind();
                    }
                }
            }
        }

        protected void gvRequests_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvRequests.PageIndex = e.NewPageIndex;

            DataTable dt = ViewState["SearchData"] as DataTable;

            if (dt != null)
            {
                gvRequests.DataSource = dt;
                gvRequests.DataBind();
            }
            else
            {
                LoadRequests();
            }
        }

        protected void btnClearDate_Click(object sender, EventArgs e)
        {
            ViewState["SearchData"] = null;
            gvRequests.PageIndex = 0;
            lblMessage.Text = "";
            LoadRequests();
        }

        protected void btnSearchDate_Click(object sender, EventArgs e)
        {
            string selectedDate = fromDate.Value;

            if (string.IsNullOrEmpty(selectedDate))
            {
                lblMessage.Text = "Please select a date!";
                lblMessage.ForeColor = System.Drawing.Color.Red;
                return;
            }

            string query = "SELECT * FROM LoginDoc WHERE CONVERT(date, CreatedAt) = @selectedDate";

            using (SqlConnection conn = new SqlConnection(
                ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString))
            {
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@selectedDate", selectedDate);

                conn.Open();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                gvRequests.PageIndex = 0;
                gvRequests.DataSource = dt;
                gvRequests.DataBind();

                ViewState["SearchData"] = dt;

                if (dt.Rows.Count == 0)
                {
                    lblMessage.Text = "No records found for this date!";
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                    gvRequests.Visible = false;
                }
                else
                {
                    lblMessage.Text = "";
                    gvRequests.Visible = true;
                }
            }
        }



    }
}