using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using NearestAutoRepairWebClient.NearestRepairRef;
using System.Web.Script.Serialization;
using System.Runtime.Serialization.Json;
using System.IO;
using System.Text;
using Microsoft.AspNet.Identity.EntityFramework;
using Microsoft.AspNet.Identity;
using System.ServiceModel;
using System.ServiceModel.Security;

namespace NearestAutoRepairWebClient
{
    public partial class WebForm2 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (!User.Identity.IsAuthenticated)
                {
                    Response.Redirect("~/Account/Login.aspx");
                }                
            }
        }
           
        protected void Button1_Click(object sender, EventArgs e)
        {
            ShowFiveNearestAutoRepairs();           
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            ShowAllAutoRepairs();
        }

        protected void btnGetNearestRepair_Click(object sender, EventArgs e)
        {
            ShowNearestAutoRepair();
        }

        /**/
        protected void ShowNearestAutoRepair()
        {          
            // This code passes to the service the user name and password as credentials. If the credentials are not valid, the service will throw an exception.
            NearestRepairRef.NearestAutoRepairServiceClient client = new NearestAutoRepairServiceClient();
            var userName = User.Identity.GetUserName();           

            if (userName == null || userName == "")
            {
                Response.Write("No value for User Name!");
                return;
            }
            else
            {
                client.ClientCredentials.UserName.UserName = userName;
            }
            // check for user password
            if (Session["uPass"] == null)
            {             
                Response.Write("Could not get user credentials. Try again.");
                return;
            }
            else
            {
                client.ClientCredentials.UserName.Password = (string)Session["uPass"];
            }            
            
            // check if hdnLocation.Value is null
            if (hdnLocation.Value == null || hdnLocation.Value == "")
            {                
                Response.Write("No value for location!");
                return;
            }            
            var userLocation = hdnLocation.Value;

            try
            {
                var query = client.GetNearestAutoRepair(userLocation);                
                // For one element    
                // GridView has to bind to List, IEnumerable ... 
                List<AutoRepairWCF> listNearest = new List<AutoRepairWCF>();
                listNearest.Add(query);

                gridViewAutoShops.DataSource = listNearest;
                gridViewAutoShops.DataBind();

                JavaScriptSerializer ser = new JavaScriptSerializer();
                hfServerValue.Value = ser.Serialize(listNearest);
            }
            catch (MessageSecurityException)
            {
                Response.Write("Authorization failed: You do not have permission to call this service.");
            }
            catch (SecurityAccessDeniedException securityEx)
            {                
                Response.Write(securityEx.Message + "<br/>" + "You do not have permission to call this operation.");
            }
            catch (FaultException<AutoRepairFault> faultEx)
            {
                Response.Write(faultEx.Message);                
            }
            catch (FaultException fex)
            {
                Response.Write("Unknown Fault: " + fex.ToString());
            }
            catch (CommunicationException)
            {
                // If Sessions are used
                // csharp-video-tutorials.blogspot.hr/2014/03/part-39-persession-wcf-services_1.html
                if (client.State == CommunicationState.Faulted)
                {
                    //client = new NearestAutoRepairServiceClient();
                    Response.Write("Session timed out. Your existing session will be lost. A new session will now be created");
                }
                else
                {
                    Response.Write("There was a communication problem.");
                }
            }
            catch (Exception)
            {
                Response.Write("Unexpected exception occurred.");
            }           
                      
            ClientScript.RegisterStartupScript(this.GetType(), "clientScript", "initialize()", true);
        }
        
        /**/
        protected void ShowFiveNearestAutoRepairs()
        {
            NearestRepairRef.NearestAutoRepairServiceClient client = new NearestAutoRepairServiceClient();
          
            var userName = User.Identity.GetUserName();           

            if (userName == null || userName == "")
            {
                Response.Write("No value for User Name!");
                return;
            }
            else
            {
                client.ClientCredentials.UserName.UserName = userName;
            }
            // check for user password
            if (Session["uPass"] == null)
            { 
                Response.Write("Could not get user credentials. Try again.");
                return;
            }
            else
            {
                client.ClientCredentials.UserName.Password = (string)Session["uPass"];
            }

            // check if hdnLocation.Value is null
            if (hdnLocation.Value == null || hdnLocation.Value == "")
            {
                Response.Write("No value for location!");
                return;
            }
            var userLocation = hdnLocation.Value;

            try
            {
                var query2 = client.GetFiveNearestAutoRepairs(userLocation);     
                gridViewAutoShops.DataSource = query2;
                gridViewAutoShops.DataBind();

                JavaScriptSerializer ser = new JavaScriptSerializer();
                hfServerValue.Value = ser.Serialize(query2);                
            }
            catch (MessageSecurityException)
            {
                Response.Write("Authorization failed: You do not have permission to call this service.");
            }
            catch (SecurityAccessDeniedException securityEx)
            {                
                Response.Write(securityEx.Message + "<br/>" + "You do not have permission to call this operation.");
            }
            catch (FaultException<AutoRepairFault> faultEx)
            {
                Response.Write(faultEx.Message);
            }
            catch (FaultException fex)
            {
                Response.Write("Unknown Fault: " + fex.ToString());
            }
            catch (CommunicationException)
            {
                // If Sessions are used
                // csharp-video-tutorials.blogspot.hr/2014/03/part-39-persession-wcf-services_1.html
                if (client.State == CommunicationState.Faulted)
                {
                    //client = new NearestAutoRepairServiceClient();
                    Response.Write("Session timed out. Your existing session will be lost. A new session will now be created");
                }
                else
                {
                    Response.Write("There was a communication problem.");
                }
            }
            catch (Exception)
            {
                Response.Write("Unexpected exception occurred.");
            }            

          ClientScript.RegisterStartupScript(this.GetType(), "clientScript", "initialize()", true);
        }
        
        /**/
        protected void ShowAllAutoRepairs()
        {
            NearestRepairRef.NearestAutoRepairServiceClient client = new NearestAutoRepairServiceClient();
           
            var userName = User.Identity.GetUserName();

            if (userName == null || userName == "")
            {
                Response.Write("No value for User Name!");
                return;
            }
            else
            {
                client.ClientCredentials.UserName.UserName = userName;
            }
            
            if (Session["uPass"] == null)
            { 
                Response.Write("Could not get user credentials. Try again.");
                return;
            }
            else
            {
                client.ClientCredentials.UserName.Password = (string)Session["uPass"];
            }

            try
            {
                var query2 = client.GetAllAutoRepairs();
                gridViewAutoShops.DataSource = query2;
                gridViewAutoShops.DataBind();

                JavaScriptSerializer ser = new JavaScriptSerializer();
                hfServerValue.Value = ser.Serialize(query2);
            }
            catch (MessageSecurityException)
            {
                Response.Write("Authorization failed: You do not have permission to call this service.");
            }
            catch (SecurityAccessDeniedException securityEx)
            {                
                Response.Write(securityEx.Message + "<br/>" + "You do not have permission to call this operation.");
            }
            catch (FaultException<AutoRepairFault> faultEx)
            {
                Response.Write(faultEx.Message);
            }
            catch (FaultException fex)
            {
                Response.Write("Unknown Fault: " + fex.ToString());
            }
            catch (CommunicationException)
            {
                // If Sessions are used
                // csharp-video-tutorials.blogspot.hr/2014/03/part-39-persession-wcf-services_1.html
                if (client.State == CommunicationState.Faulted)
                {
                    //client = new NearestAutoRepairServiceClient();
                    Response.Write("Session timed out. Your existing session will be lost. A new session will now be created");
                }
                else
                {
                    Response.Write("There was a communication problem.");
                }
            }
            catch (Exception)
            {
                Response.Write("Unexpected exception occurred.");
            }
                                
            ClientScript.RegisterStartupScript(this.GetType(), "clientScript", "initialize()", true);
        }
        
        protected void SignOut(object sender, EventArgs e)
        {
            var authenticationManager = HttpContext.Current.GetOwinContext().Authentication;
            authenticationManager.SignOut();
            Response.Redirect("~/Account/Login.aspx");
        }

    }
}