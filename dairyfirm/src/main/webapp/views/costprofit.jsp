<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<title>cost and profit</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="<c:url value="/static/theme/bootstrap431.css" /> " rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="<c:url value="/static/theme/jquery340.js" />" > </script> 
<script src="<c:url value="/static/theme/angular1.8.2.js" />" > </script>
<script src="<c:url value="/static/theme/bootstrap431.js" />" > </script>

<script>
var module=angular.module("dailyapp",[]);
module.controller("dailycontrol",function($scope,$http){
	$scope.types=['খাবার','ঘর','অন্যান্য ']
	$scope.cd=""; $scope.cm=""; $scope.cy="";
	$scope.days=['01','02','03','04','05','06','07','08','09','10','11','12','13','14','15','16','17','18','19','20','21','22','23','24','25','26',
		'27','28','29','30','31'];
	$scope.month=['01','02','03','04','05','06','07','08','09','10','11','12'];
	$scope.year=[];
$scope.rectitle="";
	$scope.inityear=function(){
		for(var k=1900;k<=3000;k++){
			
			$scope.year.push(k);
	                     }
	                         }
	

	
	$scope.std="";
$scope.dailycost=[];
var cost1={"type":"","itemname":"","amount":"","cost":null,"stringcostdate":"" };
var cost2={"type":"","itemname":"","amount":"","cost":null,"stringcostdate":"" };
var cost3={"type":"","itemname":"","amount":"","cost":null,"stringcostdate":"" };
$scope.dailycost.push(cost1);
$scope.dailycost.push(cost2);
$scope.dailycost.push(cost3);
$scope.deletecost=function(i){
	
	$scope.dailycost.splice(i,1);
}
$scope.addcost=function(){
	var c={"type":"","itemname":"","amount":"","cost":null,"stringcostdate":"" };
	$scope.dailycost.push(c);
}
$scope.removecost=function(){
	var length=$scope.dailycost.length;
	if(length>1){
		$scope.dailycost.splice(length-1,1);	
	}
	else{
		alert("can not remove");
	}
	
}

$scope.setcostdate=function(){
	
	$scope.std=$scope.cd+"/"+$scope.cm+"/"+$scope.cy;	

                      }

$scope.clearaftersave=function(){
	$scope.cd="";	$scope.cm="";	$scope.cy="";
	angular.forEach($scope.dailycost,function(v,i){
		v.itemname="";   v.amount="",v.cost=null; v.stringcostdate="";

	
	})
	
	
}



$scope.dailycostkeyup=function(){

	 $http({
			method:"GET", 
			url:"${pageContext.request.contextPath}/costprofit/costrecord",
			headers: {"Content-Type":"application/json"}
				}).then(function(response){
$scope.dailycostrecord=response.data;
$scope.calcul();
$scope.costtitle="all record";	
	             	}) 
	
                      }
                      
             $scope.ttdd=0;         
$scope.calcul=function(){
	   $scope.ttdd=0; 
	angular.forEach($scope.dailycostrecord,function(v,i){
		  $scope.ttdd=  $scope.ttdd+v.cost;
	
	})	
	
}


$scope.tdc=0;
$scope.today=function(){
	  $scope.tdc=0;
	  
	 $http({
			method:"GET", 
			url:"${pageContext.request.contextPath}/costprofit/today",
			headers: {"Content-Type":"application/json"}
				}).then(function(response){

                 $scope.dc=response.data;
             	angular.forEach($scope.dc,function(v,i){
          		  $scope.tdc=  $scope.tdc+v.cost;
          	
          	             })
                   
	             	}) 
	             	
	             	
	
}



$scope.alldailycost=function(){
	 $http({
			method:"GET", 
			url:"${pageContext.request.contextPath}/costprofit/costrecord",		
			headers: {"Content-Type":"application/json"}
				}).then(function(response){
					if(response.data.length<1){
						alert("no record found")
					}
					if(response.data.length>0){
						$scope.dailycostrecord=response.data;
						$scope.calcul();
							  $scope.costtitle="all record";
					}

	    
				}) 
	
}




$scope.dailycostbt=function(){
	
var f=[$scope.cd1,$scope.cd2];

var er1=$scope.checkdate(f[0]);
var er2 = $scope.checkdate(f[1]);

if(er1==2 && er2==2 && f[0].length>7 && f[1].length>7){
 $http({
			method:"POST", 
			url:"${pageContext.request.contextPath}/costprofit/dailycostbt",	
			data:angular.toJson(f),
			headers: {"Content-Type":"application/json"}
				}).then(function(response){
$scope.dailycostrecord=response.data;
$scope.calcul();
$scope.costtitle="record between two date";
	 
	    
				})  	
}
	


if(er1!=2 || er2!=2 || f[0].length<8 || f[1].length<8 ){
	alert("wrong date format");
}
	

	
}



$scope.cfitem=function(){
	$scope.ftc.stringcostdate="";
	
	 $http({
			method:"POST", 
			url:"${pageContext.request.contextPath}/costprofit/cfitem",
			data:$scope.ftc.itemname,
			headers: {"Content-Type":"text/plain","Response-Type":"application/json"}
				}).then(function(response){
$scope.dailycostrecord=response.data;
$scope.calcul();
$scope.costtitle="record related to item name";
	             	}) 
	             	
}

$scope.cfdate=function(){
	$scope.ftc.itemname="";
	
	 $http({
			method:"POST", 
			url:"${pageContext.request.contextPath}/costprofit/cfdate",
			data:$scope.ftc.stringcostdate,
			headers: {"Content-Type":"text/plain","Response-Type":"application/json"}
				}).then(function(response){
              $scope.dailycostrecord=response.data;
                       $scope.calcul();
                       $scope.costtitle="record related to date";
	             	}) 
	
}




$scope.deletedc=function(i,dc){
	
	var ps1=window.confirm("delete this record?");
	if(ps1){
		var ps2=window.confirm("really are you sure to delete??");	
		if(ps2){
			
			
			
			
		var passdc = prompt("enter password to confirm delete");
		
		$http({
			method:"POST",
			url:"${pageContext.request.contextPath}/checkuser",
			data:passdc,
			headers: {"Content-Type":"plain/text","Response-Type":"application/json"}}).
		    then(function(response){
		 	if(response.data.del=="ok"){
		 		
				$http({
					method:"DELETE",
					url:"${pageContext.request.contextPath}/delete/deletedailycost",
					data:angular.toJson(dc) ,
					headers: {"Content-Type":"application/json"}}).
				    then(function(response){
				 	  
				 alert("successfully deleted");	   
				 	  $scope.dailycostrecord.splice(i,1);
		                 $scope.calcul();	
		                 
				        })		
		 				 			 		
		 	}
			if(response.data.del=="no"){   alert("can not delete , password is wrong") }	 	
		 	
		 	
		 		
		    });
		
		
		
		
		
		
		}
		
	}	
	
}


$scope.checkdate=function(i){
	
	var count=0;
	for(var x=0;x<i.length;x++){
		if(i.charAt(x)=="/"){
			count++;
		}
		
	}
	
	return count;

}



$scope.updatedailycost=function(i){
	var errl="";
	var errformat="";
	var priceerr="";
	var itemnameerr="";
var d =	$scope.checkdate($scope.dailycostrecord[i].stringcostdate);
if(d!=2){
	errformat="wrong date format , use 'day/month/year'";
}

if($scope.dailycostrecord[i].stringcostdate.length!=10){
	errl="use 2 digit for day & month ,";
}

if($scope.dailycostrecord[i].cost==null){
	var priceerr="empty cost,";
}
if($scope.dailycostrecord[i].itemname==""){
	var itemnameerr="empty item name,";
}



if(errl!="" || errformat!="" || $scope.dailycostrecord[i].itemname==="" || $scope.dailycostrecord[i].cost==null){
	
	alert(errl+errformat+priceerr+itemnameerr);
}


if(errl=="" && errformat=="" &&  $scope.dailycostrecord[i].itemname!=""  &&  $scope.dailycostrecord[i].cost!=null){
    $http({
		method:"PUT", 
		url:"${pageContext.request.contextPath}/costprofit/updatecost",
		data:angular.toJson($scope.dailycostrecord[i]),
		headers: {"Content-Type":"application/json"}
			}).then(function(response){
				  $scope.calcul();
alert("successfully updated record");
	
             	})  
	
                 }

	             	
	
}




$scope.updatedailycost2=function(i){
	var errl="";
	var errformat="";
	var priceerr="";
	var itemnameerr="";
var d =	$scope.checkdate($scope.dc[i].stringcostdate);
if(d!=2){
	errformat="wrong date format , use 'day/month/year'";
}

if($scope.dc[i].stringcostdate.length!=10){
	errl="use 2 digit for day & month ,";
}

if($scope.dc[i].cost==null){
	var priceerr="empty cost,";
}
if($scope.dc[i].itemname==""){
	var itemnameerr="empty item name,";
}



if(errl!="" || errformat!="" || $scope.dc[i].itemname==="" || $scope.dc[i].cost==null){
	
	alert(errl+errformat+priceerr+itemnameerr);
}


if(errl=="" && errformat=="" && $scope.dc[i].itemname!=""  && $scope.dc[i].cost!=null){
    $http({
		method:"PUT", 
		url:"${pageContext.request.contextPath}/costprofit/updatecost",
		data:angular.toJson($scope.dc[i]),
		headers: {"Content-Type":"application/json"}
			}).then(function(response){
				$scope.today();
alert("successfully updated record");
	
             	})  
	
                 }

	             	
	
}












$scope.savecost=function(){
	var err="no";
angular.forEach($scope.dailycost,function(v,i){
if(v.itemname=="" || v.amount=="" || v.cost==null || $scope.cd==""	|| $scope.cm=="" ||	$scope.cy==""){
		err="ye";
		        	} 
else{
	v.stringcostdate=$scope.std;
}

		
	})
		
	if(err=="no"){
		
	
		 $http({
			method:"POST", 
			url:"${pageContext.request.contextPath}/costprofit/saveit",
			data:angular.toJson($scope.dailycost),
			headers: {"Content-Type":"application/json"}
				}).then(function(response){
		
					alert(response.data[0].itemname);	
		           $scope.clearaftersave();
		
		})  
		
		}
	
	else{
		
 alert("sorry!! error in form");
		
	}

}



var cps={"tcostanimal":"","tcostdaily":"","tcost":"","tsellcow":"","tsellmilk":"","tprofit":"","tsold":"",
		"dueinmilk":"","dueincow":"","totaldue":""}

$scope.thisab=function(){
	$http({
		method:"POST", 
		url:"${pageContext.request.contextPath}/costprofit/thisab",
		data:angular.toJson(cps),
		headers: {"Content-Type":"application/json"}
			}).then(function(response){
			
	$scope.cp=response.data;
document.getElementById('pophisab').click();	

	       })	
	
	
}


$scope.m=""; $scope.y=""; $scope.d="";
 $scope.d2;  $scope.m2; $scope.y2;
 
 
 $scope.profitcowim=0; $scope.profitmilkim=0; $scope.costdailyim=0;$scope.tprofitim=0;
 $scope.profitcowon=0; $scope.profitmilkon=0; $scope.costdailyon=0;$scope.tprofiton=0;
 $scope.profitcowbt=0; $scope.profitmilkbt=0; $scope.costdailybt=0;$scope.tprofitbt=0;
 
 $scope.calculscp=function(v){
	 if(v=='on'){
	 	 $scope.profitcowon=0; $scope.profitmilkon=0; $scope.costdailyon=0; 
	 	 angular.forEach($scope.scp.dc,function(v,i){
	 	 	
	 		 $scope.costdailyon=$scope.costdailyon+v.cost;
	 		 
	 		 });
	 		 	
	 		 angular.forEach($scope.scp.sm,function(v,i){
	 		 	
	 		 $scope.profitmilkon=$scope.profitmilkon+v.totalprice;
	 		 
	 		 });
	 		 
	 		  angular.forEach($scope.scp.sc,function(v,i){
	 		 	
	 			  $scope.profitcowon=$scope.profitcowon+v.sellprice;
	 		 
	 		 });
	 		  
	 		 $scope.tprofiton=$scope.profitcowon+ $scope.profitmilkon-$scope.costdailyon;
	 
	           }
	 
	 
	 
	 if(v=='im'){
	 	 $scope.profitcowim=0;  $scope.profitmilkim=0; $scope.costdailyim=0; 
	 	 angular.forEach($scope.scp.dc,function(v,i){
	 	 	
	 		 $scope.costdailyim=$scope.costdailyim+v.cost;
	 		 
	 		 });
	 		 	
	 		 angular.forEach($scope.scp.sm,function(v,i){
	 		 	
	 		 $scope.profitmilkim=$scope.profitmilkim+v.totalprice;
	 		 
	 		 });
	 		 
	 		  angular.forEach($scope.scp.sc,function(v,i){
	 		 	
	 			  $scope.profitcowim=$scope.profitcowim+v.sellprice;
	 		 
	 		 });	 
	 		  
	 		  $scope.tprofitim=$scope.profitcowim+ $scope.profitmilkim-$scope.costdailyim;
	 	 
		 
	 }
	 
	 
 if(v=='bt'){
 	 $scope.profitcowbt=0;  $scope.profitmilkbt=0; $scope.costdailybt=0;
 	 angular.forEach($scope.scp.dc,function(v,i){
 	 	
 		 $scope.costdailybt=$scope.costdailybt+v.cost;
 		 
 		 });
 		 	
 		 angular.forEach($scope.scp.sm,function(v,i){
 		 	
 		 $scope.profitmilkbt=$scope.profitmilkbt+v.totalprice;
 		 
 		 });
 		 
 		  angular.forEach($scope.scp.sc,function(v,i){
 		 	
 			  $scope.profitcowbt=$scope.profitcowbt+v.sellprice;
 		 
 		 }); 
 		
 		 $scope.tprofitbt=$scope.profitcowbt+ $scope.profitmilkbt-$scope.costdailybt;
		 
	 } 
	 

 }

 
 
 
 
$scope.inamonth=function(){
	
	var s=[];
	s[0]=$scope.mim;
	s[1]=$scope.yim;
	
	$http({
		method:"POST", 
		url:"${pageContext.request.contextPath}/costprofit/inamonth",
		data:angular.toJson(s),
		headers: {"Content-Type":"application/json"}
			}).then(function(response){
				
		$scope.scp=response.data;
		$scope.calculscp('im');
		$scope.rectitle="cost & profit in a particular month";
	       })			
	
}


$scope.inbetween=function(){
	
	var x =$scope.dbt1+"/"+$scope.mbt1+"/"+$scope.ybt1;
	var y=$scope.dbt2+"/"+$scope.mbt2+"/"+$scope.ybt2;
	var s=[x,y];
	
	$http({
		method:"POST", 
		url:"${pageContext.request.contextPath}/costprofit/inbetween",
		data:angular.toJson(s),
		headers: {"Content-Type":"application/json"}
			} ).then(function(response){
			
		$scope.scp=response.data;
		$scope.calculscp('bt');
		$scope.rectitle="cost & profit between two date";
	       })		
	
	
}




$scope.inadate=function(){
	
	$scope.d1=$scope.d+"/"+$scope.m+"/"+$scope.y;
	
	$http({
		method:"POST", 
		url:"${pageContext.request.contextPath}/costprofit/inadate",
		data:$scope.d1,
		headers: {"Content-Type":"text/plain","Response-Type":"application/json"}
			} ).then(function(response){

		$scope.scp=response.data;
		$scope.calculscp('on');
		$scope.rectitle="cost & profit in a date";

	       })	
	
	
}






})



