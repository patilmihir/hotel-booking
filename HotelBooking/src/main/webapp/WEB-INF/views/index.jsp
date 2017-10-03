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
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="css/style.css">
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
</head>
<body>
<header>
 		
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
		      <a class="navbar-brand" href=""><i class="glyphicon glyphicon-home"></i></a>
		    </div>
		
		    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
		      
		      <ul class="nav navbar-nav">
		        <li><a href="hotels/index.htm">Hotels <span class="sr-only">(current)</span></a></li>
		        <% if (session.getAttribute("user") != null) { %>	      
		        <li><a href="bookings/new.htm">Book a room</a></li>	
		        <% }  if(session.getAttribute("user") != null && session.getAttribute("role").equals("ROLE_HOTEL_MANAGER")) { %> 	
		        <li><a href="dashboard/view.htm">Dashboard</a></li> 
		        <% } %>    
		           	        		        	      
		      </ul>

		      <ul class="nav navbar-nav navbar-right">	
			   <% if (session.getAttribute("user") == null) { %>	
				  <li><a href="users/register.htm">Sign up</a></li> 
		          <li><a href="users/login.htm">Log in</a></li>	
		       <% } else { %> 	
		          <li>
		          <a href=users/me><c:out value="${fn:toUpperCase(user.name)}" /></a>
		          </li>			   
		       	  <li>
			      	<form action="users/logout.htm" method="post">
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
		
		<div>
			<form class="navbar-form"  role="search" action="hotels/search.htm" method="post">
				<div class="form-group" style="width:100%;">
					<input id="search-box" type="text"  style="width:100%;" class="form-control" placeholder="Search" name="hotel">
				</div>
			</form>
		</div>
		
		<hr/>
		<c:forEach var="hotel" items="${hotels}">
		<div>
				
				<h3 align="center">
					<span text="<c:out value='${hotel.name}'></c:out>"></span>
				</h3>				
		</div>
		
		<div class="col-md-4">
				<h3 align="center">
					<span>${hotel.name}</span>
				</h3>
				<div class="starshome">
					<span>
					<c:forEach var="i" begin="1" end="${hotel.rating}">
					<i class="starshome glyphicon glyphicon-star"></i> 
					</c:forEach>
					</span>
				</div>
				
				<figure>
				<c:forEach var="img" items="${hotel.images}">
				<c:set var="path" value="${img.value.path}"/>
				<c:if test="${fn:containsIgnoreCase(path, 'burj1.jpg') || fn:containsIgnoreCase(path, 'wildflower1.jpg') || fn:containsIgnoreCase(path, 'rajvillas1.jpg') || fn:containsIgnoreCase(path, 'taj1.jpg')}">				
				<img width="350px" height="235px" src="images/${img.value.path}" class="img-rounded" alt="Hotel photo" />
				</c:if>
				</c:forEach>

				</figure>
				
				<br>
				<div class="text-center">
					<a class="seehotel btn btn-default" href="hotels/${hotel.id}">VIEW</a>
				</div>
			</div>

		</c:forEach>

		<div>
			
		</div>

	</div>
    <footer>

    </footer>
    <script>
	$(document).ready(function(){   		
		$("#search-box").keyup(function(){
    		$.ajax({
    		type: "GET",
    		dataType: 'json',
    		url: "hotels/autocomplete",
    		data:'keyword='+$(this).val(),
    		beforeSend: function(){
    			$("#search-box").css("background","#FFF url(LoaderIcon.gif) no-repeat 165px");
    		},
    		success: function(data){     		     		    		    	
    		    $( "#search-box" ).autocomplete({
    		      source: data
    		    }); 
    		},
    		 error: function (response) {
                 
              }
    		});
    	});
	});

    	
   
    </script>
</body>
</html>