using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CallRecording
{
    public partial class Test : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [WebMethod]
        public static string StartRecording(string claimNumber)
        {
            return claimNumber;

        }

        [WebMethod]
        public static string StopRecording(string claimNumber)
        {
            return claimNumber;

        }
    }
}