using iTextSharp.text;
using iTextSharp.text.pdf;
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
    public partial class ViewAgreement : System.Web.UI.Page
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

        public void getdetails()
        {
            string query = "select * from  UserAgreement  order by Id desc";
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

        protected void rptProduct_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "DeleteRecord")
            {
                int id = Convert.ToInt32(e.CommandArgument);

                using (SqlCommand cmd = new SqlCommand("DELETE FROM UserAgreement WHERE Id = @Id", con))
                {
                    cmd.Parameters.AddWithValue("@Id", id);
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                }

                getdetails();
            }

            // ADMIN APPROVE 
            if (e.CommandName == "ReSign")
            {
                string agreementId = e.CommandArgument.ToString();
                string adminName = Session["AdminName"] != null ? Session["AdminName"].ToString() : "Admin";

                string inputPdf = "";

                try
                {
                    var details = GetAgreementDetails(agreementId);

                    if (details.Status == "Approved")
                    {
                        lblmsg.Text = "Already approved.";
                        return;
                    }

                    if (details.Status != "Signed")
                    {
                        lblmsg.Text = "User has not signed this agreement yet!";
                        return;
                    }

                    string userSignedPath = GetUserSignedPdfPath(agreementId);

                    if (string.IsNullOrEmpty(userSignedPath))
                    {
                        lblmsg.Text = "❌ Signed document not found.";
                        return;
                    }

                    // HANDLE FILE SOURCE

                    if (userSignedPath.StartsWith("http", StringComparison.OrdinalIgnoreCase))
                    {
                        // DOWNLOAD FROM URL
                        using (var client = new System.Net.WebClient())
                        {
                            string tempFolder = Server.MapPath("~/Temp/");

                            if (!Directory.Exists(tempFolder))
                                Directory.CreateDirectory(tempFolder);

                            string tempFile = Path.Combine(tempFolder, Guid.NewGuid() + ".pdf");

                            client.DownloadFile(userSignedPath, tempFile);

                            inputPdf = tempFile;
                        }
                    }
                    else
                    {
                        // HANDLE LOCAL PATHS

                        string cleanPath = userSignedPath.Replace("~/", "").TrimStart('/');

                        inputPdf = Server.MapPath("~/" + cleanPath);
                    }

                    // SIGN PDF
                    string signedPdf = AddAdminSignatureToPdf(inputPdf, adminName);

                    // UPDATE DB
                    UpdateAgreementAfterAdminSign(agreementId, signedPdf, adminName);

                    lblmsg.Text = "✅ Agreement Approved Successfully!";
                    getdetails();
                }
                catch (Exception ex)
                {
                    lblmsg.Text = "Error: " + ex.Message;
                }
                finally
                {
                    // ALWAYS CLEAN TEMP FILE
                    if (!string.IsNullOrEmpty(inputPdf) &&
                        inputPdf.Contains("\\Temp\\") &&
                        File.Exists(inputPdf))
                    {
                        File.Delete(inputPdf);
                    }
                }
            }
        }
        private (string Status, string FullName) GetAgreementDetails(string agreementId)
        {
            string status = "";
            string fullName = "";

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString))
            {
                con.Open();

                SqlCommand cmd = new SqlCommand(
                    "SELECT Status, FullName FROM UserAgreement WHERE AgreementId=@AgreementId", con);

                cmd.Parameters.AddWithValue("@AgreementId", agreementId);

                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.Read())
                {
                    status = dr["Status"]?.ToString();
                    fullName = dr["FullName"]?.ToString();
                }
            }

            return (status, fullName);
        }
        public string GetUserSignedPdfPath(string agreementId)
        {
            string path = "";

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString))
            {
                con.Open();

                SqlCommand cmd = new SqlCommand(
                    "SELECT UserSignedPath FROM UserAgreement WHERE AgreementId=@AgreementId", con);

                cmd.Parameters.AddWithValue("@AgreementId", agreementId);

                object result = cmd.ExecuteScalar();

                if (result != null)
                {
                    path = result.ToString();
                }
            }

            return path;
        }
        public void UpdateAgreementAfterAdminSign(string agreementId, string newPath, string adminName)
        {
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString))
            {
                con.Open();

                SqlCommand cmd = new SqlCommand(@"
        UPDATE UserAgreement 
        SET Status = 'Approved',
            AdminSignedPath = @Path,
            ApprovedBy = @AdminName,
            ApprovedAt = GETDATE()
        WHERE AgreementId = @AgreementId", con);

                cmd.Parameters.AddWithValue("@Path", newPath.Replace(Server.MapPath("~"), "").Replace("\\", "/"));
                cmd.Parameters.AddWithValue("@AdminName", adminName);
                cmd.Parameters.AddWithValue("@AgreementId", agreementId);

                cmd.ExecuteNonQuery();
            }
        }
        public string AddAdminSignatureToPdf(string inputPdfPath, string adminName)
        {
            string folder = Server.MapPath("~/SignedDocs/");

            if (!Directory.Exists(folder))
            {
                Directory.CreateDirectory(folder);
            }

            string outputPdfPath = Server.MapPath("~/SignedDocs/AdminSigned_" + Guid.NewGuid() + ".pdf");

            string timeStamp = DateTime.Now.ToString("dd MMM yyyy HH:mm:ss");

            using (PdfReader reader = new PdfReader(inputPdfPath))
            {
                using (FileStream fs = new FileStream(outputPdfPath, FileMode.Create))
                {
                    using (PdfStamper stamper = new PdfStamper(reader, fs))
                    {
                        int totalPages = reader.NumberOfPages;

                        var boldFont = new iTextSharp.text.Font(iTextSharp.text.Font.FontFamily.HELVETICA, 11, iTextSharp.text.Font.BOLD);
                        var smallFont = new iTextSharp.text.Font(iTextSharp.text.Font.FontFamily.HELVETICA, 9);

                        for (int i = 1; i <= totalPages; i++)
                        {
                            PdfContentByte cb = stamper.GetOverContent(i);

                            float x = reader.GetPageSize(i).Left + 40;
                            float y = reader.GetPageSize(i).Bottom + 80;

                            cb.Rectangle(x - 10, y - 10, 170, 60);
                            cb.Stroke();

                            ColumnText.ShowTextAligned(cb, Element.ALIGN_LEFT,
                                new Phrase("Approved By Admin", smallFont),
                                x, y + 30, 0);

                            ColumnText.ShowTextAligned(cb, Element.ALIGN_LEFT,
                                new Phrase(adminName, boldFont),
                                x, y + 15, 0);

                            ColumnText.ShowTextAligned(cb, Element.ALIGN_LEFT,
                                new Phrase(timeStamp, smallFont),
                                x, y, 0);
                        }
                    }
                }
            }

            return outputPdfPath;
        }
        protected string GetSignedUrl(object pathObj)
        {
            if (pathObj == null) return "#";

            string path = pathObj.ToString();

            if (string.IsNullOrWhiteSpace(path))
                return "#";

            if (path.StartsWith("http", StringComparison.OrdinalIgnoreCase))
                return path;

            return ResolveUrl("/" + path.Replace("~/", ""));
        }
    }
}