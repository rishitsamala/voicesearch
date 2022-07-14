<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>	
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>TIME - Login Page</title>
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
		
			<div class="mh-100 page-header" style="height: 70px;">
				<h3 class="text-white text-center">Voice Search</h3>
			</div>

		<div class="jumbotron my-auto">
		
			 <div class="row">
			    <div class="col-sm">
		    </div>
		    <div class="col-sm">
		    
		    <h5 style="color: #17a2b8;">Sign In</h5>
			
			<c:if test="${not empty error}">
				<div class="alert alert-danger">${error}</div>
			</c:if>
			<c:if test="${not empty logoutMsg}">
				<div class="alert alert-success">${logoutMsg}</div>
			</c:if>

			<form role="form" name='loginForm' action="<c:url value='/login' />"
				method='POST'>

				<div class="form-group">
					<input type="text" class="form-control" name="username"
						placeholder="Username">
				</div>

				<div class="form-group">
					<input type="password" class="form-control" name="password"
						placeholder="Password">
				</div>
				
				<p>
					<button type="submit" class="form-control btn btn-info">Submit
					</button>
				</p>

				<input type="hidden" name="${_csrf.parameterName}"
					value="${_csrf.token}" />
			</form>
		    </div>
		    <div class="col-sm">
		    </div>
		  </div>
		</div>

	</div>
	</div>
	</div>

</body>
</html>