using iTextSharp.text;
using iTextSharp.text.html.simpleparser;
using iTextSharp.text.pdf;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TestArtSell.Admin
{
    public partial class OrdersList : System.Web.UI.Page
    {
        TestArtSell.CDA objcda = new TestArtSell.CDA();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                GetOrderData();
            }
            
        }

        public void GetOrderData()
        {
            string query = "SELECT OM.ODRID,OM.TotalPrice, CONVERT(VARCHAR, OM.TIMESTAMP, 106) ODRDATE, OM.STATUS, OM.ItemQuantity,  UI.USERID "
                            + "FROM tbl_Order_Master OM,tbl_User_Info UI  WHERE UI.ID = OM.USERID ;";
            DataSet ds = objcda.GetDataSet(query, "SMFM");
            rptOrders.DataSource = ds;
            rptOrders.DataBind();
        }
        
        protected void ApproveOrder(object sender, CommandEventArgs e)
        {
            string orderid = e.CommandArgument.ToString();
            string UpdateQuery = "UPDATE tbl_Order_Master SET STATUS = 'OC' WHERE ODRID = '"+ orderid + "'; ";
            string updateDetailsQuery = "UPDATE tbl_Order_Details SET STATUS = 'OC' WHERE ODRID = '" + orderid + "'; ";
            objcda.ExecuteNonQuery(UpdateQuery, "SMFM");
            objcda.ExecuteNonQuery(updateDetailsQuery, "SMFM");
            DataSet ds = new DataSet();
            DataSet orderData = new DataSet();
            string orderQuery = "select * from tbl_Order_Master where ODRID ='" + orderid + "'";
            orderData = objcda.GetDataSet(orderQuery, "SMFM");
            string totalAmount = orderData.Tables[0].Rows[0]["TotalPrice"].ToString();
            string queryGetUser = "Select userID,BuyerID from tbl_order_details where odrid='"+orderid+"'";
            ds = objcda.GetDataSet(queryGetUser, "SMFM");
            string sellerID = ds.Tables[0].Rows[0]["UserID"].ToString();
            string buyerID = ds.Tables[0].Rows[0]["BuyerID"].ToString();
            string querySellerInfo = "Select * from tbl_user_info where ID='"+sellerID+"'";
            string queryBuyerInfo = "Select * from tbl_user_info where ID='" + buyerID + "'";
            DataSet buyerData = new DataSet();
            buyerData = objcda.GetDataSet(queryBuyerInfo, "SMFM");
            string BuyerName = buyerData.Tables[0].Rows[0]["UserFullName"].ToString();
            string BuyerEmail = buyerData.Tables[0].Rows[0]["UserEmail"].ToString();
            DataSet dsSeller = new DataSet();
            DataSet dsbuyer = new DataSet();
            string queryOrderDetails = "SELECT ITEMTITLE,ITEMPRICE,ITEMPHOTO FROM tbl_Order_Details OD,tbl_Item_Info ITM WHERE OD.ITEMID = ITM.ID " + "AND ODRID = '" + orderid + "'";
            DataSet orderDetailsData = new DataSet();
            orderDetailsData = objcda.GetDataSet(queryOrderDetails, "SMFM");
            dsSeller = objcda.GetDataSet(querySellerInfo, "SMFM");
            dsbuyer = objcda.GetDataSet(queryBuyerInfo, "SMFM");




            using (StringWriter sw = new StringWriter())
            {
                using (HtmlTextWriter hw = new HtmlTextWriter(sw))
                {
                    //string companyName = "Artsell.xyz";
                    //string LogoPath = "./images/artsell.png";
                    string orderNo = orderid.ToString();
                    StringBuilder sb = new StringBuilder();
                    sb.Append("<table width='100%' cellspacing='0' cellpadding='2'>");
                    sb.Append("<tr style='border:1px solid black'><td align='center' style='background-color: #18B5F0;text-align:center' colspan = '2'><img src='https://www.artsell.xyz/images/artsell.png' alt='logo' width='180' height='95' /></td></tr>");
                    sb.Append("<tr><td colspan = '2'></td></tr>");
                    sb.Append("<tr><td><b>Order No:</b>");
                    sb.Append(orderNo);
                    sb.Append("</td><td><b>Date: </b>");
                    sb.Append(DateTime.Now);
                    sb.Append(" </td></tr>");
                    sb.Append("<tr><td colspan = '2'><b>Buyer Name :</b> ");
                    sb.Append(BuyerName);
                    sb.Append("</td></tr>");
                    sb.Append("<tr><td><b>Total Amount:  </b>"+totalAmount+" BDT </td></tr>");
                    sb.Append("<tr><td><b>Payment Status :</b> Unpaid </td></tr>");
                    sb.Append("</table>");
                    sb.Append("<br/> <br/> <br/> <br/><table>");
                    sb.Append("<tr>");
                    sb.Append("<td> Item");
                    sb.Append("</td>");
                    sb.Append("<td> Item Name");
                    sb.Append("</td>");
                    sb.Append("<td> Price");
                    sb.Append("</td>");
                    sb.Append("</tr>");
                    sb.Append("<tr>");
                    sb.Append("<td>-------------------------------------</td>");
                    sb.Append("<td>-------------------------------------</td>");
                    sb.Append("<td>-------------------------------------</td>");
                    sb.Append("</tr>");
                    foreach (DataRow item in orderDetailsData.Tables[0].Rows)
                    {
                        sb.Append("<tr>");
                        string imagePath = "https://www.artsell.xyz/" + orderDetailsData.Tables[0].Rows[0]["ITEMPHOTO"].ToString();
                        imagePath = imagePath.Replace("/..", string.Empty);
                        sb.Append("<td><img width='150' src='" + imagePath+"'>");
                        sb.Append("</td>");
                        sb.Append("<td>" + orderDetailsData.Tables[0].Rows[0]["ITEMTITLE"].ToString() + "");
                        sb.Append("</td>");
                        sb.Append("<td>" + orderDetailsData.Tables[0].Rows[0]["ITEMPRICE"].ToString() + "");
                        sb.Append("</td>");
                        sb.Append("</tr>");
                        sb.Append("<tr>");
                        sb.Append("<td>-------------------------------------</td>");
                        sb.Append("<td>-------------------------------------</td>");
                        sb.Append("<td>-------------------------------------</td>");
                        sb.Append("</tr>");
                    }
                    sb.Append("<tr>");
                    sb.Append("<td>");
                    sb.Append("</td>");
                    sb.Append("<td> Delivery Charge");
                    sb.Append("</td>");
                    sb.Append("<td> 60 BDT");
                    sb.Append("</td>");
                    sb.Append("</tr>");
                    sb.Append("<tr>");
                    sb.Append("<td></td>");
                    sb.Append("<td>-------------------------------------</td>");
                    sb.Append("<td>-------------------------------------</td>");
                    sb.Append("</tr>");
                    sb.Append("<tr>");
                    sb.Append("<td>");
                    sb.Append("</td>");
                    sb.Append("<td> <b>Total Amout</b>");
                    sb.Append("</td>");
                    sb.Append("<td>"+ totalAmount);
                    sb.Append("</td>");
                    sb.Append("</tr>");
                    sb.Append("</table>");
                    sb.Append("<br/><br/>Thanks, ");
                    sb.Append("<br/><br/>Your Artsell Team ");
                    sb.Append("<br />");


                    StringReader sr = new StringReader(sb.ToString());

                    Document pdfDoc = new Document(PageSize.A4, 10f, 10f, 10f, 0f);
                    HTMLWorker htmlparser = new HTMLWorker(pdfDoc);
                    using (MemoryStream memoryStream = new MemoryStream())
                    {
                        PdfWriter writer = PdfWriter.GetInstance(pdfDoc, memoryStream);
                        pdfDoc.Open();
                        htmlparser.Parse(sr);
                        pdfDoc.Close();
                        byte[] bytes = memoryStream.ToArray();
                        memoryStream.Close();

                        MailMessage mm = new MailMessage("storyboard123456@gmail.com", BuyerEmail);
                        mm.Subject = "Order Receiptt";
                        string body = "Hello " + BuyerName.Trim() + ",";
                        body += "<br /><br />Your Order no :  " + orderid + " has been Approved.";
                        body += "<br /><br />Please check the PDF file for details.</b>";
                        body += "<br /><br />Thanks";
                        body += "<br /><br />Your Artsell Team.";
                        mm.Body = body;
                        
                       
                        mm.Attachments.Add(new Attachment(new MemoryStream(bytes), "OrderReceipt.pdf"));
                        mm.IsBodyHtml = true;
                        SmtpClient smtp = new SmtpClient();
                        smtp.Host = "smtp.gmail.com";
                        smtp.EnableSsl = true;
                        NetworkCredential NetworkCred = new NetworkCredential();
                        NetworkCred.UserName = "storyboard123456@gmail.com";
                        NetworkCred.Password = "password";
                        smtp.UseDefaultCredentials = true;
                        smtp.Credentials = NetworkCred;
                        smtp.Port = 587;
                        smtp.Send(mm);
                    }
                }
            }




        
            GetOrderData();


        }

        protected void ddlStatus_SelectedIndexChanged(object sender, EventArgs e)
        {
            string strStatus = "";
            if(ddlStatus.SelectedValue.ToString() == "0")
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