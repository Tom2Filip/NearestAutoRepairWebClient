<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GeoLocation.aspx.cs" Inherits="NearestAutoRepairWebClient.GeoLocation" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>GeoLocation</title>    
</head>
<body>    
                    
    <form id="form1" runat="server">                         
        <div class="form2">
            
            <asp:Button ID="Button1" runat="server" Text="Test Client Click" OnClick="Button1_Click" />             
            <asp:Label ID="lblmessage" runat="server"></asp:Label>                
                                            
        </div>
        
        <%--
        <script runat="server">    
            void Button1_Click(object sender, EventArgs e)
            { lblmessage.Text = "Postback!"; }                     
          </script>
            

        <script type="text/javascript">
            function myfunction() {                
                alert('In JavaScript Code after server side code execution');
            }
        </script>
            --%>  

        <script type="text/javascript">
            function changeText() {
                var x = document.getElementById("lblmessage");
                x.innerHTML = "JavaScript Code after server side code execution";
            }
        </script>
               
                   
    </form>  
    </body>
</html>
