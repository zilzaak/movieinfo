<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<title>pregnant report searching</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="<c:url value="/static/theme/bootstrap431.css" /> " rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="<c:url value="/static/theme/jquery340.js" />" > </script> 
<script src="<c:url value="/static/theme/angular1.8.2.js" />" > </script>
<script src="<c:url value="/static/theme/bootstrap431.js" />" > </script>
<link  href="<c:url value="/static/theme/pregnant.css" /> " rel="stylesheet">
<script>
var module=angular.module("dailyapp",[]);
module.controller("dailycontrol",function($scope,$http){

	$scope.types=["cow","goat","vera","buffelo"];
$scope.preglistid=[];
$scope.preglisttype=[];
$scope.preglistconcive=[];
$scope.preglistnext=[];

	$scope.inityear=function(){
		for(var k=1900;k<=3000;k++){
			
			$scope.year.push(k);
	                     }
	                         }
	
$scope.byanid=function(){
	
	$http({
		method:"POST", 
		url:"${pageContext.request.contextPath}/pregnant/byanid",
		data:angular.toJson($scope.preg.anid),
		headers: {"Content-Type":"application/json"}
			}).then(function(response){
				$scope.preglistid=response.data;
	       })			

}	
	
	
	
$scope.bytype=function(){
	
	$http({
		method:"POST", 
		url:"${pageContext.request.contextPath}/pregnant/bytype",
		data:$scope.preg.type,
		headers: {"Content-Type":"text/plain","Response-Type":"application/json"}
			}).then(function(response){
				
				$scope.preglisttype=response.data;

	       })			

}


$scope.byconcive=function(){
	
	$http({
		method:"POST", 
		url:"${pageContext.request.contextPath}/pregnant/byconcive",
		data:$scope.preg.concivedate,
		headers: {"Content-Type":"text/plain","Response-Type":"application/json"}
		
			}).then(function(response){
				
				$scope.preglistconcive=response.data;
				
	       })			

}

$scope.preglistpregnant=[];

$scope.byconcivebt=function(){
	var s=[];
	s[0]=$scope.concivedatebt1;
	s[1]=$scope.concivedatebt2;
	alert(s[0]);
	$http({
		method:"POST", 
		url:"${pageContext.request.contextPath}/pregnant/byconcivebt",
		data:angular.toJson(s),
		headers: {"Content-Type":"application/json"}
		
	}).then(function(response){
			if(response.data.length==0){
				alert("no result found");
				$scope.preglistconcive=[];
			}
			else{
				$scope.preglistconcive=response.data;
					}
				
				
	       })			

 }



$scope.byall=function(){

	$http({
		method:"GET", 
		url:"${pageContext.request.contextPath}/pregnant/byall",		
		headers: {"Content-Type":"application/json"}
		
	}).then(function(response){
		
			if(response.data.length==0){
				alert("no result found");
				$scope.listbyall==[];
			}
			else{
				$scope.listbyall=response.data;
					}
				
				
	       })			

 }



$scope.bypregnant=function(){
	
	$http({
		method:"POST", 
		url:"${pageContext.request.contextPath}/pregnant/bypregnant",
		data:$scope.preg.pgdate,
		headers: {"Content-Type":"text/plain","Response-Type":"application/json"}
		
			}).then(function(response){
				
				$scope.preglistpregnant=response.data;
				var trow=document.getElementById("t4").getElementsByTagName("tr");
			
			})			

}


$scope.deletethis=function(dp){

			$http({
				method:"DELETE", 
				url:"${pageContext.request.contextPath}/pregnant/deletethis",
				data:angular.toJson(dp),
				headers: {"Content-Type":"application/json"}
				}).then(function(response){
				
					alert("successfully deleted pregnant report");		
					})	
				
			
			}
		


$scope.deleteprg=function(i,op){
	
var z1=window.confirm("want to delete ??");

if(z1){
	var cnz=prompt("enter password to confirm delete");
	if(cnz){
		$http({
			method:"POST",
			url:"${pageContext.request.contextPath}/checkuser", 
			data:cnz,
			headers: {"Content-Type":"text/plain","responseType":"application/json"}
			}).then(function(response){
				
			if(response.data.del!="ok"){
			alert("password error");
			}
			
			if(response.data.del=="ok"){
				
				if(op=='preglistid'){
					$scope.deletethis($scope.preglistid[i]);
					$scope.preglistid.splice(i,1);
				

				}		
				
				if(op=='preglistconcive'){
					$scope.deletethis($scope.preglistconcive[i]);
					$scope.preglistconcive.splice(i,1);
					
					}

					if(op=='preglistpregnant'){
						$scope.deletethis($scope.preglistpregnant[i]);
						$scope.preglistpregnant.splice(i,1);
						
					}

					if(op=='preglisttype'){
						$scope.deletethis($scope.preglisttype[i]);
					$scope.preglisttype.splice(i,1);
					
						
					}

					if(op=='listbyall'){
						$scope.deletethis($scope.listbyall[i]);
							$scope.listbyall.splice(i,1);
						

					}	
		
			}
			
			})	
		}
}


}




$scope.bypregnantbt=function(){
	var s=[];
	s[0]=$scope.pgdatebt1;
	s[1]=$scope.pgdatebt2;
	alert(s[0]);
	$http({
		method:"POST", 
		url:"${pageContext.request.contextPath}/pregnant/bypregnantbt",
		data:angular.toJson(s),
		headers: {"Content-Type":"application/json"}
		
	}).then(function(response){
			if(response.data.length==0){
				alert("no result found");
				$scope.preglistpregnant=[];
			}
			else{
				$scope.preglistpregnant=response.data;
				var trow=document.getElementById("t4").getElementsByTagName("tr");
				}
				
				
	       })			

 }

$scope.bypregnant2=function(){
	
	if($scope.preg.pgdate.length==8 || $scope.preg.pgdate.length==10){
	$http({
		method:"POST", 
		url:"${pageContext.request.contextPath}/pregnant/bypregnant2",
		data:$scope.preg.pgdate,
		headers: {"Content-Type":"text/plain","Response-Type":"application/json"}
		
			}).then(function(response){
				
				$scope.preglistpregnant=response.data;
				var trow=document.getElementById("t4").getElementsByTagName("td");
							
	       })	
	}
	
	else{
		
		alert("the date format wrong use day/month/year, example '2/3/2020'")
	}
	

}



$scope.byconcive2=function(){
	
	if($scope.preg.concivedate.length==8 || $scope.preg.concivedate.length==10){
	$http({
		method:"POST", 
		url:"${pageContext.request.contextPath}/pregnant/byconcive2",
		data:$scope.preg.concivedate,
		headers: {"Content-Type":"text/plain","Response-Type":"application/json"}
		
			}).then(function(response){
				
				$scope.preglistconcive=response.data;
				
	       })	
	}
	else{
		
		alert("the date format wrong use day/month/year, example '2/3/2020'")
	}
	

}





$scope.aboutanimal=function(vr){
	
	$http({
	method:"POST",
	url:"${pageContext.request.contextPath}/animal/aboutanimal", 
	data:angular.toJson(vr),
	headers: {"Content-Type":"application/json"}
	}).then(function(response){
if(response.data.sellstatus!="not"){
	$scope.sa=response.data;

}
else{
	
	alert("oops, the animal id not found");	
}
		
	})
}





});




