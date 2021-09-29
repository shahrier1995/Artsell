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
    public partial class SellingHistory : System.Web.UI.Page
    {
        CDA objcda = new CDA();

        protected void Page_Load(object sender, EventArgs e)
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

                lblLeft.Text = (Convert.ToInt32(ds1.Tables[0].Rows[0]["itemPrice"]) - Convert.ToInt32(ds2.Tables[0].Rows[0]["itemPrice"])).ToString();
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
                    lblLeft.Text = (Convert.ToInt32(ds1.Tables[0].Rows[0]["itemPrice"])).ToString();
                    percentComplete = (int)Math.Round((double)(100 * sold) / worth);
                    string percentage = percentComplete.ToString() + "%";
                    lblPercentage.Text = percentage;
                    lblprog.Style.Add("width", percentage);
                    lblprog.Attributes.Add("aria-valuenow", percentComplete.ToString("F1"));
                }

            }

            //string userID = Session["UserID"].ToString();
            //string queryWorth = " select sum(itemprice) as itemPrice from tbl_Item_Info where userid='" + userID + "'";
            //DataSet ds1 = objcda.GetDataSet(queryWorth, "SMFM");
            //lblAmount.Text = ds1.Tables[0].Rows[0]["itemPrice"].ToString();
            //string querySold = " select sum(itemprice) as itemPrice from tbl_Item_Info where userid='" + userID + "' and [Status]='SO' ";
            //DataSet ds2 = objcda.GetDataSet(querySold, "SMFM");
            //if (ds2 != null)
            //{
            //    lblSold.Text = ds2.Tables[0].Rows[0]["itemPrice"].ToString();

            //    lblLeft.Text = (Convert.ToInt32(ds1.Tables[0].Rows[0]["itemPrice"]) - Convert.ToInt32(ds2.Tables[0].Rows[0]["itemPrice"])).ToString();
            //    int worth = Convert.ToInt32(ds1.Tables[0].Rows[0]["itemPrice"]);
            //    int sold = Convert.ToInt32(ds2.Tables[0].Rows[0]["itemPrice"]);
            //    int percentComplete = (int)Math.Round((double)(100 * sold) / worth);
            //    string percentage = percentComplete.ToString() + "%";
            //    lblPercentage.Text = percentage;
            //    lblprog.Style.Add("width", percentage);
            //    lblprog.Attributes.Add("aria-valuenow", percentComplete.ToString("F1"));
            //}
            //else
            //{
            //    lblSold.Text = "No Item Sold";

            //    lblLeft.Text = (Convert.ToInt32(ds1.Tables[0].Rows[0]["itemPrice"]) ).ToString();
            //    int worth = Convert.ToInt32(ds1.Tables[0].Rows[0]["itemPrice"]);
            //    int sold = 0;
            //    int percentComplete = (int)Math.Round((double)(100 * sold) / worth);
            //    string percentage = percentComplete.ToString() + "%";
            //    lblPercentage.Text = percentage;
            //    lblprog.Style.Add("width", percentage);
            //    lblprog.Attributes.Add("aria-valuenow", percentComplete.ToString("F1"));
            //}
    

        }
        protected void OnWorthClick(object sender, EventArgs e)
        {
            string userID = Session["UserID"].ToString();
            string query = "Select * from tbl_Item_Info where userid='" + userID + "'";
            DataSet ds = new DataSet();
            ds = objcda.GetDataSet(query, "SMFM");
            rptiteminfo.DataSource = ds;
            rptiteminfo.DataBind();

        }
        protected void OnSoldClick(object sender, EventArgs e)
        {
            string userID = Session["UserID"].ToString();
            string query = "Select * from tbl_Item_Info where userid='" + userID + "'and [Status]='SO'";
            DataSet ds = new DataSet();
            ds = objcda.GetDataSet(query, "SMFM");
            
            rptiteminfo.DataSource = ds;
            rptiteminfo.DataBind();

        }
        protected void OnYetClick(object sender, EventArgs e)
        {
            string userID = Session["UserID"].ToString();
            string query = "Select * from tbl_Item_Info where userid='" + userID + "' and [status] <> 'SO'";
            DataSet ds = new DataSet();
            ds = objcda.GetDataSet(query, "SMFM");
            rptiteminfo.DataSource = ds;
            rptiteminfo.DataBind();

        }
        protected void OnSelectedIndexChanged(object sender, EventArgs e)
        {
            string userID = Session["UserID"].ToString();
            string month = ddlMonth.SelectedItem.Value;
            string query = "SELECT *  from tbl_Item_Info where  MONTH([TimeStamp])='" + month + "' and userid='" + userID + "'";
            DataSet ds = new DataSet();
            ds = objcda.GetDataSet(query, "SMFM");
            rptiteminfo.DataSource = ds;
            rptiteminfo.DataBind();
        }
    }
}