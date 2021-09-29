using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TestArtSell.General.Orders
{
    public partial class RunningOrders : System.Web.UI.Page
    {
        TestArtSell.CDA objcda = new TestArtSell.CDA();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (MultiView1.ActiveViewIndex == 1)
            {
                MultiView1.ActiveViewIndex = 1;
            }
            else
            {
                MultiView1.ActiveViewIndex = 0;
            }


            if (Session["UserID"] == null)
            {
                Response.Redirect("..\\..\\Login_Registration\\LoginForm.aspx");
            }
            else
            {
                GetMonth();
                GetOrderData();

            }



        }
        protected void ShowReport_DateWise(object sender, EventArgs e)
        {
            //if (string.IsNullOrEmpty(startDate.Text) || string.IsNullOrEmpty(endDate.Text))
            //{
            //    ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Alert1", "alert", true);
            //}
            //else
            //{
            //    string startdate = "";
            //    startdate = startDate.Text.ToString().Trim();
            //    string enddate = "";
            //    enddate = endDate.Text.ToString().Trim();



            //    string userID = Session["UserID"].ToString();
            //    string query = "SELECT ODRID, CONVERT(VARCHAR, TIMESTAMP, 106) ODRDATE, STATUS, ItemQuantity,TotalPrice, USERID  FROM tbl_Order_Master WHERE USERID = '" + userID + "' and CONVERT(nvarchar(10), TIMESTAMP, 120) BETWEEN '" + startdate + "' AND '" + enddate + "'; ";

            //    DataSet ds = objcda.GetDataSet(query, "SMFM");
            //    Repeater1.DataSource = ds;
            //    Repeater1.DataBind();
            //}
            
        
            

        }
        public void GetOrderData()
        {
            string userID = Session["UserID"].ToString();
           
            string query = "SELECT ODRID, CONVERT(VARCHAR, TIMESTAMP, 106) ODRDATE, STATUS, ItemQuantity,TotalPrice, USERID  FROM tbl_Order_Master WHERE USERID = '" + userID + "'";

            DataSet ds = objcda.GetDataSet(query, "SMFM");
           
            rptrOrder.DataSource = ds;
            rptrOrder.DataBind();
        }

        protected void GetOrderDetails(object source, CommandEventArgs e)
        {
            string orderID = "";
            orderID = e.CommandArgument.ToString();

            string query = "SELECT ITEMTITLE,ITEMPRICE,ITEMPHOTO FROM tbl_Order_Details OD,tbl_Item_Info ITM WHERE OD.ITEMID = ITM.ID "
                            + "AND ODRID = '" + orderID + "'";
            DataSet ds = objcda.GetDataSet(query, "SMFM");
         
            rptrOrderDetails.DataSource = ds;
            rptrOrderDetails.DataBind();

        }

        public void GetMonth()
        {
            Dictionary<string, string> list = new Dictionary<string, string>();
            list.Add("JAN", "January");
            list.Add("FEB", "February");
            list.Add("MAR", "March");
            list.Add("APR", "April");
            list.Add("MAY", "May");
            list.Add("JUN", "June");
            list.Add("JUL", "July");
            list.Add("AUG", "August");
            list.Add("SEP", "September");
            list.Add("OCT", "October");
            list.Add("NOV", "November");
            list.Add("DEC", "December");

            //ddlMonth.DataSource = list;
            //ddlMonth.DataTextField = "Value";
            //ddlMonth.DataValueField = "Key";
            //ddlMonth.DataBind();
        }

        protected void OnSelectedIndexChanged(object sender, EventArgs e)
        {
            //string userID = Session["UserID"].ToString();
            //string month = ddlMonth.SelectedItem.Value;
            //string query = "SELECT *  from tbl_Item_Info where  MONTH([TimeStamp])='" + month + "' and userid='" + userID + "'";
            //DataSet ds = new DataSet();
            //ds = objcda.GetDataSet(query, "SMFM");
            //rptiteminfo.DataSource = ds;
            //rptiteminfo.DataBind();
        }

        protected void rptrOrder_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            string orderID = "";
            string orderDate = "";
            orderID = e.CommandArgument.ToString();
            lblInvoiceNo.Text = orderID;

            //Get Order Master Info
            string query1 = "SELECT ODRID, CONVERT(VARCHAR, TIMESTAMP, 106) ODRDATE, STATUS, ItemQuantity,TotalPrice, USERID  FROM tbl_Order_Master WHERE ODRID = '" + orderID + "'";
            DataSet ds1 = objcda.GetDataSet(query1, "SMFM");
           
            if (ds1.Tables[0].Rows.Count > 0)
            {
                orderDate = ds1.Tables[0].Rows[0]["ODRDATE"].ToString();

            }
            lblOrderDate.Text = orderDate;
            string PayMentStatus = "";
            if (ds1.Tables[0].Rows[0]["STATUS"].ToString() == "PA") {
                lblPaymentStatus.ForeColor = System.Drawing.Color.Green;
                lblPaymentStatus.Text = "Paid";
            }
            else
            {
                lblPaymentStatus.ForeColor = System.Drawing.Color.Red;
                lblPaymentStatus.Text = "Unpaid";
            }
            if (ds1.Tables[0].Rows[0]["STATUS"].ToString() == "OR") 
            
            {
                lblOrderStatus.InnerText = "Order Status : Requested";
            }
            else if (ds1.Tables[0].Rows[0]["STATUS"].ToString() == "PA")

            {
                lblOrderStatus.InnerText = "Order Status : Paid";
            }
            else if (ds1.Tables[0].Rows[0]["STATUS"].ToString() == "OC")

            {
                lblOrderStatus.InnerText = "Order Status : Confirmed";
            }
            else if (ds1.Tables[0].Rows[0]["STATUS"].ToString() == "OD")

            {
                lblOrderStatus.InnerText = "Order Status : Canceled";
            }
            else

            {
                lblOrderStatus.InnerText = "Order Status : Unpaid";
            }
            lblTotalPrice.Text = (Convert.ToInt32(ds1.Tables[0].Rows[0]["TotalPrice"]) - 60).ToString() + "  BDT";
            lblTotalAmount.Text = ds1.Tables[0].Rows[0]["TotalPrice"].ToString() + "  BDT";
            //Get Order Details Info
            string query = "SELECT ITEMTITLE,ITEMPRICE,ITEMPHOTO,BuyerID FROM tbl_Order_Details OD,tbl_Item_Info ITM WHERE OD.ITEMID = ITM.ID AND ODRID = '" + orderID + "'";
            
            
            DataSet ds = objcda.GetDataSet(query, "SMFM");

            string userID = ds.Tables[0].Rows[0]["BuyerID"].ToString();
            string queryUserInformation = "Select UserFullName,UserAddress,UserContact from [tbl_User_Info] where Id='" + userID + "'";
            DataSet dsUserInfo = objcda.GetDataSet(queryUserInformation, "SMFM");
            if (dsUserInfo.Tables[0].Rows.Count > 0)
            {
                lblUserName.InnerText= "Buyer Name : "+dsUserInfo.Tables[0].Rows[0]["UserFullName"].ToString();
                iblAddress.InnerText = "Buyer Address : " + dsUserInfo.Tables[0].Rows[0]["UserAddress"].ToString();
                lblContact.InnerText = "Buyer Contact : " + dsUserInfo.Tables[0].Rows[0]["UserContact"].ToString();

            }
            rptrOrderDetails.DataSource = ds;
            rptrOrderDetails.DataBind();
          
            MultiView1.ActiveViewIndex = 1;

            
        }

        protected void btnBackToOrderList_Click(object sender, EventArgs e)
        {
            GetOrderData();
            MultiView1.ActiveViewIndex = 0;
        }

    }
}