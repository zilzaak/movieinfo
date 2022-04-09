<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<title>find prescription</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="<c:url value="/static/theme/bootstrap431.css" /> " rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="<c:url value="/static/theme/jquery340.js" />" > </script> 
<script src="<c:url value="/static/theme/angular1.8.2.js" />" > </script>
<script src="<c:url value="/static/theme/bootstrap431.js" />" > </script>
<link  href="<c:url value="/static/theme/pregnant.css" /> " rel="stylesheet">
<script>
var module=angular.module("presapp",[]);
module.controller("prescontrol",function($scope,$http){


	$scope.checkdate=function(i){
		
		var count=0;
		for(var x=0;x<i.length;x++){
			if(i.charAt(x)=="/"){
				count++;
			}
			
		}
		
		return count;

	}
	
	$scope.drugtype=["syrup","drop","vaccine","tablet","antibiotic","dose","cream","seline"];

	$scope.update=function(r){
		var ds=	$scope.checkdate(r.stringstartingdate);
		var dl=	$scope.checkdate(r.stringlastdate);
		
		if(ds==2 && dl==2 && r.stringstartingdate.length>7 && r.stringlastdate.length>7 && r.drugname!="" && r.rules!=""){
			$http({
				method:"PUT",
				url:"${pageContext.request.contextPath}/searchpres/update", 
				data:angular.toJson(r),
				headers: {"Content-Type":"application/json"}
				}).then(function(response){
			
					alert(response.data.prestype);
					
				})	 
			
		}
		
		else{
			
			alert("error form"+ds+dl);
		}
		
		


	}	
	
	
	

	
	
$scope.bydoctorname=function(){

	
	 $http({
		method:"POST",
		url:"${pageContext.request.contextPath}/searchpres/bydoctorname", 
		data:$scope.doctorname,
		headers: {"Content-Type":"text/plain","responseType":"application/json"}
		}).then(function(response){
	
	
		$scope.listbydoctorname=response.data;
			

			});
			

}





$scope.bydrugname=function(){
	
	$http({
		method:"POST",
		url:"${pageContext.request.contextPath}/searchpres/bydrugname", 
		data:$scope.drugname,
		headers: {"Content-Type":"text/plain","responseType":"application/json"}
		}).then(function(response){
		
		$scope.listbydrugname=response.data;


		
		})	

}





$scope.bydrugtype=function(){
	$http({
		method:"POST",
		url:"${pageContext.request.contextPath}/searchpres/bydrugtype", 
		data:$scope.drugtypef,
		headers: {"Content-Type":"text/plain","responseType":"application/json"}
		}).then(function(response){
	
		$scope.listbydrugtype=response.data;

			
		})	

}

$scope.byallpres=function(){
	$http({
		method:"GET",
		url:"${pageContext.request.contextPath}/searchpres/byallpres", 
		headers: {"Content-Type":"text/plain","responseType":"application/json"}
		}).then(function(response){
	
		$scope.listbyallpres=response.data;

			
		})	

}

$scope.bydrugid=function(){
	$http({
		method:"POST",
		url:"${pageContext.request.contextPath}/searchpres/bydrugid", 
		data:angular.toJson($scope.drugid),
		headers: {"Content-Type":"application/json"}
		}).then(function(response){

if(response.data.rules=="no"){

	alert("no record found");
	
}
if(response.data.rules!="no"){
	
	$scope.listbydrugid=response.data;
	
}
			
		})	

}




$scope.bydateover=function(){
	
	$http({
		method:"GET",
		url:"${pageContext.request.contextPath}/searchpres/bydateover", 
		headers: {"Content-Type":"application/json"}
		}).then(function(response){
	
			if(response.data.length<1){
				alert("no record found");
			}
			else{
				
				$scope.listbydateover=response.data;
			}
			
		})	
	
	
	
}






$scope.byrunning=function(){
	
	$http({
		method:"GET",
		url:"${pageContext.request.contextPath}/searchpres/byrunning", 
		headers: {"Content-Type":"application/json"}
		}).then(function(response){
	
	if(response.data.length<1){
				alert("no record found");
			}
	else{
				$scope.listbyrunning=response.data;
				
			}
			
		})	
	
	
}





$scope.byanid=function(){

	
	 $http({
		method:"POST",
		url:"${pageContext.request.contextPath}/searchpres/byanid", 
		data:angular.toJson($scope.anid),
		headers: {"Content-Type":"application/json"}
		}).then(function(response){
	
	
		$scope.listbyanid=response.data;
			

			});
			

}

$scope.aboutanimal=function(i){
	$scope.f=i;
	$http({
		method:"POST",
		url:"${pageContext.request.contextPath}/search/byidd", 
		data:angular.toJson($scope.f),
		headers: {"Content-Type":"application/json"}
		}).then(function(response){
		$scope.sa=response.data;
	document.getElementById("halka").click();
	
		})	
	
}




$scope.deletepres=function(i,so){

	
	var nam = prompt("enter password to delete");	
	$http({
		method:"POST",
		url:"${pageContext.request.contextPath}/checkuser", 
		data:nam,
		headers: {"Content-Type":"text/plain","responseType":"application/json"}
		}).then(function(response){
	
	if(response.data.del=="ok"){
		
		var ask= window.confirm("want to delete this item??");
		
		if(ask){
		$scope.itemid=null;
if(so=="listbyrunning"){
	alert($scope.listbyrunning[i].drugname);
	$scope.itemid=$scope.listbyrunning[i].itemid;
	$scope.listbyrunning.splice(i,1);
		
	}		
				

if(so=="listbydateover"){

				$scope.itemid=$scope.listbyrunning[i].itemid;
					$scope.listbydateover.splice(i,1);
					
				}
				
				if(so=="listbyanid"){
	
					$scope.itemid=$scope.listbyrunning[i].itemid;
					$scope.listbyanid.splice(i,1);
					
				}	
				
				if(so=="listbydrugname"){
		
					$scope.itemid=$scope.listbyrunning[i].itemid;
					$scope.listbydrugname.splice(i,1);
					
				}	
				
				if(so=="listbydoctorname"){
				
					$scope.itemid=$scope.listbyrunning[i].itemid;
					$scope.listbydoctorname.splice(i,1);
					
				}	
				
				if(so=="listbydrugtype"){
				
					$scope.itemid=$scope.listbyrunning[i].itemid;
					$scope.listbydrugtype.splice(i,1);
					
			           	} 
				
				if(so=="listbyallpres"){
				
					$scope.itemid=$scope.listbyallpres[i].itemid;
					$scope.listbyallpres.splice(i,1);
					
			            	} 
				if(so=="listbydrugid"){
			
				$scope.itemid=$scope.listbydrugid;			
				
				               } 		
				
				
				$http({
					method:"POST",
					url:"${pageContext.request.contextPath}/delete/deletepresbyid", 
					data:angular.toJson($scope.itemid),
					headers: {"Content-Type":"application/json"}
					}).then(function(response){		
				alert(response.data.rules);
						
					});
				
				
		}			
		
			
	}
	
	if(response.data.del!="ok"){
		
		alert("wrong password");
	}
	
	
	})	
	

		
}



});





