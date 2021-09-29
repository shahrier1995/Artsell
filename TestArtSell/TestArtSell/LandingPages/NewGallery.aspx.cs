using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Web.Services;
using Newtonsoft.Json;
using System.Xml;
using System.Configuration;
using System.Web.Script.Services;

namespace TestArtSell.LandingPages
{
    public partial class NewGallery :Page
    {
        TestArtSell.CDA objcda = new TestArtSell.CDA();
        string catID = "";
        DataSet ds = new DataSet();
        string query = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                //GetCustomersPageWise(1);
                LoadLandingGallery();




            }
        }

   
        public void LoadLandingGallery()
        {

            string queryCat = "select * from tbl_Item_Category ";
            DataSet ds1 = objcda.GetDataSet(queryCat, "SMFM");


            query = "";
            catID = Request.QueryString["CatID"];
            if (catID == null)
            {
                if (Session["UserID"] == null)
                {
                    string query1 = "select *,null AS wishStatus from tbl_Item_Info ";
                    ds = objcda.GetDataSet(query1, "SMFM");

                    rptGallery.DataSource = ds;

                    rptGallery.DataBind();
                }
                else
                {
                    string userID = Session["UserID"].ToString();
                    string query1 = "SELECT a.ItemPhoto,a.ItemDetails,a.ItemTitle,a.ItemPrice,a.ID,a.[Status],b.wishStatus FROM tbl_Item_Info A LEFT JOIN(SELECT b.[Status] as wishStatus, b.ItemID FROM[tbl_WishList] B WHERE UserID = '" + userID + "') B ON A.ID = B.ItemID";
                    ds = objcda.GetDataSet(query1, "SMFM");

                    rptGallery.DataSource = ds;

                    rptGallery.DataBind();
                }

            }
            else
            {

                if (Session["UserID"] == null)
                {

                }
                else
                {
                    string userID = Session["UserID"].ToString();
                    string query1 = "SELECT a.ItemPhoto,a.ItemDetails,a.ItemTitle,a.ItemPrice,a.ID,a.[Status],b.wishStatus FROM tbl_Item_Info A LEFT JOIN(SELECT b.[Status] as wishStatus, b.ItemID FROM[tbl_WishList] B WHERE UserID = '" + userID + "') B ON A.ID = B.ItemID where CatID='" + catID + "'";
                    ds = objcda.GetDataSet(query1, "SMFM");

                    rptGallery.DataSource = ds;

                    rptGallery.DataBind();
                }


            }


        }


        protected void AddToWishList(object source, CommandEventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("../Login_Registration/LoginForm.aspx");
            }
            else
            {
                string userID = Session["UserID"].ToString();
                string itemID = e.CommandArgument.ToString();

                string insertQuery = "insert into tbl_wishlist(Status,ItemID,UserID) values('AD','" + itemID + "','" + userID + "')";
                objcda.ExecuteNonQuery(insertQuery, "SMFM");




            }
            LoadLandingGallery();

        }

    }
}