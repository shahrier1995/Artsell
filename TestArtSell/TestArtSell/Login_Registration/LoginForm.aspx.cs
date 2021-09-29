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

namespace TestArtSell.Login_Registration
{
    public partial class LoginForm1 : System.Web.UI.Page
    {
        TestArtSell.CDA objCDA = new TestArtSell.CDA();


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (mv.ActiveViewIndex == 1)
                {
                    mv.ActiveViewIndex = 1;
                }
                else
                {
                    mv.ActiveViewIndex = 0;
                }
            }

        }
        private string createEmailBody(string userName, string pass)

        {

            string body = string.Empty;
            //using streamreader for reading my htmltemplate   

            using (StreamReader reader = new StreamReader(Server.MapPath("ForgetPassTemplate.html")))

            {

                body = reader.ReadToEnd();

            }

            body = body.Replace("{UserName}", userName); //replacing the required things  

            body = body.Replace("{Pass}", pass);
          



            return body;

        }
        protected void btnForgetPassClick_Click(object sender, EventArgs e)
        {
            try
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
                smtp.Credentials = new System.Net.NetworkCredential("Email", "Password");
                smtp.Port =25;;
                smtp.EnableSsl = false;
                smtp.Send(message);

                ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "ShowPopup2('Email Sent Successfully','Please Check your email and reset your password.')", true);

            }
            catch (Exception)
            {

                ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "ShowPopup3('Email Sending Failed','Please input your registerd email address.')", true);
            }


          
            


        }
        protected void btnLogin_Click(object sender, EventArgs e)
        {
            


            string password = txtPass.Text.Trim();
            byte[] encData_byte = new byte[password.Length];
            encData_byte = System.Text.Encoding.UTF8.GetBytes(password);
            string encodedData = Convert.ToBase64String(encData_byte);

            string query = "Select * from tbl_User_Info where UserID='" + txtUserID.Text + "' and Userpassword = '" + encodedData + "' ";
            DataSet ds = objCDA.GetDataSet(query, "SMFM");
            if (ds == null)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "ShowPopup('Login Failed','You have entered incorrect username or password.')", true);
                //ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('failed');", true);
            }
            else
            {
                string UserStatus= ds.Tables[0].Rows[0]["UserStatus"].ToString();
                string USerID = ds.Tables[0].Rows[0]["ID"].ToString();
                if (UserStatus != "AC")
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "ShowPopup('Login Failed','Please Activate Your Account via verifying Your Email.')", true);

                    //Response.Write("<script>alert('Please Activate Your ID')</script>");
                    Response.Redirect("VarificationForm.aspx?UserID='"+USerID+"'");
                }
                else
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('successs');", true);
                    if (ds.Tables[0].Rows[0]["UserType"].ToString() == "SE")
                    {
                        string id = ds.Tables[0].Rows[0]["ID"].ToString();
                        string userName = ds.Tables[0].Rows[0]["UserID"].ToString();
                        Session["UserID"] = ds.Tables[0].Rows[0]["ID"].ToString();
                        Session["UserName"] = ds.Tables[0].Rows[0]["UserID"].ToString();
                        string queryLoginLog = "insert into tbl_login_Log(userID) values('" + id + "')";
                        objCDA.ExecuteNonQuery(queryLoginLog, "SMFM");
                        Response.Redirect("..\\Seller\\SellerDashboard.aspx?id=" + id + "");

                    }
                    else if (ds.Tables[0].Rows[0]["UserType"].ToString() == "111")
                    {
                        string id = ds.Tables[0].Rows[0]["ID"].ToString();
                        Session["UserID"] = ds.Tables[0].Rows[0]["ID"].ToString();
                        string queryLoginLog = "insert into tbl_login_Log(userID) values('" + id + "')";
                        objCDA.ExecuteNonQuery(queryLoginLog, "SMFM");
                        Response.Redirect("..\\Admin\\AdminDashboard.aspx?id=" + id + "");
                    }
                    else
                    {
                        string id = ds.Tables[0].Rows[0]["ID"].ToString();
                        Session["UserID"] = ds.Tables[0].Rows[0]["ID"].ToString();
                        string queryLoginLog = "insert into tbl_login_Log(userID) values('" + id + "')";
                        objCDA.ExecuteNonQuery(queryLoginLog, "SMFM");
                        Response.Redirect("..\\Buyer\\BuyerDashboard.aspx?id=" + id + "");
                    }
                }
      
            }

        }

        protected void regLink_Click(object sender, EventArgs e)
        {
            mv.ActiveViewIndex = 1;
            
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("..//landingPages//home.aspx");
        }

        protected void btnSeller_Click(object sender, EventArgs e)
        {
            Response.Redirect("SellerRegistration.aspx");
        }

        protected void btnBuyer_Click(object sender, EventArgs e)
        {
            Response.Redirect("RegistrationForm.aspx");
        }

        protected void btnBackToLogin_Click(object sender, EventArgs e)
        {
            mv.ActiveViewIndex = 0;
        }

        protected void btnBackToLoginFromModal_Click(object sender, EventArgs e)
        {
            Response.Redirect("LoginForm.aspx");
        }
    }
}