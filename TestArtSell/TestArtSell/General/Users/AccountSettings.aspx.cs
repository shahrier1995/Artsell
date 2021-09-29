using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Net.Mail;
using System.Net;
using System.Text;
using System.IO;

namespace TestArtSell.General.Users
{
    public partial class AccountSettings : System.Web.UI.Page
    {
        TestArtSell.CDA objCDA = new TestArtSell.CDA();

        protected void Page_Load(object sender, EventArgs e)
        {

        }
        private string createEmailBody(string userName, string pass)

        {

            string body = string.Empty;
            //using streamreader for reading my htmltemplate   

            using (StreamReader reader = new StreamReader(Server.MapPath("../Login_Registration/ForgetPassTemplate.html")))

            {

                body = reader.ReadToEnd();

            }

            body = body.Replace("{UserName}", userName); //replacing the required things  

            body = body.Replace("{Pass}", pass);




            return body;

        }
        protected void btnForgetPassClick_Click(object sender, EventArgs e)
        {
            string email = txtEmail.Text;
            string query = "Select * from tbl_User_Info where UserEmail='" + email + "'";
            DataSet ds = new DataSet();
            ds = objCDA.GetDataSet(query, "SMFM");
            string userID = ds.Tables[0].Rows[0]["ID"].ToString();
            string userName = ds.Tables[0].Rows[0]["UserFullName"].ToString();
            string userLoginID = ds.Tables[0].Rows[0]["UserID"].ToString();
            string strPwdchar = "abcdefghijklmnopqrstuvwxyz0123456789#+@&$ABCDEFGHIJKLMNOPQRSTUVWXYZ";
            string strPwd = "";
            Random rnd = new Random();
            for (int i = 0; i <= 5; i++)
            {
                int iRandom = rnd.Next(0, strPwdchar.Length - 1);
                strPwd += strPwdchar.Substring(iRandom, 1);
            }
            string randomPassword = strPwd;
            byte[] encData_byte = new byte[randomPassword.Length];
            encData_byte = System.Text.Encoding.UTF8.GetBytes(randomPassword);
            string encodedData = Convert.ToBase64String(encData_byte);
            string query2 = "update tbl_User_Info set UserPassword='" + encodedData + "' where ID='" + userID + "'";
            objCDA.ExecuteNonQuery(query2, "SMFM");


            MailMessage message = new MailMessage();
            message.From = new MailAddress("info@artsell.xyz");
            message.To.Add(new MailAddress(txtEmail.Text));
            message.Subject = "Account Activation";
            string body = this.createEmailBody(userName, randomPassword.ToString());
            message.Body = body;
            message.IsBodyHtml = true;
            SmtpClient smtp = new SmtpClient("artsell.xyz");
            smtp.Credentials = new System.Net.NetworkCredential("info@artsell.xyz", "password");
            smtp.Port =25;;
            smtp.EnableSsl = false;
            smtp.Send(message);


            ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('Varification Email sent.');", true);



        }
        protected void btnChange_click(object sender, EventArgs e)
        {
            string password = txtCurrentPass.Text.Trim();
            byte[] encData_byte = new byte[password.Length];
            encData_byte = System.Text.Encoding.UTF8.GetBytes(password);
            string encodedData = Convert.ToBase64String(encData_byte);
            string userID = Session["UserID"].ToString();
            string query = "Select * from tbl_User_Info where ID='" + userID + "' and Userpassword = '" + encodedData + "'";
            DataSet ds = objCDA.GetDataSet(query, "SMFM");
            if (ds == null)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('Current Password Didnt match');", true);
            }
            else
            {
                string newpassword = txtPass.Text.Trim();
                byte[] newencData_byte = new byte[newpassword.Length];
                newencData_byte = System.Text.Encoding.UTF8.GetBytes(newpassword);
                string newencodedData = Convert.ToBase64String(newencData_byte);
                string updateQuery = "update tbl_User_Info set Userpassword='"+ newencodedData + "' where ID='"+userID+"'";
                objCDA.ExecuteNonQuery(updateQuery,"SMFM");
                ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('Password Changed');", true);
            }


            }
        }
}