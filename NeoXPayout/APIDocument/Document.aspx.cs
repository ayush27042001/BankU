using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NeoXPayout.APIDocument
{
    public partial class Document : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            getdetail();
        }
        protected void getdetail()
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                string query = "SELECT Category, APIName FROM APIDocument WHERE Status='Active' ORDER BY Category, APIName";
                SqlDataAdapter da = new SqlDataAdapter(query, con);
                DataTable dt = new DataTable();
                da.Fill(dt);

                if (dt.Rows.Count == 0)
                {
                    rptCategory.Visible = false;
                }
                else
                {
                    rptCategory.Visible = true;

                    // get distinct categories
                    DataView dv = new DataView(dt);
                    DataTable dtCategory = dv.ToTable(true, "Category");

                    rptCategory.DataSource = dtCategory;
                    rptCategory.DataBind();

                    // store full data for inner repeaters
                    ViewState["APIData"] = dt;
                }
                string query2 = " SELECT * from APIWebhook where Id = @ID";
                SqlCommand cmd = new SqlCommand(query2, con);
                cmd.Parameters.AddWithValue("@ID", '1');
                SqlDataAdapter daa = new SqlDataAdapter(cmd);
                DataTable dt1 = new DataTable();
                daa.Fill(dt1);

                if (dt1.Rows.Count > 0)
                {
                    lblWebhookLink.Text = dt1.Rows[0]["Link"].ToString();
                    lblWebhookPara.Text = dt1.Rows[0]["ReqPara"].ToString();
                }
                else
                {
                    
                }
            }
        }

        protected void rptCategory_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                string category = DataBinder.Eval(e.Item.DataItem, "Category").ToString();

                using (SqlConnection con = new SqlConnection(connStr))
                {
                    string query = "SELECT APIName, Id FROM APIDocument WHERE Category=@Category AND Status='Active'";
                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@Category", category);

                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    Repeater rptAPI = (Repeater)e.Item.FindControl("rptAPI");
                    rptAPI.DataSource = dt;
                    rptAPI.DataBind();
                }
            }
        }
        [System.Web.Services.WebMethod]
        public static object GetAPIDetail(int apiId)
        {
            string connStr = ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString;
            using (SqlConnection con = new SqlConnection(connStr))
            {
                string query = "SELECT * FROM APIDocument WHERE Id=@Id";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@Id", apiId);
                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                if (reader.Read())
                {
                    return new
                    {
                        APIName = reader["APIName"].ToString(),
                        Link = reader["Link"].ToString(),
                        Discription = reader["Discription"].ToString(),
                        HeaderPara = reader["HeaderPara"].ToString(),
                        RequestPara = reader["RequestPara"].ToString(),
                        SampleReq = reader["SampleReq"].ToString(),
                        ResponsePara = reader["ResponsePara"].ToString(),
                        SampleResponse = reader["SampleResponse"].ToString()
                    };
                }
                return null;
            }
        }

    }
}