function disit(a,b,c,d,e,f,g){
	
	document.getElementById(a).style.display="block";
	document.getElementById(b).style.display="none";
		document.getElementById(c).style.display="none";
			document.getElementById(d).style.display="none";
				document.getElementById(e).style.display="none";
					document.getElementById(f).style.display="none";
						document.getElementById(g).style.display="none";					
}
</script>



<style>
a:hover{
background-color:steelblue;

}


.dropdown-menu a:hover{
background-color:steelblue;

}
table td:hover{
background-color:silver; color:green;

}

input:hover{
background-color:maroon; color:white;

}
table th{
word-break:breal-all;
background-color:black;
color:white;
padding:5px;"

}
table td{
word-break:breal-all;
background-color:white;
color:black;

}

body{
background-image:url("/static/theme/pond1.jpeg");
background-size:1200px 500px;
}
</style>

</head>
<body  ng-controller="dailycontrol"  ng-app="dailyapp"  ng-init="inityear();">

<%
if(session.getAttribute("adminuser")==null && session.getAttribute("adminpass")==null){
	response.sendRedirect("${pageContext.request.contextPath}");
	}

	  %>
	  <nav class="navbar navbar-expand-lg" style="margin-right:7%;margin-left:8%;margin-top:2%;border-radius:8px;background-color:#6f4e37;">
  <a class="navbar-brand" href="#" style="margin-left:5%;color:white;">COST AND BENIFIT</a>
   <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon" style="color:white;"><b>click</b></span>
  </button> 
   <div class="collapse navbar-collapse" id="navbarSupportedContent" style="margin-left:6%;">
    <ul class="navbar-nav mr-auto">     
      <li class="nav-item dropdown"  style="margin-left:6%;">
        <a class="nav-link dropdown-toggle" style="margin-left:5%;color:white;" href="#"  role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
         total cost & profit
        </a>
        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
      <a class="dropdown-item" href="#"  ng-click="thisab();">total cost,profit</a>
 
         </li>
           <li class="nav-item dropdown"  style="margin-left:6%;">
        <a class="nav-link dropdown-toggle" style="margin-left:5%;color:white;" href="#"  role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
         todays cost
        </a>
        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
      <a class="dropdown-item" href="#"  ng-click="today();" data-target="#todaymodal" data-toggle="modal" >todays cost</a>
 
         </li>
        <li class="nav-item dropdown"  style="margin-left:6%;">
        <a class="nav-link dropdown-toggle" style="margin-left:5%;color:white;" href="#"  role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
          search cost & profit
        </a>
        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
          <a class="dropdown-item" href="#" onclick="disit('1','2','3','7')">cost & profit in a month</a>
             <a class="dropdown-item" href="#" onclick="disit('2','3','7','1')">cost & profit between two date</a>
          <a class="dropdown-item" href="#" onclick="disit('3','7','1','2')">cost & profit in a date</a></div>
           </li>       
                
       <li class="nav-item dropdown" style="margin-left:6%;color:green;">
        <a  class="nav-link dropdown-toggle" href="#" style="margin-left:6%;color:white;" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
          Daily cost
        </a>
        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
          <a class="dropdown-item" href="#" onclick="disit('7','1','2','3');">add daily cost</a>
          <a class="dropdown-item" href="#" data-target="#costfilt" data-toggle="modal"  ng-click="dailycostkeyup();" >search daily cost</a>
        </div>
      </li>
         </ul>
  </div>
