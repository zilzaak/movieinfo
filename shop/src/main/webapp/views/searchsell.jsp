<%@ page language="java" contentType="text/html; charset=UTF-8"
 pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page isELIgnored="false"  %>
<!DOCTYPE html>
<html>
<head>
<title>Sell history</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="<c:url value="/static/theme/bootstrap431.css" /> " rel="stylesheet">
<script src="<c:url value="/static/theme/jquery340.js" />" > </script> 
<script src="<c:url value="/static/theme/popper114.js" />" > </script>
<script src="<c:url value="/static/theme/angular1.8.2.js" />" > </script>
<script src="<c:url value="/static/theme/bootstrap431.js" />" > </script>
<meta charset="UTF-8">



<script>
var mod=angular.module("sapp",[]);

mod.controller("scontrol",function($scope,$http){

	$scope.y=[];
	
	$scope.inityear=function(){
		for(i=2015;i<2040;i++){
			$scope.y.push(i);
		}
			}
$scope.d=['01','02','03','04','05','06','07','08','09','10','11','12','13','14','15','16','17','18','19','20','21','22','23','24','25','26',
		'27','28','29','30','31'];
$scope.m=['01','02','03','04','05','06','07','08','09','10','11','12'];
	
	
	$scope.sell1=[]; 	$scope.sell2=[]; 	$scope.sell3=[]; 	$scope.sell4=[]; 	$scope.sell5=[]; 
	
	$scope.company="";
	$scope.bycompany=function(){
		
		$http({ 
			method:"POST" , 
			url:"${pageContext.request.contextPath}/sellbycompany", 
		  	data:$scope.company,
		    headers:{"Response-Type":"application/json","Content-Type":"text/plain"}	
			
		        }).then(function(response){
		        	
		    $scope.sell1=response.data;
	
		    	    })	
	}
	
	$scope.productname="";
	$scope.byproductname=function(){
		
		$http({ 
			method:"POST" , 
			url:"${pageContext.request.contextPath}/sellbyproductname", 
		  	data:$scope.productname,
		    headers:{"Response-Type":"application/json","Content-Type":"text/plain"}	
			
		        }).then(function(response){
		        	
		    $scope.sell2=response.data;
	
		    	    })	
	}	
	
	$scope.sd3=""; $scope.sm3=""; $scope.sy3="";
	$scope.inadate="";
	$scope.byinadate=function(){
		
		$scope.inadate=$scope.sd3+"/"+$scope.sm3+"/"+$scope.sy3;
		if($scope.inadate.length>8){
			
			$http({ 
				method:"POST" , 
				url:"${pageContext.request.contextPath}/sellbyinadate", 
			  	data:$scope.inadate,
			    headers:{"Response-Type":"application/json","Content-Type":"text/plain"}	
				
			        }).then(function(response){
			          	if(response.data.psl.length<1){
			        		alert("no record found");
			        	}
			    $scope.sell3=response.data;
		
			    	    })	
		}
		
		if($scope.inadate.length!=10){
			
alert("sorry, wrong date");
		}

	}	
	
		
	$scope.sd4=""; $scope.sm4=""; $scope.sy4="";
	$scope.afteradate="";
	$scope.byafteradate=function(){
		
		
		$scope.afteradate=$scope.sd4+"/"+$scope.sm4+"/"+$scope.sy4;
		
		
		if($scope.afteradate.length!=10){
			alert("wrong , date length");
		}
		if($scope.afteradate.length==10){
			$http({ 
				method:"POST" , 
				url:"${pageContext.request.contextPath}/sellbyafteradate", 
			  	data:$scope.afteradate,
			    headers:{"Response-Type":"application/json","Content-Type":"text/plain"}	
				
			        }).then(function(response){
			          	if(response.data.psl.length<1){
			        		alert("no record found");
			        	}
			    $scope.sell4=response.data;
		
			    	    })	
		}
		

	                   
	                        }
	
	
	
	
	$scope.d1=""; $scope.m1=""; $scope.y1=""; 
	$scope.d2=""; $scope.m2=""; $scope.y2=""; 
	
	$scope.bybetweenadate=function(){
		var x=$scope.d1+"/"+$scope.m1+"/"+$scope.y1; 
		var y=$scope.d2+"/"+$scope.m2+"/"+$scope.y2; 
		$scope.asik=[x,y];
		
		if(x.length!=10 || x.length!=10){
			
			alert("wrong date length");
		}
		
		if(x.length==10 || x.length==10){
			$http({ 
				method:"POST" , 
				url:"${pageContext.request.contextPath}/sellbybetweenadate", 
			  	data:angular.toJson($scope.asik),
			    headers:{"Content-Type":"application/json"}	
				
			        }).then(function(response){
			        	if(response.data.psl.length<1){
			        		alert("no record found");
			        	}
			    $scope.sell5=response.data;
		
			    	    })	
		}

	                              }
	
	
	
	$scope.updatesell=function(v1,v2){
		document.getElementById("mbd").style.display="none";
		$http({ 
			method:"POST" , 
			url:"${pageContext.request.contextPath}/sell/updatesell", 
		  	data:angular.toJson(v1),
		    headers:{"Content-Type":"application/json"}	
			
		        }).then(function(response){
		        	
		  alert(response.data.productname);
			document.getElementById("mbd").style.display="block";
		  document.getElementById(v2).click();	
		         })	
		        	
		       
	            }
	


	

		

	   
	
	
	
	$scope.deletesell=function(v1,v2){
		
		var pass=window.prompt("enter password to delete");
		$http({ 
			method:"POST", 
			url:"${pageContext.request.contextPath}/checkpass", 
		  	data:pass,
		    headers:{"Content-Type":"text/plain","Response-Type":"application/json"}	
			
		        }).then(function(response){
		        
		        if(response.data.sms=="yes"){
		       $http({ 
					method:"POST", 
					url:"${pageContext.request.contextPath}/sell/deletesell", 
				  	data:angular.toJson(v1),
				    headers:{"Content-Type":"application/json"}	
					
				        }).then(function(response){
				        	
				  alert(response.data.productname);
				  document.getElementById(v2).click();	
				         })	
		        }
		        
		        if(response.data.sms=="no"){       
		        
		        alert("password not match");
		        }
		        	
		             })	
		         

		     	              }
	
	
	
	
})


