using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TestArtSell.Admin
{
    public partial class CategorySetup : System.Web.UI.Page
    {
        TestArtSell.CDA objcda = new TestArtSell.CDA();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                GetCategoryInfo();
            }
        }

        public void GetCategoryInfo()
        {

            string query = "EXEC [dbo].[GetCategoryInfo]";
            DataSet ds = objcda.GetDataSet(query, "SMFM");
            rptUsers.DataSource = ds;
            rptUsers.DataBind();

        }
        public void AddCategory()
        {
            string cattitle = txtTitle.Text.ToString().Trim();
            string catDetails = txtTitle.Text.ToString().Trim();

            string query = "INSERT INTO tbl_Item_Category (CatTitle,CatDetails,Status) VALUES ('" + cattitle + "','" + catDetails + "','AC')";

            objcda.ExecuteNonQuery(query, "SMFM");
            GetCategoryInfo();
        }

        protected void DeactivateUser(object sender, CommandEventArgs e)
        {
            string id = e.CommandArgument.ToString();
            string insertQuery = "DELETE FROM [tbl_Item_Category] WHERE ID = '"+id+"'";
            objcda.ExecuteNonQuery(insertQuery, "SMFM");
            GetCategoryInfo();
        }

        protected void btnDipo_Click(object sender, EventArgs e)
        {
            AddCategory();
        }

       
    }
}