var dp=['1','2','3','4','5','6','7','8'];

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


table td:hover{
background-color:silver; color:green;

}

input:hover{
background-color:maroon; color:white;

}
table th{
word-break:break-all;
background-color:black;
color:white;
padding:8px;
}

table td{
word-break:break-all;
background-color:white;
color:black;
text-align:center;
}

a:hover{
background-color:steelblue;
color:white;
}


.dropdown-menu a:hover{
     background-color:steelblue;
            color:red;

           }

</style>

</head>

<body style="background-color:lightseagreen;" ng-controller="prescontrol"  ng-app="presapp">

<%

if(session.getAttribute("adminuser")==null && session.getAttribute("adminpass")==null){
	response.sendRedirect("${pageContext.request.contextPath}/");
	
	}

 %>


	  <nav class="navbar navbar-expand-lg" style="margin-right:7%;margin-left:8%;margin-top:2%;border-radius:8px;background-color:#ff7f50;">
  <a class="navbar-brand" href="#" style="margin-left:5%;color:white;">SEARCH THE PRESCRIPTION</a>
     <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon" style="color:white;"><b>click</b></span>
  </button> 
  <div class="collapse navbar-collapse" style="margin-left:10%;" id="navbarSupportedContent">
            <ul class="navbar-nav mr-auto">     
      <li class="nav-item dropdown"  style="margin-left:10%;">
        <a id="x" class="nav-link dropdown-toggle" style="margin-left:5%;color:white;" href="#"  role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
          search option
        </a>
        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
          <a class="dropdown-item" href="#" onclick="disit('1');">search by doctor name</a>
          <a class="dropdown-item" href="#" onclick="disit('2');">search by drug name</a>
          <a class="dropdown-item" href="#" onclick="disit('3');">record by drug type</a>
           <a class="dropdown-item" href="#" onclick="disit('4');">search by animal id</a>
          <a class="dropdown-item" href="#" onclick="disit('5');">running medicine</a>
          <a class="dropdown-item" href="#" onclick="disit('6');">date over prescription</a>
              <a class="dropdown-item" href="#" onclick="disit('7');">search by drug id</a>
               <a class="dropdown-item" href="#" onclick="disit('8');">all prescriptions</a>
          </div>
         </li>
               </ul>
  </div>
  