</nav>



<div id="1" style="margin-left:8%;background-color:lightblue;width:85%;display:none;font-size:0.80em;">
<div style="text-align:center;">
<h1>cost & profit of a month</h1>
<b>select month</b><select ng-model="mim" ng-options="c for c in month"></select> 
<b>select year</b><select ng-model="yim" ng-options="c for c in year"></select> <button ng-click="inamonth()">search</button>
<br/>
</div>
<br/>
<div style="text-align:center;background-color:ghostwhite;padding-bottom:15px;"> 
<h4 style="color:pink;">{{rectitle}}</h4> <br/>
<b style="color:maroon;">milk sold-></b>{{profitmilkim}} <br/>
  <b style="color:maroon;">cow sold-></b>{{profitcowim}} <br/>
  <b style="color:maroon;">daily cost-></b> {{costdailyim}} <br/>
    <b style="color:green;background-color:white;">profit = (milk sold+ cow sold) - daily cost=</b>{{tprofitim}} <br/>
  </div>
</div>

<div id="3" style="margin-left:8%;background-color:lightblue;width:85%;display:none;font-size:0.80em;">

<div style="text-align:center;margin-bottom:10px;">
<h1>cost & profit in a date</h1>
<b>enter date::</b> <b>day/month/year</b><select ng-model="d" ng-options="c for c in days"></select>
<select ng-model="m" ng-options="c for c in month"></select>
<select ng-model="y" ng-options="c for c in year"></select> <br/><br/>
<button ng-click="inadate();">search</button>
</div>
<br/>
<div style="text-align:center;background-color:darkcyan;padding-bottom:15px;">
<h4 style="color:blue;">cost & profit in a date</h4> <br/>
 <b style="color:maroon;">milk sold-></b>{{profitmilkon}} <br/>
  <b style="color:maroon;">cow sold-></b>{{profitcowon}} <br/>
  <b style="color:maroon;">daily cost-></b>{{costdailyon}}<br/>
    <b style="color:blue;background-color:white">profit = (milk sold+ cow sold) - daily cost=</b> {{tprofiton}} <br/>
  </div>
 
