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
    public partial class WishList : System.Web.UI.Page
    {

        TestArtSell.CDA objcda = new TestArtSell.CDA();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("Home.aspx");
            }
            else
            {
                LoadLandingGallery();
            }
           

        }

        public void LoadLandingGallery()
        {

            DataSet ds = new DataSet();
            string userID = Session["UserID"].ToString();
            string query = "SELECT a.ItemPhoto,a.ItemDetails,a.ItemTitle,a.ItemPrice,a.ID,a.[Status],b.wishStatus FROM tbl_Item_Info A LEFT JOIN(SELECT b.[Status] as wishStatus, b.ItemID FROM[tbl_WishList] B WHERE UserID = '" + userID + "') B ON A.ID = B.ItemID where b.wishStatus='AD'";
            ds = objcda.GetDataSet(query, "SMFM");
            rptGallery.DataSource = ds;
            rptGallery.DataBind();
            if (ds==null)
            {
                noOrder.Visible = true;
            }
            else
            {
                noOrder.Visible = false;
            
            }
           
            
        }
        protected void DeletefromWishList(object source, CommandEventArgs e)
        {
            string userID = Session["UserID"].ToString();
            string itemID = e.CommandArgument.ToString();
            string updateQuery = "Update  tbl_wishlist Set Status='ND' where ItemID='" + itemID + "' and UserID='" + userID + "'";
            objcda.ExecuteNonQuery(updateQuery, "SMFM");
            LoadLandingGallery();
        }
    }
}