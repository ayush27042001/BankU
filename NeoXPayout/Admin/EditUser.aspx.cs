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
    public partial class EditUser : System.Web.UI.Page
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
            string query = "SELECT * FROM Registration WHERE RegistrationId = @ID";
            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@ID", ID);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            if (dt.Rows.Count > 0)
            {
                txtcompanyname.Text = dt.Rows[0]["CompanyName"].ToString();
                txtfullname.Text = dt.Rows[0]["FullName"].ToString();
                txtmobileno.Text = dt.Rows[0]["MobileNo"].ToString();
                txtemailid.Text = dt.Rows[0]["Email"].ToString();
                txtpassword.Text = dt.Rows[0]["MPIN"].ToString();
                txtaddress.Text = dt.Rows[0]["AddressUser"].ToString();
                txtpincode.Text = dt.Rows[0]["Postal"].ToString();
                txtaadharcard.Text = dt.Rows[0]["AadharNo"].ToString();
                txtpancard.Text = dt.Rows[0]["PANNO"].ToString();              
                txtBusiPan.Text = dt.Rows[0]["BusinessPAN"].ToString();
                txtFather.Text = dt.Rows[0]["FatherName"].ToString();
                txtState.Text = dt.Rows[0]["State"].ToString();
                ddlBusinessType.SelectedValue=dt.Rows[0]["BusinessType"].ToString();
                ddlBusiProof.SelectedValue= dt.Rows[0]["BusinessProof"].ToString();
                ddlGender.SelectedValue= dt.Rows[0]["Gender"].ToString();
                ddlNature.SelectedValue= dt.Rows[0]["NatureOfBusiness"].ToString();
                txtAccount1.SelectedValue= dt.Rows[0]["AccountType"].ToString();
              
                if (dt.Rows[0]["DOB"] != DBNull.Value)
                {
                    DateTime dob = Convert.ToDateTime(dt.Rows[0]["DOB"]);
                   
                    txtDOB.Text = dob.ToString("yyyy-MM-dd");
                }

            }
            else
            {
                Response.Write("<script>alert('Product not found'); window.location='ViewUser.aspx';</script>");
            }
        }
        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            string ID = Request.QueryString["ID"];
            try
            {
               
                con.Open();
                string query = "UPDATE Registration SET AccountType=@AccountType, BusinessType=@BusinessType, CompanyName=@CompanyName, FullName=@FullName, " +
                        " MobileNo=@MobileNo, Email=@Email, MPIN=@MPIN, AddressUser=@AddressUser, Postal=@Postal, PANNO=@PANNO, AadharNo=@AadharNo, " +
                        "BusinessPAN=@BusinessPAN, BusinessProof=@BusinessProof, NatureOfBusiness=@NatureOfBusiness,Gender=@Gender,DOB=@DOB,FatherName=@FatherName,State=@State,UserType=@UserType WHERE RegistrationId = @ID";
               
              
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
                cmd.Parameters.AddWithValue("@Id", ID);
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

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            string productId = Request.QueryString["ID"];
            if (string.IsNullOrEmpty(productId))
            {
                Response.Write("<script>alert('Invalid Product ID');</script>");
                return;
            }

            try
            {
                con.Open();
                string sql = "DELETE FROM Registration WHERE RegistrationID=@ID";
                SqlCommand cmd = new SqlCommand(sql, con);
                cmd.Parameters.AddWithValue("@ID", productId);
                cmd.ExecuteNonQuery();
                Response.Write("<script>alert('Product Deleted Successfully'); window.location='ViewUser.aspx';</script>");
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error: " + ex.Message + "');</script>");
            }
            finally
            {
                con.Close();
            }
        }
    }
}