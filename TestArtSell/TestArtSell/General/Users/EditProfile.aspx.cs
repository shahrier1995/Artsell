using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;

namespace TestArtSell.General.Users
{
    public partial class EditProfile : System.Web.UI.Page
    {
        TestArtSell.CDA objcda = new TestArtSell.CDA();
        string loggedInUser = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) {
                loggedInUser = Session["UserID"].ToString();
                string query1 = "select * from tbl_user_info where ID='" + loggedInUser + "'";
                DataSet ds1 = new DataSet();
                ds1 = objcda.GetDataSet(query1, "SMFM");
                txtUserFullName.Text = ds1.Tables[0].Rows[0]["UserFullName"].ToString();
                txtUserID.Text = ds1.Tables[0].Rows[0]["UserID"].ToString();
                txtEmail.Text = ds1.Tables[0].Rows[0]["UserEmail"].ToString();
                txtContactNumber.Text = ds1.Tables[0].Rows[0]["UserContact"].ToString();
                txtAddress.Value = ds1.Tables[0].Rows[0]["UserAddress"].ToString();
                string gender = ds1.Tables[0].Rows[0]["UserGender"].ToString();
                if (gender == "Male")
                    Radiobtngender.Items[0].Selected = true;
                else if (gender == "Female")
                    Radiobtngender.Items[1].Selected = true;

            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            StartUpLoad();
        }
        private void StartUpLoad()
        {
            string imgName = string.Empty;
            int imgSize = 0;
            string imgPath = string.Empty;
            loggedInUser = Session["UserID"].ToString();

            //validates the posted file before saving  
            if (FileUpload1.PostedFile != null && FileUpload1.PostedFile.FileName != "")
            {
                string userID = txtUserID.Text;
                string userName = txtUserFullName.Text;
                string userContact = txtContactNumber.Text;
                string userEmail = txtEmail.Text;
                string userAddress = txtAddress.Value;
                string gender = Radiobtngender.SelectedItem.Value;

                imgName = FileUpload1.PostedFile.FileName;

                imgPath = "~/images/Profile_Image/"+ userID+"_" + imgName;

                imgSize = FileUpload1.PostedFile.ContentLength;

                FileUpload1.SaveAs(Server.MapPath(imgPath));

                string dbPath = "../images/Profile_Image/" + userID + "_" + imgName;
                string query = "Update tbl_user_info set UserID='"+userID+ "',UserFullName='" + userName + "',UserContact='" + userContact + "',UserAddress='" + userAddress + "',UserEmail='" + userEmail + "',UserGender='" + gender + "',UserImage='"+ dbPath + "' where ID='" + loggedInUser+"'";

                objcda.ExecuteNonQuery(query, "SMFM");

         
            }
            else
            {
                string userID = txtUserID.Text;
                string userName = txtUserFullName.Text;
                string userContact = txtContactNumber.Text;
                string userEmail = txtEmail.Text;
                string userAddress = txtAddress.Value;
                string gender = Radiobtngender.SelectedItem.Value;
         
                string query = "Update tbl_user_info set UserID='" + userID + "',UserFullName='" + userName + "',UserContact='" + userContact + "',UserAddress='" + userAddress + "',UserEmail='" + userEmail + "',UserGender='" + gender + "' where ID='" + loggedInUser + "'";

                objcda.ExecuteNonQuery(query, "SMFM");
            }
            Page.Response.Redirect(Page.Request.Url.ToString(), true);
        }
        }
    }
