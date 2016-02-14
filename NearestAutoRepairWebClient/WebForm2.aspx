<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="WebForm2.aspx.cs" Inherits="NearestAutoRepairWebClient.WebForm2" %>
   
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server"> 
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    
    <div>         
        <div style="display:flex; justify-content: center">
        <asp:Button ID="Button1" runat="server" Text="Get Five Nearest Auto Repairs" OnClick="Button1_Click"/>       
        <asp:Button ID="Button2" runat="server" Text="Get All Auto Repairs" OnClick="Button2_Click"/>
        <asp:Button ID="btnGetNearestRepair" runat="server" Text="Get Nearest Repair" OnClick="btnGetNearestRepair_Click"/>
        </div>

        <asp:Label ID="message" runat="server" ClientIDMode="Static" style="display:flex; justify-content: center"></asp:Label>

        <div style="border-top:10px">
        <asp:GridView ID="gridViewAutoShops" runat="server" AutoGenerateColumns="false" HorizontalAlign="Center">
          <Columns>
              <asp:BoundField DataField="Name" HeaderText="Name" />   
              <asp:BoundField DataField="Address" HeaderText="Address" />
              <asp:BoundField DataField="City" HeaderText="City" />
              <asp:BoundField DataField="Phone" HeaderText="Phone" />           
             <asp:HyperLinkField
                     DataTextField="Url"
                     HeaderText="Website"
                     DataNavigateUrlFormatString="{0}"
                     DataNavigateUrlFields="Url"
                     Target="_blank" >                    
                </asp:HyperLinkField>                      
            </Columns>
          </asp:GridView>
        </div>

                                 <!-- display:none => hides map on page_load -->
        <div id="map_canvas" style="display:none; height:auto; width:auto;width: 700px; height: 500px; border: 1px solid #CCC; margin:auto; margin-top:10px"></div>
      
        <asp:HiddenField ID="hfServerValue" runat="server" ClientIDMode="Static" />
        <asp:HiddenField ID="hdnLocation" runat="server" ClientIDMode="Static" />
          
    </div>   
     
           
        <script type = "text/javascript">            
            // retrieves and displays value from HiddenField
            function ShowHiddenValue() {
                var sValue = document.getElementById('hfServerValue').value;
                alert(sValue);
                var lblCall = document.getElementById('lblCall');
                lblCall.innerHTML = sValue;
            }
        </script>         
        
     <script type="text/javascript" src="http://maps.google.com/maps/api/js?sensor=false"></script>
    
     <script type="text/javascript">         
         // use "window.onload =" to execute function on page_load
         //window.onload = 
         function initialize() {
             var markers2 = document.getElementById('hfServerValue').value;
             // forums.asp.net/t/2051728.aspx?How+to+deserialize+JSON+string+in+Javascript+
             var obj = JSON.parse(markers2);                     
                 
             // shows map
             $('#map_canvas').show();
                                   
             // use for user location marker
             var userLocation = document.getElementById('hdnLocation').value;
             var userLoc = userLocation.split(" ");
             // replace coma(,) with dot (.)
             var userlat = userLoc[0].replace(",", ".");
             var userlon = userLoc[1].replace(",", ".");             

             var mapOptions = {                              
                 center: new google.maps.LatLng(45.8555, 15.885),
                 // if you want to center map to current user location use next line
                 //center: new google.maps.LatLng(userlat, userlon),
                zoom: 11,
                mapTypeId: google.maps.MapTypeId.ROADMAP
                //marker:true
        };
        var infoWindow = new google.maps.InfoWindow();
        var map = new google.maps.Map(document.getElementById("map_canvas"), mapOptions);             
        var x
        for(x in obj)
             {                 
            var data = obj[x];
            // split location into two elements - doesn't work with only one parameter(location)
            var loc2 = data.Geolocation.split(" ");
           // replace coma(,) with dot (.)
            var lon1 = loc2[0].replace(",", ".");
            var lat1 = loc2[1].replace(",", ".");
            
            // NOT GOOD - no comma (,) allowed
            //var lat1 = "45,16516115";
            //var lon1 = "15,68468464";
            // GOOD
            //var lat1 = "45.16";
            //var lon1 = "15.68";
            //var lat1 = 45.16;
            //var lon1 = 15.68;         

            var myLatlng = new google.maps.LatLng(lat1, lon1);            
            var marker = new google.maps.Marker({
                position: myLatlng,
                map: map,
                title: data.Name
            });    
            (function(marker, data) {
                // Attaching a click event to the current marker
                google.maps.event.addListener(marker, "click", function(e) {
                    infoWindow.setContent(data.Name + "<br/>" + data.City + "<br/>" + data.Address + "<br/>" + data.Phone);
                    infoWindow.open(map, marker);
                });
            })(marker, data);            
        }          
             
       //////////////////////////////////////////
             // New marker for user Position/Location
             // Special thanks and Credits for icons used in maps to Maps Icons Collection https://mapicons.mapsmarker.com
        var imageUserPosition = 'Content/Images/person-2.png';
       
         // set user position
        var userPosition = new google.maps.LatLng(userlat, userlon);
        var userPositionMarker = new google.maps.Marker({
            position: userPosition,
            icon: imageUserPosition,
            animation: google.maps.Animation.BOUNCE
        });

        var infowindow2 = new google.maps.InfoWindow({
            content: "Your position!"
        });

        infowindow2.open(map, userPositionMarker);
        userPositionMarker.setMap(map);

             // add listener for userPositionMarker marker
             (function (userPositionMarker) {
            // Attaching a click event to the current marker
                 google.maps.event.addListener(userPositionMarker, "click", function (e) {
                infoWindow.setContent("Your position!");
                infoWindow.open(map, userPositionMarker);
            });
             })(userPositionMarker)             
       ///////////////////
    }
 </script>

        <!-- Gets user location (asks for permission) -->
        <script type="text/javascript">
            //function getPosition() {
            if (navigator.geolocation) {
                navigator.geolocation.getCurrentPosition(showPosition, showError, { maximumAge: 0 });
            }
            else { $("#message").html("Geolocation is not supported by this browser."); }
            //}            

            function showPosition(position) {                               
                var latlon = "Your position: Latitude: " + position.coords.latitude + ", " + "Longitude: " + position.coords.longitude;                            
                $("#message").html(latlon);
                //$("[id*=hdnLocation]").val(position.coords.longitude + " " + position.coords.latitude);
                // save user location in hdnLocation
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
      <!-- -->
        
</asp:Content>