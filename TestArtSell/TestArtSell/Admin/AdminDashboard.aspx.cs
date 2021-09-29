using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TestArtSell.Admin
{
    public partial class AdminDashboard : System.Web.UI.Page
    {

        TestArtSell.CDA objcda = new TestArtSell.CDA();
        protected void Page_Load(object sender, EventArgs e)
        {
            GetDashboardInfo();
            
        }       
        public  void  GetDashboardInfo()
        {
            TestArtSell.CDA objcda = new TestArtSell.CDA();
            string query = "SELECT COUNT(*) FROM tbl_User_Info";
            string  totUser = objcda.getSingleValue(query, "SMFM").ToString();
            lblTotalUser.Text = totUser;


            string queryOrder = "SELECT COUNT(*) FROM tbl_Order_Master";
            string totOrder = objcda.getSingleValue(queryOrder, "SMFM").ToString();
            lblTotalOrder.Text = totOrder;
        }
    }
}