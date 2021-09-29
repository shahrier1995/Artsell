using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TestArtSell.Seller
{
    public partial class SellerDashboard : System.Web.UI.Page
    {
        TestArtSell.CDA objcda = new TestArtSell.CDA();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"].ToString() == null)
            {
            }
            else
            {
                LoadMonthlSell();
                LoadDashBoardCard();
            }
        }
        public void LoadMonthlSell()
        {

            string userID = Session["UserID"].ToString();
            string query = "select sum(b.ItemPrice) as PRICE,Convert(char(3), a.TimeStamp, 0) as MON from tbl_Order_Details a inner join tbl_Item_Info b on a.ItemID=b.ID  where a.UserID = '" + userID + "' group by Convert(char(3), a.TimeStamp, 0) ";
            DataSet ds = new DataSet();
            ds = objcda.GetDataSet(query, "SMFM");

            #region
            //string late = "";
            string jan = "0";
            string feb = "0";
            string mar = "0";
            string apr = "0";
            string may = "0";
            string jun = "0";
            string jul = "0";
            string aug = "0";
            string sep = "0";
            string oct = "0";
            string nov = "0";
            string dec = "0";


            try
            {
                if (ds.Tables[0].Rows.Count > 0)
                {
                    foreach (DataRow prow in ds.Tables[0].Rows)
                    {
                        if (prow["MON"].ToString() == "Jan")
                        {
                            jan = prow["PRICE"].ToString();
                        }
                        if (prow["MON"].ToString() == "Feb")
                        {
                            feb = prow["PRICE"].ToString();
                        }
                        if (prow["MON"].ToString() == "Mar")
                        {
                            mar = prow["PRICE"].ToString();
                        }
                        if (prow["MON"].ToString() == "Apr")
                        {
                            apr = prow["PRICE"].ToString();
                        }
                        if (prow["MON"].ToString() == "May")
                        {
                            may = prow["PRICE"].ToString();
                        }
                        if (prow["MON"].ToString() == "Jun")
                        {
                            jun = prow["PRICE"].ToString();
                        }
                        if (prow["MON"].ToString() == "Jul")
                        {
                            jul = prow["PRICE"].ToString();
                        }
                        if (prow["MON"].ToString() == "Aug")
                        {
                            aug = prow["PRICE"].ToString();
                        }
                        if (prow["MON"].ToString() == "Sep")
                        {
                            sep = prow["PRICE"].ToString();
                        }
                        if (prow["MON"].ToString() == "Oct")
                        {
                            oct = prow["PRICE"].ToString();
                        }
                        if (prow["MON"].ToString() == "Nov")
                        {
                            nov = prow["PRICE"].ToString();
                        }
                        if (prow["MON"].ToString() == "Dec")
                        {
                            dec = prow["PRICE"].ToString();
                        }
                    }

                    lblJan.Value = jan;
                    lblFeb.Value = feb;
                    lblMar.Value = mar;
                    lblApr.Value = apr;
                    lblMay.Value = may;
                    lblJun.Value = jun;
                    lblJul.Value = jul;
                    lblAug.Value = aug;
                    lblSep.Value = sep;
                    lblOct.Value = oct;
                    lblNov.Value = nov;
                    lblDec.Value = dec;


                }
            }
            catch (Exception)
            {

                lblJan.Value = jan;
                lblFeb.Value = feb;
                lblMar.Value = mar;
                lblApr.Value = apr;
                lblMay.Value = may;
                lblJun.Value = jun;
                lblJul.Value = jul;
                lblAug.Value = aug;
                lblSep.Value = sep;
                lblOct.Value = oct;
                lblNov.Value = nov;
                lblDec.Value = dec;
            }

            #endregion
        }
        [WebMethod]
        [ScriptMethod(UseHttpGet = true)]
        public static List<NotiMessage> GetData()
        {
            SellerDashboard seller = new SellerDashboard();
            if (String.IsNullOrEmpty(seller.Session["UserID"].ToString()))
            {
                return null;
            }
            else
            {
                string userID = seller.Session["UserID"].ToString();
                TestArtSell.CDA objcda = new TestArtSell.CDA();
                string queryCountZero = "UPDATE artsell8_admin.tbl_Notification_Count SET Count = 0 WHERE UserID='" + userID + "'; ";
                objcda.ExecuteNonQuery(queryCountZero, "SMFM");
                string queryMessgaStatus = "UPDATE artsell8_admin.tbl_Notification_Message SET [Status] = 'Old' WHERE UserID='" + userID + "'; ";
                objcda.ExecuteNonQuery(queryMessgaStatus, "SMFM");
                string query = "select CONVERT(varchar, [TimeStamp], 7) AS notiDate,convert(varchar, getdate(), 8) AS notiTime,Message,UserID from artsell8_admin.tbl_Notification_Message where UserID='" + userID + "'  order by [TimeStamp] desc";
                DataSet ds = new DataSet();
                ds = objcda.GetDataSet(query, "SMFM");
                if (ds == null)
                {
                    return null;
                }
                else
                {


                    if (ds == null)
                    {
                        return null;
                    }
                    else
                    {
                        var messageList = ds.Tables[0].AsEnumerable()
                         .Select(dataRow => new NotiMessage
                         {
                             message = dataRow.Field<string>("Message"),
                             messageDate = dataRow.Field<string>("notiDate"),
                             messageTime = dataRow.Field<string>("notiTime")
                         }).ToList();
                        return messageList;
                    }


                }
            }

        }
        [WebMethod]
        [ScriptMethod(UseHttpGet = true)]
        public static string GetDataCount()
        {
            SellerDashboard seller = new SellerDashboard();
            if (String.IsNullOrEmpty(seller.Session["UserID"].ToString()))
            {
                return "";
            }
            else
            {
                string userID = seller.Session["UserID"].ToString();
                TestArtSell.CDA objcda = new TestArtSell.CDA();
                string GetStatusOfMessage = "select COUNT(*) as [Count] from artsell8_admin.tbl_Notification_Message where UserID='" + userID + "' and [Status]='New' ";
                DataSet ds1 = new DataSet();
                ds1 = objcda.GetDataSet(GetStatusOfMessage, "SMFM");
                if (ds1 != null)
                {
                    int newMessageCount = Convert.ToInt32(ds1.Tables[0].Rows[0]["Count"]);
                    string addCountQuery = "if exists(SELECT * from artsell8_admin.tbl_Notification_Count where UserID='" + userID + "') BEGIN update artsell8_admin.tbl_Notification_Count set Count = '" + newMessageCount + "' where UserID='" + userID + "' End else  begin insert into artsell8_admin.tbl_Notification_Count(UserID,Count) values('" + userID + "','" + newMessageCount + "') end";
                    objcda.ExecuteNonQuery(addCountQuery, "SMFM");
                }
                string query = "select Count from artsell8_admin.tbl_Notification_Count where UserID='" + userID + "' ";
                DataSet ds = new DataSet();
                ds = objcda.GetDataSet(query, "SMFM");

                if (ds == null)
                {
                    return "0";
                }
                else
                {
                    string data = ds.Tables[0].Rows[0]["Count"].ToString();
                    if (data == "0")
                    {
                        return "0";
                    }
                    else
                    {
                        return data;
                    }


                }
            }

        }

        public void LoadDashBoardCard()
        {
            int worth, sold, percentComplete = 0;
            string userID = Session["UserID"].ToString();
            string queryWorth = " select ISNULL(sum(itemprice),0) as itemPrice from tbl_Item_Info where userid='" + userID + "'";
            DataSet ds1 = objcda.GetDataSet(queryWorth, "SMFM");
            lblAmount.Text = ds1.Tables[0].Rows[0]["itemPrice"].ToString();
            string querySold = " select ISNULL(sum(itemprice),0) as itemPrice from tbl_Item_Info where userid='" + userID + "' and [Status]='SO' ";

            DataSet ds2 = objcda.GetDataSet(querySold, "SMFM");

            if (ds2.Tables[0].Rows.Count > 0)
            {
                lblSold.Text = ds2.Tables[0].Rows[0]["itemPrice"].ToString();

                //lblLeft.Text = (Convert.ToInt32(ds1.Tables[0].Rows[0]["itemPrice"]) - Convert.ToInt32(ds2.Tables[0].Rows[0]["itemPrice"])).ToString();
                worth = Convert.ToInt32(ds1.Tables[0].Rows[0]["itemPrice"]);
                sold = Convert.ToInt32(ds2.Tables[0].Rows[0]["itemPrice"]);
                if (worth == 0 || sold == 0)
                {

                    string percentage = "0" + "%";
                    lblPercentage.Text = percentage;
                    lblprog.Style.Add("width", percentage);
                    lblprog.Attributes.Add("aria-valuenow", percentComplete.ToString("F1"));
                }
                else
                {
                    percentComplete = (int)Math.Round((double)(100 * sold) / worth);
                    string percentage = percentComplete.ToString() + "%";
                    lblPercentage.Text = percentage;
                    lblprog.Style.Add("width", percentage);
                    lblprog.Attributes.Add("aria-valuenow", percentComplete.ToString("F1"));
                }

            }




            string queryOrderReq = " select ISNULL(COUNT(ODRID),0) as ordereq from tbl_Order_Details where STATUS IN ('OC') AND UserID='" + userID + "'";
            DataSet ds3 = objcda.GetDataSet(queryOrderReq, "SMFM");
            lblOrderReq.Text = ds3.Tables[0].Rows[0]["ordereq"].ToString();
        }
    }
}