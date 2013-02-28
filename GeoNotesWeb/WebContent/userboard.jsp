<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    	               "http://www.w3.org/TR/html4/loose.dtd">
<%
	String username = request.getParameter("username");
%>
	<script type="text/javascript">
		$(function(){
			location.hash="user";
			history.pushState( null, null, this.href);
			$(window).unbind("popstate");
			$( window ).bind( "popstate", function( e ) {
        		var returnLocation = history.location;
        		var hash = escape(returnLocation.hash.replace( /^#/, ''));
				if(hash=='user'){
					window.location.href="http://localhost:8080/GeoNotesWeb/";
				}
       		})
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
		$('#toptitle').html("User board...");
		$('#findway').button();
		$('#stat').button();
		$("#findway").click(function(){
        	$.ajax({
        		url:'findway.jsp',
        		type:'POST',
        		data:{
					username: '<%=username%>'
        		},
        		success:function(data){
        			$('#centraldiv').html(data);
        		}
       		});
        });
        $("#stat").click(function(){
			$(function(){
				location.hash="mystat";
				history.pushState( null, null, this.href);
				$(window).unbind("popstate");
				$( window ).bind( "popstate", function( e ) {
	        		var returnLocation = history.location;
	        		var hash = escape(returnLocation.hash.replace( /^#/, ''));
					if(hash=='mystat'){
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
			})
        	$.ajax({
        		url:'RetrieveMystatsServlet',
        		type: 'POST',
        		data:{
        			username: '<%=username%>'
        		},
        		success:function(data){
				    var tbl_body = "";
				    var tbl_row = "";
				    tbl_row = "<th>" + "Date" + "</th>" + "<th>" + "Route" + "</th>" + "<th>" + "Distance" + "</th>" + "<th>" + "Time" +"</th>";
				    tbl_body += "<thead><tr>"+tbl_row+"</tr></thead><tbody>";    
				    $.each(data, function() {
				        tbl_row = "";
				        $.each(this, function(k , v) {
				        	if(k==0){
				        		tbl_row += "<td>"+v.day+"-"+(v.month+1)+"-"+v.year+"</td>";
				        	}
							else if(k==2){
								tbl_row += "<td>"+v+"m</td>";
							}
							else if(k==3){
								tbl_row += "<td>"+msToTime(v)+"</td>";
							}
				        	else{
				           		tbl_row += "<td>"+v+"</td>";
				           	}
				        })
				        tbl_body += "<tr>"+tbl_row+"</tr>";                 
				    })
				    tbl_body += "</tbody>"
				    tbl_row = "<th>" + "Date" + "</th>" + "<th>" + "Route" + "</th>" + "<th>" + "Distance" + "</th>" + "<th>" + "Time" +"</th>";
				    tbl_body += "<tfoot><tr>"+tbl_row+"</tr><tfoot>";    
				    
				    $('#toptitle').html("My routes...");
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
			    <button style="width:100%" id="findway">
			        <span style = "font-size:16pt">Find a way</span>
				</button>
			<td>
    	</tr>
        <tr>
        	<td>
			    <button style="width:100%" id="stat">
			        <span style = "font-size:16pt">Statistics</span>
				</button>
			<td>
    	</tr>
	</table>