function checkit(){
	
	var p=document.getElementById("x").value;
	for(var i=1;i<11;i++){
		if(p==i){
			document.getElementById(i).style.display="block";	
		}
		
		if(p!=i){
			document.getElementById(i).style.display="none";	
		}

	}
	
}


function calc(t){
	

	for(var i=1;i<11;i++){
		if(t!=i){
			document.getElementById(i).style.display="none";		
		}
		if(t==i){
			document.getElementById(i).style.display="block";		
		}
		
	}
	
}

</script>

<style>
table th{
background-color:black;
color:white;
}

table td{
background-color:skyblue;

}

</style>
</head>

<body ng-controller="scontrol" ng-app="sapp" style="text-align:center;margin:50px;background-color:#B0E0E6;" ng-init="inityear()" id="mbd" >

<div style="padding:15px;background-color:#BC8F8F;">
<b>(sell history)</b>select option <select   id="x" onchange="checkit();"> 
<option value="h">---</option>
<option value="1">search by company</option>
<option value="2" >search by product name</option>
<option value="3">records in a date</option>
<option value="4">record after a date</option>
<option value="5">records between two date</option>
</select>
<button onclick="calc('6');" class="btn btn-info btn-md"> CALCULATOR</button>
</div>



 <div style="text-align:center;background-color:white;width:85%;display:none;font-size:0.80em;margin-left:8%;padding:10px;" id="6">
 
 <style>
 
 .container {
    max-width: 400px;
    margin: 10vh auto 0 auto;
    box-shadow: 0px 0px 43px 17px rgba(153,153,153,1);
}

#display {
    text-align: right;
    height: 70px;
    line-height: 70px;
    padding: 8px;
    font-size: 25px;
}

.buttons {
    display: grid;
    border-bottom: 1px solid #999;
    border-left: 1px solid#999;
    grid-template-columns: 1fr 1fr 1fr 1fr;
}

.buttons > div {
    border-top: 1px solid #999;
    border-right: 1px solid#999;
}

.button {
    border: 0.5px solid #999;
    line-height: 50px;
    text-align: center;
    font-size: 25px;
    cursor: pointer;
}

#equal {
    background-color: rgb(85, 85, 255);
    color: white;
}