</nav>
<div  style="margin-left:8%;background-color:lightblue;width:85%;display:none;font-size:0.80em;text-align:center;padding-bottom:20px;" id="1">

<h4>Search by doctor name</h4>
<input type="text" ng-model="doctorname" ng-keyup="bydoctorname()" placeholder="doctor name" />
<br/><br/>
<table align="center" border="1">
<tr ng-if="listbydoctorname.length>0">
<th>animal id</th>
<th>drugname</th>
<th>type</th>
<th>started</th>
<th>last date</th>
<th>rules</th>
<th>instruction</th>
<th>operarion</th>
</tr>

<tr ng-repeat="x in listbydoctorname">
<td><input style="width:80px" type="number" ng-model="x.ap.anid" disabled />
<br/><br/>
<b style="color:maroon;" ng-click="aboutanimal(x.ap.anid)">more..</b>
</td>
<td><input style="width:80px" type="text" ng-model="x.drugname " /></td>
<td><input style="width:80px" type="text" ng-model="x.drugtype" /> 
<br/>
<b>change</b> <br/>
<select ng-options="c for c in drugtype" ng-model="x.drugtype" />
</td>
<td><input style="width:80px" type="text" ng-model="x.stringstartingdate" /></td>
<td><input style="width:80px" type="text" ng-model="x.stringlastdate" /></td>
<td><input style="width:110px" type="text" ng-model="x.rules" /></td>
<td><input style="width:110px" type="text" ng-model="x.instruction" /></td>
<td><button ng-click="update(x);" class="btn btn-dark btn-sm">update</button> <br/><br/>
<button ng-click="deletepres($index,'listbydoctorname');" class="btn btn-dark btn-sm">delete</button> </td>
</tr>
</table>


</div>
<div  style="margin-left:8%;background-color:lightblue;width:85%;display:none;font-size:0.80em;text-align:center;padding-bottom:20px;" id="2">
<h4>search by drug name</h4>

<input type="text" ng-model="drugname" ng-keyup="bydrugname()" placeholder="drug name" />

<br/><br/>

