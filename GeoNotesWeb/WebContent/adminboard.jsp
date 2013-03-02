<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    	               "http://www.w3.org/TR/html4/loose.dtd">

	<script type="text/javascript">
		$(function(){
			location.hash="admin";
			history.pushState( null, null, this.href);
			$(window).unbind("popstate");
			var hisLoc = history.location;
			//If IE.......
			if(hisLoc!=null && hisLoc.hash.indexOf("#") == -1){
				$( window ).bind( "popstate", function( e ) {
	        		var returnLocation = document.location;
		        	var hash = escape(returnLocation.hash.replace( /^#/, ''));
					if(hash==''){
						window.location.href="http://www.pandahoo.com/GeoNotesWeb/";
					}
				})
			}
			else {
				$( window ).bind( "popstate", function( e ) {
	        		var returnLocation = document.location;
		        	var hash = escape(returnLocation.hash.replace( /^#/, ''));
					if(hash=='admin'){
						window.location.href="http://www.pandahoo.com/GeoNotesWeb/";
					}
				})
			}
			
		})
		function msToTime(s) {
		  var ms = s % 1000;
		  s = (s - ms) / 1000;
		  var secs = s % 60;
		  s = (s - secs) / 60;
		  var mins = s % 60;
		  var hrs = (s - mins) / 60;
		
		  return hrs + ':' + mins + ':' + secs;
		}
		$('#toptitle').html("Admin board...");
		$('#addnote').button();
		$('#create').button();
		$('#modify').button();
		$('#stat').button();
		$("#addnote").click(function(){
        	$.ajax({
        		url:'upload.jsp',
        		type:'POST',
        		success:function(data){
        			$('#centraldiv').html(data);
        		}
       		});
        });

        $("#create").click(function(){
        	$.ajax({
        		url:'createroute.jsp',
        		type:'POST',
        		success:function(data){
        			$('#centraldiv').html(data);
        		}
        	})
        })
        
        $("#modify").click(function(){
        	$.ajax({
        		url:'modifyroute.jsp',
        		type:'POST',
        		success:function(data){
        			$('#centraldiv').html(data);
        		}
        	})
        })
        
        $("#stat").click(function(){
			$(function(){
				location.hash="stat";
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
						if(hash=='stat'){
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
        	$.ajax({
        		url:'RetrieveStatsServlet',
        		type: 'POST',
        		success:function(data){
				    var tbl_body = "";
				    var tbl_row = "";
				    tbl_row = "<th>" + "Date" + "</th>" + "<th>" + "User" + "</th>" + "<th>" + "Route" + "</th>" + "<th>" + "Distance" + "</th>" + "<th>" + "Time" +"</th>";
				    tbl_body += "<thead><tr>"+tbl_row+"</tr></thead><tbody>";    
				    $.each(data, function() {
				        tbl_row = "";
				        $.each(this, function(k , v) {
				        	if(k==0){
				        		tbl_row += "<td>"+v.day+"-"+(v.month+1)+"-"+v.year+"</td>";
				        	}
							else if(k==3){
								tbl_row += "<td>"+v+"m</td>";
							}
							else if(k==4){
								tbl_row += "<td>"+msToTime(v)+"</td>";
							}
				        	else{
				           		tbl_row += "<td>"+v+"</td>";
				           	}
				        })
				        tbl_body += "<tr>"+tbl_row+"</tr>";                 
				    })
				    tbl_body += "</tbody>"
				    tbl_row = "<th>" + "Date" + "</th>" + "<th>" + "User" + "</th>" + "<th>" + "Route" + "</th>" + "<th>" + "Distance" + "</th>" + "<th>" + "Time" +"</th>";
				    tbl_body += "<tfoot><tr>"+tbl_row+"</tr><tfoot>";    
				    
				    $("#centertable").attr("cellpadding","0");
					$("#centertable").attr("cellspacing","0");
					$("#centertable").attr("border","0");
					$("#centertable").attr("class","display");
				    $("#centertable").html(tbl_body);
				    $("#centertable").dataTable({
				    	"sScrollX": "100%"
				    });
				    $('td').attr("class","center");
        		}
        	})
        })
  	</script>
    <table align="center" id="centertable">
        <tr>
        	<td>
			    <button style="width:100%" id="addnote">
			        <span style = "font-size:16pt">Add note</span>
				</button>
			</td>
    	</tr>
        <tr>
        	<td>
			    <button style="width:100%" id="create">
			        <span style = "font-size:16pt">Create route</span>
				</button>
			</td>
    	</tr>
    	<tr>
    		<td>
    			<button style="width:100%" id="modify">
    				<span style = "font-size:16pt">Modify route</span>
    			</button>
    		</td>
    	</tr>
        <tr>
        	<td>
			    <button style="width:100%" id="stat">
			        <span style = "font-size:16pt">Statistics</span>
				</button>
			</td>
    	</tr>
	</table>