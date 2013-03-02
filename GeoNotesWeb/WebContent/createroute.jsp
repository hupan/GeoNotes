<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    	               "http://www.w3.org/TR/html4/loose.dtd">
        <script type="text/javascript">
        	var beachMarker;
        	var map;
        	var gps;
        	var latitude;
        	var longitude;
        	var myLatLng;
        	var inc = 0;
        	var datacopy = [];
        	var directionsDisplay;
        	var directionsService = new google.maps.DirectionsService();
        	var tempstart;
        	var tempend;
        	var waypts = [];
			var startpointid;
			var waypointsids = [];
			var endpointid;
			var routedistance;
			var contentString = "";
			var infowindow = new google.maps.InfoWindow({
				content: contentString
			});
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
		      
		      beachMarker = new google.maps.Marker({
		          position: myLatLng,
		          map: map,
		          icon: lineSymbol
		      });
		      
			  var rendererOptions = {
				  map: map,
				  suppressMarkers : true
			  }
			  directionsDisplay = new google.maps.DirectionsRenderer(rendererOptions);

		    }
			$(function(){
				location.hash="createroute";
				history.pushState( null, null, this.href);
				$(window).unbind("popstate");
				
				var hisLoc = history.location;
				//If IE......
				if(hisLoc!=null && hisLoc.hash.indexOf("#") == -1){
					$( window ).bind( "popstate", function( e ) {
		        		var returnLocation = document.location;
		        		
		        		var hash = escape(returnLocation.hash.replace( /^#/, ''));
						if(hash=='admin'){
		        			$.ajax({
		        				url:'adminboard.jsp',
		        				type:'POST',
		        				success:function(data){
			        				$('#centraldiv').html(data);
		        				}
		        			});
						}
		       		})
				}
				else {
					$( window ).bind( "popstate", function( e ) {
		        		var returnLocation = document.location;
		        		
		        		var hash = escape(returnLocation.hash.replace( /^#/, ''));
						if(hash=='createroute'){
		        			$.ajax({
		        				url:'adminboard.jsp',
		        				type:'POST',
		        				success:function(data){
			        				$('#centraldiv').html(data);
		        				}
		        			});
						}
		       		})
				}				
			})
        	$(function(){
	        	$('#createroute').button();
	        	$('#logout').button();
	        	$('#routename').button().css({
	          		'font' : 'inherit',
	         		'color' : 'inherit',
	    			'text-align' : 'center',
	       			'outline' : 'none',
	        		'cursor' : 'text'
	  			});
	  			$('#toptitle').html("Create a route...");
	  			
				var txt=[];  
				var textbox=$('.input');  
				textbox.each(function(){  
					txt.push($(this).val());  
				});  
				textbox.focus(function(){  
					$(this).val("");  
				});  
				textbox.blur(function(){  
					if($(this).val()== ""){  
						var recover=txt[textbox.index($(this))];  
						$(this).val(recover);  
					}
				});  
				
        		$("#createroute").click(function(){
        			var x = JSON.stringify(waypointsids);
        			$.ajax({
        				url:'CreateRouteServlet',
        				type:'POST',
        				data:{
        					startpointid: startpointid,
        					endpointid: endpointid,
        					waypointsids: x,
        					routedistance: routedistance,
        					routename: $("#routename").val(),
        					comment: $("#comment").val()
        				},
        				success:function(data){
        					alert("Route is created.");
        		        	$.ajax({
        		        		url:'createroute.jsp',
        		        		type:'POST',
        		        		success:function(data){
        		        			$('#centraldiv').html(data);
        		        		}
        		        	})
        				}
        			});
        		});
        		
        		$('#logout').click(function(){
        			window.location.reload();
        		});

				$(document).ready(function(){
					$('#map_canvas').width($('body').width());
					$('#map_canvas').height($('#centraltable').height()*1.5);
					$('#panel').width($('body').width());
        			$.ajax({
        				url:'RetrieveServlet',
        				type:'POST',
        				data:{
        				},
        				success:function(data){
						    $.each(data, function (index, value) {
						        datacopy.push(value);
						        var location = new google.maps.LatLng(value[1], value[2]);					        
	        					var marker = new google.maps.Marker({
							    	position: location,
							        map: map,
							        icon: 'images/marker.png',
							        id: value[3],
							        title: value[4],
							        text: 'Name: ' + value[4] + '</br>Description: '+value[5]
							    });
							    var currentIcon = marker.getIcon();
							    google.maps.event.addListener(marker, 'click', function(){
							    	infowindow.setContent(marker.get("text"));
							    	infowindow.open(map, marker);
							    	if(marker.getIcon() == currentIcon){
										marker.setIcon('images/dd-start.png');
									}
									if(tempstart == null){
										tempstart = marker.getPosition();
										startpointid = marker.get("id");
									}
									else if(tempend == null){
										tempend = marker.getPosition();
										if(tempend != tempstart){
											endpointid = marker.get("id");
									        var request = {
									            origin: tempstart,
									            destination: tempend,
									            travelMode: google.maps.TravelMode.WALKING
									        };
									        directionsService.route(request, function(response, status) {
									          if (status == google.maps.DirectionsStatus.OK) {
									            directionsDisplay.setDirections(response);
									            var route = response.routes[0];
									            routedistance = 0;
									            for(var i=0; i<route.legs.length; i++){
									            	routedistance = routedistance + route.legs[i].distance.value;
									            }
									          }
									        });
								        }
								        else{
								        	tempend = null;
								        }
									}
									else{
									    var curpoint = marker.get("id");
									    var curposition = marker.getPosition();
										var inarray = $.inArray(curpoint,waypointsids);
										if(curposition!=tempstart && curposition!=tempend && inarray==-1){
											waypts.push({location: tempend, stopover:true});
											waypointsids.push(endpointid);
											tempend = marker.getPosition();
											endpointid = marker.get("id");
									        var request = {
									            origin: tempstart,
									            destination: tempend,
									            waypoints: waypts,
									            optimizeWaypoints: true,
									            travelMode: google.maps.TravelMode.WALKING
									        };
									        directionsService.route(request, function(response, status) {
									          if (status == google.maps.DirectionsStatus.OK) {
									            directionsDisplay.setDirections(response);
									            var route = response.routes[0];
									            routedistance = 0;
									            for(var i=0; i<route.legs.length; i++){
									            	routedistance = routedistance + route.legs[i].distance.value;
									            }							            
									          }
									        });
								        }
									}
							    })						        
						    });
        				}
        			});
					startgps();

				});
        	})
	
			
  		</script>
		
        <div id="map_canvas" style="margin:0 auto;padding:0" ></div>
        <div id="panel">
	  		<table id="centraltable" style="width:100%" align = 'center'>
	  			<tr>
	  				<td>
		       			<input class="input" id="routename" style="-webkit-box-sizing: border-box;-moz-box-sizing: border-box;box-sizing: border-box;width:100%" type="text" value="Name"/>
		       		</td>
		       	</tr>
		       	<tr>
		       		<td>
		        		<textarea class="input" id="comment" style="text-align:center;-webkit-box-sizing: border-box;-moz-box-sizing: border-box;box-sizing: border-box;width:100%" rows="4">Comment</textarea>
		        	</td>
		        </tr>
		        <tr>
		        	<td>
			        	<button style="width:100%" id="createroute">
			        		<span style = "font-size:16pt">Create</span>
			       		</button>
			       	</td>
			    </tr>
		        <tr>
		        	<td>
			        	<button style="width:100%" id="logout">
			        		<span style = "font-size:16pt">Log out</span>
			       		</button>
			       	</td>
			    </tr>
		    </table>
	    </div>
