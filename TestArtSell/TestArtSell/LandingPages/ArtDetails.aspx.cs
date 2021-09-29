using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Web.UI.HtmlControls;
using System.Web.Services;
using System.Web.Script.Services;
using AjaxControlToolkit;
using System.Configuration;
using System.Net.Http;
using System.Net;
using System.IO;
using Newtonsoft.Json;

namespace TestArtSell.LandingPages
{
    public partial class ArtDetails : System.Web.UI.Page
    {
        TestArtSell.CDA objcda = new TestArtSell.CDA();

        DataSet dsIemInfo = new DataSet();
        DataTable dt = new DataTable();
        string PhotoID = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            string a = "";

            if (Session["orderCart"] == null)
            {
                LoadMoreArt();
                Session["orderCart"] = null;
                PhotoID = Request.QueryString["PhotoID"];
                string query = "select a.ItemDetails,a.status,a.height,a.width,a.ItemPhoto,b.UserImage,a.ItemPrice,a.ID as ItemID ,a.UserID, b.UserFullName ,b.UserAddress,c.CatTitle as CatTitle, b.ID from tbl_Item_Info a inner join tbl_User_Info b on  a.UserID= b.ID inner join tbl_Item_Category c on a.catid=c.catid where where a.ID='" + PhotoID + "'";
                DataSet ds = objcda.GetDataSet(query, "SMFM");

                string sellStatus = ds.Tables[0].Rows[0]["status"].ToString();
                string imgsrc= ds.Tables[0].Rows[0]["ItemPhoto"].ToString();
                string price = ds.Tables[0].Rows[0]["ItemPrice"].ToString();
                string width = ds.Tables[0].Rows[0]["Width"].ToString();
                string height = ds.Tables[0].Rows[0]["Height"].ToString();
                lblPrice.InnerText = price;
                if (String.IsNullOrEmpty(width)  && String.IsNullOrEmpty(height))
                {
                    lblPriceWFrame.InnerText = "0";
                    lblTotal.InnerText = "Total Price: " + (0 + Convert.ToDouble(price)).ToString();
                   
                }
                else
                {
                    double dimension = Convert.ToDouble(width) * Convert.ToDouble(height);
                    double dimensionPrice = dimension * 200;
                    lblPriceWFrame.InnerText = (dimensionPrice).ToString() + "(Dimension: " + dimension + " )";
                    lblTotal.InnerText = "Total Price: " + (dimensionPrice + Convert.ToDouble(price)).ToString();
                }
               
                modalImg.Src = imgsrc;
                rptgallerySingle.DataSource = ds;
                rptgallerySingle.DataBind();
                if (sellStatus == "SO")
                {
                    foreach (RepeaterItem item in rptgallerySingle.Items)
                    {
                      
                        item.FindControl("btnFbShare").Visible = false;
                        item.FindControl("linkbtnAddCart").Visible = false;
                        item.FindControl("linkbtnCheckout").Visible = true;
                    }
                }
                else
                {
                    foreach (RepeaterItem item in rptgallerySingle.Items)
                    {

                        item.FindControl("linkbtnAddCart").Visible = true;
                        item.FindControl("linkbtnCheckout").Visible = true;
                    }
                }

                #region
                //string Ipaddress = GetUserIP();
                //string queryExistInDb = "select * from tbl_cart where ipaddress='" + Ipaddress + "' and status='OR' and ItemId='" + PhotoID + "'";
                //DataSet Dscart = new DataSet();
                //Dscart = objcda.GetDataSet(queryExistInDb, "SMFM");
                //if (Dscart == null)
                //{
                //    foreach (RepeaterItem item in rptgallerySingle.Items)
                //    {
                //        item.FindControl("linkbtnAddCart").Visible = true;
                //        item.FindControl("linkbtnCheckout").Visible = true;
                //    }
                //}
                //else
                //{
                //    foreach (RepeaterItem item in rptgallerySingle.Items)
                //    {
                //        item.FindControl("linkbtnAddCart").Visible = false;
                //        item.FindControl("linkbtnCheckout").Visible = true;
                //    }
                //}
                //string queryItemInfo = "select * from tbl_Item_Info where ID='" + PhotoID + "'";
                //dsIemInfo = objcda.GetDataSet(queryItemInfo, "SMFM");
                #endregion


            }
            else
            {
                LoadMoreArt();
                PhotoID = Request.QueryString["PhotoID"];
                string query = "select a.ItemDetails,a.status,a.height,a.width,a.ItemPhoto,b.UserImage,a.ItemPrice,a.ID as ItemID ,a.UserID, b.UserFullName ,b.UserAddress,c.CatTitle as CatTitle, b.ID from tbl_Item_Info a inner join tbl_User_Info b on  a.UserID= b.ID inner join tbl_Item_Category c on a.catid=c.catid where where a.ID='" + PhotoID + "'";
                DataSet ds = objcda.GetDataSet(query, "SMFM");
                rptgallerySingle.DataSource = ds;
                rptgallerySingle.DataBind();
                string queryItemInfo = "select * from tbl_Item_Info where ID='" + PhotoID + "'";
                dsIemInfo = objcda.GetDataSet(queryItemInfo, "SMFM");
                dt = (DataTable)Session["orderCart"];
                for (int i = dt.Rows.Count - 1; i >= 0; i--)
                {
                    DataRow dr = dt.Rows[i];
                    if (dr["ID"].ToString() == PhotoID)
                    {

                        foreach (RepeaterItem item in rptgallerySingle.Items)
                        {



                            item.FindControl("linkbtnAddCart").Visible = false;
                            item.FindControl("linkbtnCheckout").Visible = true;
                        }


                    }

                }
                #region
                //PhotoID = Request.QueryString["PhotoID"];
                //string Ipaddress = GetUserIP();
                //string queryExistInDb = "select * from tbl_cart where ipaddress='" + Ipaddress + "' and status='OR' and ItemId='" + PhotoID + "'";
                //DataSet Dscart = new DataSet();
                //Dscart = objcda.GetDataSet(queryExistInDb, "SMFM");
                //if (Dscart == null)
                //{
                //    foreach (RepeaterItem item in rptgallerySingle.Items)
                //    {
                //        item.FindControl("linkbtnAddCart").Visible = true;
                //        item.FindControl("linkbtnCheckout").Visible = true;
                //    }
                //}
                //else
                //{
                //    foreach (RepeaterItem item in rptgallerySingle.Items)
                //    {
                //        item.FindControl("linkbtnAddCart").Visible = false;
                //        item.FindControl("linkbtnCheckout").Visible = true;
                //    }
                //}
                #endregion
            }

        }
        //protected void btnShare_Click(object sender, EventArgs e)
        //{
        //    var url = "https://www.artsell.xyz/";
        //    var urlEncoded = Uri.EscapeDataString(url);

