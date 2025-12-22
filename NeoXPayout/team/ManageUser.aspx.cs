using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NeoXPayout.team
{
    public partial class ManageUser : System.Web.UI.Page
    {
        UserManagement Um = new UserManagement();
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["BankUConnectionString"].ConnectionString);
        protected void Page_Load(object sender, EventArgs e)
        {
            if (this.Session["BUTeamName"] == null)
            {
                Response.Redirect("Default.aspx");
            }
            else
            {
                if (!IsPostBack)
                {
                    getpaymentdetails();
                }
            }
        }

        public void getpaymentdetails()
        {
            string query = "select * from  onboarding where UserID=@ProductId";
            SqlCommand mcom = new SqlCommand(query, con);
            mcom.Parameters.AddWithValue("@ProductId", Request.QueryString["id"]);
            mcom.Parameters.AddWithValue("@Status", "1");
            SqlDataAdapter mda = new SqlDataAdapter(mcom);
            DataTable dt = new DataTable();
            mda.Fill(dt);
            if (dt.Rows.Count > 0)
            {

                //Create new Account

                lblmobileno.Text = dt.Rows[0]["MobileNo"].ToString();
                lblemailid.Text = dt.Rows[0]["EmailId"].ToString();
                lblfullname.Text = dt.Rows[0]["FullName"].ToString();
                txtpanno.Text = dt.Rows[0]["PancardNo"].ToString();
                lblsignupstatus.Text = dt.Rows[0]["SignupStatus"].ToString();
                lblmobilevefified.Text = dt.Rows[0]["MobileverifyStatus"].ToString();

                //Business Details

                txtbusinessname.Text = dt.Rows[0]["CompanyName"].ToString();
                txtbusinessaddress.Text = dt.Rows[0]["companyaddress"].ToString();
                txtdhyamregistrationnumber.Text = dt.Rows[0]["UdyamRegNo"].ToString();
                ddlbusinesstype.Text = dt.Rows[0]["BusinessType"].ToString();
                
                    txtdateofincorportation.Text = dt.Rows[0]["BusinessStartOn"].ToString();
               
                //txtdateofincorportation.Text = dt.Rows[0]["BusinessStartOn"].ToString();
                lblbusinessstatus.Text = dt.Rows[0]["businessdetailsstatus"].ToString();

                //Personal Details
                txtaadharno.Text = dt.Rows[0]["AadharNo"].ToString();
                txtvoterid.Text = dt.Rows[0]["VoterCardNo"].ToString();
                txtfathername.Text = dt.Rows[0]["FatherName"].ToString();
                txtmothername.Text = dt.Rows[0]["MotherName"].ToString();
               
                    txtdob.Text = dt.Rows[0]["DOB"].ToString();


                lblgender.Text = dt.Rows[0]["Gender"].ToString();

                txtpermanentaddress.Text = dt.Rows[0]["Address"].ToString();
                lblstate.Text = dt.Rows[0]["State"].ToString();
                txtpincode.Text = dt.Rows[0]["Pincode"].ToString();
                lbluserposition.Text = dt.Rows[0]["Userposition"].ToString();
                lbleducation.Text = dt.Rows[0]["Education"].ToString();
                lblpersonalstatus.Text = dt.Rows[0]["PersonalInfoStatus"].ToString();

                //Bank Details

                lblaccountholder.Text = dt.Rows[0]["AccountHolderName"].ToString();
                lblbankname.Text = dt.Rows[0]["BankName"].ToString();
                lblaccountno.Text = dt.Rows[0]["Accountno"].ToString();
                lblifsccode.Text = dt.Rows[0]["IfscCode"].ToString();
                lblaccounttype.Text = dt.Rows[0]["Accounttype"].ToString();
                lblbankdetailsstatus.Text = dt.Rows[0]["Bankaccountstatus"].ToString();


                //,,,,Password,,,,,,,,,,,,,,,,,,,,,,,,,RegDate,Status,ApprovedBy,ApprovedDate,AdminRemarks
                //KYC Upload
                lbluploadpan.Text = dt.Rows[0]["PanUpload"].ToString();
                lblaadharfront.Text = dt.Rows[0]["AadharUpload"].ToString();
                lblaadharback.Text = dt.Rows[0]["Aadharbackcopy"].ToString();
                lbluploadvoter.Text = dt.Rows[0]["VoterCardUpload"].ToString();
                lbludyamcertificate.Text = dt.Rows[0]["UdyamUpload"].ToString();
                lblgstcertificate.Text = dt.Rows[0]["GstUpload"].ToString();
                lbljiotag.Text = dt.Rows[0]["JioTagPhotoUpload"].ToString();
                lblpassportphoto.Text = dt.Rows[0]["PassportSizePhoto"].ToString();
                lblkcystatus.Text = dt.Rows[0]["KycStatus"].ToString();

                //Registrationform and Additionaldocument
                lblonboardingform.Text = dt.Rows[0]["RegistrationForm"].ToString();
                lblregstatus.Text = dt.Rows[0]["DocumentStatus"].ToString();

                //Agrementcopy
                lblsignedagrement.Text = dt.Rows[0]["AgrementCopy"].ToString();
                lblagrementstatus.Text = dt.Rows[0]["AgrementStatus"].ToString();

                txtnotification.Text = dt.Rows[0]["AdminRemarks"].ToString();
                //hfNotificationType.Value = dt.Rows[0]["NotificationType"].ToString();

              
                ddlbusinessstatus.Text = dt.Rows[0]["businessdetailsstatus"].ToString();
                ddlpersonalstatus.Text = dt.Rows[0]["PersonalInfoStatus"].ToString();
                ddlbankdetailsstatus.Text = dt.Rows[0]["Bankaccountstatus"].ToString();
                ddlonboardingformstatus.Text = dt.Rows[0]["DocumentStatus"].ToString();
                ddlkycdocumetstatus.Text = dt.Rows[0]["KycStatus"].ToString();

                ddlagrementstatus.Text = dt.Rows[0]["AgrementStatus"].ToString();
                ddlonboardingstatus.Text = dt.Rows[0]["OnboardingStatus"].ToString();
                HiddenField1.Value = dt.Rows[0]["UserID"].ToString();
            }
            else
            {

            }


        }

       
        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            try
            {
                string sqlfr12 = "update onboarding set AdminRemarks=@AdminRemarks,ApprovedDate=@ApprovedDate,ApprovedBy=@ApprovedBy,NotificationType=@NotificationType,DocumentStatus=@DocumentStatus,OnboardingStatus=@OnboardingStatus,AgrementStatus=@AgrementStatus,KycStatus=@KycStatus where UserID=@UserID";
                SqlCommand cmdfr12 = new SqlCommand(sqlfr12, con);
                cmdfr12.Parameters.AddWithValue("@UserID", HiddenField1.Value);
                cmdfr12.Parameters.AddWithValue("@OnboardingStatus", ddlonboardingstatus.Text);
                cmdfr12.Parameters.AddWithValue("@AgrementStatus", ddlagrementstatus.Text);
                cmdfr12.Parameters.AddWithValue("@KycStatus", ddlkycdocumetstatus.Text);
                cmdfr12.Parameters.AddWithValue("@DocumentStatus", ddlonboardingformstatus.Text);
                //cmdfr12.Parameters.AddWithValue("@Bankaccountstatus", ddlbankdetailsstatus.Text);
                //cmdfr12.Parameters.AddWithValue("@PersonalInfoStatus", ddlpersonalstatus.Text);
                //cmdfr12.Parameters.AddWithValue("@businessdetailsstatus", ddlbusinessstatus.Text);
                //,,,
                cmdfr12.Parameters.AddWithValue("@NotificationType", ddlbusinessstatus.Text);
                cmdfr12.Parameters.AddWithValue("@ApprovedBy", Session["BUTeamName"].ToString());
                cmdfr12.Parameters.AddWithValue("@ApprovedDate", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss.fff"));
                cmdfr12.Parameters.AddWithValue("@AdminRemarks", txtnotification.Text);
                con.Open();
                cmdfr12.ExecuteNonQuery();
                con.Close();
                Response.Redirect("ViewNewUser.aspx");
               
            }
            catch (Exception ex)
            {
                string strscript = "<script language='javascript'>alert('Something Went Wrong!')</script>";
                Page.RegisterStartupScript("popup", strscript);
                
            }
            finally
            {
                con.Close();
            }
        }

        protected void LinkButton2_Click(object sender, EventArgs e)
        {
            try
            {
                string sqlfr12 = "update onboarding set AdminRemarks=@AdminRemarks,ApprovedDate=@ApprovedDate,ApprovedBy=@ApprovedBy,NotificationType=@NotificationType,businessdetailsstatus=@businessdetailsstatus where UserID=@UserID";
                SqlCommand cmdfr12 = new SqlCommand(sqlfr12, con);
                cmdfr12.Parameters.AddWithValue("@UserID", HiddenField1.Value);
               
                cmdfr12.Parameters.AddWithValue("@businessdetailsstatus", ddlbusinessstatus.Text);
                //,,,
                cmdfr12.Parameters.AddWithValue("@NotificationType", ddlbusinessstatus.Text);
                cmdfr12.Parameters.AddWithValue("@ApprovedBy", Session["BUTeamName"].ToString());
                cmdfr12.Parameters.AddWithValue("@ApprovedDate", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss.fff"));
                cmdfr12.Parameters.AddWithValue("@AdminRemarks", TextBox1.Text);
                con.Open();
                cmdfr12.ExecuteNonQuery();
                con.Close();
                Response.Redirect("ViewNewUser.aspx");

            }
            catch (Exception ex)
            {
                string strscript = "<script language='javascript'>alert('Something Went Wrong!')</script>";
                Page.RegisterStartupScript("popup", strscript);

            }
            finally
            {
                con.Close();
            }

        }

        protected void LinkButton3_Click(object sender, EventArgs e)
        {
            try
            {
                string sqlfr12 = "update onboarding set AdminRemarks=@AdminRemarks,ApprovedDate=@ApprovedDate,ApprovedBy=@ApprovedBy,NotificationType=@NotificationType,PersonalInfoStatus=@PersonalInfoStatus where UserID=@UserID";
                SqlCommand cmdfr12 = new SqlCommand(sqlfr12, con);
                cmdfr12.Parameters.AddWithValue("@UserID", HiddenField1.Value);
               
                cmdfr12.Parameters.AddWithValue("@PersonalInfoStatus", ddlpersonalstatus.Text);
               
                cmdfr12.Parameters.AddWithValue("@NotificationType", ddlbusinessstatus.Text);
                cmdfr12.Parameters.AddWithValue("@ApprovedBy", Session["BUTeamName"].ToString());
                cmdfr12.Parameters.AddWithValue("@ApprovedDate", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss.fff"));
                cmdfr12.Parameters.AddWithValue("@AdminRemarks", TextBox2.Text);
                con.Open();
                cmdfr12.ExecuteNonQuery();
                con.Close();
                Response.Redirect("ViewNewUser.aspx");

            }
            catch (Exception ex)
            {
                string strscript = "<script language='javascript'>alert('Something Went Wrong!')</script>";
                Page.RegisterStartupScript("popup", strscript);

            }
            finally
            {
                con.Close();
            }
        }

        protected void LinkButton4_Click(object sender, EventArgs e)
        {
            try
            {
                string sqlfr12 = "update onboarding set AdminRemarks=@AdminRemarks,ApprovedDate=@ApprovedDate,ApprovedBy=@ApprovedBy,NotificationType=@NotificationType,Bankaccountstatus=@Bankaccountstatus where UserID=@UserID";
                SqlCommand cmdfr12 = new SqlCommand(sqlfr12, con);
                cmdfr12.Parameters.AddWithValue("@UserID", HiddenField1.Value);
                
                cmdfr12.Parameters.AddWithValue("@Bankaccountstatus", ddlbankdetailsstatus.Text);
                
                //,,,
                cmdfr12.Parameters.AddWithValue("@NotificationType", ddlbusinessstatus.Text);
                cmdfr12.Parameters.AddWithValue("@ApprovedBy", Session["BUTeamName"].ToString());
                cmdfr12.Parameters.AddWithValue("@ApprovedDate", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss.fff"));
                cmdfr12.Parameters.AddWithValue("@AdminRemarks", TextBox3.Text);
                con.Open();
                cmdfr12.ExecuteNonQuery();
                con.Close();
                Response.Redirect("ViewNewUser.aspx");

            }
            catch (Exception ex)
            {
                string strscript = "<script language='javascript'>alert('Something Went Wrong!')</script>";
                Page.RegisterStartupScript("popup", strscript);

            }
            finally
            {
                con.Close();
            }
        }
    }
}