</div>


<div id="2" style="margin-left:8%;background-color:lightblue;width:85%;display:none;font-size:0.80em;">
<div style="text-align:center;margin-bottom:10px;">
<h1>cost & profit between two date</h1> <br/>
<b>1st date::</b> <b>day/month/year</b><select ng-model="dbt1" ng-options="c for c in days"></select>
<select ng-model="mbt1" ng-options="c for c in month"></select><select ng-model="ybt1" ng-options="c for c in year"  ></select> <br/><br/>

<b>2nd date::</b> <b>day/month/year</b><select ng-model="dbt2" ng-options="c for c in days"></select>
<select ng-model="mbt2" ng-options="c for c in month"></select><select ng-model="ybt2" ng-options="c for c in year"></select> <br/><br/>
<button ng-click="inbetween();">search</button>
</div>
<br/>
<div style="text-align:center;background-color:burlywood;padding-bottom:15px;"> <h4 style="color:maroon;">
<h4 style="color:green;">cost & profit between two date</h4> <br/>
 <b style="color:maroon;">milk sold-></b>{{profitmilkbt}} <br/>
  <b style="color:maroon;">cow sold-></b>{{profitcowbt}} <br/>
  <b style="color:maroon;">daily cost-></b>{{costdailybt}}<br/>
    <b style="color:purple;background-color:white;">profit = (milk sold+ cow sold) - daily cost=</b> {{tprofitbt}} <br/>
  </div>
