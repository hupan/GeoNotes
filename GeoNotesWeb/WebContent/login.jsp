<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    	               "http://www.w3.org/TR/html4/loose.dtd">
	<script type="text/javascript">
        $(function(){
        	$('#login').button();
        	$('input').button().css({
          		'font' : 'inherit',
         		'color' : 'inherit',
    			'text-align' : 'left',
       			'outline' : 'none',
        		'cursor' : 'text'
  			});
  			$('#login').unbind('click');
  			$('#login').click(function(){
  			    history.pushState( null, null, this.href );
	  			var firsttext = $('#username').val();
	  			var secondtext = $('#password').val();
	  			if(firsttext == '' || secondtext == ''){
	  				alert("No field can be left blank.");
	  			}
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
        					return;
        				}
        				else{
        					$("#centraldiv").html(data);
        				}
        			    
        			}
        		});
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
        	<td colspan="2">
			    <button style="width:100%" id="login">
			        <span style = "font-size:16pt">Login</span>
				</button>
			<td>
    	</tr>
	</table>