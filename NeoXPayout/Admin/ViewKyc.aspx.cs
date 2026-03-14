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
                Response.Write("<script>alert('Invalid User ID'); window.location='ViewUserBanku.aspx';</script>");
                return;
            }

            string query = "SELECT aadharUpload, panUpload, photoUpload, gstUpload,BusinessProofUploadtype ,ShopFrontupload,ShopInupload, KycApplication FROM Registration WHERE RegistrationId = @ID";

            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@ID", ID);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                if (dt.Rows.Count == 0)
                {
                    Response.Write("<script>alert('User not found'); window.location='ViewUserBanku.aspx';</script>");
                    return;
                }

                DataRow row = dt.Rows[0];

                SetDoc(imgAadhar, lnkAadhar, lblAadharStatus, row["aadharUpload"]);
                SetDoc(imgPan, lnkPan, lblPanStatus, row["panUpload"]);
                SetDoc(imgFront, lnkFront, lblShopFront, row["ShopFrontupload"]);
                SetDoc(imgInside, lnkInside, lblShopIn, row["ShopInupload"]);
                SetDoc(imgApplication, lnkApplication, lblApplication, row["KycApplication"]);
                SetDoc(imgPhoto, lnkPhoto, lblPhotoStatus, row["photoUpload"]);
                SetDoc(imgGst, lnkGst, lblGstStatus, row["gstUpload"], true);
            }
        }
        private void SetDoc(Image img, HyperLink link, Label lbl, object dbValue, bool isOptional = false)
        {
            string path = dbValue?.ToString();

            if (!string.IsNullOrEmpty(path))
            {
                string ext = Path.GetExtension(path).ToLower();

                if (ext == ".pdf")
                {
                    img.Visible = false;

                    link.Visible = true;
                    link.NavigateUrl = path;
                    link.Text = Path.GetFileName(path);
                    link.Target = "_blank";
                }
                else
                {
                    img.ImageUrl = path;
                    img.Visible = true;
                    link.Visible = false;
                }

                lbl.Text = "Uploaded";
                lbl.CssClass = "badge bg-success mt-2";
            }
            else
            {
                img.Visible = false;
                link.Visible = false;

                lbl.Text = isOptional ? "Not Uploaded" : "Not Uploaded";
                lbl.CssClass = "badge bg-danger mt-2";
            }
        }


    }
}