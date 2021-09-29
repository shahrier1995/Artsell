using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TestArtSell.General
{
    public partial class UserMaster : System.Web.UI.MasterPage
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
                    GetUserInfo();
                }
            }

        }
        

        protected void btnLogOut_Click(object sender, EventArgs e)
        {
            Session.Remove("UserID");
            //Response.Redirect("~\\Login_Registration\\LoginForm.aspx");
            Response.Redirect("~\\LandingPages\\Home.aspx");


        }
        protected void BecomSeller_click(object sender, EventArgs e)
        {
            
            Response.Redirect("~\\Login_Registration\\SellerRegistration.aspx");
        }
        public void GetUserInfo()
         {
            var str_userType = "";
           
            string userID = Session["UserID"].ToString();
            string query = "select * from tbl_User_Info Where ID='" + userID + "' ";
            DataSet ds = objcda.GetDataSet(query, "SMFM");
            string ID = ds.Tables[0].Rows[0]["ID"].ToString();
            if (ds.Tables[0].Rows.Count > 0)
            {
                foreach (DataRow dr in ds.Tables[0].Rows)
                {
                    var fullName = dr["UserFullName"].ToString();
                    var userEmail = dr["UserEmail"].ToString();
                    var str_userID = dr["UserID"].ToString();
                    var userImage = dr["UserImage"].ToString();
                    str_userType = dr["UserType"].ToString();
                    var names = fullName.Split(' ');
                    string firstName = names[0];

                    lblFirstName.Text = firstName;
                    lblFullName.Text = fullName;
                    lblUserEmail.Text = userEmail;
                    lblUserNameInSideBar.InnerText = fullName;
                    lblUserIDInSideBar.InnerText = "@" + str_userID;
                    imgProfile.Src = userImage;
                    imgMainProImage.Src = userImage;
                    //imgProfile1.Src = userImage;
                    imgMainUserImg.Src = userImage;
                }


            }
            string userTypeQuery = "";
            DataSet ds1 = new DataSet();
            if (str_userType == "SE")
            {
                userTypeQuery = "select COUNT(ODRID) as ordereq from tbl_Order_Details where STATUS IN ('OC') AND UserID='" + userID + "'";
                ds1 = objcda.GetDataSet(userTypeQuery, "SMFM");
                rptDashBoard.DataSource = ds1;
                rptDashBoard.DataBind();
                foreach (RepeaterItem item in rptDashBoard.Items)
                {

                    //item.FindControl("liBSeller").Visible = false;
                    item.FindControl("liBuyerDash").Visible = false;
                    item.FindControl("liMyOrder").Visible = true;
                    item.FindControl("liOrderReq").Visible = true;
                    item.FindControl("liGallery").Visible = true;
                    item.FindControl("liSellHist").Visible = true;
                    //item.FindControl("liOrderHistory").Visible = true;
                    item.FindControl("liSellDash").Visible = true;
                    item.FindControl("liUpload").Visible = true;

                }
                liBSeller.Visible = false;

            }
            else
            {
                userTypeQuery = "select COUNT(ODRID) as ordereq from tbl_Order_Details where  UserID='" + userID + "'";
                ds1 = objcda.GetDataSet(userTypeQuery,"SMFM");
                rptDashBoard.DataSource = ds1;
                rptDashBoard.DataBind();
                foreach (RepeaterItem item in rptDashBoard.Items)
                {
                    item.FindControl("liBuyerDash").Visible = true;
                    item.FindControl("liSellDash").Visible = false;
                    item.FindControl("liUpload").Visible = false;

                    //item.FindControl("liBSeller").Visible = true;
                    item.FindControl("liMyOrder").Visible = true;
                    //item.FindControl("liOrderHistory").Visible = true;
                    item.FindControl("liOrderReq").Visible = false;
                    item.FindControl("liGallery").Visible = false;
                    item.FindControl("liSellHist").Visible = false;
                }
                liBSeller.Visible = true;
            }
            
        }


        protected void btnRedirect_Click(object sender, EventArgs e)
        {
            Response.Redirect("..\\General\\Orders\\OrderHistory.aspx");
        }
    }
}