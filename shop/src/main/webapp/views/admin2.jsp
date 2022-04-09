<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<title>admin page</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="<c:url value="/static/theme/bootstrap431.css" /> " rel="stylesheet">
<script src="<c:url value="/static/theme/jquery340.js" />" > </script> 
<script src="<c:url value="/static/theme/popper114.js" />" > </script>
<script src="<c:url value="/static/theme/angular1.8.2.js" />" > </script>
<script src="<c:url value="/static/theme/bootstrap431.js" />" > </script>
<style>
table th{
background-color:black;
color:white;
padding:8px;

}

table td{
background-color:skyblue;
padding:8px;
}

</style>
<script>

var mod=angular.module("pressapp",[]);

mod.controller("presscon",function($scope,$http,$window){
	
	$scope.emaillist=[];
	
	$scope.alluser=function(){
		$http({
			method:"GET",
			url:"${pageContext.request.contextPath}/alluser",
			//data: angular.toJson($scope.presitems),
			headers: {"Content-Type":"application/json"}}).
			then(function(response){
				$scope.emaillist=response.data;
               				
			        })		
		
	}
	
	$scope.admin={"email":"","password":""};
	
	$scope.edit=function(t){
	
$scope.ined=t;
		
	}
	
	
	$scope.edit2=function(r){
		
		$http({
			method:"PUT",
			url:"${pageContext.request.contextPath}/edit",
			data: angular.toJson($scope.emaillist[r]),
			headers: {"Content-Type":"application/json"}}).
			then(function(response){
				
               alert(response.data.stringdate);				
			        })		
				
			}
	
	
	$scope.adminmail=null;
	
	$scope.seeadmin=function(){
		
		$http({
		method:"GET",
		url:"${pageContext.request.contextPath}/seeadmin",
		headers: {"Content-Type":"application/json"}}).
		then(function(response){
		
			$scope.adminmail=response.data;	
			
		        })				
	   
              }
	
	
	
	
	$scope.adminset=function(){
		$http({
			method:"POST",
			url:"${pageContext.request.contextPath}/adminset",
			data: angular.toJson($scope.admin),
			headers: {"Content-Type":"application/json"}}).
			then(function(response){
				
            alert(response.data.email); 
      	
			})	
		
	}
	
	
	$scope.clearadmin=function(){
		
		$http({
			method:"GET",
			url:"${pageContext.request.contextPath}/clearadmin",
			//data: angular.toJson($scope.admin),
			headers: {"Content-Type":"application/json"}}).
			then(function(response){
				
            alert("SUCCESSFULLY DELETED"); 
      	
			})	
		
	}
	
	
	
	$scope.delet=function(t){
		

		$http({
			method:"DELETE",
			url:"${pageContext.request.contextPath}/delete",
			data: angular.toJson($scope.emaillist[t]),
			headers: {"Content-Type":"application/json"}}).
			then(function(response){
				
              alert("deleted successfully"); 
      		$scope.emaillist.splice(t,1);
			})	
		
		
		}
	
	$scope.clearbt={"email":"","pass":"","sms":""};
	
	
	$scope.clearsell=function(t){
		var email=window.prompt("enter email");
		var pass=window.prompt("enter password");
$scope.clearbt.email=email;$scope.clearbt.pass=pass;

		$http({
			method:"DELETE",
			url:"${pageContext.request.contextPath}/clear/clearsell",
			data: angular.toJson($scope.clearbt),
			headers: {"Content-Type":"application/json"}}).
			then(function(response){
				alert(response.data.sms);
			})	
		
		
		}	
	
	
	$scope.clearorder=function(t){
		var email=window.prompt("enter email");
		var pass=window.prompt("enter password");
$scope.clearbt.email=email;$scope.clearbt.pass=pass;

		$http({
			method:"DELETE",
			url:"${pageContext.request.contextPath}/clear/clearorder",
			data: angular.toJson($scope.clearbt),
			headers: {"Content-Type":"application/json"}}).
			then(function(response){
				alert(response.data.sms);
			})	
		
		
		}
	
	$scope.clearsample=function(t){
		
		var email=window.prompt("enter email");
		var pass=window.prompt("enter password");
$scope.clearbt.email=email;$scope.clearbt.pass=pass;
		
		$http({
			method:"DELETE",
			url:"${pageContext.request.contextPath}/clear/clearsample",
			data: angular.toJson($scope.clearbt),
			headers: {"Content-Type":"application/json"}}).
			then(function(response){
			alert(response.data.sms);
			})	
		
		
		}	
	
	
	
	
	
});

