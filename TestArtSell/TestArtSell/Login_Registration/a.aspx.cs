using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TestArtSell.Login_Registration
{
    public partial class Registration : System.Web.UI.Page
    {
        TestArtSell.CDA objCDA = new TestArtSell.CDA();
        DataSet ds = new DataSet();
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnRegistration_Click(object sender, EventArgs e)
        {
            
            string query = "DECLARE @TBL AS TABLE(ID nvarchar(36)) INSERT INTO tbl_User_Info (UserFullName,UserID,UserContact,UserEmail,UserPassword,UserStatus)  OUTPUT inserted.ID INTO @TBL VALUES('" + txtUserFullName.Text + "','" + txtUserID.Text + "','" + txtContactNumber.Text + "','" + txtEmail.Text + "','" + txtPass.Text + "',0) SELECT * FROM @TBL  ; ";
            ds = objCDA.GetDataSet(query, "SMFM");
            string NewUserID = ds.Tables[0].Rows[0]["ID"].ToString();
            string activationCode = Guid.NewGuid().ToString();

            using (MailMessage mm = new MailMessage("shahrier.lged@gmail.com", txtEmail.Text))
            {
                mm.Subject = "Account Activation";
                string body = "Hello " + txtUserFullName.Text.Trim() + ",";
                body += "<br /><br />Please click the following link to activate your account";
                body += "<br /><a href = '" + Request.Url.AbsoluteUri.Replace("Login_Registration/Registration.aspx", "LandingPages/Home.aspx?ActivationCode=" + activationCode+"&NewUserID="+ NewUserID + "&status=0") + "'>Click here to activate your account.</a>";
                body += "<br /><br />Thanks";
                mm.Body = body;
                mm.IsBodyHtml = true;
                SmtpClient smtp = new SmtpClient();
                smtp.Host = "smtp.gmail.com";
                smtp.EnableSsl = true;
                NetworkCredential NetworkCred = new NetworkCredential("shahrier.lged@gmail.com", "password");
                smtp.UseDefaultCredentials = true;
                smtp.Credentials = NetworkCred;
                smtp.Port = 587;
                smtp.Send(mm);
            }
            ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('Varification Email sent.');", true);

        }
        [System.Web.Services.WebMethod]
        public static string CheckEmail(string useroremail)
        {
            TestArtSell.CDA objCDA = new TestArtSell.CDA();
            DataSet ds = new DataSet();
            string query = "select * from tbl_User_Info where UserID='" + useroremail + "'";
            ds = objCDA.GetDataSet(query,"SMFM");
            string retval = "";
    
            if (ds!=null)
            {
                retval = "true";
            }
            else
            {
                retval = "false";
            }

            return retval;
        }

        protected void TextBox1_Unload(object sender, EventArgs e)
        {

        }
    }
}