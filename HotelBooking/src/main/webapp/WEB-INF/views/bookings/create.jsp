
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>HOTEL BOOKING</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="../css/style.css">
<link rel="stylesheet" href="../css/main.css">
<script src="../js/jquery.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="../js/pikaday.js"></script>
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
    <div class="page-header"><h1>Book a Room</h1></div>	
	
	
	<div>
	    	<form:form action="search.htm" method="post" commandName="booking">
	    		<div>
		        	<div style="display: inline-block">
				        <label for="start"><i class='glyphicon glyphicon-calendar'></i> Check-in:</label>				        
				        <form:input path="begin_date" type="text" class="form-control" id="start" readonly='true' />
				    </div>
				    
				    <p></p>				
				
				    <div style="display: inline-block">
				        <label for="end"><i class='glyphicon glyphicon-calendar'></i> Check-out:</label>
				        <form:input path="end_date" type="text" class="form-control" id="end" readonly='true'/>
				    </div>	
				    <div>
				    
				    <p></p>
				    <label><i class="glyphicon glyphicon-user"></i> Room Type</label>
			    	<select class="form-control" name="roomType">
			    	<c:forEach var="rt" items="${roomTypes}">
	        			<option value="${rt.id}">${rt.description} ${rt.occupancy}</option>
	        			</c:forEach>
		        	</select>
		        	
		        	
		        	 <p></p>
				    <label>Number of rooms</label>
			    	<select id="ddl" class="form-control" name="numberRooms">
		        	</select>
		        	
		        	</div>	        	
	        	</div>
	        	<br>
	    	    <p><input class="btn btn-primary" type="submit" value="Submit" /> <input class="btn btn-default" type="reset" value="Reset" /></p>
		    </form:form>
	    </div>
	
	
	
			
	</div>
	<script type="text/javascript">
	
	
	jQuery('#start').bind('keypress', function(e) {
	    e.stopPropagation(); 
	});
	
	jQuery('#end').bind('keypress', function(e) {
	    e.stopPropagation(); 
	});
	
    var startDate,
        endDate,
        updateStartDate = function() {
            startPicker.setStartRange(startDate);
            endPicker.setStartRange(startDate);
            endPicker.setMinDate(startDate);
        },
        updateEndDate = function() {
            startPicker.setEndRange(endDate);
            startPicker.setMaxDate(endDate);
            endPicker.setEndRange(endDate);
        },
        startPicker = new Pikaday({
            field: document.getElementById('start'),
            minDate: new Date(),
            maxDate: new Date(2020, 12, 31),
            onSelect: function() {
                startDate = this.getDate();
                updateStartDate();
            }
        }),
        endPicker = new Pikaday({
            field: document.getElementById('end'),
            minDate: new Date(),
            maxDate: new Date(2020, 12, 31),
            onSelect: function() {
                endDate = this.getDate();
                updateEndDate();
            }
        }),
        _startDate = startPicker.getDate(),
        _endDate = endPicker.getDate();

        if (_startDate) {
            startDate = _startDate;
            updateStartDate();
        }

        if (_endDate) {
            endDate = _endDate;
            updateEndDate();
        }
        
        var select = $("#ddl");
        for (i=1;i<=5;i++){
            select.append($('<option></option>').val(i).html(i));
        }

    </script> 	
		
		

    <footer>

    </footer>
 
</body>
</html>