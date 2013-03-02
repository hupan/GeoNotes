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
        	var contentString = "";
			var infowindow = new google.maps.InfoWindow({
				content: contentString
			});
			
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
					alert("Position is null");
			}
			
       		function startgps()
	      	{
       			

	       		if ("geolocation" in navigator)
	        	{
	       			
	       			navigator.geolocation.getCurrentPosition(showgps);
	          	}
	           	else
	            {
	            	alert("error");
	        	}
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

		    }
		    
			$(function(){
				location.hash="upload";
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
						if(hash=='upload'){
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
	        	$('#upload').button();
	        	$('#logout').button();
	        	$('#placename').button().css({
	          		'font' : 'inherit',
	         		'color' : 'inherit',
	    			'text-align' : 'center',
	       			'outline' : 'none',
	        		'cursor' : 'text'
	  			});
	  			$('#toptitle').html("Add a note...");
	  			
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

        		$("#upload").click(function(){
        			$.ajax({
        				url:'UploadLocationServlet',
        				type:'POST',
        				data:{
        					latitude: latitude,
        					longitude: longitude,
        					placename: $("#placename").val(),
        					description: $("#description").val()
        				},
        				success:function(data){
        					myLatLng = new google.maps.LatLng(latitude, longitude);
        					var marker = new google.maps.Marker({
						    	position: myLatLng,
						        map: map
						    });
        					
        					alert("Note added successfully.");
        				    $("#placename").val("Name");
        				    $("#description").val("Description");
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
					startgps();
					setTimeout(function(){
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
								        text: 'Name: ' + value[4] + '</br>Description: ' + value[5]
								    });
								    google.maps.event.addListener(marker, 'click', function(){
								    	infowindow.setContent(marker.get("text"));
								    	infowindow.open(map, marker);
								   	})					        
							    });
	        				}
	        			});
						
					}, 500);

					

				});
        	})
	
			
  		</script>
		
        <div id="map_canvas" style="margin:0 auto;padding:0" ></div>
        <div id="panel">
	  		<table id="centraltable" style="width:100%" align = 'center'>
	  			<tr>
	  				<td>
		       			<input class="input" id="placename" style="-webkit-box-sizing: border-box;-moz-box-sizing: border-box;box-sizing: border-box;width:100%" type="text" value="Name"/>
		       		</td>
		       	</tr>
		       	<tr>
		       		<td>
		        		<textarea class="input" id="description" style="text-align:center;-webkit-box-sizing: border-box;-moz-box-sizing: border-box;box-sizing: border-box;width:100%" rows="4">Description</textarea>
		        	</td>
		        </tr>
		        <tr>
		        	<td>
			        	<button style="width:100%" id="upload">
			        		<span style = "font-size:16pt">Add</span>
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
