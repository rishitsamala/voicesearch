<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>	
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Voice Search - Vehicle Search</title>
<link rel="stylesheet" type="text/css"
	href="https://cdn.datatables.net/1.10.16/css/jquery.dataTables.min.css">
<link rel="stylesheet" type="text/css"
	href="https://cdn.datatables.net/1.10.9/css/jquery.dataTables.min.css">
<link rel="stylesheet" type="text/css"
	href="https://cdn.datatables.net/responsive/1.0.7/css/responsive.dataTables.min.css">
<script type="text/javascript"
	src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript" src="https://www.google.com/jsapi"></script>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/bootstrap.min.css">
<script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/js/popper.min.js"></script>
<script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
<script defer src="${pageContext.request.contextPath}/js/all.js"></script>

<style>

.requiredLabel:after {
	content:"*";color:red;
}

label {
  font-weight:bold;
}

</style>

</head>
<body>

	<div class="container">

		<div class="d-flex flex-column justify-content-center">

		<div style="background-color: #17a2b8;">
		
			<div class="mh-100 page-header" style="height: 25px;">
				<h3 class="text-white text-center">Voice Search</h3>
			</div>
			
			<security:authorize access="isAuthenticated()">
				<nav class="navbar navbar-expand-lg">
					<button class="navbar-toggler navbar-dark" type="button" data-toggle="collapse"
						data-target="#navbarTogglerDemo03"
						aria-controls="navbarTogglerDemo03" aria-expanded="false"
						aria-label="Toggle navigation">
						<span class="navbar-toggler-icon"></span>
					</button>
					<a id="homeV" class="navbar-brand text-white" href="${pageContext.request.contextPath}/app">Home</a>
			
					<div class="collapse navbar-collapse" id="navbarTogglerDemo03">
						<ul class="navbar-nav ml-auto mt-2 mt-lg-0">
							<li class="nav-item"><a id="vehicleSearchV" class="nav-link text-white"
								href="${pageContext.request.contextPath}/app/vehicleSearch">Vehicle Search</a></li>
							<li class="nav-item"><a id="personSearchV" class="nav-link text-white"
								href="${pageContext.request.contextPath}/app/personSearch">Person Search</a></li>
							<li class="nav-item"><a id="logoffV" class="nav-link text-white"
								href="${pageContext.request.contextPath}/login?logout">Logout</a></li>
						</ul>
					</div>
				</nav>
			</security:authorize>
		</div>
		
		
		<div class="jumbotron my-auto">
		
			<!-- Voice search commands -->
			<div>
			  <h4>Voice Commands:</h4>
			  <p class="output"></p>
			</div>
			
			<c:url var="searchURL" value="/app/vehicleSearch/submit" />
			<form:form id="searchForm" modelAttribute="searchForm" action="${searchURL}" method="POST">
			
				<spring:hasBindErrors name="searchForm">
					<div class="alert alert-danger">
						<c:forEach var="error" items="${errors.allErrors}">
							<spring:message message="${error}" />
							<br />
						</c:forEach>
					</div>
				</spring:hasBindErrors>
			
				<c:choose>
					<c:when test="${page eq 'vehicleSearch'}">
					
					<h2 class="text-center" style="color: #17a2b8;">Vehicle Search</h2><div>&nbsp;</div>
					
					<div class="form-group">
						<label for="plateNumber">Plate Number:</label>
						<form:input id="plateNumber" type="text" path="plateNumber" class="form-control"
							placeholder="Enter Plate Number" />
						<form:errors path="plateNumber" class="alert-danger" />
					</div>
					<div class="form-group">
						<label for="expYear">Expiration Year:</label>
						<form:input id="expYear" type="number" path="expYear" class="form-control" />
						<form:errors path="expYear" class="alert-danger" />
					</div>
					<div class="form-group">
						<label for="vinNumber">VIN/OAN/Serial Number:</label>
						<form:input id="vinNumber" type="text" path="vinNumber" class="form-control"
							placeholder="Enter VIN Number" />
						<form:errors path="vinNumber" class="alert-danger" />
					</div>
		
					<p>
						<button type="submit" class="btn btn-info">Search</button>
					</p>
					
					</c:when>
					<c:otherwise>
						
						<h2 class="text-center" style="color: #17a2b8;">Vehicle Search Results</h2><div>&nbsp;</div>
					
						<div class="alert-danger text-center">
							<strong>Stolen vehicle</strong>
							<input id="resultId" value="Alert!! license plate number ${searchForm.plateNumber} is registered as a stolen vehicle. please proceed with caution." type="hidden" />
						</div>
						
						<div class="form-group">
							<label for="plateNumber">Plate Number:</label>
							<form:input type="text" path="plateNumber" readonly="true" class="form-control"
								  />
						</div>
						<div class="form-group">
							<label for="expYear">Expiration Year:</label>
							<form:input type="number" path="expYear" readonly="true" class="form-control" />
						</div>
						<div class="form-group">
							<label for="vinNumber">VIN/OAN/Serial Number:</label>
							<form:input type="text" path="vinNumber" readonly="true" class="form-control"
								  />
						</div>
						
					</c:otherwise>
				</c:choose>
			
			</form:form>
			<div>&nbsp;</div>
			<div>&nbsp;</div>
			<div>&nbsp;</div>
		
		</div>
		
		
		</div>
	</div>
</body>
<script src="${pageContext.request.contextPath}/js/voiceVehicleSearch.js"></script>
</html>