using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TestArtSell.Admin
{
    public partial class UsersList : System.Web.UI.Page
    {
        TestArtSell.CDA objcda = new TestArtSell.CDA();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                GetUserData();
            }
        }

        public void GetUserData()
        {
            string strStatus = "";
            if (ddlStatus.SelectedValue.ToString() == "0")
            {
                strStatus = "";
            }
            else
            {
                strStatus = ddlStatus.SelectedValue.ToString();
            }
            string query = "EXEC [dbo].[GetUserInfo] @Status = '" + strStatus + "'";
            DataSet ds = objcda.GetDataSet(query, "SMFM");
            rptUsers.DataSource = ds;
            rptUsers.DataBind();
            
        }

        protected void ApproveUser(object sender, CommandEventArgs e)
        {
            string userid = e.CommandArgument.ToString();
            string insertQuery = "UPDATE tbl_User_Info SET USERSTATUS = 'AC' WHERE USERID = '" + userid + "'; ";
            objcda.ExecuteNonQuery(insertQuery, "SMFM");
            GetUserData();
        }
        protected void DeactivateUser(object sender, CommandEventArgs e)
        {
            string userid = e.CommandArgument.ToString();
            string insertQuery = "UPDATE tbl_User_Info SET USERSTATUS = 'DE' WHERE USERID = '" + userid + "'; ";
            objcda.ExecuteNonQuery(insertQuery, "SMFM");
            GetUserData();
        }
        
        protected void ddlStatus_SelectedIndexChanged(object sender, EventArgs e)
        {
            GetUserData();
        }
    }
}