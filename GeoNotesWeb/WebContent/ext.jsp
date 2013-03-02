<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    	               "http://www.w3.org/TR/html4/loose.dtd">
<%
	String latitude = request.getParameter("latitude");
	String longitude = request.getParameter("longitude");
%>
<html>
    <head>
        <meta name="viewport" content="width = device-width; initial-scale=1">
        <title>GeoNotes</title>
        <link rel="stylesheet" href="css/jquery.mobile-1.2.0.css" />
        <link rel="stylesheet" href="css/jquery-ui-1.10.0.custom.min.css" />
        <link rel="stylesheet" href="css/default.css" />
        <script src="js/jquery-1.9.0.min.js"></script>
        <script src="js/jquery-ui-1.10.0.custom.min.js"></script>
        <script src="js/jquery.mobile-1.2.0.min.js"></script>
        <script type="text/javascript" 
        	src="http://maps.googleapis.com/maps/api/js?key=AIzaSyBS2ajTg0q3hMrYkp6YDmunPrFZw6skUlU&sensor=false">
        </script>
        <script type="text/javascript">
        	var senderLatitude = '<%=latitude%>';
        	var senderLongitude = '<%=longitude%>';
        	var directionsDisplay;
        	var directionsService = new google.maps.DirectionsService();
        	var map;
        	var gps;
        	var latitude;
        	var longitude;
        	var myLatLng;
        	var senderLatLng;
        	var inc = 0;
       		function startgps()
	      	{
	        	gps = navigator.geolocation;
	       		if (gps)
	        	{
	            gps.getCurrentPosition(showgps,
	            	function(error){
	                	alert("Got an error, code: " + error.code + " message: "+ error.message);
	            	},
					{maximumAge: 10000});
	          	}
	           	else
	            {
	            	showgps();
	        	}
			}   
	      	function showgps(position)
			{
	            if (position)
	            {
	                latitude = position.coords.latitude;
	               	longitude = position.coords.longitude;
	               	if(inc == 0){
	               		initialize();
	               		inc++;
	               	}
					keeprefresh();
	            }
	        	else
					alert("position is null");
			}
			
			function keeprefresh(){
				setTimeout(function(){
					startgps();
					myLatLng = new google.maps.LatLng(latitude, longitude);
					beachMarker.setPosition(myLatLng);
				},"2000");
			}
			
			function initialize() {
			  myLatLng = new google.maps.LatLng(latitude, longitude);
			  senderLatLng = new google.maps.LatLng(senderLatitude, senderLongitude);

		      var mapOptions = {
		        center: myLatLng,
		        zoom: 15,
		        mapTypeId: google.maps.MapTypeId.ROADMAP
		      };
		      
		      map = new google.maps.Map(document.getElementById("map_canvas"),
		          mapOptions);
		      
	          var lineSymbol = {
	            path: google.maps.SymbolPath.CIRCLE,
	            scale: 4,
	            strokeColor: '#393',
	            fillOpacity: 1
	          };
		      
		      var beachMarker = new google.maps.Marker({
		          position: myLatLng,
		          map: map,
		          icon: lineSymbol
		      });	
		      
		      var senderMarker = new google.maps.Marker({
		      	  position: senderLatLng,
		      	  map: map
		      });	      
		      
			  var rendererOptions = {
				  map: map,
				  suppressMarkers : true,
				  icon: 'images/marker.png'
			  }
			  directionsDisplay = new google.maps.DirectionsRenderer(rendererOptions);
			  
			  var request = {
				  origin: myLatLng,
				  destination: senderLatLng,
				  travelMode: google.maps.TravelMode.WALKING
			  };
			  
			  
			  directionsService.route(request, function(response, status) {
				  if (status == google.maps.DirectionsStatus.OK) {
					  directionsDisplay.setDirections(response);
				  }
			  });
		    }
		    
			
        	$(function(){
				$(document).ready(function(){
					$('#map_canvas').width($('body').width());
					$('#map_canvas').height($('body').height()*0.8);
					startgps();
				});
        	})
	
		</script>
    </head>
    <body style="margin:0 auto;padding:0;">
       	<div class="ui-bar-a ui-header">
        	<h1 id="toptitle" class="ui-title">The way...</h1>
        </div>

        <div style="margin:0 auto; padding:0;" id="centraldiv" class="ui-content">
			<div id="map_canvas" style="margin:0 auto;padding:0" ></div>
        </div>
        <div class="ui-bar-a ui-footer">
			<h1 class="ui-title">Designed by Pan HU</h1>
		</div>
    </body>
</html>
