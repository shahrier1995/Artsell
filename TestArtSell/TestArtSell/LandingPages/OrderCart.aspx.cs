using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data.SqlClient;
using System.Data;
using System.Web.Services;
using System.Web.Script.Services;
using System.Net.Mail;
using System.IO;

namespace TestArtSell.LandingPages
{
    public partial class OrderCart : System.Web.UI.Page
    {
        
        TestArtSell.CDA objcda = new TestArtSell.CDA();
       
        string UserID = "";
        int totalPrice = 0;
        int orderOuantity = 0;
        string orderID = "";


        public DataTable ff ;
        public DataTable tsetdt;
        public static DataTable dt = new DataTable();

        protected void Page_Load(object sender, EventArgs e)
        {
           

            if (!IsPostBack)
            {
                if (Session["UserID"] == null)
                {

                }
                else
                {
                    int modalTotalPrice = 0;
                    UserID = Session["UserID"].ToString();
                    string query = "select * from tbl_User_Info where ID='" + UserID + "'";
                    DataSet ds = new DataSet();
                    ds = objcda.GetDataSet(query, "SMFM");
                    //string address = ds.Tables[0].Rows[0]["UserAddress"].ToString();
                    txtName.Text = ds.Tables[0].Rows[0]["UserFullName"].ToString();
                    txtContact.Text = ds.Tables[0].Rows[0]["UserContact"].ToString();
                    txtAddress.Text = ds.Tables[0].Rows[0]["UserAddress"].ToString();

                    dt = (DataTable)Session["orderCart"];
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        modalTotalPrice = modalTotalPrice + Convert.ToInt32(dt.Rows[i]["ItemPrice"].ToString());

                    }
                    string modalTotalPricewithDeli = (Convert.ToInt32(modalTotalPrice) + 60).ToString();
                    txtOrderTotal.InnerText = modalTotalPricewithDeli.ToString() + " BDT";
                    this.rptConfrmOrder.DataSource = dt;
                    this.rptConfrmOrder.DataBind();

                }

                if (Session["orderCart"] == null)
                {
                    isOrder.Visible = false;
                    noOrder.Visible = true;

                }
                else
                {
                    noOrder.Visible = false;
                    GetOrderInfo();
                }
            }
        
               
            

        }

        public void GetOrderInfo()
        {
            
            UserID = Request.QueryString["userID"];

            dt = (DataTable)Session["orderCart"];
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                totalPrice = totalPrice + Convert.ToInt32(dt.Rows[i]["ItemPrice"].ToString());

            }

            totalLabel.Text = totalPrice.ToString();
            totalAmount.Text = (Convert.ToInt32(totalPrice) + 60).ToString();
         
            this.rptOrder.DataSource = dt;
            this.rptOrder.DataBind();