</script>




</head>

<body ng-app="pressapp" ng-controller="presscon">

<div style="margin-left:30%;margin-top:60px;background-color:gray;margin-right:35%;text-align:center;">
<h4 align="center" style="color:white;background-color:black;padding:6px;">add a user</h4>
<form action="/addemail" method="post">
<ul style="list-style-type:none;padding:10px;">
<li style="padding:10px;color:yellow;">${sms}</li>
<li style="padding:10px;"><input style="width:80%;display:block;" type="text" name="email" placeholder="users gmail"/></li>
<li style="padding:10px;"><button class="btn btn-sm btn-success">add</button></li>
</ul>
</form>
</div>

<br/>

<div  style="background-color:dakseagreen;margin-left:30%;margin-right:35%;">
<button class="btn btn-sm btn-success" ng-click="alluser()">see all user</button>
<br/>
<br/>
<table border="1">
<tr ng-if="emaillist.length>0">
<th>adding date</th>
<th>email</th>
<th>edit</th>
<th>delete</th>
</tr>

<tr ng-repeat="x in emaillist">
<td>{{x.stringdate}}</td>
<td>{{x.email}}</td>
<td><button class="btn btn-sm btn-primary" ng-click="edit($index)"  data-toggle="modal" data-target="#emodal">edit</button></td>
<td><button class="btn btn-sm btn-danger" ng-click="delet($index)">delete</button></td>
</tr>

</table>

</div>




<div style="margin-left:30%;margin-top:30px;background-color:gray;margin-right:35%;text-align:center;">
<h4 align="center" style="color:white;background-color:black;padding:6px;">set up admin data</h4>
<ul style="list-style-type:none;padding:10px;">
<li style="padding:10px;color:white;background-color:maroon;" ng-if="adminmail!=null">email::{{adminmail.email}} , password::{{adminmail.password}}</li>
<li style="padding:10px;"><input style="width:80%;display:block;" type="text" ng-model="admin.email" placeholder="gmail name"/></li>
<li style="padding:10px;"><input style="width:80%;display:block;" type="password" ng-model="admin.password" placeholder="gmails password"/></li>
<li style="padding:10px;">

<button class="btn btn-sm btn-success" style="margin:10px;" ng-click="adminset()">add now</button>
<button class="btn btn-sm btn-success" style="margin:10px;" ng-click="clearadmin()">clear all mail</button> 
<button class="btn btn-sm btn-success" style="margin:10px;" ng-click="seeadmin()">see admin mail</button> 

</li>
</ul>

</div>

<br/>
<br/>

<div style="margin-left:30%;margin-top:30px;background-color:gray;margin-right:35%;text-align:center;">

<button class="btn btn-sm btn-success" style="margin:10px;" ng-click="clearsell()">clear sell</button>
<button class="btn btn-sm btn-success" style="margin:10px;" ng-click="clearorder()">clear order</button> 
<button class="btn btn-sm btn-success" style="margin:10px;" ng-click="clearsample()">clear sample</button> 

</div>








 <div id="emodal" class="modal fade" role="dialog">
        <div class="modal-dialog" style="border-radius:10px;width:420px;">
        <div class="modal-content">
        <div class="modal-header" style="background-color:gray;">
        <button type="button" class="close" data-dismiss="modal" >&times;</button>
        <h4 class="modal-title">close</h4>
      </div>
<div class="modal-body" style="text-align:center;">
<h4>edit email</h4> 
<input type="text" ng-model="emaillist[ined].email"/> <br/>
<button ng-click="edit2(ined)">submit</button>
</div>
 <div class="modal-footer" style="background-color:gray;">
 
      
     </div>
     </div>
     </div>
</div>

</body>


</html>