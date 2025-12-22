using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NeoXPayout
{
    public partial class Payment : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Check if session has payment URL
                //if (Session["paymentUrl"] != null)
                //{
                //    string paymentUrl = Session["paymentUrl"].ToString();

                //    // Set iframe src securely (without exposing URL in query string)
                //    paymentFrame.Attributes["src"] = paymentUrl;
                //}
                //else
                //{
                //    // Optionally handle missing URL
                //    paymentFrame.Attributes["src"] = "about:blank";
                //}
            }
        }
    }
}