.button:hover {
    background-color: #323330;
    color: white;
    transition: 0.5s ease-in-out;
}
 
 </style>
 
 
 
 <div class="container">
            <div id="display"></div>
            <div class="buttons">
                <div class="button">C</div>
                <div class="button">/</div>
                <div class="button">*</div>
                <div class="button">&larr;</div>
                <div class="button">7</div>
                <div class="button">8</div>
                <div class="button">9</div>
                <div class="button">-</div>
                <div class="button">4</div>
                <div class="button">5</div>
                <div class="button">6</div>
                <div class="button">+</div>
                <div class="button">1</div>
                <div class="button">2</div>
                <div class="button">3</div>
                <div class="button">.</div>
                <div class="button">(</div>
                <div class="button">0</div>
                <div class="button">)</div>
                <div id="equal" class="button">=</div>
            </div>
        </div>
        
        <script type="text/javascript">
        var display = document.getElementById('display');

        var buttons = Array.from(document.getElementsByClassName('button'));

        buttons.map( button => {
            button.addEventListener('click', (e) => {
                switch(e.target.innerText){
                    case 'C':
                        display.innerText = '';
                        break;
                    case '=':
                        try{
                            display.innerText = eval(display.innerText);
                        } catch {
                            display.innerText = "Error"
                        }
                        break;
                    case '←':
                        if (display.innerText){
                           display.innerText = display.innerText.slice(0, -1);
                        }
                        break;
                    default:
                        display.innerText += e.target.innerText;
                }
            });
        });

        
        </script>
<br/>
<br/>

</div>





<div style="padding:15px;background-color:#BC8F8F;display:none;" id="1">
<%
if(session.getAttribute("adminuser")==null && session.getAttribute("adminpass")==null){
	response.sendRedirect("${pageContext.request.contextPath}"); 
	}

	  %>

<span><h4>search by company</h4><input type="text" ng-model="company" ng-keyup="bycompany()" ng-click="bycompany()" id="a" /></span>
 <br/><br/>
<div style="color:maroon;background-color:darkseagreen;padding:10px;border:2px solid black;">
<b>total orders amount:: {{sell1.totalsell}} TK</b><br/><br/>
<b>total due amount:: {{sell1.due}} TK</b>
</div>
<br/>
<br/>
<table border="1" align="center" ng-if="sell1.psl.length>0">
<tr> 
<th>ক্রমিক নং</th>
<th>পন্নের বর্ণনা </th>
<th>তারিখ ও <br/>নোট  </th>
<th>task</th>
</tr>

<tr ng-repeat="x in sell1.psl">
<td>{{$index+1}}</td>
<td>

<b>*পন্যের নাম</b><br/>
<input type="text" ng-model="x.productname"/> <br/>
<b>*কম্পানি </b><br/>
<input type="text" ng-model="x.company"/> <br/>

<b>*পরিমান</b><br/>
<input type="text" ng-model="x.amount"/> <br/>
<b>*দাম</b><br/>
<input type="number" ng-model="x.price"/> <br/>
<b>বকেয়া</b><br/>
<input type="number" ng-model="x.due"/> <br/>
</td>
<td>
<b>*দিন/মাস/বছর</b> <br/>
<input type="text" ng-model="x.stringselldate">
<br/>
<b>নোট </b> <br/>
<textarea ng-model="x.note" rows="3" cols="20"></textarea> <br/>
</td>
<td>
<button ng-click="updatesell(x,'a')" class="btn btn-sm btn-success">আপডেট </button>
<br/> <br/>
<button ng-click="deletesell(x,'a')" class="btn btn-sm btn-dark">ডিলিট </button>
</td>
</tr>
</table> <br/>



</div>


<div style="padding:15px;background-color:#BC8F8F;display:none;" id="2">
<span><h4>search by product name</h4><input type="text" ng-model="productname" ng-keyup="byproductname()" ng-click="byproductname()" id="b" /></span>
 <br/><br/>
<div style="color:maroon;background-color:darkseagreen;padding:10px;border:2px solid black;">
<b>total orders amount:: {{sell2.totalsell}} TK</b><br/><br/>
<b>total due amount:: {{sell2.due}} TK</b>
</div>
<br/>
<br/>
<table border="1" align="center" ng-if="sell2.psl.length>0">
<tr> 
<th>ক্রমিক নং</th>
<th>পন্নের বর্ণনা </th>
<th>তারিখ ও <br/>নোট  </th>
<th>task</th>
</tr>

