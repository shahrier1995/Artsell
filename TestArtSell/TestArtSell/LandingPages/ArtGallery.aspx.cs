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
    public partial class ArtGallery : System.Web.UI.Page
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

            ddlCategory.DataSource = ds1;
            ddlCategory.DataValueField = ds1.Tables[0].Columns["ID"].ToString();
            ddlCategory.DataTextField = ds1.Tables[0].Columns["CatTitle"].ToString();

            ddlCategory.DataBind();
            ddlCategory.Items.Insert(0, new ListItem("Select category", "0"));
            ddlPricerange.Items.Insert(0, new ListItem("Select range", "0"));

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
    }
}