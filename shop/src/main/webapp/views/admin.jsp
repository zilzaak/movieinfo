<%@ page language="java" contentType="text/html; charset=UTF-8"
 pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page isELIgnored="false"  %>
<!DOCTYPE html>
<html>
<head>
<title>make prescription</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="<c:url value="/static/theme/bootstrap431.css" /> " rel="stylesheet">
<script src="<c:url value="/static/theme/jquery340.js" />" > </script> 
<script src="<c:url value="/static/theme/popper114.js" />" > </script>
<script src="<c:url value="/static/theme/angular1.8.2.js" />" > </script>
<script src="<c:url value="/static/theme/bootstrap431.js" />" > </script>
</head>
<body>

<div style="margin-left:30%;margin-top:100px;">
<form method="post" action="/adminlogin">
<ul style="list-style-type:none;padding:10px;">
<li style="padding:10px;color:red;">${sms}</li>
<li style="padding:10px;"><input type="password" name="adminpass" placeholder="password" /></li>
<li style="padding:10px;"><button class="btn btn-sm btn-success">login</button></li>
</ul>


</form>
</div>


</body>

</html>