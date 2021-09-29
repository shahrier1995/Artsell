using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TestArtSell.Login_Registration
{
    public partial class RegistrationForm : System.Web.UI.Page
    {

        TestArtSell.CDA objCDA = new TestArtSell.CDA();
        DataSet ds = new DataSet();
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        private string createEmailBody(string userName, string otp, string userID)
        {

            string body = string.Empty;
            //using streamreader for reading my htmltemplate   

            using (StreamReader reader = new StreamReader(Server.MapPath("VarificationTemplate.html")))

            {

                body = reader.ReadToEnd();

            }

            body = body.Replace("{UserName}", userName); //replacing the required things  

            body = body.Replace("{otp}", otp);
            body = body.Replace("{UserID}", userID);



            return body;

        }
        protected void btnRegistration_Click(object sender, EventArgs e)
        {
            try
            {
                string password = txtPass.Text.Trim();
                byte[] encData_byte = new byte[password.Length];
                encData_byte = System.Text.Encoding.UTF8.GetBytes(password);
                string encodedData = Convert.ToBase64String(encData_byte);
                Random _rdm = new Random();
                int OTP = _rdm.Next(1000, 9999);
                string userDemoImg = "../images/Gallery/proImg.png";
                string query = "DECLARE @TBL AS TABLE(ID nvarchar(36)) INSERT INTO tbl_User_Info (UserFullName,UserID,UserContact,UserEmail,UserPassword,UserStatus,UserType,ActicationCode,UserImage)  OUTPUT inserted.ID INTO @TBL VALUES('" + txtUserFullName.Text + "','" + txtUserID.Text + "','" + txtContactNumber.Text + "','" + txtEmail.Text + "','" + encodedData + "','RE','BU','" + OTP + "','" + userDemoImg + "') SELECT * FROM @TBL  ; ";
                ds = objCDA.GetDataSet(query, "SMFM");
                string NewUserID = ds.Tables[0].Rows[0]["ID"].ToString();



                MailMessage message = new MailMessage();
                message.From = new MailAddress("info@artsell.xyz");
                message.To.Add(new MailAddress(txtEmail.Text));
                message.Subject = "Account Activation";
                string body = this.createEmailBody(txtUserFullName.Text, OTP.ToString(), NewUserID);
                message.Body = body;
                message.IsBodyHtml = true;
                SmtpClient smtp = new SmtpClient("artsell.xyz");
                smtp.Credentials = new System.Net.NetworkCredential("info@artsell.xyz", "password");
                smtp.Port =25;;
                smtp.EnableSsl = false;
                smtp.Send(message);
                ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('Varification Email sent.');", true);
                Response.Redirect("VarificationForm.aspx?UserID='" + NewUserID + "'",false);
            }
            catch
            {
                Response.Redirect("../ErrorOccured.aspx");
            }
           

        }
        protected void Log_click(object sender, EventArgs e)
        {
            Response.Redirect("LoginForm.aspx");
        }
        [System.Web.Services.WebMethod]
        public static string CheckUserID(string useroremail, string useroremail2)
        {
            TestArtSell.CDA objCDA = new TestArtSell.CDA();
            DataSet dsuser = new DataSet();
            DataSet dsemail = new DataSet();

            string query = "select * from tbl_User_Info where UserID='" + useroremail + "'";


            string query2 = "select * from tbl_User_Info where UserEmail='" + useroremail2 + "'";

            dsuser = objCDA.GetDataSet(query, "SMFM");
            dsemail = objCDA.GetDataSet(query2, "SMFM");
            string retval = "";

            if (dsuser != null && dsemail != null)
            {

                retval = "true";
            }
            else
            {
                retval = "false";
            }

            return retval;
        }
        [System.Web.Services.WebMethod]
        public static string CheckEmail(string useroremail)
        {
            TestArtSell.CDA objCDA = new TestArtSell.CDA();
            DataSet ds = new DataSet();
            string query = "select * from tbl_User_Info where UserEmail='" + useroremail + "'";
            ds = objCDA.GetDataSet(query, "SMFM");
            string retval = "";

            if (ds != null)
            {
                
                retval = "true";
            }
            else
            {
                retval = "false";
            }

            return retval;
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            
            Response.Redirect("..//landingPages//home.aspx");
        }

        protected void txtUserID_TextChanged(object sender, EventArgs e)
        {
            CheckEmail_UserID();
        }

        protected void txtEmail_TextChanged(object sender, EventArgs e)
        {
            CheckEmail_UserID();
        }

        public void CheckEmail_UserID()
        {
            TestArtSell.CDA objCDA = new TestArtSell.CDA();
            DataSet dsuser = new DataSet();
            DataSet dsemail = new DataSet();

            string query = "select * from tbl_User_Info where UserID='" + txtUserID.Text.Trim() + "'";
            string query2 = "select * from tbl_User_Info where UserEmail='" + txtEmail.Text.Trim() + "'";

            dsuser = objCDA.GetDataSet(query, "SMFM");
            dsemail = objCDA.GetDataSet(query2, "SMFM");
            string retval = "";

            if (dsuser == null && dsemail == null)
            {

                //retval = "true";
                btnRegistration.Enabled = true;

                lblStatus.Text = "User ID not taken.";
                lblStatus.ForeColor = System.Drawing.Color.Red;
                lblStatus.Visible = false;
            }
            else if (dsuser != null && dsemail == null)
            {
                btnRegistration.Enabled = false;

                lblStatus.Text = "User ID taken";

                lblStatus.Visible = true;
                lblStatus.ForeColor = System.Drawing.Color.Red;
            }
            else if (dsuser == null && dsemail != null)
            {

                btnRegistration.Enabled = false;

                lblStatus.Text = "Email taken";

                lblStatus.Visible = true;
                lblStatus.ForeColor = System.Drawing.Color.Red;
            }
            else
            {
                btnRegistration.Enabled = false;

                lblStatus.Text = "User Id and Email Both taken";

                lblStatus.Visible = true;
                lblStatus.ForeColor = System.Drawing.Color.Red;
            }
        }
    }
}