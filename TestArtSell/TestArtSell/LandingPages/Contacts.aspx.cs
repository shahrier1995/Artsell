using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data.SqlClient;
using System.Data;
using System.Web.Services;
using System.Web.Script.Services;

namespace TestArtSell.LandingPages
{
    public partial class Contacts : System.Web.UI.Page
    {

        TestArtSell.CDA objcda = new TestArtSell.CDA();
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            string querySubmit = "insert into tbl_Message(Name,Email,Website,Message) values('"+txtName.Value+ "','" + txtEmail.Value + "','" + txtWebsite.Value + "','" + txtMessage.Value + "')";
            objcda.ExecuteNonQuery(querySubmit, "SMFM");
        }

        protected void btnSubmit_ServerClick(object sender, EventArgs e)
        {

        }
    }
}