</div>








<div id="costfilt"  class="modal fade" role="dialog" >
  <div class="modal-dialog" style="margin-left:100px;" >
       <!-- Modal content-->
  <div class="modal-content" style="width:650px;font-size:0.80em;">
  <div class="modal-header" style="background-color:gray;">
  <button type="button" class="close" data-dismiss="modal">&times;</button>
  <h4 class="modal-title">filter</h4>
  </div>
  <div class="modal-body" style="text-align:center;">
  <script>
  function takeval(){
	  
	  var d = document.getElementById("cs").value;
	  var asd=["x","y","z","w"];
	  
	  for(var i=0;i<asd.length;i++){
		  
		  if(asd[i]==d){
			  document.getElementById(d).style.display="block";  
		  }
		  if(asd[i]!=d){
			  
			  document.getElementById(asd[i]).style.display="none";   
		  }
		  
	  }
	  
	  
  }
  </script>
<b>select search option:</b><select name="cs" id="cs" onchange="takeval()">
<option value="--">---</option>
<option value="x">get all record</option>
<option value="y">search by item name</option>
<option value="z">search between two date</option>
<option value="w">search by a date</option>
</select>
  <br/><br/>
  
  <div style="background-color:green;padding:8px;display:none;" id="x">
  <button class="btn btn-dark btn-sm" ng-click="alldailycost();">get all record</button>
  </div>
  
  <div id="y" style="background-color:skyblue;padding:8px;display:none;">
 
  <input type="text" ng-model="ftc.itemname"   ng-keyup="cfitem();" placeholder="item name"  />
  </div>
  
  <div id="z" style="background-color:darkslategrey;color:white;padding:8px;display:none;">
   
 <span><b>1st date:</b><input type="text" placeholder="day/month/year" ng-model="cd1" />
     <b>2nd date:</b><input type="text" placeholder="day/month/year" ng-model="cd2" /> </span><br/><br/>
     <button ng-click="dailycostbt()">search</button> 
   </div>
   
   <div id="w" style="background-color:gray;padding:8px;display:none;">
    filter by date( day/month/year):: <br/>
   <input  type="text" ng-model="ftc.stringcostdate" placeholder="day/month/year"  ng-keyup="cfdate();"  /> <br/><br/>
   <b>use 2 digit for day ,example:: 07 ,11 etc </b><br/>
   <b>use 2 digit for month, example: 01 for january, 03 for March </b> </div>
  
  
  <div style="background-color:darkslategrey;color:white;">
    <span><b>total price:: {{ttdd}} </b></span><br/>
    <b>( {{costtitle}} )</b>
    <br/>
  </div>