<table align="center" border="1">
<tr ng-if="listbydrugname.length>0">
<th>animal id</th>
<th>drugname</th>
<th>type</th>
<th>started</th>
<th>last date</th>
<th>rules</th>
<th>instruction</th>
<th>operation</th>
</tr>

<tr ng-repeat="x in listbydrugname">
<td><input style="width:80px" type="number" ng-model="x.ap.anid" disabled />
<br/>
<button style="color:maroon;" ng-click="aboutanimal(x.ap.anid)">more..</button>
</td>
<td><input style="width:80px" type="text" ng-model="x.drugname " /></td>
<td><input style="width:80px" type="text" ng-model="x.drugtype" /> 
<br/>
<b>change</b> <br/>
<select ng-options="c for c in drugtype" ng-model="x.drugtype" />
</td>
<td><input style="width:80px" type="text" ng-model="x.stringstartingdate" /></td>
<td><input style="width:80px" type="text" ng-model="x.stringlastdate" /></td>
<td><input style="width:110px" type="text" ng-model="x.rules" /></td>
<td><input style="width:110px" type="text" ng-model="x.instruction" /></td>
<td><button ng-click="update(x);" class="btn btn-dark btn-sm">update</button> <br/><br/>
<button ng-click="deletepres($index,'listbydrugname');" class="btn btn-dark btn-sm">delete</button> </td>
</tr>
</table>

</div>

<div  style="margin-left:8%;background-color:lightblue;width:85%;display:none;font-size:0.80em;text-align:center;text-align:center;padding-bottom:20px;" id="3">

<h4>search by drug type</h4>
<br/>
<select ng-options="c for c in drugtype" ng-model="drugtypef"  ng-change="bydrugtype()" >
</select>
<br/><br/>
<table align="center" border="1">
<tr ng-if="listbydrugtype.length>0">
<th>animal id</th>
<th>drugname</th>
<th>type</th>
<th>started</th>
<th>last date</th>
<th>rules</th>
<th>instruction</th>
<th>operation</th>
</tr>

<tr ng-repeat="x in listbydrugtype">
<td><input style="width:80px" type="number" ng-model="x.ap.anid" disabled />
<br/>
<button style="color:maroon;" ng-click="aboutanimal(x.ap.anid)">more..</button>
</td>
<td><input style="width:80px" type="text" ng-model="x.drugname " /></td>
<td><input style="width:80px" type="text" ng-model="x.drugtype" /> 
<br/>
<b>change</b> <br/>
<select ng-options="c for c in drugtype" ng-model="x.drugtype" />
</td>
<td><input style="width:80px" type="text" ng-model="x.stringstartingdate" /></td>
<td><input style="width:80px" type="text" ng-model="x.stringlastdate" /></td>
<td><input style="width:110px" type="text" ng-model="x.rules" /></td>
<td><input style="width:110px" type="text" ng-model="x.instruction" /></td>
<td><button ng-click="update(x);" class="btn btn-dark btn-sm">update</button> <br/><br/>
<button ng-click="deletepres($index,'listbydrugtype');" class="btn btn-dark btn-sm">delete</button></td>
</tr>
</table>

</div>


<div  style="margin-left:8%;background-color:lightblue;width:85%;display:none;font-size:0.80em;text-align:center;padding-bottom:20px;" id="4">


<h4>search by animal id</h4>
<input type="number" ng-model="anid" ng-keyup="byanid()"/>
<br/><br/>
<table align="center" border="1">
<tr ng-if="listbyanid.length>0">
<th>animal id</th>
<th>drugname</th>
<th>type</th>
<th>started</th>
<th>last date</th>
<th>rules</th>
<th>instruction</th>
<th>operation</th>
</tr>