        //    var requestUrl = "https://opengraph.io/api/1.1/site/" + urlEncoded;

        //    // Make sure to get your API key!  No need for a CC
        //    requestUrl += "?app_id=845424682934259";

        //    var request = WebRequest.Create(requestUrl);
        //    request.ContentType = "application/json;";

        //    string text;

        //    var response = (HttpWebResponse)request.GetResponse();

        //    using (var sr = new StreamReader(response.GetResponseStream()))
        //    {
        //        text = sr.ReadToEnd();

        //        dynamic x = JsonConvert.DeserializeObject(text);

        //        Console.WriteLine("Title\t\t" + x.hybridGraph.title);
        //        Console.WriteLine("Description\t" + x.hybridGraph.description);
        //        Console.WriteLine("Image\t\t" + x.hybridGraph.image);
        //    }
        //}

        protected void AddToOderCart(object sender, System.EventArgs eventArgs)
        {


            string PhotoID = Request.QueryString["PhotoID"];
            string query = "   select a.ItemPhoto,a.UserID,a.ID , b.UserFullName ,b.UserAddress, b.ID from tbl_Item_Info a inner join tbl_User_Info b on a.UserID= b.ID where a.ID='" + PhotoID + "'";
        }

        protected void btnAddCart_Click(object sender, EventArgs e)
        {
            
        }
        public string GetUserIP()
        {
            System.Web.HttpContext context = System.Web.HttpContext.Current;
            string ipAddress = context.Request.ServerVariables["HTTP_X_FORWARDED_FOR"];

            if (!string.IsNullOrEmpty(ipAddress))
            {
                return ipAddress.Split(',')[0];
            }

            return context.Request.ServerVariables["REMOTE_ADDR"];
        }