<table border="1" style="text-align:center;">
<tr ng-if="dailycostrecord.length>0" >
<th >record no</th>
<th >item type</th>
<th >item name</th>
<th > amount</th>
<th>buying date</th>
<th >cost(TaKa)</th>
<th>task</th>
</tr>
<tr ng-repeat="x in dailycostrecord" style="width:110%">
<td>{{$index+1}}

</td>
<td><select ng-model="x.type" ng-options="c for c in types">
</select></td>
<td><input style="width:100%;" type="text" ng-model="x.itemname" /></td>
<td><input style="width:80px;" type="text" ng-model="x.amount" /></td>
<td><input style="width:80px;" type="text" ng-model="x.stringcostdate"  placeholder="day/month/year"/></td>
<td><input style="width:100px;" type="number" ng-model="x.cost"/></td>
<td>
<br/>
<button class="btn  btn-dark btn-sm" ng-click="updatedailycost($index)">update</button> <br/>
<br/>
<button class="btn btn-danger btn-sm " ng-click="deletedc($index,x)">delete</button> <br/>
</td>
</tr>
</table>

  <div class="modal-footer">
   <button  class="btn btn-default" data-dismiss="modal">Close</button>
      </div>
    </div>

  </div>
</div> 
</div>




<div  style="margin-left:8%;background-color:lightblue;width:85%;display:none;font-size:0.80em;" id="7">
	<br/><br/>