var dp=['1','2','3','4','5']

function disit(a){
	
for(var i=0; i<dp.length; i++){
	if(dp[i]==a){
		var s = dp[i];
		document.getElementById(s).style.display="block";
	}
	
	if(dp[i]!=a){
		var s = dp[i];
		document.getElementById(s).style.display="none";	
		
	}
}	
	
}




</script>

<style>
table th{
background-color:black;
color:white;
text-align:center;
padding:5px;
break-word:break-all;

}

table td{
background-color:white;
color:black;
text-align:center;
padding:5px;
break-word:break-all;

}

a:hover{
background-color:steelblue;

}
input:hover{
background-color:maroon; color:white;

}

.dropdown-menu a:hover{
background-color:steelblue;

}
</style>

</head>

<body  ng-controller="dailycontrol"  ng-app="dailyapp">

<%
if(session.getAttribute("adminuser")==null && session.getAttribute("adminpass")==null){
	response.sendRedirect("${pageContext.request.contextPath}");
	}

	  %>
	  <nav class="navbar navbar-expand-lg" style="margin-right:7%;margin-left:8%;margin-top:2%;border-radius:8px;background-color:darkolivegreen;">
  <a class="navbar-brand" href="#" style="margin-left:5%;color:white;">Searching pregnant report</a>
   <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon" style="color:white;"><b>click</b></span>
  </button> 
   <div class="collapse navbar-collapse" id="navbarSupportedContent" style="margin-left:6%;">
    <ul class="navbar-nav mr-auto">     
        <li class="nav-item dropdown"  style="margin-left:6%;">
        <a class="nav-link dropdown-toggle" style="margin-left:5%;color:white;" href="#"  role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
          search option
        </a>
        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
          <a class="dropdown-item" href="#" onclick="disit('1')">by animal id</a>
             <a class="dropdown-item" href="#" onclick="disit('2')">by animal type</a>
          <a class="dropdown-item" href="#" onclick="disit('3')">by concive date</a>
           <a class="dropdown-item" href="#" onclick="disit('4')">by pregnant date date</a>
             <a class="dropdown-item" href="#" onclick="disit('5')">all report</a>
          </div>
                   </li>       
                
           </ul>
  </div>
