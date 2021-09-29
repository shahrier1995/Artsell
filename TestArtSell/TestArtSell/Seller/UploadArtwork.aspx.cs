using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.IO;
using System.Linq;
using System.Net.Mail;
using System.Threading;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TestArtSell.Seller
{
    public partial class UploadArtwork : System.Web.UI.Page
    {
        TestArtSell.CDA objcda = new TestArtSell.CDA();
        protected void Page_Load(object sender, EventArgs e)
        {


            if (!IsPostBack)
            {
                if (Session["UserID"] == null)
                {
                    Response.Redirect("..\\Login_Registration\\LoginForm.aspx");
                }
                else
                {
                    GetCategory();
                }

            }
        }
        public void GetCategory()
        {

            string query = "Select * from tbl_Item_Category";
            DataSet ds = objcda.GetDataSet(query, "SMFM");
            ddlCat.DataSource = ds.Tables[0];

            ddlCat.DataValueField = "CatID";
            ddlCat.DataTextField = "CatTitle";
            ddlCat.DataBind();
            ddlCat.Items.Insert(0, new ListItem("Select category", "NA"));
        }

        protected void btnSubmitArt_Click(object sender, EventArgs e)
        {
            
            try
            {
                StartUpLoad();
                //Thread.Sleep(20000);
                Response.Redirect("SellerGallery.aspx", false);
                //ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "ShowPopup2('Your Art has been Submitted Successfully','Please wait for a while','Your art will be published to gallery after verification')", true);
            }
            catch (Exception r)
            {

                Response.Redirect("../ErrorOccured.aspx");
            }

        }
        private void StartUpLoad()
        {
            string userIDVal = Session["UserID"].ToString();
            string userName = Session["UserName"].ToString();

            string imgName = string.Empty;
            int imgSize = 0;
            string imgPath = string.Empty;
            if (string.IsNullOrEmpty(txttitle.Text) || string.IsNullOrEmpty(txtDetails.Value) || string.IsNullOrEmpty(txtPrice.Text))
            {
                ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('Fill the Data');", true);
            }
            else
            {
                //validates the posted file before saving  
                if (FileUpload1.PostedFile != null && FileUpload1.PostedFile.FileName != "")
                {

                    imgName = userName + "_" + DateTime.Now.ToString("yyyyMMddHHmmss") +".jpg";


                    imgPath = "../images/Gallery/" + imgName;
                    Stream strm = FileUpload1.PostedFile.InputStream;
                    imgSize = FileUpload1.PostedFile.ContentLength;
                    FileUpload1.SaveAs(Server.MapPath(imgPath));
                    //Image1.ImageUrl = "~/" + imgPath;

                    string itemID = txttitle.Text;
                    string itemTitle = txttitle.Text;
                    string itemDetails = txtDetails.Value;
                    string itemPrice = txtPrice.Text;
                    //double itemPrice = Convert.ToDouble(txtPrice.Text);
                    double itemOwnerPart = Convert.ToDouble(txtPrice.Text) - (Convert.ToDouble(txtPrice.Text) * .20);
                    itemOwnerPart = Math.Round(itemOwnerPart, 0);
                    string catID = ddlCat.SelectedItem.Value;
                    double height = Convert.ToDouble(txtHeight.Text);
                    double width = Convert.ToDouble(txtWidth.Text);
                    string userID = Session["UserID"].ToString();
                    string dbPath = "../images/Gallery/" + imgName;
                    string query = "INSERT INTO tbl_Item_Info (Status,ItemID,ItemTitle,ItemPhoto,UserID,ItemPrice,ItemDetails,CatID,Height,Width,ItemOwnerPart) VALUES ('RE','" + itemID.Replace("'", "''") + "','" + itemTitle.Replace("'", "''") + "','" + dbPath + "','" + userID + "','" + itemPrice.ToString() + "','" + itemDetails.Replace("'", "''") + "','" + catID + "'," + height + "," + width + ",'" + itemOwnerPart.ToString() + "')";

                    objcda.ExecuteNonQuery(query, "SMFM");
                    SendMail();
                    SendMailAdmin();
                    //GetGalleryData();
                }
                else
                {


                    //validates the posted file before saving  
                    if (FileUpload1.PostedFile != null && FileUpload1.PostedFile.FileName != "")
                    {

                        //imgName = userName + "_" + DateTime.Now.ToString();
                        imgName = userName + "_" + DateTime.Now.ToString("yyyyMMddHHmmss") +".jpg";

                        imgPath = "../images/Gallery/" + imgName;

                        imgSize = FileUpload1.PostedFile.ContentLength;

                        FileUpload1.SaveAs(Server.MapPath(imgPath));


                        string itemID = txttitle.Text;
                        string itemTitle = txttitle.Text;
                        string itemDetails = txtDetails.Value;
                        string itemPrice = txtPrice.Text;
                        //double itemPrice = Convert.ToDouble(txtPrice.Text);
                        double itemOwnerPart = Convert.ToDouble(txtPrice.Text) - (Convert.ToDouble(txtPrice.Text) * .20);
                        string catID = ddlCat.SelectedItem.Value;
                        double height = Convert.ToDouble(txtHeight.Text);
                        double width = Convert.ToDouble(txtWidth.Text);
                        string PhotoID = Session["PhotoId"].ToString();
                        string dbPath = "../images/Gallery/" + imgName;
                        string query = "Update tbl_Item_Info Status='RE', ItemTitle='" + itemTitle.Replace("'", "''") + "',ItemPhoto='" + dbPath + "',ItemDetails='" + itemDetails.Replace("'", "''") + "',CatID='" + catID + "',Height=" + height + ",Width=" + width + ", ItemOwnerPart='" + itemOwnerPart.ToString() + "' where ID= '" + PhotoID + "'";

                        objcda.ExecuteNonQuery(query, "SMFM");
                        SendMail();
                        //GetGalleryData();
                    }
                }
                
                //ClientScript.RegisterStartupScript(this.GetType(), "Popup", "$('#successModal').modal('show')", true);
                //ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('Thank You.Please wait for admin approval');", true);
            }
            
        }
        private string createEmailBody(string userName,string bodyType)
        {

            string body = string.Empty;
            //using streamreader for reading my htmltemplate   

            using (StreamReader reader = new StreamReader(Server.MapPath("UploadArtMessage.html")))

            {

                body = reader.ReadToEnd();

            }

            body = body.Replace("{UserName}", userName);  //replacing the required things 
            body = body.Replace("{BodyType}", bodyType);
            return body;

        }
        public void SendMail()
        {
            string userIDVal = Session["UserID"].ToString();
            string getUserInformation = "Select UserFullName ,UserEmail from tbl_user_info where ID='" + userIDVal + "'";
            DataSet ds =  objcda.GetDataSet(getUserInformation, "SMFM"); 
            string userName = ds.Tables[0].Rows[0]["UserFullName"].ToString();
            string userEmail = ds.Tables[0].Rows[0]["UserEmail"].ToString();
            MailMessage message = new MailMessage();
            message.From = new MailAddress("info@artsell.xyz");
            message.To.Add(new MailAddress(userEmail));
            message.Subject = "Art submitted";
            string body = this.createEmailBody(userName,"Your art has been submitted");
            message.Body = body;
            message.IsBodyHtml = true;
            SmtpClient smtp = new SmtpClient("artsell.xyz");
            smtp.Credentials = new System.Net.NetworkCredential("info@artsell.xyz", "password");
            smtp.Port =25;;
            smtp.EnableSsl = false;
            smtp.Send(message);

        }
      
        public void SendMailAdmin()
        {
            string userIDVal = Session["UserID"].ToString();
            string getUserInformation = "Select UserFullName ,UserEmail from tbl_user_info where ID='" + userIDVal + "'";
            DataSet ds = objcda.GetDataSet(getUserInformation, "SMFM");
            string userName = ds.Tables[0].Rows[0]["UserFullName"].ToString();
            string userEmail = ds.Tables[0].Rows[0]["UserEmail"].ToString();
            MailMessage message = new MailMessage();
            message.From = new MailAddress("info@artsell.xyz");
            message.To.Add(new MailAddress("shahrier.1995@gmail.com"));
            message.Subject = "Art submitted";
            SmtpClient smtp = new SmtpClient("artsell.xyz");
            string body = this.createEmailBody("Admin", "'" + userName + "' uploaded an art");
            message.Body = body;
            message.IsBodyHtml = true;
            smtp.Credentials = new System.Net.NetworkCredential("info@artsell.xyz", "password");
            smtp.Port =25;;
            smtp.EnableSsl = false;
            smtp.Send(message);
        }
        protected void goToGallery_Click(object sender, EventArgs e)
        {
            Response.Redirect("SellerGallery.aspx");
        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            Response.Redirect("SellerGallery.aspx");
        }
    }
}