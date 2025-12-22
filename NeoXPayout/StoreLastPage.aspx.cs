using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NeoXPayout
{
    public partial class StoreLastPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string url = Request.QueryString["url"];
            if (!string.IsNullOrEmpty(url))
            {
                
                if (!url.Contains("http") && !url.Contains("//"))
                    Session["LastPage"] = url;
            }
            // Mark MPIN as not verified when session locks
            Session["IsMPINVerified"] = false;
        }
    }
}