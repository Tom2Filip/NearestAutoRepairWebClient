<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="About.aspx.cs" Inherits="NearestAutoRepairWebClient.About" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="MainContent" runat="server">

    <p>
      This is a ASP.NET Web Client app for WCF service (NearestAutoRepairWCFSolution). It shows nearest auto repair shops in Zagreb, Croatia, based on users position.
    </p>
    <p>
      Authorization for this app is following tutorial: <a href="https://msdn.microsoft.com/en-us/library/ff406125.aspx" target="_blank">Case 2: Internal Web-Hosted Service</a>
     <br/>The service is configured to only allow members of the Windows users group to view Auto Repair Shops.               
    </p>   
     <p>
      Special thanks and Credits for icons used in maps to: <a href="https://mapicons.mapsmarker.com" target="_blank">Maps Icons Collection</a>
    </p>
    <p>
      Tecnhologies used: ASP.Net WebForms/Identity, C#, Entity Framework, MSSQL, HTML, CSS, jQuery, JSON, Javascript
    </p>

</asp:Content>
