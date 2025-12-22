using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace NeoXPayout.Admin
{
    public partial class Margin : System.Web.UI.Page
    {
        string conStr = ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString;
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
                    BindRepeater();
                }
            }
        }

        private void BindRepeater()
        {
            using (SqlConnection con = new SqlConnection(conStr))
            {
                SqlDataAdapter da = new SqlDataAdapter("SELECT * FROM MarginSetting", con);
                DataTable dt = new DataTable();
                da.Fill(dt);
                rptMargin.DataSource = dt;
                rptMargin.DataBind();
            }
        }

        //protected void rptMargin_ItemCommand(object source, System.Web.UI.WebControls.RepeaterCommandEventArgs e)
        //{
        //    if (e.CommandName == "UpdateMargin")
        //    {
        //        int id = Convert.ToInt32(e.CommandArgument);

        //        TextBox txtIPShare = (TextBox)e.Item.FindControl("txtIPShare");
        //        TextBox txtWLShare = (TextBox)e.Item.FindControl("txtWLShare");
        //        TextBox txtCommType = (TextBox)e.Item.FindControl("txtCommType");

        //        using (SqlConnection con = new SqlConnection(conStr))
        //        {
        //            SqlCommand cmd = new SqlCommand("UPDATE MarginSetting SET IPShare=@IPShare, WLShare=@WLShare, CommissionType=@CommType WHERE Id=@Id", con);
        //            cmd.Parameters.AddWithValue("@IPShare", txtIPShare.Text);
        //            cmd.Parameters.AddWithValue("@WLShare", txtWLShare.Text);
        //            cmd.Parameters.AddWithValue("@CommType", txtCommType.Text);
        //            cmd.Parameters.AddWithValue("@Id", id);

        //            con.Open();
        //            cmd.ExecuteNonQuery();
        //            con.Close();
        //        }

               
        //        BindRepeater();

        //        ScriptManager.RegisterStartupScript(this, this.GetType(), "alert",
        //    "alert('Your Margin has been updated successfully!');", true);
        //    }
        //}

        protected void rptMargin_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "UpdateMargin")
            {
                int id = Convert.ToInt32(e.CommandArgument);

                TextBox txtIPShare = (TextBox)e.Item.FindControl("txtIPShare");
                TextBox txtWLShare = (TextBox)e.Item.FindControl("txtWLShare");
                TextBox txtCommType = (TextBox)e.Item.FindControl("txtCommType");

                using (SqlConnection con = new SqlConnection(conStr))
                {
                    SqlCommand cmd = new SqlCommand("UPDATE MarginSetting SET IPShare=@IPShare, WLShare=@WLShare, CommissionType=@CommType WHERE Id=@Id", con);
                    cmd.Parameters.AddWithValue("@IPShare", txtIPShare.Text);
                    cmd.Parameters.AddWithValue("@WLShare", txtWLShare.Text);
                    cmd.Parameters.AddWithValue("@CommType", txtCommType.Text);
                    cmd.Parameters.AddWithValue("@Id", id);

                    con.Open();
                    cmd.ExecuteNonQuery();
                }

                BindRepeater();
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Your Margin has been updated successfully!');", true);
            }

          
            if (e.CommandName == "DeleteMargin")
            {
                int id = Convert.ToInt32(e.CommandArgument);

                using (SqlConnection con = new SqlConnection(conStr))
                {
                    SqlCommand cmd = new SqlCommand("DELETE FROM MarginSetting WHERE Id=@Id", con);
                    cmd.Parameters.AddWithValue("@Id", id);

                    con.Open();
                    cmd.ExecuteNonQuery();
                }

                BindRepeater();

                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Record deleted successfully!');", true);
            }
        }

    }
}