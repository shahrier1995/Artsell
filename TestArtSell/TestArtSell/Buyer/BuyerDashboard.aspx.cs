using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TestArtSell.Buyer
{
    public partial class BuyerDashboard : System.Web.UI.Page
    {
        TestArtSell.CDA objcda = new TestArtSell.CDA();
        string userID;

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
                    GetDashboardInfo();
                }

            }
        }
        public void GetDashboardInfo()
        {
            GetCardInfo();
            GetItemInfo();
            GetOrderData();
            GetArtistList();
        }

        public void GetCardInfo()
        {
            userID = Session["UserID"].ToString();
            TestArtSell.CDA objcda = new TestArtSell.CDA();

            string query = "SELECT Sum(TotalPrice) FROM tbl_order_master where UserID='" + userID + "'";
            string queryOrder = "SELECT COUNT(*) FROM tbl_order_master where UserID='" + userID + "'";
            string queryWishList = "SELECT COUNT(*) FROM tbl_WishList where UserID='" + userID + "'";
            string queryQuantity = "SELECT Sum(ItemQuantity) FROM tbl_order_master where UserID='" + userID + "'";

            string totPrice = objcda.getSingleValue(query, "SMFM").ToString();
            string totalOrder = objcda.getSingleValue(queryOrder, "SMFM").ToString();
            string totalWishList = objcda.getSingleValue(queryWishList, "SMFM").ToString();
            string totQuantity = objcda.getSingleValue(queryQuantity, "SMFM").ToString();


            lblMoney.Text = totPrice + " BDT";
            lbltotalOrder.Text = totalOrder;
            lblWishList.Text = totalWishList;
            lblQuantity.Text = totQuantity;

        }

        public void GetItemInfo()
        {
            string GetImagequery = "SELECT * FROM tbl_Item_Info where status IN ('APV','SO')";
            DataSet ds = objcda.GetDataSet(GetImagequery, "SMFM");
            DataSet ds2 = objcda.GetDataSet(GetImagequery, "SMFM");
            if (ds != null && ds2 != null )
            {
                ds.Merge(ds2);
            }
            rptItems.DataSource = ds;
            rptItems.DataBind();
        }

        public void GetOrderData()
        {
            string userID = Session["UserID"].ToString();
            string query = "SELECT top 2 ODRID, CONVERT(VARCHAR, TIMESTAMP, 106) ODRDATE, STATUS, ItemQuantity,TotalPrice, USERID  FROM tbl_Order_Master WHERE USERID = '" + userID + "' ORDER BY TIMESTAMP DESC";

            DataSet ds = objcda.GetDataSet(query, "SMFM");
            rptOrder.DataSource = ds;
            rptOrder.DataBind();
        }

        public void GetArtistList()
        {

            string queryArtist = "select top 5 *, CASE WHEN RatingCount =0 or UserRating=0 THEN 1  ELSE UserRating/RatingCount END AS rate from tbl_user_info where UserType='SE' ORDER BY NEWID() ";
            DataSet ds = objcda.GetDataSet(queryArtist, "SMFM");
            rptArtist.DataSource = ds;
            rptArtist.DataBind();



        }
    }
}