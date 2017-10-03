
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>HOTEL BOOKING</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="../css/style.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>
	<header>

	<div class="jumbotron">
		<div class="container text-center">
			<h1>HOTEL BOOKING</h1>
		</div>
	</div>

	<header> <nav class="navbar navbar-default">
	<div class="container-fluid">

		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expanded="false">
				<span class="sr-only">Toggle navigation</span> <span
					class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="/bookingApp"><i
				class="glyphicon glyphicon-home"></i></a>
		</div>

		<div class="collapse navbar-collapse"
			id="bs-example-navbar-collapse-1">

			<ul class="nav navbar-nav">
				<li><a href="../hotels/index.htm">Hotels <span
						class="sr-only">(current)</span></a></li>
				<%
					if (session.getAttribute("user") != null) {
				%>
				<li><a href="../bookings/new.htm">Book a room</a></li>
				<%
					}
					if (session.getAttribute("user") != null && session.getAttribute("role").equals("ROLE_HOTEL_MANAGER")) {
				%>
				<li><a href="../dashboard/view.htm">Dashboard</a></li>
				<%
					}
				%>

			</ul>
			<ul class="nav navbar-nav navbar-right">
				<%
					if (session.getAttribute("user") == null) {
				%>
				<li><a href="../users/register.htm">Sign up</a></li>
				<li><a href="../users/login.htm">Log in</a></li>
				<%
					} else {
				%>
				<li><a href=../users/me><c:out
							value="${fn:toUpperCase(user.name)}" /></a></li>
				<li>
					<form action="../users/logout.htm" method="post">
						<input class="btn btn-link navbar-btn" type="submit"
							value="Log out"></input>
					</form>
				</li>
				<%
					}
				%>
			</ul>

		</div>
	</div>
	</nav> </header>


	<div class="container">

		<div class="page-header">
			<h1>
				<span>${fn:toUpperCase(user.name)}</span>
			</h1>
		</div>



		<h4>BOOKINGS</h4>
		<hr>
		<c:if test="${not empty bookings}">
			<div>
				<table class="table">
					<thead>
						<tr>
							<th>Check-in</th>
							<th>Check-out</th>
							<th>Hotel</th>
							<th>Room Type</th>
							<th>Room Number</th>
							<th></th>
						</tr>
					</thead>
					<c:forEach var="booking" items="${bookings}">
						<c:if test="${booking.state}">

							<tr>
								<td><span><fmt:formatDate type="date"
											value="${booking.begin_date}" /></span>
								<td><span><fmt:formatDate type="date"
											value="${booking.end_date}" /></span>
								<td><a href="../hotels/${booking.hotel.id}">${booking.hotel.name}</a>
								</td>
								<td><span>${booking.roomType}</span></td>
								<td><c:forEach var="room" items="${booking.rooms}">
										<div>
											<span>${room.room_number}</span><br>
										</div>
									</c:forEach></td>
								<td><jsp:useBean id="today" class="java.util.Date" /> <c:if
										test="${today lt booking.begin_date}">
										<a href="../bookings/${booking.id}/cancel"> <i
											class="glyphicon glyphicon-trash"></i>
										</a>
									</c:if></td>
							</tr>
						</c:if>
					</c:forEach>

				</table>
			</div>
		</c:if>
		<c:if test="${empty bookings}">
			<p>
				<i>No bookings</i>
			</p>
		</c:if>
		<hr>
		<h4>CANCELLED BOOKINGS</h4>
		<hr>
		<c:if test="${not empty bookings}">
			<div>
				<table class="table">
					<thead>
						<tr>
							<th>Check-in</th>
							<th>Check-out</th>
							<th>Hotel</th>
							<th>Room Type</th>
							<th>Room Number</th>
							<th></th>
						</tr>
					</thead>
					<c:forEach var="booking" items="${bookings}">
						<c:if test="${!booking.state}">

							<tr>
								<td><span><fmt:formatDate type="date"
											value="${booking.begin_date}" /></span>
								<td><span><fmt:formatDate type="date"
											value="${booking.end_date}" /></span>
								<td><a href="../hotels/${booking.hotel.id}|}">${booking.hotel.name}</a>
								</td>
								<td><span>${booking.roomType}</span></td>
								<td><c:forEach var="room" items="${booking.rooms}">
										<div>
											<span>${room.room_number}</span><br>
										</div>
									</c:forEach></td>
								<td></td>
							</tr>
						</c:if>
					</c:forEach>

				</table>
			</div>
		</c:if>
		<c:if test="${empty bookings}">
			<p>
				<i>No bookings</i>
			</p>
		</c:if>
		<hr>					
		
		<div class="row">
			<div class="col-sm-12">
				<h3>COMMENTS</h3>
			</div>
		</div>
		<hr>
		<c:forEach var="comment" items="${comments}">
			<div class="row">
				<div class="col-md-12">
					<div class="panel panel-default">
						<div class="panel-heading">
							<strong> 
							<span class="text-muted"><fmt:formatDate type="date" value="${comment.date}" /></span>
							</strong>
							<b><a href="../hotels/${comment.hotel.id}">${comment.hotel.name}</a></b>
						</div>
						<div class="panel-body">${comment.text}</div>
					</div>
				</div>
			</div>
		</c:forEach>
	</div>



	<footer> </footer>
</body>
</html>