<tr ng-repeat="x in listbyanid">
<td><input style="width:80px" type="number" ng-model="x.ap.anid" disabled />
<br/>
<button style="color:maroon;" ng-click="aboutanimal(x.ap.anid)">more..</button>
</td>
<td><input style="width:80px" type="text" ng-model="x.drugname " /></td>
<td><input style="width:80px" type="text" ng-model="x.drugtype" /> 
<br/>
<b>change</b> <br/>
<select ng-options="c for c in drugtype" ng-model="x.drugtype" />
</td>
<td><input style="width:80px" type="text" ng-model="x.stringstartingdate" /></td>
<td><input style="width:80px" type="text" ng-model="x.stringlastdate" /></td>
<td><input style="width:110px" type="text" ng-model="x.rules" /></td>
<td><input style="width:110px" type="text" ng-model="x.instruction" /></td>
<td><button ng-click="update(x);" class="btn btn-dark btn-sm">update</button> <br/><br/>
<button ng-click="deletepres($index,'listbyanid');" class="btn btn-dark btn-sm">delete</button></td>
</tr>
</table>
</div>

<div  style="margin-left:8%;background-color:lightblue;width:85%;display:none;font-size:0.80em;text-align:center;padding-bottom:20px;" id="5">

<h4>currently running medicine</h4>

<button class="btn btn-success btn-sm" ng-click="byrunning()">click to see</button>
<br/> <br/>
<table align="center" border="1">
<tr ng-if="listbyrunning.length>0">
<th>animal id</th>
<th>drugname</th>
<th>type</th>
<th>started</th>
<th>last date</th>
<th>rules</th>
<th>instruction</th>
<th>operation</th>
</tr>

<tr ng-repeat="x in listbyrunning">
<td><input style="width:80px" type="number" ng-model="x.ap.anid" disabled />
<br/>
<button style="color:maroon;" ng-click="aboutanimal(x.ap.anid)">more..</button>
</td>
<td><input style="width:80px" type="text" ng-model="x.drugname " /></td>
<td><input style="width:80px" type="text" ng-model="x.drugtype" /> 
<br/>
<b>change</b> <br/>
<select ng-options="c for c in drugtype" ng-model="x.drugtype" />
</td>
<td><input style="width:80px" type="text" ng-model="x.stringstartingdate" /></td>
<td><input style="width:80px" type="text" ng-model="x.stringlastdate" /></td>
<td><input style="width:110px" type="text" ng-model="x.rules" /></td>
<td><input style="width:110px" type="text" ng-model="x.instruction" /></td>
<td><button ng-click="update(x);" class="btn btn-dark btn-sm">update</button><br/><br/>
<button ng-click="deletepres($index,'listbyrunning');" class="btn btn-dark btn-sm">delete</button>
</td>
</tr>
</table>


</div>

<div  style="margin-left:8%;background-color:lightblue;width:85%;display:none;font-size:0.80em;text-align:center;padding-bottom:20px;" id="6">

<h4>date over prescription</h4>
<button class="btn btn-success btn-sm" ng-click="bydateover()">click to see</button>
<br/> <br/>
<table align="center" border="1">
<tr ng-if="listbydateover.length>0">
<th>animal id</th>
<th>drugname</th>
<th>type</th>
<th>started</th>
<th>last date</th>
<th>rules</th>
<th>instruction</th>
<th>operation</th>

</tr>

<tr ng-repeat="x in listbydateover">
<td><input style="width:80px" type="number" ng-model="x.ap.anid" disabled />
<br/>
<button style="color:maroon;" ng-click="aboutanimal(x.ap.anid)">more..</button>
</td>
<td><input style="width:80px" type="text" ng-model="x.drugname " /></td>
<td>
<br/>
<b>change</b> <br/>
<select ng-options="c for c in drugtype" ng-model="x.drugtype" />
</td>
<td><input style="width:80px" type="text" ng-model="x.stringstartingdate" /></td>
<td><input style="width:80px" type="text" ng-model="x.stringlastdate" /></td>
<td><input style="width:110px" type="text" ng-model="x.rules" /></td>
<td><input style="width:110px" type="text" ng-model="x.instruction" /></td>
<td><button ng-click="update(x);" class="btn btn-dark btn-sm">update</button> <br/><br/>
<button ng-click="deletepres($index,'listbydateover');" class="btn btn-dark btn-sm">delete</button>

