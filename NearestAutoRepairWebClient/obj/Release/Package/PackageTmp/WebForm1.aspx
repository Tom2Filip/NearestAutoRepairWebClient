<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="NearestAutoRepairWebClient.WebForm1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="http://ajax.aspnetcdn.com/ajax/jquery/jquery-1.9.0.js"></script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
 <p>Click on button to get location.</p>
            
            <p>
            <asp:HiddenField ID="hdnLocation" runat="server" /> 
            </p>
            <p>
            <asp:Button ID="btnSubmit" runat="server" Text="Get Location"  OnClick="btnSubmit_Click" />
            </p>
            <p id="message"></p>
        
        <%-- // staticmapmaker.com/google/ --%>        
        <p>HTML</p>        
        <img width="600" src="http://maps.googleapis.com/maps/api/staticmap?center=ilica55,+zagreb&zoom=15&scale=1&size=600x300&maptype=roadmap&format=png&visual_refresh=true&markers=size:mid%7Ccolor:0xff0000%7Clabel:1%7Cilica55,+zagreb" alt="Google Map of ilica55, zagreb"/>
        <p>Map with link to Google Maps</p>   
         <a href="https://www.google.com/maps/place/ilica55,+zagreb/"><img src="http://maps.googleapis.com/maps/api/staticmap?center=ilica55,+zagreb&zoom=15&scale=1&size=600x300&maptype=roadmap&format=png&visual_refresh=true&markers=size:mid%7Ccolor:0xff0000%7Clabel:1%7Cilica55,+zagreb" alt="Google Map of ilica55, zagreb"/></a>
        <p>Map with link to Google Maps directions</p>   
        <a href="https://www.google.com/maps/dir//ilica55,+zagreb/"><img src="http://maps.googleapis.com/maps/api/staticmap?center=ilica55,+zagreb&zoom=15&scale=1&size=600x300&maptype=roadmap&format=png&visual_refresh=true&markers=size:mid%7Ccolor:0xff0000%7Clabel:1%7Cilica55,+zagreb" alt="Google Map of ilica55, zagreb"/></a>

        <br />
        <p>Click on button to see location in map.</p>
        <asp:Button ID="btnShowLocation" runat="server" Text="Show Location"  OnClick="btnShowLocation_Click" />
         <div id="mapholder" ></div>
        <br />

    </div>       

        <script type="text/javascript">
            // WORKS !!
            function getPosition() {
                if (navigator.geolocation) {
                    navigator.geolocation.getCurrentPosition(showPosition, showError, { maximumAge: 0 });
                }
                else { $("#message").html("Geolocation is not supported by this browser."); }
            }

            function showPosition(position) {
                // Not used -> this is for markers on google maps
                //var latlondata = position.coords.latitude + "," + position.coords.longitude;
                var latlon = "Latitude: " + position.coords.latitude + ", " + "Longitude: " + position.coords.longitude;
                $("#message").html(latlon);
                //$("[id*=hdnLocation]").val(position.coords.longitude + " " + position.coords.latitude);
                $("[id*=hdnLocation]").val(position.coords.latitude + " " + position.coords.longitude);
            }

            function showError(error) {
                if (error.code == 1) {
                    $("#message").html("User denied the request for Geolocation.");
                }
                else if (error.code == 2) {
                    $("#message").html("Location information is unavailable.");
                }
                else if (error.code == 3) {
                    $("#message").html("The request to get user location timed out.");
                }
                else {
                    $("#message").html("An unknown error occurred.");
                }
            }
        </script>
              
        <script type="text/javascript">
            function myfunction() {
                alert('In JavaScript Code after server side code execution');
            }
        </script>

        <script type="text/javascript">
         function showPositionMap() {
             //var latlondata =  position.coords.latitude + "," +position.coords.longitude;
             var latlondata = "45.883397" + "," + "15.716727";
             var latlondata2 = "45.883397, 15.716727";
       // var latlon = "Your Latitude Position is:=" + position.coords.latitude + "," + "Your Longitude Position is:="  +position.coords.longitude;
        

             var link = "https://www.google.com/maps/dir//Autoservis Filipčić, Zagrebačka ulica 64, Laduč/";
             var linkStart = "<a href=\"" + link + "\">";
             var linkEnd ="</a>";
             
                        // (https://)maps.googleapis.com/maps/api/staticmap?zoom=5&size=250x250&sensor=false&maptype=roadmap&markers=color:red|39.926586,116.405640
             var img_url = "http://maps.googleapis.com/maps/api/staticmap?&zoom=10&size=400x300&sensor=false&maptype=roadmap&markers=color:red|" + latlondata;
             //var img_url = "http://maps.googleapis.com/maps/api/staticmap?zoom=12&size=600x400&sensor=false&maptype=roadmap&markers=color:red|" + latlondata2;
             document.getElementById("mapholder").innerHTML = linkStart + "<img src='" + img_url + "' />" + linkEnd;
         }
            </script>

        <%-- www.aspsnippets.com/Articles/ASPNet-Google-Maps-V3-with-Multiple-Markers-Database-Example.aspx --%>

    </form>
</body>
</html>
