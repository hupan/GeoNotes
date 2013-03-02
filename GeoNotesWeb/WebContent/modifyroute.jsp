<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    	               "http://www.w3.org/TR/html4/loose.dtd">
        <script type="text/javascript">
        	var curRouteid;
        	var curRoutename;
        	var curComment;
        	var retrievedPoints = [];
	        var startTime;
	        var routeId;
        	var beachMarker;
        	var map;
        	var gps;
        	var latitude;
        	var longitude;
        	var myLatLng;
        	var inc = 0;
        	var directionsDisplay;
        	var directionsService = new google.maps.DirectionsService();
        	var routestart;
        	var waypoints = [];
        	var waypointsids = [];
        	var startpointid;
        	var endpointid;
        	var routeend;
        	var routedistance;
			var contentString = "";
			var infowindow = new google.maps.InfoWindow({
				content: contentString
			});
			
			function clickLoopOne(allpoints, value){
								
								google.maps.event.clearListeners(value, 'click');
							    google.maps.event.addListener(value, 'click', function(){
							    	allpoints.push(value);
							    	infowindow.setContent(value.get("text"));
							    	infowindow.open(map, value);
							    	
							    	
							    	
									value.setIcon('images/dd-start.png');
									
									if(routestart == null){
										
										routestart = value.getPosition();
										startpointid = value.get("id");
									}
									else if(routeend == null){
										
										
										routeend = value.getPosition();
										if(routeend != routestart){
											endpointid = value.get("id");
											directionsDisplay.setMap(map);
											drawDir(routestart, routeend, waypoints);
								        }
								        else{
								        	routeend = null;
								        }
									}
									else{
										
									    var curpoint = value.get("id");
									    var curposition = value.getPosition();
										var inarray = $.inArray(curpoint,waypointsids);
										
										if(curposition!=routestart && curposition!=routeend && inarray==-1){
											waypoints.push({location: routeend, stopover:true});
											
											waypointsids.push(endpointid);
											routeend = value.getPosition();
											endpointid = value.get("id");
											drawDir(routestart, routeend, waypoints)
								        }
									}
									clickLoopTwo(allpoints, value);
							    })
			}
			
			function clickLoopTwo(allpoints, marker){
										google.maps.event.clearListeners(marker, 'click');
									    google.maps.event.addListener(marker, 'click', function(){
									    	
									    	
									    	
									    	marker.setIcon('images/marker.png');
									    	infowindow.setContent(marker.get("text"));
									    	infowindow.open(map, marker);
									    	setTimeout(function () { infowindow.close(); }, 2000);
									     	for(var i=0; i<allpoints.length;i++){
									     		if(allpoints[i] == marker){
													if(i==0){
														if(waypoints.length>0){
															routestart = waypoints[0].location;
															startpointid = waypointsids[0];
															waypoints.shift();
															waypointsids.shift();
															drawDir(routestart, routeend, waypoints);
														}
														else{
															routestart = routeend;
															startpointid = endpointid;
															routeend = null;
															endpointid = null;
															reloadMap();
															for(var x=0;x<retrievedPoints.length;x++){
																retrievedPoints[x].setMap(map);
															}
															directionsDisplay.setMap(null);
														}
													}
													else if(i==allpoints.length-1){
														
														if(waypoints.length>0){
															
															var tmpindex = waypoints.length-1;
															
															routeend = waypoints[tmpindex].location;
															endpointid = waypointsids[tmpindex];
															
															if(waypoints.lengh==1){
																waypoints.shift();
																waypointsids.shift();
															}
															else{
																waypoints.pop();
																waypointsids.pop();
															}
															
															
															drawDir(routestart, routeend, waypoints);
														}
														else{
															routeend = null;
															endpointid = null;
															reloadMap();
															for(var x=0;x<retrievedPoints.length;x++){
																retrievedPoints[x].setMap(map);
															}
															
															directionsDisplay.setMap(null);
														}
													}
													else{
														waypoints.splice(i-1, 1);
														waypointsids.splice(i-1, 1);
														drawDir(routestart, routeend, waypoints);
													}
													allpoints.splice(allpoints.indexOf(marker), 1);
													break;
										     	}
									     	}
									     	clickLoopOne(allpoints, marker);
									   	})
						    						
			}			
			
			function drawDir(routestart, routeend, waypoints){
				var request = {
					origin: routestart,
					destination: routeend,
					waypoints: waypoints,
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
			
			function reloadMap(){
		        var mapOptions = {
		          center: myLatLng,
		          zoom: 15,
		          mapTypeId: google.maps.MapTypeId.ROADMAP
		        };
		        map = new google.maps.Map(document.getElementById("map_canvas"),
		            mapOptions);
		        directionsDisplay.setMap(map);
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
			  var rendererOptions = {
				  map: map,
				  suppressMarkers : true
			  }
			  directionsDisplay = new google.maps.DirectionsRenderer(rendererOptions);
		      directionsDisplay.setMap(map);
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
		    }
			$(function(){
				location.hash="modify";
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
						if(hash=='modify'){
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
				$('#sharelocation').button();
	        	$('#findway').button();
	        	$('#logout').button();
	        	$('.input').button().css({
	          		'font' : 'inherit',
	         		'color' : 'inherit',
	    			'text-align' : 'center',
	       			'outline' : 'none',
	        		'cursor' : 'text'
	  			});
	  			$('#sharelocation').button().css({
	  			    'font' : 'inherit',
	         		'color' : 'inherit',
	    			'text-align' : 'center',
	       			'outline' : 'none',
	       			'cursor' : 'hand'
	  			})
	  			$('#toptitle').html("Modify a way..."); 			
        		$("#findway").click(function(){
					reloadMap();
					for(var x=0;x<retrievedPoints.length;x++){
						retrievedPoints[x].setMap(map);
					}
        			$.ajax({
        				url:'FindServlet',
        				type:'POST',
        				data:{
        					departure: $("#startplace").val(),
        					destination: $("#endplace").val(),
        					routename: $("#routename").val(),
        					mylatitude: latitude,
        					mylongitude: longitude
        				},
        				success:function(data){
 
							var allpoints = [];

							$.each(retrievedPoints, function (index, value) {
								clickLoopOne(allpoints, value);
							})
        					
						    $.each(data, function (index, value) {
						    		if(index == 0){
						    			curRoutename = value[4];
						    			curComment = value[5];
						    			curRouteid = value[7]
						    		}
						    		var marker;
							    	var curLatitude = value[2];
							    	var curLongitude = value[3];
							    	var location = new google.maps.LatLng(curLatitude, curLongitude);
							    	var j = 0;
	
							    	for(j=0;j<retrievedPoints.length;j++){
							    		if(curLatitude == retrievedPoints[j].get("lat") && curLongitude == retrievedPoints[j].get("lon")){
	
							    			marker = retrievedPoints[j];
											marker.setIcon('images/dd-start.png');
											clickLoopTwo(allpoints,marker);
											break;
							    		}
							    	}
	
									if(index == 0){
										routestart = new google.maps.LatLng(curLatitude, curLongitude);
										startpointid = marker.get("id");
									}
								   	else if(index != data.length-1){
								   		waypoints.push({location: location, stopover: true});
								   		waypointsids.push(marker.get("id"));
								   	}					        
								   	else if(index == data.length-1){
								   		routeend = location;
								   		endpointid = marker.get("id");
								   	}
								   	allpoints.push(marker);

						    });
							drawDir(routestart, routeend, waypoints);
       						$.ajax({
				        		url:'saveroute.jsp',
				        		type:'POST',
				        		success:function(data){
				        			$('#panel').html(data);
				        			$('#routename').val(curRoutename);
				        			$('#comment').val(curComment);
				        		}
				        	})
        				}
        			});
        		});
        		
        		$('#logout').click(function(){
        			window.location.reload();
        		})
        		
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
						        
						        var location = new google.maps.LatLng(value[1], value[2]);					        
	        					var marker = new google.maps.Marker({
							    	position: location,
							        map: map,
							        icon: 'images/marker.png',
							        id: value[3],
							        title: value[4],
							        text: 'Name: ' + value[4] + '</br>Description: '+value[5],
							        lat: value[1],
							        lon: value[2]
							    });	
							    
							    retrievedPoints.push(marker);		        
						    });
        				}
        			});
        			startgps();
				})
        	})
  		</script>
        <div id="map_canvas" style="margin:0 auto;padding:0" ></div>
        <div id="panel">
	  		<table id="centraltable" style="width:100%" align = 'center'>
	  			<tr>
	  				<td colspan=2>
		       			<input style="-webkit-box-sizing: border-box;-moz-box-sizing: border-box;box-sizing: border-box;width:100%" class="input" id="routename" type="text" value="Route name(optional)"/>
		       		</td>
		       	</tr>
	  			<tr>
	  				<td colspan=2>
		       			<input style="-webkit-box-sizing: border-box;-moz-box-sizing: border-box;box-sizing: border-box;width:100%" class="input" id="startplace" type="text" value="Departure(optional)"/>
		       		</td>
		       	</tr>
		       	<tr>
		       		<td colspan=2>
		        		<input style="-webkit-box-sizing: border-box;-moz-box-sizing: border-box;box-sizing: border-box;width:100%" class="input" id="endplace" type="text" value="Destination"/>
		        	</td>
		        </tr>
		        <tr>
		        	<td colspan=2>
			        	<button style="width:100%" id="findway">
			        		<span style = "font-size:16pt">Check</span>
			       		</button>
			       	</td>
			    </tr>
		        <tr>
		        	<td colspan=2>
			        	<button style="width:100%" id="logout">
			        		<span style = "font-size:16pt">Log out</span>
			       		</button>
			       	</td>
			    </tr>
		    </table>
	    </div>
