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
    public partial class VarificationForm : System.Web.UI.Page
    {
        TestArtSell.CDA objCDA = new TestArtSell.CDA();
        DataSet ds = new DataSet();
        string NewuserID = "";
        
        
        protected void Page_Load(object sender, EventArgs e)
        {
             NewuserID = Request.QueryString["UserID"];
        }
        private string createEmailBody(string userName, string otp,string userID)

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
        protected void btnVarification_Click(object sender, EventArgs e)
        {
            NewuserID = Request.QueryString["UserID"];

            string query = "select * from tbl_User_Info where id=" + NewuserID + "";
            ds = objCDA.GetDataSet(query, "SMFM");
            if (ds == null)
            {
                Response.Write("<script>alert('Please Register')</script>");
            }
            else
            {
                string baseotp = ds.Tables[0].Rows[0]["ActicationCode"].ToString();
                string currOtp = txtVariCode.Text;
                if (baseotp == currOtp)
                {
                    string Updatequery = "Update tbl_User_Info set UserStatus='AC' where ID="+NewuserID+"";
                    objCDA.ExecuteNonQuery(Updatequery, "SMFM");
                    Response.Write("<script>alert('Registration Successfull')</script>");
                    if (ds.Tables[0].Rows[0]["UserType"].ToString() == "SE")
                    {
                        string id = ds.Tables[0].Rows[0]["ID"].ToString();
                        Session["UserID"] = ds.Tables[0].Rows[0]["ID"].ToString();
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
                else
                {
                    Response.Write("<script>alert('OTP error')</script>");
                }
            }

        }
        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("..//landingPages//home.aspx");
        }

        protected void regLink_Click(object sender, EventArgs e)
        {
            string userEmail =objCDA.getSingleValue("Select UserEmail from tbl_User_Info where ID=" + NewuserID + "","SMFM").ToString();
            Random _rdm = new Random();
            int OTP = _rdm.Next(1000, 9999);
            string Updatequery = "Update tbl_User_Info set ActicationCode='" + OTP + "' where ID=" + NewuserID + "";
            objCDA.ExecuteNonQuery(Updatequery, "SMFM");
            string selectQuery = "Select * from tbl_User_Info where ID=" + NewuserID + "";
            DataSet ds1 = new DataSet();
            ds1 = objCDA.GetDataSet(selectQuery, "SMFM");
            string username = ds1.Tables[0].Rows[0]["UserFullName"].ToString();
            MailMessage message = new MailMessage();
            message.From = new MailAddress("info@artsell.xyz");
            message.To.Add(new MailAddress(userEmail));
            message.Subject = "Account Activation";
            string body = this.createEmailBody(username, OTP.ToString(), NewuserID);
            message.Body = body;
            message.IsBodyHtml = true;
            SmtpClient smtp = new SmtpClient("artsell.xyz");
            smtp.Credentials = new System.Net.NetworkCredential("info@artsell.xyz", "password");
            smtp.Port =25;;
            smtp.EnableSsl = false;
            smtp.Send(message);
            lblEmailSent.Visible = true;
            lblEmailSent.Text = "Email has been sent";
            lblEmailSent.ForeColor = System.Drawing.Color.Red;


            ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('Varification Email sent.');", true);
        }
        protected void btnForgetPassClick_Click(object sender, EventArgs e)
        {
           
      
           



        }
    }
}