</td>
</tr>
</table>
</div>



<div  style="margin-left:8%;background-color:lightblue;width:85%;display:none;font-size:0.80em;text-align:center;padding-bottom:20px;" id="7">

<h4>prescription by drug id</h4> <a><input type="number" ng-model="drugid"/></a>
<button class="btn btn-success btn-sm" ng-click="bydrugid()">click to see</button>
<br/> <br/>
<table align="center" border="1" >
<tr ng-if="listbydrugid!=null">
<th>animal id</th>
<th>drugname</th>
<th>type</th>
<th>started</th>
<th>last date</th>
<th>rules</th>
<th>instruction</th>
<th>operation</th>

</tr>

<tr ng-if="listbydrugid!=null">
<td><input style="width:80px" type="number" ng-model="listbydrugid.ap.anid" disabled />
<br/>
<button style="color:maroon;" ng-click="aboutanimal(listbydrugid.ap.anid)">more..</button>
</td>
<td><input style="width:80px" type="text" ng-model="listbydrugid.drugname" /></td>
<td>
<br/>
<b>change</b> <br/>
<select ng-options="c for c in drugtype" ng-model="listbydrugid.drugtype" />
</td>
<td><input style="width:80px" type="text" ng-model="listbydrugid.stringstartingdate" /></td>
<td><input style="width:80px" type="text" ng-model="listbydrugid.stringlastdate" /></td>
<td><input style="width:110px" type="text" ng-model="listbydrugid.rules" /></td>
<td><input style="width:110px" type="text" ng-model="listbydrugid.instruction" /></td>
<td><button ng-click="update(listbydrugid);" class="btn btn-dark btn-sm">update</button> <br/><br/>
<button ng-click="deletepres($index,'listbydrugid');" class="btn btn-dark btn-sm">delete</button>

</td>
</tr>
</table>
</div>



<div  style="margin-left:8%;background-color:lightblue;width:85%;display:none;font-size:0.80em;text-align:center;padding-bottom:20px;" id="8">

<h4>all prescription</h4>
<button class="btn btn-success btn-sm" ng-click="byallpres()">click to see</button>
<br/> <br/>
<table align="center" border="1">
<tr ng-if="listbyallpres.length>0">
<th>animal id</th>
<th>drugname</th>
<th>type</th>
<th>started</th>
<th>last date</th>
<th>rules</th>
<th>instruction</th>
<th>operation</th>

</tr>

<tr ng-repeat="x in listbyallpres">
<td><input style="width:80px" type="number" ng-model="x.ap.anid" disabled />
<br/>
<button style="color:maroon;" ng-click="aboutanimal(x.ap.anid)">more..</button>
</td>
<td><input style="width:80px" type="text" ng-model="x.drugname " /></td>
<td>
<br/>
<b>change</b> <br/>
<select ng-options="c for c in drugtype" ng-model="x.drugtype" />
</td>
<td><input style="width:80px" type="text" ng-model="x.stringstartingdate" /></td>
<td><input style="width:80px" type="text" ng-model="x.stringlastdate" /></td>
<td><input style="width:110px" type="text" ng-model="x.rules" /></td>
<td><input style="width:110px" type="text" ng-model="x.instruction" /></td>
<td><button ng-click="update(x);" class="btn btn-dark btn-sm">update</button> <br/><br/>
<button ng-click="deletepres($index,'listbyallpres');" class="btn btn-dark btn-sm">delete</button>

</td>
</tr>
</table>
</div>








<button data-target="#aboutanimal" data-toggle="modal" style="display:none;" id="halka">okkk</button>
 <div id="aboutanimal" class="modal fade" role="dialog" >
        <div class="modal-dialog" style="border-radius:10px;width:420px;margin-left:50px;">
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