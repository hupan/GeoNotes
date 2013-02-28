<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    	               "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta name="viewport" content="width = device-width; initial-scale=1">
        <title>GeoNotes</title>
        <link rel="stylesheet" href="css/jquery.mobile-1.2.0.css" />
        <link rel="stylesheet" href="css/jquery-ui-1.10.0.custom.min.css" />
        <link rel="stylesheet" href="css/default.css"/>
        <script type="text/javascript" src="js/history.js"></script>
        <script src="js/jquery-1.9.0.min.js"></script>
        <script src="js/jquery-ui-1.10.0.custom.min.js"></script>
        <script src="js/jquery.mobile-1.2.0.min.js"></script>
        <script type="text/javascript" 
        	src="http://maps.googleapis.com/maps/api/js?key=AIzaSyBS2ajTg0q3hMrYkp6YDmunPrFZw6skUlU&sensor=false">
        </script>
	    <style type="text/css">
	      @import "css/demo_page.css";
	      @import "css/demo_table.css";
	    </style>
	   	<script type="text/javascript" src="http://datatables.net/download/build/jquery.dataTables.nightly.js"></script>
        <script type="text/javascript">

        	$(function(){
				$(window).unbind("popstate");
        		$('#login').button();
        		$('#register').button();
        		$('input').button().css({
          			'font' : 'inherit',
         			'color' : 'inherit',
    				'text-align' : 'left',
       				'outline' : 'none',
        			'cursor' : 'text'
  				});
        		$("#register").click(function(){
        			$.ajax({
        				url:'register.jsp',
        				type:'POST',
        				success:function(data){
        					$('#toptitle').html("Register...");
        				    $('#centraldiv').html(data);
        				}
        			});
        		});

        		$("#login").click(function(){
        		    var firsttext = $('#username').val();
	        		var secondtext = $('#password').val();
	        		if(firsttext == '' || secondtext == ''){
	        			alert("No field can be left blank");
	        			return;
	        		};
        			$.ajax({
        				url:'LoginServlet',
        				type:'POST',
        				data:{
        					username: firsttext,
        					passwd: secondtext
        				},
        				success:function(data){
        					if(data == "error"){
        						alert("Wrong username/password.");
        					}
        					else{
	        					$('#centraldiv').html(data);
        					}
        				}
        			});
        		});
        	})
  		</script>
    </head>
    <body style="margin:0 auto;padding:0;">
       	<div class="ui-bar-a ui-header">
        	<h1 id="toptitle" class="ui-title">Please log in...</h1>
        </div>

        <div style="margin:0 auto; padding:0;" id="centraldiv" class="ui-content">
        	<table align="center">
        		<tr>
        			<td>
		        		<img src="images/l_username_icon.png" alt="Username"/>
		        	</td>
		        	<td>
		        		<input id="username" type="text"/>
		        	</td>
        		</tr>
        		<tr>
        			<td>
		        		<img src="images/l_pass_icon.png" alt="Password"/>
		        	</td>
		        	<td>
		        		<input id="password" type="password"/>
		        	</td>
        		</tr>
        		<tr>
        			<td colspan="2">
			        	<button style="width:100%" id="login">
			        		<span style = "font-size:16pt">Login</span>
			        	</button>
		        	<td>
        		</tr>
        		<tr>
        			<td colspan="2">
			        	<button style="width:100%" id="register">
			        		<span style = "font-size:16pt">Register</span>
			        	</button>
		        	<td>
        		</tr>
        	</table>
        </div>
        <div class="ui-bar-a ui-footer">
			<h1 class="ui-title">Designed by Pan HU</h1>
		</div>
    </body>
</html>
