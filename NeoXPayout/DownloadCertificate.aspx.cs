using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Drawing;
using System.Drawing.Imaging;
using System.Drawing.Text;
using System.IO;
using iTextSharp.text;
using iTextSharp.text.pdf;

namespace NeoXPayout
{
    public partial class DownloadCertificate : System.Web.UI.Page
    {
        SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString);

        protected void Page_Load(object sender, EventArgs e)
        {
            string userKey = this.Session["BankURTUID"]?.ToString();
            string fileName = Request.QueryString["file"];

            if (string.IsNullOrEmpty(userKey) || string.IsNullOrEmpty(fileName))
            {
                Response.Write("Missing required parameters.");
                Response.End();
                return;
            }

            string accountHolderType = Session["AccountHolderType"] != null
                ? Session["AccountHolderType"].ToString().ToUpper()
                : "";

            fileName = Path.GetFileName(fileName); // Sanitize filename
            string templatePath = Server.MapPath("~/certificates/" + fileName);

            if (!File.Exists(templatePath))
            {
                Response.Write("Certificate template not found.");
                Response.End();
                return;
            }

            try
            {
                using (Bitmap bitmap = new Bitmap(templatePath))
                {
                    if (accountHolderType == "BANKU SEVA KENDRA")
                    {
                        // Fetch user info from database
                        string connStr = cn.ConnectionString;
                        string CompanyName = "", FullName = "", UserMob = "", panNumber = "",  date = "", CompanyAddress = "";

                        using (SqlConnection conn = new SqlConnection(connStr))
                        {
                            conn.Open();
                            SqlCommand cmd = new SqlCommand("SELECT CompanyName, CompanyAddress, FullName, MobileNo, PANNo, BankAccount, BusinessStartOn FROM Registration WHERE RegistrationId = @UserID", conn);
                            cmd.Parameters.AddWithValue("@UserID", this.Session["BankURTUID"].ToString());

                            SqlDataReader reader = cmd.ExecuteReader();
                            if (reader.Read())
                            {
                                CompanyAddress = reader["CompanyAddress"].ToString();
                                CompanyName = reader["CompanyName"].ToString();
                                FullName = reader["FullName"].ToString();
                                UserMob = reader["MobileNo"].ToString();
                                panNumber = reader["PANNo"].ToString();
                               
                                
                                date = Convert.ToDateTime(reader["BusinessStartOn"]).ToString("yyyy-MM-dd");
                            }
                        }

                        using (Graphics graphics = Graphics.FromImage(bitmap))
                        {
                            System.Drawing.Font font = new System.Drawing.Font("Arial", 45, FontStyle.Bold);
                            System.Drawing.Font shopFont = new System.Drawing.Font("Arial", 16, FontStyle.Bold);
                            System.Drawing.Font keyFont = new System.Drawing.Font("Arial", 24, FontStyle.Bold);
                            System.Drawing.Font dateFont = new System.Drawing.Font("Arial", 28, FontStyle.Bold);
                            System.Drawing.Font IdFont = new System.Drawing.Font("Arial", 27, FontStyle.Bold);
                            System.Drawing.Font Big = new System.Drawing.Font("Arial", 40, FontStyle.Bold);

                            Brush shopBrush = new SolidBrush(Color.Black);
                            Brush RedBrush = new SolidBrush(Color.Red);
                            Brush keyBrush = new SolidBrush(Color.DarkOrange);
                            Brush dateBrush = new SolidBrush(Color.DarkBlue);
                            Brush brush = Brushes.Black;
                            graphics.TextRenderingHint = TextRenderingHint.AntiAliasGridFit;

                            switch (fileName.ToLower())
                            {
                                case "certificate.jpg":
                                    graphics.DrawString(CompanyName, Big, brush, new PointF(580, 486));
                                    graphics.DrawString(userKey, keyFont, keyBrush, new PointF(1300, 110));
                                    graphics.DrawString(date, dateFont, dateBrush, new PointF(270, 910));
                                    break;

                                case "idcard.jpg":
                                    string overlayPath = Server.MapPath("profile.jpg");
                                    if (File.Exists(overlayPath))
                                    {
                                        using (System.Drawing.Image overlay = System.Drawing.Image.FromFile(overlayPath))
                                        {
                                            graphics.DrawImage(overlay, new System.Drawing.Rectangle(156, 223, 290, 401));
                                        }
                                    }

                                    graphics.DrawString(CompanyName, font, RedBrush, new PointF(691, 272));
                                    graphics.DrawString(UserMob, IdFont, brush, new PointF(958, 456));
                                    graphics.DrawString(panNumber, IdFont, brush, new PointF(958, 594));
                                    graphics.DrawString(userKey, IdFont, brush, new PointF(958, 407));
                                    graphics.DrawString(CompanyName, IdFont, brush, new PointF(958, 501));
                                    graphics.DrawString(CompanyAddress, IdFont, brush, new PointF(958, 545));
                                    break;

                                case "bcauth.jpg":
                                    graphics.DrawString(CompanyAddress, shopFont, shopBrush, new PointF(330, 485));
                                    graphics.DrawString(CompanyName, shopFont, shopBrush, new PointF(330, 415));
                                    graphics.DrawString(UserMob, shopFont, shopBrush, new PointF(330, 545));
                                    graphics.DrawString(FullName, shopFont, shopBrush, new PointF(330, 375));
                                    graphics.DrawString(userKey, shopFont, shopBrush, new PointF(330, 340));
                                    break;

                                case "aepsconsent.jpg":
                                case "aepscash.jpg":
                                case "storebranding.png":
                                    break;

                                default:
                                    Response.Write("Unsupported template file.");
                                    Response.End();
                                    return;
                            }
                        }
                    }

                    // Convert to PDF (for both with or without text)
                    using (MemoryStream imageStream = new MemoryStream())
                    {
                        bitmap.Save(imageStream, ImageFormat.Jpeg);
                        imageStream.Position = 0;

                        iTextSharp.text.Rectangle pageSize = PageSize.A4.Rotate();
                        if (fileName.ToLower() == "bcauth.jpg" || fileName.ToLower() == "aepsconsent.jpg")
                        {
                            pageSize = PageSize.A4;
                        }

                        using (Document pdfDoc = new Document(pageSize, 0, 0, 0, 0))
                        using (MemoryStream pdfStream = new MemoryStream())
                        {
                            PdfWriter.GetInstance(pdfDoc, pdfStream);
                            pdfDoc.Open();

                            iTextSharp.text.Image image = iTextSharp.text.Image.GetInstance(imageStream.ToArray());
                            image.ScaleToFit(pdfDoc.PageSize.Width, pdfDoc.PageSize.Height);
                            image.Alignment = Element.ALIGN_CENTER;

                            pdfDoc.Add(image);
                            pdfDoc.Close();

                            Response.Clear();
                            Response.ContentType = "application/pdf";
                            Response.AddHeader("Content-Disposition", $"attachment; filename=Certificate_{Path.GetFileNameWithoutExtension(fileName)}_{userKey}.pdf");
                            Response.BinaryWrite(pdfStream.ToArray());
                            Response.End();
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Response.Write("Error: " + ex.Message);
                Response.End();
            }
        }

    }
}