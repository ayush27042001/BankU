using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NeoXPayout.Admin
{
    public partial class ManageDISTReq : System.Web.UI.Page
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
                string query = "SELECT * FROM DistAcctiveRequest";
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


        protected void gvRequests_RowCommand(object sender, System.Web.UI.WebControls.GridViewCommandEventArgs e)
        {
            if (e.CommandName == "UpdateStatus")
            {
                string[] args = e.CommandArgument.ToString().Split('|');
                int id = Convert.ToInt32(args[0]);       
                int userId = Convert.ToInt32(args[1]);   
                string reqId = args[2];
                string title = args[3];
                GridViewRow row = ((System.Web.UI.Control)e.CommandSource).NamingContainer as GridViewRow;
                DropDownList ddlStatus = (DropDownList)row.FindControl("ddlStatus");
                string selectedStatus = ddlStatus.SelectedValue;
                string fullName = "";
                string mobileNo = "";

                using (SqlConnection con = new SqlConnection(connStr))
                {
                    con.Open();
                  
                    string GetUser = "SELECT FullName, MobileNo FROM Registration WHERE RegistrationId=@UserId";
                    using (SqlCommand cmd = new SqlCommand(GetUser, con))
                    {
                        cmd.Parameters.AddWithValue("@UserId", userId);
                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                fullName = reader["FullName"].ToString();
                                mobileNo = reader["MobileNo"].ToString();
                            }
                        }
                    }

                    string updateQuery = "UPDATE DistAcctiveRequest SET Status = @Status WHERE Id = @Id";
                    using (SqlCommand cmd = new SqlCommand(updateQuery, con))
                    {
                        cmd.Parameters.AddWithValue("@Status", ddlStatus.SelectedValue);
                        cmd.Parameters.AddWithValue("@Id", id);
                        cmd.ExecuteNonQuery();
                    }
                }
                // Send SMS based on status
                if (selectedStatus == "Approved")
                {
                    um.ApproveMsg(mobileNo, title, fullName, reqId);
                }
                else if (selectedStatus == "Rejected")
                {
                    um.RejectMsg(mobileNo, title, fullName, reqId);
                }
                LoadRequests();
            }
        }
    }
}