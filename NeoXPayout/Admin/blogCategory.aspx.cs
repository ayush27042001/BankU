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
    public partial class blogCategory : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString);
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

                    getdetails();
                }
            }
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            con.Open();
            string sql = "insert into blogCategory (Categoryname,Status,CreatedDate)values(@Categoryname,@Status,@CreatedDate)";
            SqlCommand cmd = new SqlCommand(sql, con);
            cmd.Parameters.AddWithValue("@CategoryName", txtcategoryname.Text);
            cmd.Parameters.AddWithValue("@CreatedDate", DateTime.Now.ToString());
            cmd.Parameters.AddWithValue("@Status", ddlstatus.Text);
            cmd.ExecuteNonQuery();
            con.Close();
            getdetails();
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Added Successfully!');", true);
        }

        public void getdetails()
        {
            string query = "select * from  blogCategory  order by Id desc";
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
    }
}