        protected void cartDataset()
        {
            string itemid= dsIemInfo.Tables[0].Rows[0]["ID"].ToString();
            string orderStatus = "OR";
            string IPAddress = GetUserIP();
            if (Session["UserID"]==null)
            {
                string queryAddCart = "insert into tbl_Cart(ItemID,UserID,Status,IPAddress) values('" + itemid + "','','" + orderStatus + "','" + IPAddress + "')";
                objcda.ExecuteNonQuery(queryAddCart,"SMFM");
            }
            else
            {
                string queryAddCart = "insert into tbl_Cart(ItemID,UserID,Status,IPAddress) values('" + itemid + "','" + Session["UserId"].ToString() + "','" + orderStatus + "','" + IPAddress + "')";
                objcda.ExecuteNonQuery(queryAddCart, "SMFM");

            }
            
            if (Session["orderCart"] ==null)
            {
             
                dt.Columns.Add("ID");
                dt.Columns.Add("ItemTitle");
                dt.Columns.Add("ItemPrice");
                dt.Columns.Add("ItemPhoto");
                dt.Columns.Add("SellerID");

                DataRow nr = dt.NewRow();
                nr["ID"] = dsIemInfo.Tables[0].Rows[0]["ID"].ToString();
                nr["ItemTitle"] = dsIemInfo.Tables[0].Rows[0]["ItemTitle"].ToString();
                nr["ItemPrice"] = dsIemInfo.Tables[0].Rows[0]["ItemPrice"].ToString();
                nr["ItemPhoto"] = dsIemInfo.Tables[0].Rows[0]["ItemPhoto"].ToString();
                nr["SellerID"] = dsIemInfo.Tables[0].Rows[0]["UserID"].ToString();

                dt.Rows.Add(nr);
                DataTable a = dt;
                Session["orderCart"] = dt;
                Session["secret key"] = dt;


            }
            else
            {
                dt = (DataTable)Session["orderCart"];
                DataRow nr = dt.NewRow();
                nr["ID"] = dsIemInfo.Tables[0].Rows[0]["ID"].ToString();
                nr["ItemTitle"] = dsIemInfo.Tables[0].Rows[0]["ItemTitle"].ToString();
                nr["ItemPrice"] = dsIemInfo.Tables[0].Rows[0]["ItemPrice"].ToString();
                nr["ItemPhoto"] = dsIemInfo.Tables[0].Rows[0]["ItemPhoto"].ToString();
                nr["SellerID"] = dsIemInfo.Tables[0].Rows[0]["UserID"].ToString();

                dt.Rows.Add(nr);
                DataTable a = dt;
                Session["orderCart"] = dt;
                Session["secret key"] = dt;

            }

            
        }
        [WebMethod]
        [ScriptMethod(UseHttpGet = true)]
        public static string addRating(string ID, string Rate)
        {
            string sellerID = ID;
            int rate = Convert.ToInt16(Rate);
            ArtDetails artsell = new ArtDetails();
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
                    string insertQuery = "insert into tbl_Artist_Rating(RatIng,SellerID,UserID) values(" + rate + ",'" + sellerID + "','" + userID + "')";
                    objcda.ExecuteNonQuery(insertQuery, "SMFM");

                    return "AD";
                }
                else
                {

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
                string queryuserImage = "select avg(xx.RatIng)as rate, count(*) as count, xx.SellerID as sellerId from tbl_user_info a inner join (select * from tbl_Artist_Rating where SellerID = '" + rptUserID + "') xx on a.ID = xx.SellerID   group by xx.SellerID";
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
        protected void btnCart_Click(object sender, EventArgs e)
        {
            
            cartDataset();
            


        }
        [WebMethod]
        [ScriptMethod(UseHttpGet  = true)]
        public static string addCart()
        {
            ArtDetails artcell = new ArtDetails();
            CDA objcda = new CDA(); 
            string PhotoID = HttpContext.Current.Request.QueryString["PhotoID"].ToString();
            string queryItemInfo = "select * from tbl_Item_Info where ID='" + PhotoID + "'";
            artcell.dsIemInfo = objcda.GetDataSet(queryItemInfo, "SMFM");
            artcell.cartDataset();
            
          
            return "OR";
        }

        protected void OnRatingChanged(object sender, RatingEventArgs e)
        {
            string userQuery = "select a.ItemPhoto,a.UserID,a.ID from tbl_Item_Info a inner join tbl_User_Info b on a.UserID= b.ID where a.ID='" + PhotoID + "'";
            DataSet ds = objcda.GetDataSet(userQuery, "SMFM");
            string userID = ds.Tables[0].Rows[0]["UserID"].ToString();
            string query = "    update tbl_User_Info set UserRating=UserRating+"+e.Value+",RatingCount=RatingCount+1 where ID='"+userID+"'";
            objcda.ExecuteNonQuery(query,"SMFM");
            Response.Redirect(Request.Url.AbsoluteUri);
        }
        protected void rptgallerySingle_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            LinkButton linkbtnAddCart = e.Item.FindControl("linkbtnAddCart") as LinkButton;
            LinkButton linkbtnCheckout = e.Item.FindControl("linkbtnCheckout") as LinkButton;

            cartDataset();
           

            linkbtnAddCart.Visible = false;
            linkbtnCheckout.Visible = true;
            
        }

        protected void ddlFrames_SelectedIndexChanged(object sender, EventArgs e)
        {
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "none",
           "<script>$('#mymodal').modal('show');</script>", false);

        }

        public void LoadMoreArt()
        {
            DataSet ds = new DataSet();
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

    }
}