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
    public partial class AddUser : System.Web.UI.Page
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
                   

                }
            }

        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            try
            {
                //string ApiKey = Session["AdminNeoxApikey"].ToString();
                con.Open();
                string query = "insert into Registration(AccountType,BusinessType,CompanyName,FullName,MobileNo,Email,MPIN,AddressUser,Postal,PANNO,AadharNo,BusinessPAN,BusinessProof,NatureOfBusiness,Gender,DOB,FatherName,State,Regdate,Status,FaceVerificationResult,RegistrationStatus,UserType)" +
                    "values(@AccountType,@BusinessType,@CompanyName,@FullName,@MobileNo,@Email,@MPIN,@AddressUser,@Postal,@PANNO,@AadharNo ,@BusinessPAN,@BusinessProof,@NatureOfBusiness,@Gender,@DOB,@FatherName,@State,@Regdate  ,@Status,@FaceVerificationResult,@RegistrationStatus,@UserType)";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@AccountType", txtAccount1.SelectedValue);
                cmd.Parameters.AddWithValue("@BusinessType", ddlBusinessType.SelectedValue);
                cmd.Parameters.AddWithValue("@CompanyName", txtcompanyname.Text);
                cmd.Parameters.AddWithValue("@FullName", txtfullname.Text);
                cmd.Parameters.AddWithValue("@MobileNo", txtmobileno.Text);
                cmd.Parameters.AddWithValue("@Email", txtemailid.Text);
                cmd.Parameters.AddWithValue("@MPIN", txtpassword.Text);
                cmd.Parameters.AddWithValue("@AddressUser", txtaddress.Text);
                cmd.Parameters.AddWithValue("@Postal", txtpincode.Text);
                cmd.Parameters.AddWithValue("@PANNO", txtpancard.Text);
                cmd.Parameters.AddWithValue("@AadharNo", txtaadharcard.Text);

                cmd.Parameters.AddWithValue("@BusinessPAN", txtBusiPan.Text);
                cmd.Parameters.AddWithValue("@BusinessProof", ddlBusiProof.SelectedValue);
                cmd.Parameters.AddWithValue("@NatureOfBusiness", ddlNature.SelectedValue);
                cmd.Parameters.AddWithValue("@Gender", ddlGender.SelectedValue);
                cmd.Parameters.AddWithValue("@DOB", txtDOB.Text);
                cmd.Parameters.AddWithValue("@FatherName", txtFather.Text);
                cmd.Parameters.AddWithValue("@State", txtState.Text);

                cmd.Parameters.AddWithValue("@Regdate", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss.fff"));
                cmd.Parameters.AddWithValue("@Status", "1");
                cmd.Parameters.AddWithValue("@FaceVerificationResult", "True");
                cmd.Parameters.AddWithValue("@RegistrationStatus", "Done");
                cmd.Parameters.AddWithValue("@UserType", "Retailer");
                cmd.ExecuteNonQuery();
                con.Close();
                Response.Redirect("ViewUser.aspx");
            }
            catch (Exception ex)
            {
                Label1.Text = ex.ToString();
            }
            finally
            {
                con.Close();
            }
        }
    }
}