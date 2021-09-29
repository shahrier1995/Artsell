using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;


namespace TestArtSell.Login_Registration
{
    public partial class LoginForm : System.Web.UI.Page
    {
        TestArtSell.CDA objCDA = new TestArtSell.CDA();


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

            }

        }



        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string query = "Select * from tbl_User_Info where UserID='" + txtUserID.Text + "' and Userpassword = '" + txtPass.Text + "'";
            DataSet ds = objCDA.GetDataSet(query, "SMFM");
            if (ds == null)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('failed');", true);
            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('successs');", true);
                if (ds.Tables[0].Rows[0]["UserType"].ToString() == "1")
                {
                    string id= ds.Tables[0].Rows[0]["ID"].ToString();
                    Session["UserID"] = ds.Tables[0].Rows[0]["ID"].ToString();
                    Response.Redirect("..\\Seller\\SellerDashboard.aspx?id=" + id + "");
                }
                else
                {
                    string id = ds.Tables[0].Rows[0]["ID"].ToString();
                    Session["UserID"] = ds.Tables[0].Rows[0]["ID"].ToString();
                    Response.Redirect("..\\Buyer\\BuyerDashboard.aspx?id=" + id + "");
                }
            }

        }

        protected void regLink_Click(object sender, EventArgs e)
        {
            Response.Redirect("Registration.aspx");
        }
    }
}