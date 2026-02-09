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
    public partial class rmManagement : System.Web.UI.Page
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
                bindRm();
                LoadRequests();
               
            }
        }
        private void LoadRequests()
        {

            using (SqlConnection con = new SqlConnection(connStr))
            {
                string query = "SELECT RegistrationId, MobileNo,FullName,RmId  FROM Registration";
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
                        gvRequests.DataSource = reader;
                        gvRequests.DataBind();
                        lblMessage.Text = "";
                    }
                }
            }
        }
        private void bindRm()
        {
            DataTable dt = new DataTable();

            using (SqlConnection con = new SqlConnection(
                ConfigurationManager.ConnectionStrings["BankUConnectionString"].ToString()))
            {
                using (SqlCommand cmd = new SqlCommand(
                    "SELECT * FROM RmDetail", con))
                {
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    da.Fill(dt);
                }
            }

            dt.Columns.Add("MobileDisplay", typeof(string));
            foreach (DataRow row in dt.Rows)
            {
                row["MobileDisplay"] = $"{row["RmName"]} ({row["RmMobile"]})";
            }

            ViewState["RmList"] = dt;   // ✅ store for GridView rows
        }
        protected void gvRequests_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                DropDownList ddlStatus =
                    (DropDownList)e.Row.FindControl("ddlStatus");

                if (ddlStatus != null)
                {
                    DataTable dt = ViewState["RmList"] as DataTable;

                    ddlStatus.DataSource = dt;
                    ddlStatus.DataTextField = "MobileDisplay";
                    ddlStatus.DataValueField = "Id";
                    ddlStatus.DataBind();

                    ddlStatus.Items.Insert(0, new ListItem("-- Select RM --", ""));
                }
            }
        }



        protected void gvRequests_RowCommand(object sender, System.Web.UI.WebControls.GridViewCommandEventArgs e)
        {
            if (e.CommandName == "UpdateStatus")
            {
                int id = Convert.ToInt32(e.CommandArgument);
                GridViewRow row = ((System.Web.UI.Control)e.CommandSource).NamingContainer as GridViewRow;
                DropDownList ddlStatus = (DropDownList)row.FindControl("ddlStatus");
                string selectedRmId = ddlStatus.SelectedValue;
                string registrationId = e.CommandArgument.ToString();

                using (SqlConnection con = new SqlConnection(connStr))
                {
                    con.Open();
                    string updateQuery = "UPDATE Registration SET RmId = @RmId WHERE RegistrationId = @RegistrationId";
                    using (SqlCommand cmd = new SqlCommand(updateQuery, con))
                    {
                        cmd.Parameters.AddWithValue("@RmId", selectedRmId);
                        cmd.Parameters.AddWithValue("@RegistrationId", id);
                        cmd.ExecuteNonQuery();
                    }
                }
                LoadRequests();
            }
        }
    }
}