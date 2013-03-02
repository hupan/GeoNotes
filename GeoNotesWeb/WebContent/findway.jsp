<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    	               "http://www.w3.org/TR/html4/loose.dtd">
<%
	String username = request.getParameter("username");
%>
        <script type="text/javascript">
        
	        // Define a property to hold the Home state
	        HomeControl.prototype.waypoints_ = [];
	        HomeControl.prototype.curhomeindex_ = 0;
	
	        // Define setters and getters for this property
	        HomeControl.prototype.getWaypoints = function() {
	          return this.waypoints_;
	        }
	
	        HomeControl.prototype.setWaypoints = function(waypoints) {
	          this.waypoints_ = waypoints;
	        }
	        
	        HomeControl.prototype.getCurhomeindex = function(){
	          return this.curhomeindex_;
	        }
	        
	        HomeControl.prototype.setCurhomeindex = function(curhomeindex){
	          this.curhomeindex_ = curhomeindex;
	        }
	
	        function HomeControl(controlDiv, map, waypoints) {
	
	          // We set up a variable for this since we're adding
	          // event listeners later.
	          var control = this;
	
	          // Set the home property upon construction
	          control.waypoints_ = waypoints;
	
	          // Set CSS styles for the DIV containing the control
	          // Setting padding to 5 px will offset the control
	          // from the edge of the map
	          controlDiv.style.padding = '5px';
	
	          // Set CSS for the control border
	          var nextStopUI = document.createElement('div');
	          nextStopUI.style.backgroundColor = 'white';
	          nextStopUI.style.borderStyle = 'solid';
	          nextStopUI.style.borderWidth = '2px';
	          nextStopUI.style.cursor = 'pointer';
	          nextStopUI.style.textAlign = 'center';
	          nextStopUI.title = 'Click to set home to the next stop';
	          controlDiv.appendChild(nextStopUI);
	
	          // Set CSS for the control interior
	          var nextStopText = document.createElement('div');
	          nextStopText.style.fontFamily = 'Arial,sans-serif';
	          nextStopText.style.fontSize = '12px';
	          nextStopText.style.paddingLeft = '4px';
	          nextStopText.style.paddingRight = '4px';
	          nextStopText.innerHTML = '<b>Next stop</b>';
	          nextStopUI.appendChild(nextStopText);
	
	          // Set CSS for the lastStop control border
	          var lastStopUI = document.createElement('div');
	          lastStopUI.style.backgroundColor = 'white';
	          lastStopUI.style.borderStyle = 'solid';
	          lastStopUI.style.borderWidth = '2px';
	          lastStopUI.style.cursor = 'pointer';
	          lastStopUI.style.textAlign = 'center';
	          lastStopUI.title = 'Click to set home to the last stop';
	          controlDiv.appendChild(lastStopUI);
	
	          // Set CSS for the control interior
	          var lastHomeText = document.createElement('div');
	          lastHomeText.style.fontFamily = 'Arial,sans-serif';
	          lastHomeText.style.fontSize = '12px';
	          lastHomeText.style.paddingLeft = '4px';
	          lastHomeText.style.paddingRight = '4px';
	          lastHomeText.innerHTML = '<b>Last stop</b>';
	          lastStopUI.appendChild(lastHomeText);
	          
	          // Set CSS for the control border
	          var finishUI = document.createElement('div');
	          finishUI.style.backgroundColor = 'white';
	          finishUI.style.borderStyle = 'solid';
	          finishUI.style.borderWidth = '2px';
	          finishUI.style.cursor = 'pointer';
	          finishUI.style.textAlign = 'center';
	          finishUI.title = 'Click to finish the guide';
	          controlDiv.appendChild(finishUI);
	
	          // Set CSS for the control interior
	          var finishText = document.createElement('div');
	          finishText.style.fontFamily = 'Arial,sans-serif';
	          finishText.style.fontSize = '12px';
	          finishText.style.paddingLeft = '4px';
	          finishText.style.paddingRight = '4px';
	          finishText.innerHTML = '<b>Finish</b>';
	          finishUI.appendChild(finishText);
	
	          google.maps.event.addDomListener(nextStopUI, 'click', function() {
	          	
	            var wpts = control.getWaypoints();
	            var curIndex = control.getCurhomeindex();
	            var nextStopLoc;
	            if(curIndex+1<wpts.length){
	            	
	            	curIndex = curIndex + 1;
	            	var marker = wpts[curIndex];
					marker.setIcon('images/dd-start.png');
	                control.setCurhomeindex(curIndex);
	            	nextStopLoc = wpts[curIndex];
	            	map.setCenter(nextStopLoc.getPosition());
	            }
	            else{
	            	alert("foo");
	            }
	          });
	
	          google.maps.event.addDomListener(lastStopUI, 'click', function() {
	            var wpts = control.getWaypoints();
	            var curIndex = control.getCurhomeindex();
	            var lastStoploc;
	            if(curIndex-1>-1){
	            	if(curIndex>0){
	            		var marker = wpts[curIndex];
						marker.setIcon('images/marker.png');
					}
					curIndex = curIndex - 1;
	                control.setCurhomeindex(curIndex);
	            	lastStoploc = wpts[curIndex];
	            	if(curIndex > 0){
	            		map.setCenter(lastStoploc.getPosition());
	            	}
	            	else{
	            		map.setCenter(lastStoploc);
	            	}
	            }
	            else{
	            	alert("foo");
	            }
	          });
	          
	          google.maps.event.addDomListener(finishUI, 'click', function() {
	          	  reloadMap();
				  directionsDisplay.setMap(null);
				  var endTime = new Date();
				  var timeSpent = endTime - startTime;
        		  $.ajax({
        		      url:'AddStatServlet',
        			  type:'POST',
        			  data:{
						  username: '<%=username%>',
						  routeid: routeId,
						  timespent: timeSpent
        			  },
        			  success:function(data){
        			  	  alert("Success");
        			  }
        		  });
	          });
	          
	        }
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
        	var routeend;
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
				location.hash="findway";
				history.pushState( null, null, this.href);
				$(window).unbind("popstate");
				
				var hisLoc = history.location;
				//If IE......
				if(hisLoc!=null && hisLoc.hash.indexOf("#") == -1){
					$( window ).bind( "popstate", function( e ) {
		        		var returnLocation = document.location;
		        		
		        		var hash = escape(returnLocation.hash.replace( /^#/, ''));
						if(hash=='user'){
		        			$.ajax({
		        				url:'userboard.jsp',
		        				type:'POST',
		        				data:{
		        					username: '<%=username%>'
		        				},
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
						if(hash=='findway'){
		        			$.ajax({
		        				url:'userboard.jsp',
		        				type:'POST',
		        				data:{
		        					username: '<%=username%>'
		        				},
		        				success:function(data){
			        				$('#centraldiv').html(data);
		        				}
		        			});
						}
		       		})
				}				
			})
        	$(function(){
        		$("#sharelocation").click(function(){
        			$.ajax({
        				url:'ShareLocationServlet',
        				type:'POST',
        				data:{
        					number: $("#number").val(),
							latitude: latitude,
							longitude: longitude
        				},
        				success:function(data){
        					alert("success");
        				}
        			});
        		});
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
	  			$('#toptitle').html("Find a way..."); 			
        		$("#findway").click(function(){
					reloadMap();
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
        					routestart = new google.maps.LatLng(latitude, longitude);
        					allpoints.push(routestart);
						    $.each(data, function (index, value) {
						        var location = new google.maps.LatLng(value[2], value[3]);
	        					var marker = new google.maps.Marker({
							    	position: location,
							        map: map,
							        text: 'Place: ' + value[0] + '</br>Description: ' + value[1] + '</br>Route: ' + value[4] + '</br>Comment: ' + value[5] + '</br>Total Distance: ' + value[6] 
							    });
							    google.maps.event.addListener(marker, 'click', function(){
							    	infowindow.setContent(marker.get("text"));
							    	infowindow.open(map, marker);
							   	})
							   	if(index != data.length-1){
							   		waypoints.push({location: location, stopover: true});
							   	}					        
							   	else{
							   		routeId = value[7];
							   		routeend = location;
							   	}
							   	allpoints.push(marker);
						    });
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
								}
							});

					        var homeControlDiv = document.createElement('div');
					        var homeControl = new HomeControl(homeControlDiv, map, allpoints);
					
					        homeControlDiv.index = 1;
					        map.controls[google.maps.ControlPosition.TOP_RIGHT].push(homeControlDiv);
					        startTime = new Date();
        				}
        			});
        		});
        		
        		$('#logout').click(function(){
        			window.location.reload();
        		})
        		
        		$(document).ready(function(){
					$('#map_canvas').width($('body').width());
					$('#map_canvas').height($('#centraltable').height()*1.2);
					$('#panel').width($('body').width());
					startgps();
				})
        	})
  		</script>
        <div id="map_canvas" style="margin:0 auto;padding:0" ></div>
        <div id="panel">
	  		<table id="centraltable" style="width:100%" align = 'center'>
				<tr>
	  				<td>
		       			<input style="-webkit-box-sizing: border-box;-moz-box-sizing: border-box;box-sizing: border-box;width:100%" class="input" id="number" type="text" value="Phone number"/>
		       		</td>
	  				<td>
		       			<input style="-webkit-box-sizing: border-box;-moz-box-sizing: border-box;box-sizing: border-box;width:100%" id="sharelocation" type="submit" value="Share location"/>
		       		</td>
			    </tr>
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
