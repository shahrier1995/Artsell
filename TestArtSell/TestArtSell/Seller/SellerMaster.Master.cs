using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TestArtSell.Seller
{
    public partial class SellerMaster : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["UserID"] == null)
                {
                    Response.Redirect("..\\Login_Registration\\LoginForm.aspx");
                }
            }

        }

        protected void btnLogOut_Click(object sender, EventArgs e)
        {
            Session.Remove("UserID");
            Response.Redirect("..\\LandingPages\\Home.aspx");
        }

       
    }
}