<div class="row">

<div class="col col-sm-2" style="text-align:center;">
<button ng-click="addcost()" class="btn btn-sm btn-info">add row</button>
<br/>
<br/>

<button ng-click="removecost()" class="btn btn-sm btn-dark" >remove</button>
<br/>
<br/>

<button ng-click="savecost()" class="btn btn-sm btn-success" style="width:65px">save</button>

</div>

<div class="col col-md-10">
<b>buying date::</b>
<span>
<b>day</b>
<select ng-model="cd" ng-options="c for c in days" ng-change="setcostdate()"></select>
<b>month</b>
<select ng-model="cm" ng-options="c for c in month" ng-change="setcostdate()"></select>
<b>year</b>
<select ng-model="cy" ng-options="c for c in year" ng-change="setcostdate()"></select>
</span>
<br/><br/>
<table border="1" style="text-align:center;margin-left:25px;">
<tr>
<th>record no</th>
<th>Cost type</th>
<th>item name</th>
<th>amount</th>
<th>cost(TaKa)</th>
</tr>
<tr ng-repeat="x in dailycost">
<td>{{$index+1}}<br/>
<button class="btn btn-sm btn-danger" ng-click="deletecost($index)">delete</button>
</td>
<td><select ng-model="x.type" ng-options="c for c in types">
</select></td>
<td><input type="text" ng-model="x.itemname" /></td>
<td><input type="text" ng-model="x.amount" /></td>

<td><input type="number" ng-model="x.cost"/></td>
</tr>
</table>
</div>

</div>
	<br/><br/>
