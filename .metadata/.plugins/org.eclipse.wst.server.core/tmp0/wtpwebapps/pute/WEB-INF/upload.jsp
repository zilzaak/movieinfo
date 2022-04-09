<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ page  isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
<link href="webjars/bootstrap/4.3.1/css/bootstrap.min.css"
        rel="stylesheet">

<script src="webjars/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<script src="webjars/jquery/3.2.1/jquery.min.js"></script>
<script src="webjars/angularjs/1.8.2/angular.min.js"></script>
<meta charset="ISO-8859-1">
<script>

</script>
</head>
<body>
<form action="${pageContext.request.contextPath}/upload" method="post"  enctype="multipart/form-data" modelAttribute="fo">
<input type="file" name="fls" /><br/>
<input type="text" name="description" /><br/>
<input type="submit" />
</form>
<h1>${f.description}</h1>
<div>
<img src="<c:url value="/static/images/${f.filename}"/>" />
</div>
   </body>
</html>