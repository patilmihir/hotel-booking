
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
		        <li><a href="">Hotels <span class="sr-only">(current)</span></a></li>	
		        <% if (session.getAttribute("user") != null) { %>	       
		        <li><a href="../bookings/new.htm">Book a room</a></li>
		          <% }  if(session.getAttribute("user") != null && session.getAttribute("role").equals("ROLE_HOTEL_MANAGER")) { %>
		        <li><a href="../dashboard/view.htm">Dashboard</a></li> 
		        <% } %> 		        	        		        	      
		      </ul>
		          <ul class="nav navbar-nav navbar-right">	
			   <% if (session.getAttribute("user") == null) { %>	
				  <li><a href="../users/register.htm">Sign up</a></li> 
		          <li><a href="../users/login.htm">Log in</a></li>	
		       <% } else { %> 	
		          <li>
		          <a href=../users/me><c:out value="${fn:toUpperCase(user.name)}" /></a>
		          </li>			   
		       	  <li>
			      	<form action="../users/logout.htm" method="post">
	    				<input class="btn btn-link navbar-btn" type="submit" value="Log out"></input>
				  	</form>
				  </li> 
		       <% } %>         
		      </ul>
		      
			</div>
		</div>
	</nav>
	</header>

      
    <div class="container">

		<div class="page-header">
			<h1>Hotel List</h1>
		</div>
		
		
		<c:forEach var="hotel" items="${hotels}">
		
		<div class="list-group">
				<a class="list-group-item"  href="${hotel.id}">${hotel.name}</a>
		</div>
		
		</c:forEach>
	</div>
    <footer>

    </footer>
</body>
</html>