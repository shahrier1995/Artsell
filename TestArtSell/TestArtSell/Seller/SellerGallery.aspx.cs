using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;

namespace TestArtSell.Seller
{
    public partial class SellerGallery : System.Web.UI.Page
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
          
            if (!IsPostBack)
            {
                if (Session["UserID"] == null)
                {
                    Response.Redirect("..\\Login_Registration\\LoginForm.aspx");
                }
                else
                {
                   

                    GetGalleryData();
                    GetCategory();
                }

            }
        }
        public void GetGalleryData()
        {
            string userID = Session["UserID"].ToString();
            string query = "select * from tbl_Item_Info Where UserID='" + userID + "' AND STATUS NOT IN ('DEL') order by TimeStamp desc";
            DataSet ds = objcda.GetDataSet(query, "SMFM");
            rptGallery.DataSource = ds;
            rptGallery.DataBind();
        }
        public void GetCategory()
        {
           
            string query = "Select * from tbl_Item_Category";
            DataSet ds = objcda.GetDataSet(query, "SMFM");
            ddlCat.DataSource = ds.Tables[0];

            ddlCat.DataValueField = "CatID";
            ddlCat.DataTextField= "CatTitle";
            ddlCat.DataBind();
            ddlCat.Items.Insert(0, new ListItem("Select category", "NA"));
        }
        protected void btnUpload_Click(object sender, EventArgs e)
        {
            
        }
        protected void btnEdit_Click(object sender, EventArgs e,string ID)
        {
            string a = ID;
         
            
        }
        

        protected void rptGallery_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            string itemID = e.CommandArgument.ToString();
            string editquery = "select * from tbl_Item_Info where ID='" + itemID + "'";


            DataSet ds1 = objcda.GetDataSet(editquery, "SMFM");
            string itemTitle = ds1.Tables[0].Rows[0]["ItemTitle"].ToString();
            string itemDetails = ds1.Tables[0].Rows[0]["ItemDetails"].ToString();
            string itemPrice = ds1.Tables[0].Rows[0]["ItemPrice"].ToString();
            string catID = ds1.Tables[0].Rows[0]["CatID"].ToString();
            string userID = ds1.Tables[0].Rows[0]["UserID"].ToString();
            string dbPath = ds1.Tables[0].Rows[0]["ItemPhoto"].ToString();
            string width = ds1.Tables[0].Rows[0]["Width"].ToString();
            string height = ds1.Tables[0].Rows[0]["Height"].ToString();

            Session["PhotoId"] = e.CommandArgument.ToString();
            MultiView1.ActiveViewIndex = 1;

            imgServer.ImageUrl = dbPath;
            txttitle.Text = itemTitle;
            ddlCat.SelectedValue = catID;
            txtPrice.Text = itemPrice;
            txtWidth.Text = width;
            txtHeight.Text = height;
            txtDetails.Value = itemDetails;

        }
        protected void btnUpdateArtInfo_Click(object sender, EventArgs e)
        {
            string id = Session["PhotoId"].ToString();
            string updateQuery = "UPDATE tbl_item_info SET ItemTitle='" + txttitle.Text.Trim() + "', ItemDetails = '" + txtDetails.Value + "' , CatID = '" + ddlCat.SelectedValue + "', Height = '" + txtHeight.Text.Trim() + "', Width = '" + txtWidth.Text.Trim() + "' WHERE ID = '" + id + "' ";
            objcda.ExecuteNonQuery(updateQuery, "SMFM");
            MultiView1.ActiveViewIndex = 0;
            GetGalleryData();
        }
        protected void btnBackToGallery_Click(object sender, EventArgs e)
        {
            MultiView1.ActiveViewIndex = 0;
            txttitle.Text = "";
            txtPrice.Text = "";
            txtWidth.Text = "";
            txtHeight.Text = "";
            txtDetails.Value = "";
            GetGalleryData();
        }
        protected void btnDeleteArt_Click(object sender, EventArgs e)
        {
            string id = Session["PhotoId"].ToString();
            string updateQuery = "UPDATE tbl_item_info SET STATUS='DEL' WHERE ID = '" + id + "' ";
            objcda.ExecuteNonQuery(updateQuery, "SMFM");
            MultiView1.ActiveViewIndex = 0;
            GetGalleryData();
        }
    }
}