</nav>



<div id="1" style="margin-left:8%;background-color:lightseagreen;width:85%;display:none;font-size:0.80em;">
<div style="text-align:center;padding-top:15px;padding-bpttom:15px;">
<b>enter animal id</b><input type="number" ng-model="preg.anid" ng-keyup="byanid()" /> 
<button class="btn btn-success btn-sm" ng-click="byanid()">search</button>

<br/>
</div>

<br/>
<div style="text-align:center;background-color:lightblue;padding-top:20px;padding-bottom:40px;"> 
<table border="1" align="center">
<tr ng-if="preglistid.length>0">
<th>animal id</th>
<th>type</th>
<th>concive date</th>
<th>possible prenancy</th>
<th>next concive date</th>
<th>about animal</th>
</tr>

<tr ng-repeat="x in preglistid">
<td>{{x.anid}}</td>
<td>{{x.type}}</td>
<td>{{x.stringconcivedate}}</td>
<td>{{x.stringpossibledate}}</td>
<td>{{x.stringnextconcive}}</td>
<td><button class="btn btn-dark btn-sm" ng-click="aboutanimal(x.anid);" data-target="#aboutanimal" data-toggle="modal" >
detail</button>
 <br/>
<button class="btn btn-dark btn-sm" ng-click="deleteprg($index,'preglistid')">delete</button>
</td>
</tr>

</table>

  </div>
</div>


<div id="2" style="margin-left:8%;background-color:burlywood;width:85%;display:none;font-size:0.80em;">
<div style="text-align:center;">
<h1>search by type</h1>
<b>select animal type::</b><select ng-model="preg.type" ng-options="c for c in types" ng-change="bytype()"></select> 
 <button ng-click="bytype">search</button>
<br/>
</div>
<br/>
<div style="text-align:center;background-color:lightblue;padding-bottom:40px;padding-top:20px;"> 
<table border="1" align="center">
<tr ng-if="preglisttype.length>0">
<th>animal id</th>
<th>type</th>
<th>concive date</th>
<th>possible prenancy</th>
<th>next concive date</th>
<th>about animal</th>
</tr>

<tr ng-repeat="x in preglisttype">
<td>{{x.anid}}</td>
<td>{{x.type}}</td>
<td>{{x.stringconcivedate}}</td>
<td>{{x.stringpossibledate}}</td>
<td>{{x.stringnextconcive}}</td>
<td><button class="btn btn-dark btn-sm" ng-click="aboutanimal(x.anid);" data-target="#aboutanimal" data-toggle="modal" >
detail</button>
 <br/>
<button class="btn btn-dark btn-sm" ng-click="deleteprg($index,'preglisttype')">delete</button>
</td>
</tr>

</table>

  </div>
</div>


<div id="3" style="margin-left:8%;background-color:#d8bfd8;width:85%;display:none;font-size:0.80em;">
<div style="text-align:center;">
<br/>
<h4 style="color:white;background-color:black;display:inline;">search by concive date</h4> <br/> <br/>
<b>date example "05/04/2020"</b>
<input type="text" placeholder="day/month/year" ng-model="preg.concivedate" ng-keyup="byconcive()" placeholder="day/month/year"/> <button ng-click="byconcive2()">search</button>
<br/>
<br/>
<h4 style="color:white;background-color:black;display:inline;">search between two date</h4> <br/> <br/>
<b>date1::</b>
<input type="text" placeholder="day/month/year" ng-model="concivedatebt1"/> <b>date2::</b>
<input type="text" placeholder="day/month/year" ng-model="concivedatebt2"/>
<br/><br/>
<button ng-click="byconcivebt()">search</button>

<br/>

</div>
<br/>
<div style="text-align:center;background-color:cornsilk;padding-bottom:40px;padding-top:20px;"> 
<table border="1" align="center">
<tr ng-if="preglistconcive.length>0">
<th>animal id</th>
<th>type</th>
<th>concive date</th>
<th>possible prenancy</th>
<th>next concive date</th>
<th>about animal</th>
</tr>

<tr ng-repeat="x in preglistconcive">
<td>{{x.anid}}</td>
<td>{{x.type}}</td>
<td>{{x.stringconcivedate}}</td>
<td>{{x.stringpossibledate}}</td>
<td>{{x.stringnextconcive}}</td>
<td><button class="btn btn-dark btn-sm" ng-click="aboutanimal(x.anid);" data-target="#aboutanimal" data-toggle="modal" >
detail</button>
 <br/>
