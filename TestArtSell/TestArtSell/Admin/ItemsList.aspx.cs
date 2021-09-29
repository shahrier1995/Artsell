using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TestArtSell.Admin
{
    public partial class ItemsList : System.Web.UI.Page
    {
        TestArtSell.CDA objcda = new TestArtSell.CDA();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                GetItemInfo();
            }

        }

        public void GetItemInfo()
        {
            string query = "SELECT * FROM tbl_Item_Info";
            DataSet ds = objcda.GetDataSet(query, "SMFM");
            rptOrders.DataSource = ds;
            rptOrders.DataBind();
        }

        protected void ApproveOrder(object sender, CommandEventArgs e)
        {
            string orderid = e.CommandArgument.ToString();
            string UpdateQuery = "UPDATE tbl_Order_Master SET STATUS = 'OC' WHERE ODRID = '" + orderid + "'; ";
            string updateDetailsQuery = "UPDATE tbl_Order_Details SET STATUS = 'OC' WHERE ODRID = '" + orderid + "'; ";
            objcda.ExecuteNonQuery(UpdateQuery, "SMFM");
            objcda.ExecuteNonQuery(updateDetailsQuery, "SMFM");
            DataSet ds = new DataSet();
            string queryGetUser = "Select userID,BuyerID from tbl_order_details where odrid='" + orderid + "'";
            ds = objcda.GetDataSet(queryGetUser, "SMFM");
            string sellerID = ds.Tables[0].Rows[0]["UserID"].ToString();
            string buyerID = ds.Tables[0].Rows[0]["BuyerID"].ToString();
            string querySellerInfo = "Select * from tbl_user_info where ID='" + sellerID + "'";
            string queryBuyerInfo = "Select * from tbl_user_info where ID='" + buyerID + "'";
            DataSet dsSeller = new DataSet();
            DataSet dsbuyer = new DataSet();
            dsSeller = objcda.GetDataSet(querySellerInfo, "SMFM");
            dsbuyer = objcda.GetDataSet(queryBuyerInfo, "SMFM");
            using (MailMessage mm = new MailMessage("shahrier.lged@gmail.com", dsSeller.Tables[0].Rows[0]["UserEmail"].ToString()))
            {
                mm.Subject = "Account Activation";
                string body = "Hello " + dsSeller.Tables[0].Rows[0]["UserFullName"].ToString() + ",";
                body += "You product of order no ='" + orderid + "' have been placed.";
                body += "<br /><br />Thanks";
                mm.Body = body;
                mm.IsBodyHtml = true;
                SmtpClient smtp = new SmtpClient();
                smtp.Host = "smtp.gmail.com";
                smtp.EnableSsl = true;
                NetworkCredential NetworkCred = new NetworkCredential("shahrier.lged@gmail.com", "lged@1234");
                smtp.UseDefaultCredentials = true;
                smtp.Credentials = NetworkCred;
                smtp.Port = 587;
                smtp.Send(mm);
            }
            using (MailMessage mm = new MailMessage("shahrier.lged@gmail.com", dsbuyer.Tables[0].Rows[0]["UserEmail"].ToString()))
            {
                mm.Subject = "Account Activation";
                string body = "Hello " + dsbuyer.Tables[0].Rows[0]["UserFullName"].ToString() + ",";
                body += "You product of order no ='" + orderid + "' have been placed.";
                body += "<br /><br />Thanks";
                mm.Body = body;
                mm.IsBodyHtml = true;
                SmtpClient smtp = new SmtpClient();
                smtp.Host = "smtp.gmail.com";
                smtp.EnableSsl = true;
                NetworkCredential NetworkCred = new NetworkCredential("shahrier.lged@gmail.com", "lged@1234");
                smtp.UseDefaultCredentials = true;
                smtp.Credentials = NetworkCred;
                smtp.Port = 587;
                smtp.Send(mm);
            }
            GetItemInfo();


        }

        protected void ddlStatus_SelectedIndexChanged(object sender, EventArgs e)
        {
            string strStatus = "";
            if (ddlStatus.SelectedValue.ToString() == "0")
            {
                strStatus = " WHERE UI.ID = OM.USERID";
            }
            else
            {
                strStatus = "WHERE UI.ID = OM.USERID AND  OM.STATUS = '" + ddlStatus.SelectedValue.ToString() + "'";

            }
            string query = "SELECT OM.ODRID,OM.TotalPrice, CONVERT(VARCHAR, OM.TIMESTAMP, 106) ODRDATE, OM.STATUS, OM.ItemQuantity,  UI.USERID "
                            + " FROM tbl_Order_Master OM,tbl_User_Info UI " + strStatus + " ";
            DataSet ds = objcda.GetDataSet(query, "SMFM");
            rptOrders.DataSource = ds;
            rptOrders.DataBind();
        }
    }
}