using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NeoXPayout.Admin
{
    public partial class SystemUpdate : System.Web.UI.Page
    {
        string conStr = ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindNotifications();
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            using (SqlConnection con = new SqlConnection(conStr))
            {
                SqlCommand cmd;
                if (string.IsNullOrEmpty(hdnNotificationID.Value)) // Insert
                {
                    cmd = new SqlCommand("INSERT INTO Notifications(Content, Status) VALUES(@Content, @Status)", con);
                }
                else // Update
                {
                    cmd = new SqlCommand("UPDATE Notifications SET Content=@Content, Status=@Status WHERE NotificationID=@ID", con);
                    cmd.Parameters.AddWithValue("@ID", hdnNotificationID.Value);
                }

                cmd.Parameters.AddWithValue("@Content", txtContent.Text.Trim());
                cmd.Parameters.AddWithValue("@Status", ddlStatus.SelectedValue);

                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
            }

            BindNotifications();
        }

        private void BindNotifications()
        {
            using (SqlConnection con = new SqlConnection(conStr))
            {
                SqlDataAdapter da = new SqlDataAdapter("SELECT * FROM Notifications ORDER BY NotificationID DESC", con);
                DataTable dt = new DataTable();
                da.Fill(dt);

                rptNotifications.DataSource = dt;
                rptNotifications.DataBind();

                lblTotal.Text = dt.Rows.Count.ToString();
            }
        }

        protected void rptNotifications_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "EditNotification")
            {
                int id = Convert.ToInt32(e.CommandArgument);
                using (SqlConnection con = new SqlConnection(conStr))
                {
                    SqlCommand cmd = new SqlCommand("SELECT * FROM Notifications WHERE NotificationID=@ID", con);
                    cmd.Parameters.AddWithValue("@ID", id);
                    con.Open();
                    SqlDataReader dr = cmd.ExecuteReader();
                    if (dr.Read())
                    {
                        hdnNotificationID.Value = dr["NotificationID"].ToString();
                        txtContent.Text = dr["Content"].ToString();
                        ddlStatus.SelectedValue = dr["Status"].ToString();
                    }
                    con.Close();
                }

                ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openEditModal();", true);
            }
            else if (e.CommandName == "DeleteNotification")
            {
                int id = Convert.ToInt32(e.CommandArgument);
                using (SqlConnection con = new SqlConnection(conStr))
                {
                    SqlCommand cmd = new SqlCommand("DELETE FROM Notifications WHERE NotificationID=@ID", con);
                    cmd.Parameters.AddWithValue("@ID", id);
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                }

                // success alert
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('✅ Notification deleted successfully!');", true);

                BindNotifications();
            }
        }
    }
}