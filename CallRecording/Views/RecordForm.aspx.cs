using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using CallRecording.DAL;

namespace CallRecording
{
    public partial class RecordForm : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            LoadRoles();
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

        private void LoadRoles()
        {
            RoleRepository roleRepository = new RoleRepository();
            ddlRole.DataValueField = "Id";
            ddlRole.DataTextField = "Name";
            ddlRole.DataSource = roleRepository.GetRoles();
            ddlRole.DataBind();
        }
    }
}