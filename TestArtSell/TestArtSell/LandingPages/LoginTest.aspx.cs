using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;

namespace TestArtSell.LandingPages
{
    public partial class LoginTest : System.Web.UI.Page
    {

        TestArtSell.CDA objCDA = new TestArtSell.CDA();
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string query = "Select * from tbl_User_Info where UserID='" + txtUserID.Text + "' and Userpassword = '" + txtPassword.Text + "'";
            DataSet ds = objCDA.GetDataSet(query, "SMFM");
            if (ds == null)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('failed');", true);
            }
            else
            {
                string id = ds.Tables[0].Rows[0]["ID"].ToString();
                Session["UserID"] = ds.Tables[0].Rows[0]["ID"].ToString();
                Response.Redirect("OrderCart.aspx?UserID=" + id + "");

            }
        }
    }
}