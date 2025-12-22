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
    public partial class UserLog : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString;
        UserManagement um = new UserManagement();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (this.Session["AdminName"] == null)
            {
                Response.Redirect("Default.aspx");
            }
            if (!IsPostBack)
            {
                LoadRequests();
            }
        }
        private void LoadRequests()
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                string query = "SELECT * FROM AllLoginDoc order by ID desc";
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
        protected void gvRequests_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                string userType = DataBinder.Eval(e.Row.DataItem, "UserType")?.ToString();

                if (userType == "New User")
                {
                    // Apply Green Color
                    e.Row.Cells[4].ForeColor = System.Drawing.Color.Green;
                    e.Row.Cells[4].Font.Bold = true;
                }
            }
        }

        protected void btnClearDate_Click(object sender, EventArgs e)
        {
            LoadRequests();
            ViewState["SearchData"] = null; 
        }


        protected void btnSearchDate_Click(object sender, EventArgs e)
        {
            string selectedDate = Request.Form["fromDate"];

            string query = "SELECT * FROM AllLoginDoc WHERE 1=1";

            if (!string.IsNullOrEmpty(selectedDate))
                query += " AND CONVERT(date, CreatedAt) = @selectedDate";

            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString))
            {
                SqlCommand cmd = new SqlCommand(query, conn);

                if (!string.IsNullOrEmpty(selectedDate))
                    cmd.Parameters.AddWithValue("@selectedDate", selectedDate);

                conn.Open();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                gvRequests.DataSource = dt;
                gvRequests.DataBind();

                ViewState["SearchData"] = dt; // keep data for paging
            }
        }



    }
}