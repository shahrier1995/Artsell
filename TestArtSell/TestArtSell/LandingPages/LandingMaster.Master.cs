using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
namespace TestArtSell.LandingPages
{
    public partial class LandingMaster : System.Web.UI.MasterPage
    {
        TestArtSell.CDA objcda = new TestArtSell.CDA();
        protected void Page_Load(object sender, EventArgs e)
        {
            LoginCheck();
        }

        protected void LoginCheck()
        {
            if (Session["UserID"]==null)
            {
                btnLogin.Visible = true;
                btnMember.Visible = true;
                btnExpand.Visible = false;
                btnLogout.Visible = false;
                LinkUser.Visible = false;


            }

            else
            {
                string UserID = Session["UserID"].ToString();
                DataSet ds = new DataSet();
                string queryGetUserName = "Select * from tbl_User_Info where ID='"+UserID+"'";
                ds = objcda.GetDataSet(queryGetUserName,"SMFM");
                string userName = ds.Tables[0].Rows[0]["UserFullName"].ToString();
                string userType= ds.Tables[0].Rows[0]["UserType"].ToString();
                btnLogin.Visible = false;
                btnMember.Visible = false;


                LinkUser.Visible = true;
                LinkUser.Text = userName;
                btnExpand.Visible = true;
                btnLogout.Visible = true;
              
            }
        }
        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Remove("UserID");
            Response.Redirect("Home.aspx");
        }
         protected void btnWishList_Click(object sender, EventArgs e)
        {
          
            Response.Redirect("WishList.aspx");
        }
        
        protected void btnDashboard_Click(object sender, EventArgs e)
        {
            string UserID = Session["UserID"].ToString();
            DataSet ds = new DataSet();
            string queryGetUserName = "Select * from tbl_User_Info where ID='" + UserID + "'";
            ds = objcda.GetDataSet(queryGetUserName, "SMFM");
            string userName = ds.Tables[0].Rows[0]["UserFullName"].ToString();
            string userType = ds.Tables[0].Rows[0]["UserType"].ToString();
            if (userType == "SE")
            {
                Response.Redirect("..\\Seller\\SellerDashboard.aspx");
            }
            else
            {
                Response.Redirect("..\\Buyer\\BuyerDashboard.aspx");
            }
        }
    }
}