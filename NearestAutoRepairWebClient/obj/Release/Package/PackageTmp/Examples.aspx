<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Examples.aspx.cs" Inherits="NearestAutoRepairWebClient.Examples" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
  <div>
                
        <asp:Button ID="Button1" runat="server" OnClientClick="return confirm('Ready to submit.');"  Text="Test Client Click" OnClick="Button1_Click1" />
        <asp:Label ID="lblmessage" runat="server"  ViewStateMode="Enabled"></asp:Label>
        <asp:TextBox ID="TextBox1" runat="server" onkeyup="getCharacterCount() , CallScript()"></asp:TextBox>

        <asp:Label ID="Label1" runat="server" ClientIDMode="Static"></asp:Label>

   <script type="text/javascript">
        
        function getCharacterCount()
        {
            document.getElementById("<%=Label1.ClientID%>").innerHTML = document.getElementById("<%=TextBox1.ClientID%>").value.length;
            //document.getElementById("Label1").innerHTML = document.getElementById("TextBox1").value.length;
            
        }
        
    function CallScript()
    {
        var x = document.getElementById("<%=lblmessage.ClientID%>");
        x.innerHTML = "TextBox1 onKeyUp";
    }
    function changeImageOnMouseOut()
    {
        var x = document.getElementById("<%=lblmessage.ClientID%>");
        x.innerHTML = "Ye ima!!";
    }
   </script>
    
  </div>
</asp:Content>