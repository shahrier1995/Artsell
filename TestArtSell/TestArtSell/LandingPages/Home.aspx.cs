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
    public partial class Home : System.Web.UI.Page
    {
        TestArtSell.CDA objcda = new TestArtSell.CDA();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {



                
                string NewuserID = Request.QueryString["NewUserID"];
                string status= Request.QueryString["status"];
                string activeCode = Request.QueryString["ActivationCode"];
                if (status == "0")
                {
                    string query = "UPDATE tbl_User_Info SET UserStatus='AC',ActicationCode='"+activeCode+"' WHERE ID='" + NewuserID + "'; ";
                    objcda.ExecuteNonQuery(query, "SMFM");
                    LoadLandingGallery();
                }
                else
                {
                    LoadLandingGallery();
                }
                
            }
        }

        public void LoadLandingGallery()
        {
            DataSet ds = new DataSet();
            DataSet ds1 = new DataSet();
            DataSet ds2 = new DataSet();
            
            if (Session["UserID"]==null)
            {
                
                string query = "select top 4 *,null AS wishStatus from tbl_Item_Info where not (status='DEL' or Status='RE') ORDER BY NEWID()";
                ds = objcda.GetDataSet(query, "SMFM");
                rptGallery.DataSource = ds;
                rptGallery.DataBind();
                string query2 = " select * from(Select a.ID,a.CatID, a.CatTitle,a.CatDetails, b.ItemPhoto, ROW_NUMBER() over(PARTITION BY a.ID ORDER BY a.ID)RN from tbl_Item_Category a inner join tbl_Item_Info b on a.CatID = b.CatID WHERE b.STATUS = 'APV' )x where x.RN = 1";
                ds1 = objcda.GetDataSet(query2, "SMFM");
                rptCat.DataSource = ds1;
                rptCat.DataBind();
                string query3 = "select top 5 *, CASE WHEN RatingCount =0 or UserRating=0 THEN 1  ELSE UserRating/RatingCount END AS rate from tbl_user_info where UserType='SE' ORDER BY NEWID()";
                ds2 = objcda.GetDataSet(query3, "SMFM");
                rptUser.DataSource = ds2;
                rptUser.DataBind();
            }
            else
            {
                string userID = Session["UserID"].ToString();
                string query = "SELECT a.ItemPhoto,a.ItemDetails,a.ItemTitle,a.ItemPrice,a.ID,a.[Status],b.wishStatus FROM tbl_Item_Info A LEFT JOIN(SELECT b.[Status] as wishStatus, b.ItemID FROM[tbl_WishList] B WHERE  UserID = '" + userID + "') B ON A.ID = B.ItemID where not (a.Status='DEL' or a.Status='RE')";
                 ds = objcda.GetDataSet(query, "SMFM");
                rptGallery.DataSource = ds;
                rptGallery.DataBind();
                string query2 = " select* from(Select a.ID,a.CatID, a.CatTitle,a.CatDetails, b.ItemPhoto, ROW_NUMBER() over(PARTITION BY a.ID ORDER BY a.ID)RN from tbl_Item_Category a inner join tbl_Item_Info b on a.CatID = b.CatID WHERE b.STATUS = 'APV' )x where x.RN = 1";
                 ds1 = objcda.GetDataSet(query2, "SMFM");
                rptCat.DataSource = ds1;
                rptCat.DataBind();
                string query3 = "select top 5 *, CASE WHEN RatingCount =0 or UserRating=0 THEN 1  ELSE UserRating/RatingCount END AS rate from tbl_user_info where UserType='SE' order by rate desc";
                ds2 = objcda.GetDataSet(query3, "SMFM");
                rptUser.DataSource = ds2;
                rptUser.DataBind();
            }

      
        }
        [WebMethod]
        [ScriptMethod(UseHttpGet = true)]
        public static string addWishList(string ID)
        {
            string itemId = ID;
            Home artsell = new Home();
            CDA objcda = new CDA();
            //artsell.AddingWishList(itemId);
            //artcell.addingWishList(itemId);
            if (artsell.Session["UserID"] == null)
            {
                return "LO";
            }
            else
            {
                string status = "";
                string userID = artsell.Session["UserID"].ToString();
                string itemID = ID;
                string Query = "select * from tbl_WishList where ItemID='" + itemID + "' and UserID='" + userID + "'";
                DataSet ds = new DataSet();
                ds = objcda.GetDataSet(Query, "SMFM");
              
                if (ds == null)
                {
                    string insertQuery = "insert into tbl_wishlist(Status,ItemID,UserID) values('AD','" + itemID + "','" + userID + "')";
                    objcda.ExecuteNonQuery(insertQuery, "SMFM");

                    return "AD";
                }
                else
                {
                    status = ds.Tables[0].Rows[0]["Status"].ToString();
                    if (status == "AD")
                    {
                        string updateQuery = "Update  tbl_wishlist Set Status='ND' where ItemID='" + itemID + "' and UserID='" + userID + "'";
                        objcda.ExecuteNonQuery(updateQuery, "SMFM");
                        return "ND";
                    }
                    else
                    {
                        string updateQuery = "Update  tbl_wishlist Set Status='AD' where ItemID='" + itemID + "' and UserID='" + userID + "'";
                        objcda.ExecuteNonQuery(updateQuery, "SMFM");
                        return "AD";
                    }

                }
            

            }


        }
        [WebMethod]
        [ScriptMethod(UseHttpGet = true)]
        public static string addRating(string ID,string Rate)
        {
            string sellerID = ID;
            int rate = Convert.ToInt16(Rate);
            Home artsell = new Home();
            CDA objcda = new CDA();
            //artsell.AddingWishList(itemId);
            //artcell.addingWishList(itemId);
            if (artsell.Session["UserID"] == null)
            {
                return "LO";
            }
            else
            {
                
                string userID = artsell.Session["UserID"].ToString();
              
                string Query = "select * from tbl_Artist_Rating where SellerID='" + sellerID + "' and UserID='" + userID + "'";
                DataSet ds = new DataSet();
                ds = objcda.GetDataSet(Query, "SMFM");
              

                if (ds == null)
                {
               
                    string insertIntoUserTbl = "Update tbl_user_info set UserRating=UserRating+"+rate+ " , RatingCount =RatingCount+1 where ID='" + sellerID + "'";
                    objcda.ExecuteNonQuery(insertIntoUserTbl, "SMFM");
                    string insertQuery = "insert into tbl_Artist_Rating(RatIng,SellerID,UserID) values("+rate+",'" + sellerID + "','" + userID + "')";
                    objcda.ExecuteNonQuery(insertQuery, "SMFM");

                    return "AD";
                }
                else
                {
                        int previousRate = Convert.ToInt32(ds.Tables[0].Rows[0]["Rating"]);
                        string updateIntoUserTbl = "Update tbl_user_info set UserRating=(UserRating+"+ rate + ")-" + previousRate + " where ID='" + sellerID + "'";
                        objcda.ExecuteNonQuery(updateIntoUserTbl, "SMFM");
                        string updateQuery = "Update  tbl_Artist_Rating Set RatIng="+rate+" where SellerID='" + sellerID + "' and UserID='" + userID + "'";
                        objcda.ExecuteNonQuery(updateQuery, "SMFM");
                        return "UD";
                    //}
                    //else
                    //{
                    //    string updateQuery = "Update  tbl_wishlist Set Status='AD' where ItemID='" + itemID + "' and UserID='" + userID + "'";
                    //    objcda.ExecuteNonQuery(updateQuery, "SMFM");
                    //    return "AD";
                    //}

                }


            }


        }
        protected void OnItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                string rptUserID = (e.Item.FindControl("hfuserID") as HiddenField).Value;
                Repeater rptrating = e.Item.FindControl("rptRating") as Repeater;
                string queryuserImage = "select ROUND(avg(xx.RatIng),0) as rate, count(*) as count, xx.SellerID as sellerId from tbl_user_info a inner join (select * from tbl_Artist_Rating where SellerID = '" + rptUserID + "') xx on a.ID = xx.SellerID   group by xx.SellerID";
                DataSet ds1 = objcda.GetDataSet(queryuserImage, "SMFM");
                if (ds1==null || ds1.Tables[0].Rows.Count == 0)
                {
                    DataTable dt = new DataTable();
                    dt.Clear();
                    dt.Columns.Add("rate");
                    dt.Columns.Add("count");
                    dt.Columns.Add("sellerId");
                    DataRow demoRate = dt.NewRow();
                    demoRate["rate"] = "0";
                    demoRate["count"] = "0";
                    demoRate["sellerId"] = rptUserID;
                    dt.Rows.Add(demoRate);
                    rptrating.DataSource = dt;
                    rptrating.DataBind();

                }
                else
                {
                    rptrating.DataSource = ds1;
                    rptrating.DataBind();
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

    
