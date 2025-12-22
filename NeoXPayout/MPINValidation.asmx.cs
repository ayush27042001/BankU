using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;

namespace NeoXPayout
{
    /// <summary>
    /// Summary description for MPINValidation
    /// </summary>
    
    [System.Web.Script.Services.ScriptService] 
    [System.ComponentModel.ToolboxItem(false)]
   
    public class MPINValidation : System.Web.Services.WebService
    {

        [WebMethod(EnableSession = true)]
        
        public string ValidateMPIN(string mpin)
        {
           

            if (Session["UserMPIN"] == null)
            {
               
                return "locked";
            }

            string storedMPIN = Session["UserMPIN"].ToString();

            if (Session["MPINAttempts"] == null)
                Session["MPINAttempts"] = 0;

            int attempts = (int)Session["MPINAttempts"];

            if (attempts >= 3)
            {
                Session["RequireMPIN"] = true;
                return "locked";
            }

            if (mpin == storedMPIN)
            {
                Session["MPINAttempts"] = 0;
                Session["RequireMPIN"] = false; // MPIN is now correct
                return "valid";
            }
            else
            {
                attempts++;
                Session["MPINAttempts"] = attempts;
                Session["RequireMPIN"] = true;

                if (attempts >= 3)
                    return "locked";
                else
                    return "invalid";
            }
        }
        // New method to lock the session after inactivity
        [WebMethod(EnableSession = true)]
        public void LockSession()
        {
            
            Session["RequireMPIN"] = true;
            Session["MPINAttempts"] = 0; // reset attempts when locking for inactivity
        }
    }
}
