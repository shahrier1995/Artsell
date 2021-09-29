using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TestArtSell.Seller
{
     
    public partial class OrderRequests : System.Web.UI.Page
    {
        TestArtSell.CDA objcda = new TestArtSell.CDA();

        public static DataSet dt = new DataSet();

        protected void Page_Load(object sender, EventArgs e)
        {
            GetOrderData();
        }

        public void GetOrderData()
        {

            
            string userID = Session["UserID"].ToString();


         
            string query = "SELECT  OM.ODRID,OM.TotalPrice, CONVERT(VARCHAR, OM.TIMESTAMP, 106) ODRDATE, OM.STATUS, OD.QTY, OD.USERID  "
                            + "FROM tbl_ORDER_MASTER OM, "
                            + "(SELECT DISTINCT ODRID,USERID, COUNT(ODRID) QTY FROM tbl_ORDER_DETAILS WHERE USERID = '" + userID + "' GROUP BY ODRID,USERID) OD "
                            +"WHERE OM.ODRID = OD.ODRID AND OM.STATUS IN ('OC') ORDER BY OM.TIMESTAMP DESC";

            DataSet ds = objcda.GetDataSet(query, "SMFM");
            Repeater1.DataSource = ds;
            Repeater1.DataBind();
        }

        [WebMethod]
        [ScriptMethod(UseHttpGet = true)]
        public static string GetOrderDetails(string orderid)
        {
            OrderRequests obj = new OrderRequests();
            TestArtSell.CDA objcda = new TestArtSell.CDA();

            string userID = obj.Session["UserID"].ToString();
            string query = "SELECT ITEMTITLE,ITEMPRICE,ITEMPHOTO FROM tbl_Order_Details OD,tbl_Item_Info ITM WHERE OD.ITEMID = ITM.ID "
                            + "AND ODRID = '" + orderid + "' AND OD.USERID = '" + userID + "' ;";

            DataSet ds = objcda.GetDataSet(query, "SMFM");

            DataTable table = ds.Tables[0];
            

            var JSONString = new StringBuilder();
            if (table.Rows.Count > 0)
            {
                JSONString.Append("[");
                for (int i = 0; i < table.Rows.Count; i++)
                {
                    JSONString.Append("{");
                    for (int j = 0; j < table.Columns.Count; j++)
                    {
                        if (j < table.Columns.Count - 1)
                        {
                            JSONString.Append("\"" + table.Columns[j].ColumnName.ToString() + "\":" + "\"" + table.Rows[i][j].ToString() + "\",");
                        }
                        else if (j == table.Columns.Count - 1)
                        {
                            JSONString.Append("\"" + table.Columns[j].ColumnName.ToString() + "\":" + "\"" + table.Rows[i][j].ToString() + "\"");
                        }
                    }
                    if (i == table.Rows.Count - 1)
                    {
                        JSONString.Append("}");
                    }
                    else
                    {
                        JSONString.Append("},");
                    }
                }
                JSONString.Append("]");
            }
            return JSONString.ToString();
        }

        protected void GetOrderDetails(object source, CommandEventArgs e)
        {
            string[] arg = new string[2];
            arg = e.CommandArgument.ToString().Split(';');
            string orderID = arg[0];
            string sellerID = arg[1];

            string query = "SELECT ITEMTITLE,ITEMPRICE,ITEMPHOTO, HEIGHT, WIDTH FROM tbl_Order_Details OD,tbl_Item_Info ITM WHERE OD.ITEMID = ITM.ID "
                            + "AND ODRID = '" + orderID + "' AND OD.USERID = '" + sellerID + "' ;";
            DataSet ds = objcda.GetDataSet(query, "SMFM");
            rptrOrderDetails.DataSource = ds;
            rptrOrderDetails.DataBind();

        }

    }
}