</div>




  <button data-toggle="modal" data-target="#tcpmodal" id="pophisab" style="display:none;"></button>
 
  <div id="tcpmodal" class="modal fade" role="dialog" >
  <div class="modal-dialog"  >
       <!-- Modal content-->
  <div class="modal-content" style="width:500px;font-size:0.80em;">
  <div class="modal-header" style="background-color:gray;">
  <button type="button" class="close" data-dismiss="modal">&times;</button>
  <h4 class="modal-title">cost & profit</h4>
  </div>
  <div class="modal-body" style="text-align:center;">

<h4>total Cost</h4> <br/>
<ul style="list-style-type:none;padding:5px;">
<li style="background-color:maroon;color:white"><b style="color:gold;">animal buying cost -></b>{{cp.tcostanimal}} tk</li>
<li style="background-color:steelblue;color:white;"><b style="color:gold;">food,medicine,firm cost -></b>{{cp.tcostdaily}}tk</li>
<li style="background-color:maroon;color:white;"><b style="color:gold;">total cost=</b>{{cp.tcost}} tk</li>
</ul>
<br/>
<h4>total sell</h4> <br/>
<ul style="list-style-type:none;padding:5px;">
<li style="background-color:maroon;color:white"><b style="color:gold;">animal sold -></b>{{cp.tsellcow}} tk</li>
<li style="background-color:steelblue;color:white;"><b style="color:gold;">milk sold -></b>{{cp.tsellmilk}} tk</li>
<li style="background-color:maroon;color:white;"><b style="color:gold;">total sold=</b>{{cp.tsold}} tk</li>
</ul>
<br/>
<h4>due amount in sell</h4> <br/>
<ul style="list-style-type:none;padding:5px;">
<li style="background-color:maroon;color:white"><b style="color:gold;">due in milk sell -></b>{{cp.dueinmilk}} tk</li>
<li style="background-color:steelblue;color:white;"><b style="color:gold;">due in cow sell -></b>{{cp.dueincow}} tk</li>
<li style="background-color:maroon;color:white;"><b style="color:gold;">you will get from customer=</b>{{cp.totaldue}} tk</li>
</ul>

<br/>
<h4 style="color:darkslategrey;">total profit ( due amount is included in this profit)</h4> <br/>
<ul style="list-style-type:none;">
<li style="color:maroon;"><b>total profit in taka =totalsell-totalcost=</b>{{cp.tprofit}} tk</li>
</ul>
   </div>
  <div class="modal-footer">
   <button  class="btn btn-default" data-dismiss="modal">Close</button>
      </div>
    </div>

  </div>
</div>   
    

  <div id="todaymodal" class="modal fade" role="dialog" >
  <div class="modal-dialog" style="font-size:0.80em;margin-left:100px;" >
       <!-- Modal content-->
  <div class="modal-content" style="width:600px;">
  <div class="modal-header" style="background-color:gray;">
  <button type="button" class="close" data-dismiss="modal">&times;</button>
  <h4 class="modal-title">todays cost</h4>
  </div>
  <div class="modal-body" style="text-align:center;">
  <br/>
<b>todays total daily cost is = {{tdc}}</b> <br/>

<table border="1" align="center">

<tr ng-if="dc.length>0">
<th>costdate</th>
<th>item type</th>
<th>name</th>
<th>amount</th>
<th>price</th>
<th>update</th>
</tr>

<tr ng-repeat="x in dc">
<td><input style="width:100px;" type="text" ng-model="x.stringcostdate" /></td>
<td><input style="width:80px;" type="text" ng-model="x.type" /></td>
<td><input style="width:100px;" type="text" ng-model="x.itemname" /></td>
<td><input style="width:80px;"  type="text" ng-model="x.amount" /></td>
<td><input style="width:80px;" type="number" ng-model="x.cost" /></td>
<td><button class="btn btn-success btn-sm" ng-click="updatedailycost2($index);">update</button></td>
</tr>

</table>

  </div>
  
  <div class="modal-footer">
   <button  class="btn btn-default" data-dismiss="modal">Close</button>
      </div>
    </div>

  </div>
</div>   




</body>

</html>
