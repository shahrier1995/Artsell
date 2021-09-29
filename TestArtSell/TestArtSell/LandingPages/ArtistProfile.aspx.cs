using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Web.Script.Services;
using System.Web.Services;

namespace TestArtSell.LandingPages
{
    public partial class ArtistProfile : System.Web.UI.Page
    {

        TestArtSell.CDA objcda = new TestArtSell.CDA();
        string UserID = "";
        protected void Page_Load(object sender, EventArgs e)
        {
           
                LoadLandingArtist();
        


        }
        public void LoadLandingArtist()
        {



            string query = "";
            UserID = Request.QueryString["UserID"];
            string query1 = "select *, CASE WHEN RatingCount =0 or UserRating=0 THEN 1  ELSE UserRating/RatingCount END AS rate from tbl_user_info where UserType='SE' and ID= '" + UserID + "' ";
            DataSet ds1 = objcda.GetDataSet(query1, "SMFM");
            rptUser.DataSource = ds1;
            rptUser.DataBind();

            if (UserID == null)
            {
                query = "select *,null AS wishStatus from tbl_Item_Info where not (Status='DEL' or Status='RE')";
                DataSet ds = objcda.GetDataSet(query, "SMFM");
                rptGallery.DataSource = ds;
                rptGallery.DataBind();

            }
            else
            {
                query = "select *,null AS wishStatus from tbl_Item_Info where not (Status='DEL' or Status='RE') and UserID='" + UserID + "'";
                DataSet ds = objcda.GetDataSet(query, "SMFM");
                rptGallery.DataSource = ds;
                rptGallery.DataBind();
            }
        }
        [WebMethod]
        [ScriptMethod(UseHttpGet = true)]
        public static string addRating(string ID, string Rate)
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

                    string insertIntoUserTbl = "Update tbl_user_info set UserRating=UserRating+" + rate + " , RatingCount =RatingCount+1 where ID='" + sellerID + "'";
                    objcda.ExecuteNonQuery(insertIntoUserTbl, "SMFM");
                    string insertQuery = "insert into tbl_Artist_Rating(RatIng,SellerID,UserID) values(" + rate + ",'" + sellerID + "','" + userID + "')";
                    objcda.ExecuteNonQuery(insertQuery, "SMFM");

                    return "AD";
                }
                else
                {
                    int previousRate = Convert.ToInt32(ds.Tables[0].Rows[0]["Rating"]);
                    string updateIntoUserTbl = "Update tbl_user_info set UserRating=(UserRating+" + rate + ")-" + previousRate + " where ID='" + sellerID + "'";
                    objcda.ExecuteNonQuery(updateIntoUserTbl, "SMFM");
                    string updateQuery = "Update  tbl_Artist_Rating Set RatIng=" + rate + " where SellerID='" + sellerID + "' and UserID='" + userID + "'";
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
                if (ds1 == null || ds1.Tables[0].Rows.Count == 0)
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
    }
}