<tr ng-repeat="x in sell2.psl">
<td>{{$index+1}}</td>
<td>

<b>*পন্যের নাম</b><br/>
<input type="text" ng-model="x.productname"/> <br/>
<b>*কম্পানি </b><br/>
<input type="text" ng-model="x.company"/> <br/>

<b>*পরিমান</b><br/>
<input type="text" ng-model="x.amount"/> <br/>
<b>*দাম</b><br/>
<input type="number" ng-model="x.price"/> <br/>
<b>বকেয়া</b><br/>
<input type="number" ng-model="x.due"/> <br/>
</td>
<td>
<b>*দিন/মাস/বছর</b> <br/>
<input type="text" ng-model="x.stringselldate">
<br/>
<b>নোট </b> <br/>
<textarea ng-model="x.note" rows="3" cols="20"></textarea> <br/>
</td>
<td>
<button ng-click="updatesell(x,'b')" class="btn btn-sm btn-success">আপডেট </button>
<br/> <br/>
<button ng-click="deletesell(x,'b')" class="btn btn-sm btn-dark">ডিলিট </button>
</td>
</tr>
</table> <br/>


</div>

<div style="padding:15px;background-color:#BC8F8F;display:none;" id="3">
<h4>records in a date</h4>
<div>
<b style="color:white;">তারিখঃ-- *দিন/মাস/বছর</b> <br/> 
<select ng-model="sd3"  ng-options="c for c in d"></select> 

<select ng-model="sm3" ng-options="c for c in m"></select>

<select ng-model="sy3"  ng-options="c for c in y"></select>

<br/><br/>
<button ng-click="byinadate()" class="btn bn-sm btn-dark" id="c" >submit</button>
</div> 
 <br/><br/>
<div style="color:maroon;background-color:darkseagreen;padding:10px;border:2px solid black;">
<b>total orders amount:: {{sell3.totalsell}} TK</b><br/><br/>
<b>total due amount:: {{sell3.due}} TK</b>
</div>
<br/>
<br/>
<table border="1" align="center" ng-if="sell3.psl.length>0">
<tr> 
<th>ক্রমিক নং</th>
<th>পন্নের বর্ণনা </th>
<th>তারিখ ও <br/>নোট  </th>
<th>task</th>
</tr>

<tr ng-repeat="x in sell3.psl">
<td>{{$index+1}}</td>
<td>

<b>*পন্যের নাম</b><br/>
<input type="text" ng-model="x.productname"/> <br/>
<b>*কম্পানি </b><br/>
<input type="text" ng-model="x.company"/> <br/>

<b>*পরিমান</b><br/>
<input type="text" ng-model="x.amount"/> <br/>
<b>*দাম</b><br/>
<input type="number" ng-model="x.price"/> <br/>
<b>বকেয়া</b><br/>
<input type="number" ng-model="x.due"/> <br/>
</td>
<td>
<b>*দিন/মাস/বছর</b> <br/>
<input type="text" ng-model="x.stringselldate">
<br/>
<b>নোট </b> <br/>
<textarea ng-model="x.note" rows="3" cols="20"></textarea> <br/>
</td>
<td>
<button ng-click="updatesell(x,'c')" class="btn btn-sm btn-success">আপডেট </button>
<br/> <br/>
<button ng-click="deletesell(x,'c')" class="btn btn-sm btn-dark">ডিলিট </button>
</td>
</tr>
</table> <br/>


</div>

<div style="padding:15px;background-color:#BC8F8F;display:none;" id="4">
<h4>records after a date</h4>
<div>
<b style="color:white;">তারিখঃ-- *দিন/মাস/বছর</b> <br/> 
<select ng-model="sd4"  ng-options="c for c in d"></select> 

<select ng-model="sm4" ng-options="c for c in m"></select>

<select ng-model="sy4"  ng-options="c for c in y"></select>

<br/><br/>
<button ng-click="byafteradate()" class="btn bn-sm btn-dark" id="d" >submit</button>
</div> 
 <br/><br/>
