using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using AjaxControlToolkit;
using System.Web.Services;
using System.Web.Script.Services;

namespace TestArtSell.LandingPages
{
    public partial class ArtsGallery : System.Web.UI.Page
    {
        TestArtSell.CDA objcda = new TestArtSell.CDA();
        string catID = "";
        DataSet ds = new DataSet();
        string query = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadLandingGallery();
            }

        }
        public void LoadLandingGallery()
        {


            string queryCat = "select * from tbl_Item_Category ";
            DataSet ds1 = objcda.GetDataSet(queryCat, "SMFM");

            ddlCategory.DataSource = ds1;
            ddlCategory.DataValueField = ds1.Tables[0].Columns["CatID"].ToString();
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
                    string query1 = "select *,null AS wishStatus from tbl_Item_Info where not (Status='DEL' or Status='RE')";
                    ds = objcda.GetDataSet(query1, "SMFM");

                    rptGallery.DataSource = ds;

                    rptGallery.DataBind();
                }
                else
                {
                    string userID = Session["UserID"].ToString();
                    string query1 = "SELECT a.ItemPhoto,a.ItemDetails,a.ItemTitle,a.ItemPrice,a.ID,a.[Status],b.wishStatus FROM tbl_Item_Info A LEFT JOIN(SELECT b.[Status] as wishStatus, b.ItemID FROM[tbl_WishList] B WHERE UserID = '" + userID + "') B ON A.ID = B.ItemID where not (a.Status='DEL' or a.Status='RE')";
                    ds = objcda.GetDataSet(query1, "SMFM");

                    rptGallery.DataSource = ds;

                    rptGallery.DataBind();
                }

            }
            else
            {

                if (Session["UserID"] == null)
                {
                    query = "select *,null AS wishStatus from tbl_Item_Info where not (Status='DEL' or Status='RE') and CatID='" + catID + "'";
                    ds = objcda.GetDataSet(query, "SMFM");
                    rptGallery.DataSource = ds;
                    rptGallery.DataBind();
                }
                else
                {
                    string userID = Session["UserID"].ToString();
                    string query1 = "SELECT a.ItemPhoto,a.ItemDetails,a.ItemTitle,a.ItemPrice,a.ID,a.[Status],b.wishStatus FROM tbl_Item_Info A LEFT JOIN(SELECT b.[Status] as wishStatus, b.ItemID FROM[tbl_WishList] B WHERE UserID = '" + userID + "') B ON A.ID = B.ItemID where not (a.Status='DEL' or a.Status='RE') and a.CatID='" + catID + "'";
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
        protected void ddlCategory_SelectedIndexChanged(object sender, EventArgs e)
        {

            catID = ddlCategory.SelectedItem.Value;

            if (catID == "0")
            {
                if (Session["UserID"] == null)
                {
                    query = "select *,null AS wishStatus from tbl_Item_Info where not (Status='DEL' or Status='RE')";
                    ds = objcda.GetDataSet(query, "SMFM");
                    rptGallery.DataSource = ds;
                    rptGallery.DataBind();
                }
                else
                {
                    string userID = Session["UserID"].ToString();
                    query = "SELECT a.ItemPhoto,a.ItemDetails,a.ItemTitle,a.ItemPrice,a.ID,a.[Status],b.wishStatus FROM tbl_Item_Info A LEFT JOIN(SELECT b.[Status] as wishStatus, b.ItemID FROM[tbl_WishList] B WHERE UserID = '" + userID + "') B ON A.ID = B.ItemID  where not (a.Status='DEL' or a.Status='RE')";
                    ds = objcda.GetDataSet(query, "SMFM");
                    rptGallery.DataSource = ds;
                    rptGallery.DataBind();

                }


            }
            else
            {
                if (Session["UserID"] == null)
                {
                    query = "select *,null AS wishStatus from tbl_Item_Info where not (Status='DEL' or Status='RE') and CatID='" + catID + "'";
                    ds = objcda.GetDataSet(query, "SMFM");
                    rptGallery.DataSource = ds;
                    rptGallery.DataBind();
                }
                else
                {
                    string userID = Session["UserID"].ToString();
                    query = "SELECT a.ItemPhoto,a.ItemDetails,a.ItemTitle,a.ItemPrice,a.ID,a.[Status],b.wishStatus FROM tbl_Item_Info A LEFT JOIN(SELECT b.[Status] as wishStatus, b.ItemID FROM[tbl_WishList] B WHERE UserID = '" + userID + "') B ON A.ID = B.ItemID where not (a.Status='DEL' or a.Status='RE') and CatID='" + catID + "'";
                    ds = objcda.GetDataSet(query, "SMFM");
                    rptGallery.DataSource = ds;
                    rptGallery.DataBind();
                }


            }

        }
        protected void ddlPriceRange_SelectedIndexChanged(object sender, EventArgs e)
        {
            string price = ddlPricerange.SelectedItem.Value;
            if (price == "0")
            {
                if (Session["UserID"] == null)
                {
                    query = "select * ,null AS wishStatus from tbl_Item_Info where not (Status='DEL' or Status='RE')";
                    ds = objcda.GetDataSet(query, "SMFM");
                    rptGallery.DataSource = ds;
                    rptGallery.DataBind();
                }
                else
                {
                    string userID = Session["UserID"].ToString();
                    query = "SELECT a.ItemPhoto,a.ItemDetails,a.ItemTitle,a.ItemPrice,a.ID,a.[Status],b.wishStatus FROM tbl_Item_Info A LEFT JOIN(SELECT b.[Status] as wishStatus, b.ItemID FROM[tbl_WishList] B WHERE UserID = '" + userID + "') B ON A.ID = B.ItemID where not (a.Status='DEL' or a.Status='RE')";
                    ds = objcda.GetDataSet(query, "SMFM");
                    rptGallery.DataSource = ds;
                    rptGallery.DataBind();
                }


            }
            else
            {
                string rangeFrom = "";
                string rangeTo = "";
                // Split authors separated by a comma followed by space  
                string[] priceArr = price.Split('&');
                rangeFrom = priceArr[0];
                rangeTo = priceArr[1];



                if (Session["UserID"] == null)
                {
                    query = "SELECT * ,null AS wishStatus FROM tbl_Item_Info where not (Status='DEL' or Status='RE') and ItemPrice BETWEEN " + Convert.ToInt16(rangeFrom) + " AND " + Convert.ToInt16(rangeTo) + "";
                    ds = objcda.GetDataSet(query, "SMFM");
                    rptGallery.DataSource = ds;
                    rptGallery.DataBind();

                }
                else
                {
                    string userID = Session["UserID"].ToString();
                    query = "SELECT a.ItemPhoto,a.ItemDetails,a.ItemTitle,a.ItemPrice,a.ID,a.[Status],b.wishStatus FROM tbl_Item_Info A LEFT JOIN(SELECT b.[Status] as wishStatus, b.ItemID FROM[tbl_WishList] B WHERE UserID = '" + userID + "') B ON A.ID = B.ItemID where not (a.Status='DEL' or a.Status='RE') and ItemPrice BETWEEN " + Convert.ToInt16(rangeFrom) + " AND " + Convert.ToInt16(rangeTo) + "";
                    ds = objcda.GetDataSet(query, "SMFM");
                    rptGallery.DataSource = ds;
                    rptGallery.DataBind();
                }



            }



        }
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            string itemName = txtSearch.Text;

            if (Session["UserID"] == null)
            {
                query = "  SELECT *,null AS wishStatus FROM tbl_Item_Info where not (Status='DEL' or Status='RE') and ItemTitle LIKE '%" + itemName + "%'";
                ds = objcda.GetDataSet(query, "SMFM");
                rptGallery.DataSource = ds;
                rptGallery.DataBind();
            }
            else
            {
                string userID = Session["UserID"].ToString();
                query = "SELECT a.ItemPhoto,a.ItemDetails,a.ItemTitle,a.ItemPrice,a.ID,a.[Status],b.wishStatus FROM tbl_Item_Info A LEFT JOIN(SELECT b.[Status] as wishStatus, b.ItemID FROM[tbl_WishList] B WHERE UserID = '" + userID + "') B ON A.ID = B.ItemID where not (a.Status='DEL' or a.Status='RE') and ItemTitle LIKE '%" + itemName + "%'";
                ds = objcda.GetDataSet(query, "SMFM");
                rptGallery.DataSource = ds;
                rptGallery.DataBind();
            }



        }

        protected void ddlCategory_SelectedIndexChanged1(object sender, EventArgs e)
        {
            catID = ddlCategory.SelectedItem.Value;

            if (catID == "0")
            {
                if (Session["UserID"] == null)
                {
                    query = "select *,null AS wishStatus from tbl_Item_Info where not (Status='DEL' or Status='RE')";
                    ds = objcda.GetDataSet(query, "SMFM");
                    rptGallery.DataSource = ds;
                    rptGallery.DataBind();
                }
                else
                {
                    string userID = Session["UserID"].ToString();
                    query = "SELECT a.ItemPhoto,a.ItemDetails,a.ItemTitle,a.ItemPrice,a.ID,a.[Status],b.wishStatus FROM tbl_Item_Info A LEFT JOIN(SELECT b.[Status] as wishStatus, b.ItemID FROM[tbl_WishList] B WHERE UserID = '" + userID + "') B ON A.ID = B.ItemID  where not (a.Status='DEL' or a.Status='RE')";
                    ds = objcda.GetDataSet(query, "SMFM");
                    rptGallery.DataSource = ds;
                    rptGallery.DataBind();

                }


            }
            else
            {
                if (Session["UserID"] == null)
                {
                    query = "select *,null AS wishStatus from tbl_Item_Info where not (Status='DEL' or Status='RE') and CatID='" + catID + "'";
                    ds = objcda.GetDataSet(query, "SMFM");
                    rptGallery.DataSource = ds;
                    rptGallery.DataBind();
                }
                else
                {
                    string userID = Session["UserID"].ToString();
                    query = "SELECT a.ItemPhoto,a.ItemDetails,a.ItemTitle,a.ItemPrice,a.ID,a.[Status],b.wishStatus FROM tbl_Item_Info A LEFT JOIN(SELECT b.[Status] as wishStatus, b.ItemID FROM[tbl_WishList] B WHERE UserID = '" + userID + "') B ON A.ID = B.ItemID where not (a.Status='DEL' or a.Status='RE') and CatID='" + catID + "'";
                    ds = objcda.GetDataSet(query, "SMFM");
                    rptGallery.DataSource = ds;
                    rptGallery.DataBind();
                }


            }
        }

        protected void ddlPricerange_SelectedIndexChanged1(object sender, EventArgs e)
        {

            string price = ddlPricerange.SelectedItem.Value;
            if (price == "0")
            {
                if (Session["UserID"] == null)
                {
                    query = "select * ,null AS wishStatus from tbl_Item_Info where not (Status='DEL' or Status='RE')";
                    ds = objcda.GetDataSet(query, "SMFM");
                    rptGallery.DataSource = ds;
                    rptGallery.DataBind();
                }
                else
                {
                    string userID = Session["UserID"].ToString();
                    query = "SELECT a.ItemPhoto,a.ItemDetails,a.ItemTitle,a.ItemPrice,a.ID,a.[Status],b.wishStatus FROM tbl_Item_Info A LEFT JOIN(SELECT b.[Status] as wishStatus, b.ItemID FROM[tbl_WishList] B WHERE UserID = '" + userID + "') B ON A.ID = B.ItemID where not (a.Status='DEL' or a.Status='RE')";
                    ds = objcda.GetDataSet(query, "SMFM");
                    rptGallery.DataSource = ds;
                    rptGallery.DataBind();
                }


            }
            else
            {
                string rangeFrom = "";
                string rangeTo = "";
                // Split authors separated by a comma followed by space  
                string[] priceArr = price.Split('&');
                rangeFrom = priceArr[0];
                rangeTo = priceArr[1];



                if (Session["UserID"] == null)
                {
                    query = "SELECT * ,null AS wishStatus FROM tbl_Item_Info where not (Status='DEL' or Status='RE') and ItemPrice BETWEEN " + Convert.ToInt16(rangeFrom) + " AND " + Convert.ToInt16(rangeTo) + "";
                    ds = objcda.GetDataSet(query, "SMFM");
                    rptGallery.DataSource = ds;
                    rptGallery.DataBind();

                }
                else
                {
                    string userID = Session["UserID"].ToString();
                    query = "SELECT a.ItemPhoto,a.ItemDetails,a.ItemTitle,a.ItemPrice,a.ID,a.[Status],b.wishStatus FROM tbl_Item_Info A LEFT JOIN(SELECT b.[Status] as wishStatus, b.ItemID FROM[tbl_WishList] B WHERE UserID = '" + userID + "') B ON A.ID = B.ItemID where not (a.Status='DEL' or a.Status='RE') and ItemPrice BETWEEN " + Convert.ToInt16(rangeFrom) + " AND " + Convert.ToInt16(rangeTo) + "";
                    ds = objcda.GetDataSet(query, "SMFM");
                    rptGallery.DataSource = ds;
                    rptGallery.DataBind();
                }



            }


        }
    }
}