<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    	               "http://www.w3.org/TR/html4/loose.dtd">
	<script type="text/javascript">
		$(function(){
			location.hash="register";
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
					if(hash=='register'){
						window.location.href="http://www.pandahoo.com/GeoNotesWeb/";
					}
				})
			}
			
		})
        $(function(){
        	$('#toptitle').html("Register...");
        	$('#register').button();
        	$('#goback').button();
        	$('input').button().css({
          		'font' : 'inherit',
         		'color' : 'inherit',
    			'text-align' : 'left',
       			'outline' : 'none',
        		'cursor' : 'text'
  			});
  			$('#register').unbind('click');
        	$("#register").click(function(){
        		var firsttext = $('#username').val();
        		var secondtext = $('#password').val();
        		var thirdtext = $('#passwordconfirm').val();
        		if(firsttext == "" || secondtext == "" || thirdtext == ""){
        			alert("No field can be left blank.");
        			return;
        		}
        		else if(secondtext != thirdtext){
        			alert("Please verify your password input.");
        			return;
        		}
        		$.ajax({
        			url:'RegisterServlet',
        			type:'POST',
        			data:{
        				username: firsttext,
        				passwd: secondtext
        			},
        			success:function(data){
        				if(data == "error"){
        					alert("Username already exists.");
        				}
        				else{
        					
        					$("#centraldiv").html(data);
        				}
        			    
        			}
        		});
        	});
        	$('#goback').unbind('click');
        	$('#goback').click(function(){
        		window.location.href="http://www.pandahoo.com/GeoNotesWeb/";
        	})
        })
  	</script>
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
        	<td>
		       	<img src="images/l_pass_icon.png" alt="PasswordConfirm"/>
		    </td>
		    <td>
		 	 	<input id="passwordconfirm" type="password"/>
			</td>
        </tr>
        <tr>
        	<td colspan="2">
			    <button style="width:100%" id="register">
			        <span style = "font-size:16pt">Register</span>
				</button>
			<td>
    	</tr>
        <tr>
        	<td colspan="2">
			    <button style="width:100%" id="goback">
			        <span style = "font-size:16pt">Go back</span>
				</button>
			<td>
    	</tr>
	</table>