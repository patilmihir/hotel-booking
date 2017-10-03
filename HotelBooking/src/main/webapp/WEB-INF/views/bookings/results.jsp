
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
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
<script src="../js/jquery.js"></script>
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
			<h1>Rooms</h1>
		</div>

		<table class="table table-striped">
			<thead>
				<tr>
					<th style="width: 45%;">Check-in</th>
					<th style="width: 33%;">Check-out</th>
					<th>Room Type</th>
				</tr>
			</thead>
			<tr>
				<td><fmt:formatDate type="date" value="${booking.begin_date}" /></td>
				<td><fmt:formatDate type="date" value="${booking.end_date}" /></td>
				<td>${roomType.description}</td>
			</tr>
		</table>




		<hr>
		<table class="table table-striped">
			<thead>
				<tr>
					<th>Hotel</th>
					<th>Price ($/night)</th>
					<th></th>
				</tr>
			</thead>
			<c:forEach var="room" items="${rooms}">
				<tr>
					<td><a href="../hotels/${room.hotel.id}">${room.hotel.name}</a></td>
					<td><span>${room.price}</span> x <span>${numberRooms}</span></td>
					<td><a class="btn btn-default" href="new/${room.hotel.id}">Book</a></td>
				</tr>
			</c:forEach>
		</table>

	</div>



	<footer> </footer>
</body>
</html>