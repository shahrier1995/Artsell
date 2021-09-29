using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TestArtSell.Admin
{
    public partial class AdminMaster : System.Web.UI.MasterPage
    {
        TestArtSell.CDA objcda = new TestArtSell.CDA();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["UserID"] == null)
                {
                    Response.Redirect("..\\Login_Registration\\LoginForm.aspx");
                }
                else
                {
                    GetUserInfo();
                }
            }

        }
        protected void btnLogOut_Click(object sender, EventArgs e)
        {
            Session.Remove("UserID");
            Response.Redirect("~\\Login_Registration\\LoginForm.aspx");
        }
        public void GetUserInfo()
        {
            var str_userType = "";
            string userID = Session["UserID"].ToString();
            string query = "select * from tbl_User_Info Where ID='" + userID + "' ";
            DataSet ds = objcda.GetDataSet(query, "SMFM");
            if (ds.Tables[0].Rows.Count > 0)
            {
                foreach (DataRow dr in ds.Tables[0].Rows)
                {
                    var fullName = dr["UserFullName"].ToString();
                    var userEmail = dr["UserEmail"].ToString();
                    var str_userID = dr["UserID"].ToString();
                    str_userType = dr["UserType"].ToString();
                    var names = fullName.Split(' ');
                    string firstName = names[0];

                    lblFirstName.Text = firstName;
                    lblFullName.Text = fullName;
                    lblUserEmail.Text = userEmail;
                    lblUserNameInSideBar.InnerText = fullName;
                    lblUserIDInSideBar.InnerText = "@" + str_userID;
                }


            }

           

        }

        protected void btnRedirect_Click(object sender, EventArgs e)
        {
            Response.Redirect("..\\General\\Orders\\OrderHistory.aspx");
        }
    }
}