<button class="btn btn-dark btn-sm" ng-click="deleteprg($index,'preglistconcive')">delete</button>
</td>
</tr>
</table>
  </div>
  
</div>









<div id="4" style="margin-left:8%;background-color:#6f4e37;width:85%;display:none;font-size:0.80em;">
<div style="text-align:center;">
<br/>
<h4 style="color:white;background-color:black;display:inline;">search by pregnant date</h4> <br/> <br/>
<b style="color:white;">date example "05/04/2020"</b>
<input type="text" placeholder="day/month/year" ng-model="preg.pgdate" ng-keyup="bypregnant()" placeholder="day/month/year"/> <button ng-click="bypregnant2()">search</button>
<br/>
<br/>
<h4 style="color:white;background-color:black;display:inline;">search between two date</h4> <br/> <br/>
<b style="color:white;">date1::</b>
<input type="text" placeholder="day/month/year" ng-model="pgdatebt1"/> <b style="color:white;">date2::</b>
<input type="text" placeholder="day/month/year" ng-model="pgdatebt2"/>
<br/><br/>
<button ng-click="bypregnantbt()">search</button>

<br/>

</div>
<br/>
<div style="text-align:center;background-color:burlywood;padding-bottom:40px;padding-top:20px;"> 
<table border="1" align="center" id="t4">
 <tr ng-if="preglistpregnant.length>0">
<th>animal id</th>
<th>type</th>
<th>concive date</th>
<th>possible prenancy</th>
<th>next concive date</th>
<th>about animal</th>
</tr> 

<tr ng-repeat="x in preglistpregnant">
<td>{{x.anid}}</td>
<td>{{x.type}}</td>
<td>{{x.stringconcivedate}}</td>
<td>{{x.stringpossibledate}}</td>
<td>{{x.stringnextconcive}}</td>
<td><button class="btn btn-dark btn-sm" ng-click="aboutanimal(x.anid);" data-target="#aboutanimal" data-toggle="modal" >
detail</button>
 <br/>
<button class="btn btn-dark btn-sm" ng-click="deleteprg($index,'preglistpregnant')">delete</button>

</td>
</tr>
</table>
  </div>
</div>



<div id="5" style="margin-left:8%;background-color:burlywood;width:85%;display:none;font-size:0.80em;">
<div style="text-align:center;">
<h1>all record</h1>
<button ng-click="byall()">get all</button>
<br/>
</div>
<br/>
<div style="text-align:center;background-color:lightblue;padding-bottom:40px;padding-top:20px;"> 
<table border="1" align="center">
<tr ng-if="listbyall.length>0">
<th>animal id</th>
<th>type</th>
<th>concive date</th>
<th>possible prenancy</th>
<th>next concive date</th>
<th>about animal</th>
</tr>

<tr ng-repeat="x in listbyall">
<td>{{x.anid}}</td>
<td>{{x.type}}</td>
<td>{{x.stringconcivedate}}</td>
<td>{{x.stringpossibledate}}</td>
<td>{{x.stringnextconcive}}</td>
<td><button class="btn btn-dark btn-sm" ng-click="aboutanimal(x.anid);" data-target="#aboutanimal" data-toggle="modal" >
detail</button> <br/>
<button class="btn btn-dark btn-sm" ng-click="deleteprg($index,'listbyall')">delete</button>

</td>
</tr>

</table>

  </div>
</div>


 <div id="aboutanimal" class="modal fade" role="dialog" >
        <div class="modal-dialog" style="border-radius:10px;width:420px;">
        <div class="modal-content">
        <div class="modal-header" style="background-color:gray;">
        <button type="button" class="close" data-dismiss="modal" >&times;</button>
        <h4 class="modal-title">close</h4>
      </div>
<div class="modal-body" style="text-align:center;">
<img  style="height:150px;width:150px;"  src="<c:url value="/static/images/{{sa.filename}}" />" />

 <ul style="list-style-type:none;">
 <li>animal id:{{sa.anid}}</li>
 <li>animal type:{{sa.type}}</li>
 <li>animal source:{{sa.source}}</li>
 <li>animal price:{{sa.chest}}</li>
 <li>color:{{sa.color}}</li>
 <li>weight:{{sa.weight}}</li>
 <li>gender:{{sa.gender}}</li>
 </ul>
 <div class="modal-footer" style="background-color:gray;">
 
       </div>
     </div>
     </div>
     </div>
</div>
</body>
</html>