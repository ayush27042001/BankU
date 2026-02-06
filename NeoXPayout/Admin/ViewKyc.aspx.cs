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
    public partial class ViewKyc : System.Web.UI.Page
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

                    Getdetails();
                }
            }
        }
        protected void Getdetails()
        {
            string ID = Request.QueryString["ID"];
            if (string.IsNullOrEmpty(ID))
            {
                Response.Write("<script>alert('Invalid User ID'); window.location='ViewUser.aspx';</script>");
                return;
            }

            string query = "SELECT aadharUpload, panUpload, photoUpload, gstUpload FROM Registration WHERE RegistrationId = @ID";

            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@ID", ID);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                if (dt.Rows.Count == 0)
                {
                    Response.Write("<script>alert('User not found'); window.location='ViewUser.aspx';</script>");
                    return;
                }

                DataRow row = dt.Rows[0];

                SetDoc(imgAadhar, lblAadharStatus, row["aadharUpload"]);
                SetDoc(imgPan, lblPanStatus, row["panUpload"]);
                SetDoc(imgPhoto, lblPhotoStatus, row["photoUpload"]);
                SetDoc(imgGst, lblGstStatus, row["gstUpload"], isOptional: true);
            }
        }
        private void SetDoc(Image img, Label lbl, object dbValue, bool isOptional = false)
        {
            string path = dbValue?.ToString();

            if (!string.IsNullOrEmpty(path))
            {
                img.ImageUrl = path;
                img.Visible = true;

                lbl.Text = "Uploaded";
                lbl.CssClass = "badge bg-success mt-2";
            }
            else
            {
                img.Visible = false;

                lbl.Text = isOptional ? "Not Uploaded (Optional)" : "Not Uploaded";
                lbl.CssClass = "badge bg-danger mt-2";
            }
        }


    }
}