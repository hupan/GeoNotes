<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    	               "http://www.w3.org/TR/html4/loose.dtd">
        <script type="text/javascript">
        	$(function(){
	        	$('#saveroute').button();
	        	$('#logout').button();
	        	$('#routename').button().css({
	          		'font' : 'inherit',
	         		'color' : 'inherit',
	    			'text-align' : 'center',
	       			'outline' : 'none',
	        		'cursor' : 'text'
	  			});
	  			$('#toptitle').html("Save a route...");
				
        		$("#saveroute").click(function(){
        			var x = JSON.stringify(waypointsids);
        			$.ajax({
        				url:'SaveRouteServlet',
        				type:'POST',
        				data:{
        					currouteid: curRouteid,
        					startpointid: startpointid,
        					endpointid: endpointid,
        					waypointsids: x,
        					routedistance: routedistance,
        					routename: $("#routename").val(),
        					comment: $("#comment").val()
        				},
        				success:function(data){
							alert("Success");
				        	$.ajax({
				        		url:'modifyroute.jsp',
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

        	})
	
			
  		</script>
		

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
			        	<button style="width:100%" id="saveroute">
			        		<span style = "font-size:16pt">Save</span>
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