            if (dt.Rows.Count>0)
            {
                noOrder.Visible = false;


            }
            else
            {
                isOrder.Visible = false;
                noOrder.Visible = true;
         
            }


        }

    

        protected void deleteITem(object sender, CommandEventArgs e)
        {


 
            string delID = e.CommandArgument.ToString();

            dt = (DataTable)Session["orderCart"];
            for (int i = dt.Rows.Count - 1; i >= 0; i--)
            {
                DataRow dr = dt.Rows[i];
                if (dr["ID"].ToString() == delID)
                    dr.Delete();
            }
            dt.AcceptChanges();
      
            Session["orderCart"] = dt;
            dt = (DataTable)Session["orderCart"];
            GetOrderInfo();
                

        }

        protected void btnConfirm_Click(object sender, EventArgs e)
        {

            

            UserID = Session["UserID"].ToString();
            dt = (DataTable)Session["orderCart"];
           
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                totalPrice = totalPrice + Convert.ToInt32(dt.Rows[i]["ItemPrice"].ToString());

            }

            if (CkhBAdd.Checked) {
                string address = txtAddress.Text;
                string updateAddrsQuery = "UPDATE tbl_User_Info SET UserAddress ='" + address + "' WHERE ID = '"+UserID+"' ";
                objcda.ExecuteNonQuery(updateAddrsQuery, "SMFM");
            }
            totalPrice = Convert.ToInt32(totalPrice) + 60;
            orderOuantity = dt.Rows.Count;
                string orderMasterQuery = "DECLARE @TBL AS TABLE(OderID nvarchar(36)) INSERT INTO tbl_Order_Master ([Status],ItemQuantity,UserID,ODRID ,TotalPrice,UserAddress,UserContact )OUTPUT inserted.ODRID INTO @TBL VALUES('OR', '" + orderOuantity + "','" + UserID + "', 'AS-' + RIGHT('0000'+ CAST(NEXT VALUE FOR dbo.GetInvoiceNumber AS VARCHAR(3)), 6),'" + totalPrice.ToString() + "', '"+txtAddress.Text+"','"+txtContact.Text+"' ) SELECT* FROM @TBL  ";

                DataSet orderMasterDS = objcda.GetDataSet(orderMasterQuery, "SMFM");
                orderID = orderMasterDS.Tables[1].Rows[0]["OderID"].ToString();
                
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                   
                    string ItemID = dt.Rows[i]["ID"].ToString();
                    string SellerID = objcda.getSingleValue("Select UserID from tbl_Item_Info where ID='"+ItemID+"'", "SMFM").ToString();
                    string ItemTitle = dt.Rows[i]["ItemTitle"].ToString();
                    string ItemPrice = dt.Rows[i]["ItemPrice"].ToString();
                    string ItemPhoto = dt.Rows[i]["ItemPhoto"].ToString();
                    string insertQuery = "INSERT INTO [tbl_Order_Details] (Status,[ItemID],[UserID],ODRID,BuyerID) VALUES('OR','" + ItemID + "','" + SellerID + "','" + orderID + "','"+UserID+"')";
                    objcda.ExecuteNonQuery(insertQuery, "SMFM");
                string updateQuery= "update tbl_Item_Info set Status='SO' where ID='"+ItemID+"'";
                objcda.ExecuteNonQuery(updateQuery, "SMFM");
            }
                ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Alert1", "alert(' Order Confirmed..Thanks,your order ID is " + orderID + "');", true);
                Session.Remove("orderCart"); // jokhn order kore fele tokhn ar card Session e rakhe kokhon
                SendMail(orderID);
                SendMailAdmin(orderID);
                Response.Redirect("OrderConfirmForm.aspx", false);
            
        }
        private string createEmailBody(string userName, string bodyType,string Greetings,string WaitMessage)
        {

            string body = string.Empty;
            //using streamreader for reading my htmltemplate   

            using (StreamReader reader = new StreamReader(Server.MapPath("OrderConfirmMessage.html")))

            {

                body = reader.ReadToEnd();

            }

            body = body.Replace("{UserName}", userName);  //replacing the required things 
            body = body.Replace("{BodyType}", bodyType);
            body = body.Replace("{Greetings}", Greetings);
            body = body.Replace("{WaitMessage}", WaitMessage);
            return body;

        }

        public void SendMail(string orderID)
        {
            string userIDVal = Session["UserID"].ToString();
            string getUserInformation = "Select UserFullName ,UserEmail from tbl_user_info where ID='" + userIDVal + "'";
            DataSet ds = objcda.GetDataSet(getUserInformation, "SMFM");
            string userName = ds.Tables[0].Rows[0]["UserFullName"].ToString();
            string userEmail = ds.Tables[0].Rows[0]["UserEmail"].ToString();
            MailMessage message = new MailMessage();
            message.From = new MailAddress("info@artsell.xyz");
            message.To.Add(new MailAddress(userEmail));
            message.Subject = "Order placed";
            string body = this.createEmailBody(userName, "Your Order ID is '"+orderID+"'", "Thank you very much for your order.", "You will be contacted by our representitive for further details.");
            message.Body = body;
            message.IsBodyHtml = true;
            SmtpClient smtp = new SmtpClient("artsell.xyz");
            smtp.Credentials = new System.Net.NetworkCredential("info@artsell.xyz", "password");
            smtp.Port =25;;
            smtp.EnableSsl = false;
            smtp.Send(message);

        }

        public void SendMailAdmin(string orderID)
        {
            string userIDVal = Session["UserID"].ToString();
            string getUserInformation = "Select UserFullName ,UserEmail from tbl_user_info where ID='" + userIDVal + "'";
            DataSet ds = objcda.GetDataSet(getUserInformation, "SMFM");
            string userName = ds.Tables[0].Rows[0]["UserFullName"].ToString();
            string userEmail = ds.Tables[0].Rows[0]["UserEmail"].ToString();
            MailMessage message = new MailMessage();
            message.From = new MailAddress("info@artsell.xyz");
            message.To.Add(new MailAddress("shahrier.1995@gmail.com"));
            message.Subject = "Order Placed";
            SmtpClient smtp = new SmtpClient("artsell.xyz");
            string body = this.createEmailBody("Admin", "the Order ID is '" + orderID + "'", "'"+userName+"' placed an order", "Contact with the buyer");
            message.Body = body;
            message.IsBodyHtml = true;
            smtp.Credentials = new System.Net.NetworkCredential("info@artsell.xyz", "password");
            smtp.Port =25;;
            smtp.EnableSsl = false;
            smtp.Send(message);
        }

        [WebMethod]
        [ScriptMethod(UseHttpGet =true)]
        public static string CheckLogin()
        {
            string chk = "";
           
            if (HttpContext.Current.Session["UserID"] == null)
            {
                chk = "0";
            }
            else
            {
                chk = "1";
                
            }
            return chk;
        }
        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string password = txtPassword.Text.Trim();
            byte[] encData_byte = new byte[password.Length];
            encData_byte = System.Text.Encoding.UTF8.GetBytes(password);
            string encodedData = Convert.ToBase64String(encData_byte);
            string query = "Select * from tbl_User_Info where UserID='" + txtUserID.Text + "' and Userpassword = '" + encodedData + "'";
            DataSet ds = objcda.GetDataSet(query, "SMFM");
            if (ds == null)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('failed');", true);
            }
            else
            {
                string id = ds.Tables[0].Rows[0]["ID"].ToString();
                Session["UserID"] = ds.Tables[0].Rows[0]["ID"].ToString();
                string queryLoginLog = "insert into tbl_login_Log(userID) values('" + id + "')";
                objcda.ExecuteNonQuery(queryLoginLog, "SMFM");
                Response.Redirect("OrderCart.aspx?UserID=" + id + "");

            }
        }
    }
}


    
