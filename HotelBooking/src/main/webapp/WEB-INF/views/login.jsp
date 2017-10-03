
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>HOTEL BOOKING</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="../css/style.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>

 		
    <div class="jumbotron">
    <div class="container text-center">
        <h1>HOTEL BOOKING</h1>
    </div>
    </div>	
    
	<header>
		<nav class="navbar navbar-default">
		<div class="container-fluid">

		    <div class="navbar-header">
		      <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
		        <span class="sr-only">Toggle navigation</span>
		        <span class="icon-bar"></span>
		        <span class="icon-bar"></span>
		        <span class="icon-bar"></span>
		      </button>
		      <a class="navbar-brand" href="/bookingApp"><i class="glyphicon glyphicon-home"></i></a>
		    </div>
		
		    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
		      
		      <ul class="nav navbar-nav">
		        <li><a href="../hotels/index.htm">Hotels <span class="sr-only">(current)</span></a></li>
		        <% if (session.getAttribute("user") != null) { %>	  		      
		        <li><a href="../bookings/new.htm">Book a room</a></li>	
		        <% }  if(session.getAttribute("user") != null && session.getAttribute("role").equals("ROLE_HOTEL_MANAGER")) { %> 	
		        <li><a href="../dashboard/view.htm">Dashboard</a></li> 
		        <% } %>  	        	        		        	      
		      </ul>
		      <ul class="nav navbar-nav navbar-right">	
			   
				  <li><a href="register.htm">Sign up</a></li> 
		          <li><a href="login.htm">Log in</a></li>		        
		      </ul>
		      
			</div>
		</div>
	</nav>
	</header>

      
    <div class="container">

		<div class="page-header">
			<h1>Log in</h1>
		</div>
		<div>
			<form action="login.htm" method="post">
				<p><label>Username</label><input placeholder="Username" class="form-control" type="text" name="username" /></p>
				<p><label> Password</label><input placeholder="Password" class="form-control" type="password" name="password" /></p>
				<input class="btn btn-primary" type="submit" value="Sign In" />
			</form>
		</div>

	</div>
    <footer>

    </footer>
</body>
</html>