<div style="color:maroon;background-color:darkseagreen;padding:10px;border:2px solid black;">
<b>total orders amount:: {{sell4.totalsell}} TK</b><br/><br/>
<b>total due amount:: {{sell4.due}} TK</b>
</div>
<br/>
<br/>
<table border="1" align="center" ng-if="sell4.psl.length>0">
<tr> 
<th>ক্রমিক নং</th>
<th>পন্নের বর্ণনা </th>
<th>তারিখ ও <br/>নোট  </th>
<th>task</th>
</tr>

<tr ng-repeat="x in sell4.psl">
<td>{{$index+1}}</td>
<td>

<b>*পন্যের নাম</b><br/>
<input type="text" ng-model="x.productname"/> <br/>
<b>*কম্পানি </b><br/>
<input type="text" ng-model="x.company"/> <br/>

<b>*পরিমান</b><br/>
<input type="text" ng-model="x.amount"/> <br/>
<b>*দাম</b><br/>
<input type="number" ng-model="x.price"/> <br/>
<b>বকেয়া</b><br/>
<input type="number" ng-model="x.due"/> <br/>
</td>
<td>
<b>*দিন/মাস/বছর</b> <br/>
<input type="text" ng-model="x.stringselldate">
<br/>
<b>নোট </b> <br/>
<textarea ng-model="x.note" rows="3" cols="20"></textarea> <br/>
</td>
<td>
<button ng-click="updatesell(x,'d')" class="btn btn-sm btn-success">আপডেট </button>
<br/> <br/>
<button ng-click="deletesell(x,'d')" class="btn btn-sm btn-dark">ডিলিট </button>
</td>
</tr>
</table> <br/>

</div>

<div style="padding:15px;background-color:#BC8F8F;display:none;" id="5">
<h4>records between two date</h4>

<div>
<b style="color:white;">তারিখঃ-- *দিন/মাস/বছর</b> <br/> 
<select ng-model="d1"  ng-options="c for c in d"></select> 

<select ng-model="m1" ng-options="c for c in m"></select>

<select ng-model="y1"  ng-options="c for c in y"></select>
</div>
<div>
<b style="color:white;">তারিখঃ-- *দিন/মাস/বছর</b> <br/> 
<select ng-model="d2"  ng-options="c for c in d"></select> 

<select ng-model="m2" ng-options="c for c in m"></select>

<select ng-model="y2"  ng-options="c for c in y"></select>
</div>
<br/><br/>
<button ng-click="bybetweenadate()" class="btn btn-dark bn-sm " id="e" >submit</button>

 <br/><br/>
<div style="color:maroon;background-color:darkseagreen;padding:10px;border:2px solid black;">
<b>total orders amount:: {{sell5.totalsell}} TK</b><br/><br/>
<b>total due amount:: {{sell5.due}} TK</b>
</div>
<br/>
<br/>
<table border="1" align="center" ng-if="sell5.psl.length>0">
<tr> 
<th>ক্রমিক নং</th>
<th>পন্নের বর্ণনা </th>
<th>তারিখ ও <br/>নোট  </th>
<th>task</th>
</tr>

<tr ng-repeat="x in sell5.psl">
<td>{{$index+1}}</td>
<td>

<b>*পন্যের নাম</b><br/>
<input type="text" ng-model="x.productname"/> <br/>
<b>*কম্পানি </b><br/>
<input type="text" ng-model="x.company"/> <br/>

<b>*পরিমান</b><br/>
<input type="text" ng-model="x.amount"/> <br/>
<b>*দাম</b><br/>
<input type="number" ng-model="x.price"/> <br/>
<b>বকেয়া</b><br/>
<input type="number" ng-model="x.due"/> <br/>
</td>
<td>
<b>*দিন/মাস/বছর</b> <br/>
<input type="text" ng-model="x.stringselldate">
<br/>
<b>নোট </b> <br/>
<textarea ng-model="x.note" rows="3" cols="20"></textarea> <br/>
</td>
<td>
<button ng-click="updatesell(x,'e')" class="btn btn-success btn-sm">আপডেট </button>
<br/> <br/>
<button ng-click="deletesell(x,'e')" class="btn btn-dark btn-sm">ডিলিট </button>
</td>
</tr>
</table> <br/>

</div>

</body>

</html>