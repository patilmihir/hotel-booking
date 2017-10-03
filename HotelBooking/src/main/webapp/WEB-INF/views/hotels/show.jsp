
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
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
<link rel="stylesheet" href="../css/pgwslider.css">
<script src="../js/jquery.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="../js/pikaday.js"></script>
<script src="../js/pgwslider.js"></script>
<style type="text/css">
.thumbnail {
	padding: 0px;
}

.panel {
	position: relative;
}

.panel>.panel-heading:after, .panel>.panel-heading:before {
	position: absolute;
	top: 11px;
	left: -16px;
	right: 100%;
	width: 0;
	height: 0;
	display: block;
	content: " ";
	border-color: transparent;
	border-style: solid solid outset;
	pointer-events: none;
}

.panel>.panel-heading:after {
	border-width: 7px;
	border-right-color: #f7f7f7;
	margin-top: 1px;
	margin-left: 2px;
}

.panel>.panel-heading:before {
	border-right-color: #ddd;
	border-width: 8px;
}
</style>
</head>
<body>
	<c:set var="contextPath" value="${pageContext.request.contextPath}" />

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
				<li><a href="..//dashboard/view.htm">Dashboard</a></li>
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

		<h1 style="text-align: center;">
			<span>${hotel.name}</span> <small> <span> <c:forEach
						var="i" begin="1" end="${hotel.rating}">
						<i class="starshome glyphicon glyphicon-star"></i>
					</c:forEach>
			</span>
			</small> <br /> <small> · <span id="address">${hotel.address}</span>
			</small>
		</h1>

		<div class="row">
			<div class="col-md-8 col-md-offset-2">
				
				<div class="row">
				<ul class="pgwSlider">
				<c:forEach var="img" items="${hotel.images}">
					<li><img src="../images/${img.value.path}" alt=""></li>					
						</c:forEach>
				</ul>
				</div>


				<br>
				<hr>
				<div style="text-align: center;">
					<span class="clear-fix"> <a class="btn btn-default" href="#"
						data-toggle="modal" data-target="#myModalTypes">Room types
							available</a>
					</span>

					<%
						if (session.getAttribute("user") != null && session.getAttribute("role").equals("ROLE_HOTEL_MANAGER")
								&& session.getAttribute("isManager") != null && session.getAttribute("isManager").equals("true")) {
					%>
					<span> <a class="btn btn-default"
						href="${hotel.id}/rooms.htm">Manage rooms</a>
					</span>
					<%
						}
					%>
				</div>
				<hr>
			</div>
		</div>


		<div class="row">
			<div class="col-sm-12">
				<h3>REVIEWS</h3>
			</div>
		</div>
		<c:forEach var="comment" items="${comments}">
			<div class="row">
				<div class="col-md-12">
					<div class="panel panel-default">
						<div class="panel-heading">
							<strong>${comment.value.user.name}</strong> <span
								class="text-muted"> ${comment.value.date} </span>
						</div>
						<div class="panel-body">${comment.value.text}</div>
					</div>
				</div>
			</div>
		</c:forEach>




		<%
			if (session.getAttribute("user") != null) {
		%>
		<div class="row">
			<div class="col-md-12">

				<form:form action="${hotel.id}/comment" method="post"
					commandName="comment">

					<p>
						<form:textarea path="text" rows="5" class="form-control"></form:textarea>
					</p>

					<p>
						<input class="btn btn-primary" type="submit" value="Submit" /> <input
							class="btn btn-default" type="reset" value="Reset" />
					</p>
				</form:form>

			</div>
		</div>
		<%
			}
		%>

		<div class="modal fade" id="myModalTypes" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabel">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title" id="myModalLabel">Room types
							available</h4>
					</div>
					<div class="modal-body">
						<table class="table">
							<thead>
								<tr>
									<th>Description</th>
									<th>Price</th>
									<th>Occupancy</th>
								</tr>

								<c:forEach var="type" items="${hotelRoomTypes}">
									<tr>
										<td>${type.key.description}</td>
										<td><span>${type.value.price}</span> $/night</td>
										<td><c:forEach var="i" begin="1"
												end="${type.key.occupancy}">
												<span><i class="glyphicon glyphicon-user"></i></span>
											</c:forEach></td>
									</tr>
								</c:forEach>
						</table>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
					</div>
				</div>
			</div>
		</div>


	</div>



	<footer> </footer>
	<script type="text/javascript">
		$(document).ready(function() {
			$('.pgwSlider').pgwSlider();
		});
		var startDate, endDate, updateStartDate = function() {
			startPicker.setStartRange(startDate);
			endPicker.setStartRange(startDate);
			endPicker.setMinDate(startDate);
		}, updateEndDate = function() {
			startPicker.setEndRange(endDate);
			startPicker.setMaxDate(endDate);
			endPicker.setEndRange(endDate);
		}, startPicker = new Pikaday({
			field : document.getElementById('start'),
			minDate : new Date(),
			maxDate : new Date(2020, 12, 31),
			onSelect : function() {
				startDate = this.getDate();
				updateStartDate();
			}
		}), endPicker = new Pikaday({
			field : document.getElementById('end'),
			minDate : new Date(),
			maxDate : new Date(2020, 12, 31),
			onSelect : function() {
				endDate = this.getDate();
				updateEndDate();
			}
		}), _startDate = startPicker.getDate(), _endDate = endPicker.getDate();

		if (_startDate) {
			startDate = _startDate;
			updateStartDate();
		}

		if (_endDate) {
			endDate = _endDate;
			updateEndDate();
		}
	</script>
</body>
</html>