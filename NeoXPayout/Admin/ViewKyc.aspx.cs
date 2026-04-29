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
        UserManagement Um = new UserManagement();
        
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

            string query = "SELECT aadharUpload, panUpload, photoUpload, KycStatus,gstUpload,BusinessProofUploadtype ,ShopFrontupload,ShopInupload, KycApplication FROM Registration WHERE RegistrationId = @ID";

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
                lblKycStatus.Text = row["KycStatus"].ToString();

                string status = row["KycStatus"].ToString();

                switch (status)
                {
                    case "Pending":
                        lblKycStatus.CssClass = "badge bg-warning fs-6";
                        break;

                    case "ReUpload":
                        lblKycStatus.CssClass = "badge bg-danger fs-6";
                        break;

                    case "Complete":
                        lblKycStatus.CssClass = "badge bg-success fs-6";
                        break;
                }
                ddlKycStatus.SelectedValue = status;
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

        protected void btnUpdateStatus_Click(object sender, EventArgs e)
        {
            string ID = Request.QueryString["ID"];

            if (string.IsNullOrEmpty(ID))
                return;

            string newStatus = ddlKycStatus.SelectedValue;
            string adminName = Session["AdminName"].ToString();
            string adminId = Session["AdminUID"].ToString();
            string rejectReason = txtRejectReason.Text.Trim();

            if (newStatus == "Rejected" && string.IsNullOrEmpty(rejectReason))
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "err",
                    "alert('Please enter rejection reason');", true);
                return;
            }
            con.Open();
            SqlTransaction trans = con.BeginTransaction();

            try
            {
                // GET USER FULL DETAILS
                SqlCommand userCmd = new SqlCommand(@"
            SELECT FullName, MobileNo, Email, PANNo, AadharNo, KycStatus
            FROM Registration WHERE RegistrationId=@ID", con, trans);

                userCmd.Parameters.AddWithValue("@ID", ID);

                SqlDataReader dr = userCmd.ExecuteReader();

                if (!dr.Read())
                    return;

                string name = dr["FullName"].ToString();
                string mobile = dr["MobileNo"].ToString();
                string email = dr["Email"].ToString();
                string pan = dr["PanNo"].ToString();
                string aadhar = dr["AadharNo"].ToString();
                string oldStatus = dr["KycStatus"].ToString();

                dr.Close();

                // MASK DATA
                string maskedPan = MaskPan(pan);
                string maskedAadhar = MaskAadhar(aadhar);

                // UPDATE STATUS
                SqlCommand updateCmd = new SqlCommand(
                    "UPDATE Registration SET KycStatus=@Status WHERE RegistrationId=@ID",
                    con, trans);

                updateCmd.Parameters.AddWithValue("@Status", newStatus);
                updateCmd.Parameters.AddWithValue("@ID", ID);
                updateCmd.ExecuteNonQuery();

                // INSERT LOG
                SqlCommand logCmd = new SqlCommand(@"INSERT INTO KycApprovalLog(RegistrationId,AdminName,AdminId,OldStatus,NewStatus,RejectReason)VALUES(@RegistrationId,@AdminName,@AdminId,@OldStatus,@NewStatus,@RejectReason)",con, trans);

                logCmd.Parameters.AddWithValue("@RegistrationId", ID);
                logCmd.Parameters.AddWithValue("@AdminName", adminName);
                logCmd.Parameters.AddWithValue("@AdminId", adminId);
                logCmd.Parameters.AddWithValue("@OldStatus", oldStatus);
                logCmd.Parameters.AddWithValue("@NewStatus", newStatus);
                logCmd.Parameters.AddWithValue("@RejectReason",
                    newStatus == "Rejected" ? rejectReason : (object)DBNull.Value);
                logCmd.ExecuteNonQuery();

                trans.Commit();

                lblKycStatus.Text = newStatus;

                string KycID = "BANKUKYC" + ID;
                Um.SendKycStatusMsg(mobile, name, KycID, newStatus);

                string ip = GetIpAddress();
                string location = GetLocation(ip);
                if (newStatus == "Approved") 
                { 
                string script = @"
                    setTimeout(function () {

                    try {

                    document.getElementById('certApproval').innerText='BANKU-" + ID + @"';
                    document.getElementById('certName').innerText='" + SafeJs(name) + @"';
                    document.getElementById('certMobile').innerText='" + SafeJs(mobile) + @"';
                    document.getElementById('certEmail').innerText='" + SafeJs(email) + @"';

                    document.getElementById('certPan').innerText='" + maskedPan + @"';
                    document.getElementById('certAadhar').innerText='" + maskedAadhar + @"';

                    document.getElementById('certStatus').innerText='" + newStatus + @"';
                    document.getElementById('certAdmin').innerText='" + SafeJs(adminName) + @"';
                    document.getElementById('certIP').innerText='" + ip + @"';

                    document.getElementById('certCustId').innerText='" + ID + @"';
                    document.getElementById('certReqId').innerText='REQ-" + ID + @"';
                    document.getElementById('certLocation').innerText='" + SafeJs(location) + @"';
                    document.getElementById('certDate').innerText='" + DateTime.Now.ToString("dd MMM yyyy hh:mm tt") + @"';

                    var modalEl = document.getElementById('statusUpdatedModal');
                    var myModal = new bootstrap.Modal(modalEl);
                    myModal.show();

                    } catch(e) {
                    console.log('Modal Error:', e);
                    }

                    }, 300);
                    ";

                ScriptManager.RegisterStartupScript(this, this.GetType(), "popup", script, true);
                }
                else if (newStatus == "Rejected")
                {
                    string script = $"alert('KYC Rejected! Reason: {SafeJs(rejectReason)}');";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "rejectMsg", script, true);
                }
                else 
                {
                    string script = "alert('Status updated successfully!');";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alertMsg", script, true);
                }
            }
            catch
            {
                trans.Rollback();
                throw;
            }
            finally
            {
                con.Close();
            }
        }
        public string GetDetails(string id, string type)
        {
            try
            {
                string column = "";

                if (type.ToLower() == "name")
                    column = "FullName";
                else if (type.ToLower() == "mobile")
                    column = "MobileNo";
                else
                    return "";

                string query = $"SELECT {column} FROM Registration WHERE RegistrationId=@Id";

                using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString))
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@Id", id);

                    con.Open();

                    object result = cmd.ExecuteScalar();

                    return result?.ToString() ?? "";
                } // ✅ connection automatically closed here
            }
            catch (Exception)
            {
                return "";
            }
        }

        public string GetIpAddress()
        {
            string ip = HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"];

            if (string.IsNullOrEmpty(ip))
                ip = HttpContext.Current.Request.ServerVariables["REMOTE_ADDR"];

            return ip;
        }
        public string GetLocation(string ip)
        {
            try
            {
                using (var client = new System.Net.WebClient())
                {
                    string json = client.DownloadString("http://ip-api.com/json/" + ip);
                    dynamic data = Newtonsoft.Json.JsonConvert.DeserializeObject(json);

                    return data.city + ", " + data.regionName + ", " + data.country;
                }
            }
            catch
            {
                return "Unknown";
            }
        }
        private string MaskPan(string pan)
        {
            if (string.IsNullOrEmpty(pan) || pan.Length < 10)
                return pan;

            return pan.Substring(0, 2) + "XXXX" + pan.Substring(pan.Length - 2);
        }

        private string MaskAadhar(string aadhar)
        {
            if (string.IsNullOrEmpty(aadhar) || aadhar.Length < 12)
                return aadhar;

            return "XXXX XXXX " + aadhar.Substring(aadhar.Length - 4);
        }
        private string SafeJs(string input)
        {
            if (string.IsNullOrEmpty(input)) return "";
            return input.Replace("'", "\\'")
                        .Replace("\n", "")
                        .Replace("\r", "");
        }
    }
}