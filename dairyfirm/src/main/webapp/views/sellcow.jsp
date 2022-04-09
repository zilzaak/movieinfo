<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<title>sell animal</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="<c:url value="/static/theme/bootstrap431.css" /> " rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="<c:url value="/static/theme/jquery340.js" />" > </script> 
<script src="<c:url value="/static/theme/angular1.8.2.js" />" > </script>
<script src="<c:url value="/static/theme/bootstrap431.js" />" > </script>

<script>
var module=angular.module("sellapp",[]);
module.controller("sellcontrol",function($scope,$http){
	$scope.types=['খাবার','ঘর','অন্যান্য ']
	$scope.cd=[]; $scope.cm=[]; $scope.cy=[];
	$scope.day=['01','02','03','04','05','06','07','08','09','10','11','12','13','14','15','16','17','18','19','20','21','22','23','24','25','26',
		'27','28','29','30','31'];
	$scope.month=['01','02','03','04','05','06','07','08','09','10','11','12'];
	$scope.year=[];
	$scope.inityear=function(){
		for(var k=1900;k<=3000;k++){
			
			$scope.year.push(k);
	                     }
	                         }
	
	
	var s1={"anid":null,"stringselldate":"","sellprice":null,"due":null,"buyername":"","buyercontact":null,"sms":""};	
	var s2={"anid":null,"stringselldate":"","sellprice":null,"due":null,"buyername":"","buyercontact":null,"sms":""};	
	var s3={"anid":null,"stringselldate":"","sellprice":null,"due":null,"buyername":"","buyercontact":null,"sms":""};
	
$scope.sellform=[];
$scope.sellform.push(s1);
$scope.sellform.push(s2);
$scope.sellform.push(s3);

$scope.searchres=[];$scope.rectitle="";	$scope.totalprice=0; $scope.totalanimal=0; $scope.totaldue=0;

$scope.deletesell=function(i){
	if($scope.sellform.length>1){
		$scope.sellform.splice(i,1);
	}

}

$scope.addsell=function(i){
	
	var s1={"anid":null,"stringselldate":"","sellprice":null,"due":null,"buyername":"","buyercontact":null,"sms":""};	
	$scope.sellform.splice(i,0,s1);
	
	}
	
$scope.setdat=function(i){
	
$scope.sellform[i].stringselldate=$scope.cd[i]+"/"+$scope.cm[i]+"/"+$scope.cy[i];
if($scope.sellform[i].stringselldate.length==10){
	if($scope.sellform[i].sms.indexOf("wrong date,")!== -1){
		$scope.sellform[i].sms=$scope.sellform[i].sms.replace("wrong date,", "");
		
	}
}

}

$scope.checkprice=function(i){
	if($scope.sellform[i].sellprice>0){
		if($scope.sellform[i].sms.indexOf("price error,")!== -1){
			$scope.sellform[i].sms=$scope.sellform[i].sms.replace("price error,", "");
		
		}
	}

	}
	
	

$scope.savesell=function(){
	
	$http({ 
		method:"POST" , 
		url:"${pageContext.request.contextPath}/cowsell/savesell", 
	  	data:angular.toJson($scope.sellform),
	    headers:{"Content-Type":"application/json"}	
		
	        }).then(function(response){
	        	
	        	$scope.vars=response.data;
               var en="no";
	        	angular.forEach($scope.vars,function(v,i){
	        		if(v.sms!=""){
	        		en="ye";
	        		}
	        	})
	        	
     if(en=="ye"){
    	$scope.sellform=response.data;
    	alert("sorry, invalid form"); 
          
          }
	            if(en=="no"){
	            	alert("successfull"); 
	            	
	             }	
		
	})
	
}



$scope.totalcost=function(){

	$http({ 
		method:"GET", 
		url:"${pageContext.request.contextPath}/cowsell/findall", 	  
	headers:{"Content-Type":"application/json"}	
		
	        }).then(function(response){	
	
	    	if(response.data.length==0){
					alert("no record found");
				    }
				else{
					$scope.searchres=response.data;
					$scope.calcultt(); 
					$scope.rectitle="total animal selling records";
					document.getElementById("result").style.display="block";
				}
	        	
	        	
	        });
	        
	        
}



	$scope.checkit=function(i){

		$http({ 
		method:"POST", 
		url:"${pageContext.request.contextPath}/cowsell/existbyanid", 
	  	data:angular.toJson($scope.sellform[i].anid),
	headers:{"Content-Type":"application/json"}	
		
	        }).then(function(response){
	        	
	      $scope.p=response.data;  
	        
		if($scope.p.length==0){
			$scope.sellform[i].sms="";
			
	   angular.forEach($scope.sellform,function(v,k){
		 
		  if(i!=k &&  $scope.sellform[i].anid==v.anid){
			  
			  $scope.sellform[i].sms="duplicate id";  
		  } 
		   
	   })    
					                      
		}
		
		 if($scope.p.length!=0){
		
				$scope.sellform[i].sms="id already added";
			
			
		                       	}
		
	                       	});                       	
	                       	          
	             }
	
	
	
	$scope.schd="";
	$scope.schm="";
	$scope.schy="";		$scope.schd1="";
	$scope.schm1="";
	$scope.schy1="";	
	$scope.dt=[];
	

	
	
	$scope.calcultt=function(){
		$scope.totalprice=0; $scope.totalanimal=0; $scope.totaldue=0;
angular.forEach($scope.searchres,function(v,i){
		$scope.totalprice=$scope.totalprice+v.sellprice-v.due;
		$scope.totaldue=$scope.totaldue+v.due;
	})	
		
	$scope.totalanimal=$scope.searchres.length;	
	
	}
	
	
	
$scope.sdate=function(){
	
	$scope.dt[0]=$scope.schd+"/"+$scope.schm+"/"+$scope.schy;


}	


$scope.sdate2=function(){
	
	$scope.dt[1]=$scope.schd1+"/"+$scope.schm1+"/"+$scope.schy1;


}


$scope.aboutanimal=function(){
			
		$http({
		method:"POST",
		url:"${pageContext.request.contextPath}/animal/aboutanimal", 
		data:angular.toJson($scope.sanid),
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

$scope.aboutanimal2=function(r){
	
	$http({
	method:"POST",
	url:"${pageContext.request.contextPath}/animal/aboutanimal", 
	data:angular.toJson(r),
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

$scope.sellafter=function(){

		$http({
		method:"POST",
		url:"${pageContext.request.contextPath}/cowsell/sellafter", 
		data:$scope.dt[0],
		headers: {"Content-Type":"text/plain","responseType":"application/json"}
		}).then(function(response){
			if(response.data.length==0){
				alert("no record found");
			}
			else{
				$scope.searchres=response.data;
				$scope.calcultt();
				$scope.rectitle="records after a date";
				document.getElementById("result").style.display="block";
			}
		})
			}	
	

	
	$scope.sellbefore=function(){
		
			$http({
			method:"POST",
		    url:"${pageContext.request.contextPath}/cowsell/sellbefore", 
			data:$scope.dt[1],
			headers: {"Content-Type":"text/plain","responseType":"application/json"}
			}).then(function(response){
				if(response.data.length==0){
					alert("no record found");
				}
				else{
					$scope.searchres=response.data; 
					$scope.calcultt();
					$scope.rectitle="records before a date";
					document.getElementById("result").style.display="block";
				}
			})
				}	


$scope.updatesell=function(x){
	
	$scope.upsell=x
	
}





$scope.inadate=function(){

	var sr=$scope.checkdate($scope.ad);
	if(sr==2 && $scope.ad.length>7){
		$http({
			method:"POST",
			url:"${pageContext.request.contextPath}/cowsell/inadate", 
			data:$scope.ad,
			headers: {"Content-Type":"text/plain","responseType":"application/json"}
			}).then(function(response){
				if(response.data.length==0){
					alert("no record found");
				}
				else{
					$scope.searchres=response.data; 
					$scope.calcultt();
					$scope.rectitle="sell records of a date";
					document.getElementById("result").style.display="block";
				}
				
				
				})	
	}

	if(sr!=2 || $scope.ad.length<8){
		alert("wrong date");
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

$scope.finalsell=function(){
	
	var d = $scope.checkdate($scope.upsell.stringselldate);
	
	if(d==2){
		$http({
			method:"PUT",
		    url:"${pageContext.request.contextPath}/cowsell/update", 
			data:angular.toJson($scope.upsell),
			headers: {"Content-Type":"application/json"}	
			
				}).then(function(response){
			
			alert("successfully updated");
		})
	}
	
	}
	
	$scope.selldatebt=function(){	
				
		$http({
		method:"POST",
	    url:"${pageContext.request.contextPath}/cowsell/selldatebt", 
		data:angular.toJson($scope.dt),
		headers: {"Content-Type":"application/json"}
		}).then(function(response){
		if(response.data.length==0){
			alert("no record found");
		}
		else{
			$scope.searchres=response.data;
			$scope.calcultt(); 
			$scope.rectitle="records between two date";
			document.getElementById("result").style.display="block";
		}
		
		})
		
		
			}	
	
	
	
	$scope.recbyid=function(){

		$http({ 
		method:"POST", 
		url:"${pageContext.request.contextPath}/cowsell/existbyanid", 
	  	data:angular.toJson($scope.anid),
	headers:{"Content-Type":"application/json"}	
		
	        }).then(function(response){
	
	    		if(response.data.length==0){
	    			alert("no record found");
	    		}
	    		else{
	    			$scope.searchres=response.data;	    		
	    			$scope.rectitle="record by id";
	    			$scope.calcultt();
	    			document.getElementById("result").style.display="block";
	    		}	
	        })
		
	}
	
	$scope.details=function(i){

		$http({ 
		method:"POST", 
		url:"${pageContext.request.contextPath}/cowsell/findbyanid", 
	  	data:angular.toJson($scope.searchres[i].anid),
	headers:{"Content-Type":"application/json"}	
		
	        }).then(function(response){
	    		
	        	$scope.animal=response.data;
	    			
	        })
		
	}	
	
	
	
	
$scope.sellprice1;$scope.sellprice2;
$scope.sellp=[];
	
	$scope.priceupper=function(){
		
		$http({
			method:"POST",
		    url:"${pageContext.request.contextPath}/cowsell/sellpricegt", 
			data:angular.toJson($scope.sellprice1),
			headers: {"Content-Type":"application/json"}
			}).then(function(response){
			
				
	    		if(response.data.length==0){
	    			alert("no record found");
	    		}
	    		else{
	    			$scope.searchres=response.data;
	    			$scope.calcultt();
	    			$scope.rectitle="records > a particular price";
	    			document.getElementById("result").style.display="block";
	    		}		
				
		     	})
	
	     }	
	
	
$scope.pricelower=function(){
	
	$http({
		method:"POST",
	    url:"${pageContext.request.contextPath}/cowsell/sellpricelt", 
		data:angular.toJson($scope.sellprice2),
		headers: {"Content-Type":"application/json"}
		}).then(function(response){
		
			
    		if(response.data.length==0){
    			alert("no record found");
    		}
    		else{
    			$scope.searchres=response.data;
    			$scope.calcultt(); $scope.rectitle="records < a particular price";
    			document.getElementById("result").style.display="block";
    		}		
			
	     	})	
	
}	
	
	
$scope.pricebt=function(){
	
	$http({
		method:"POST",
	    url:"${pageContext.request.contextPath}/cowsell/sellpricebt", 
		data:angular.toJson($scope.sellp),
		headers: {"Content-Type":"application/json"}
		}).then(function(response){
	
			if(response.data.length==0){
    			alert("no record found");
    		}
    		else{
    			$scope.searchres=response.data;
    			$scope.calcultt();
    			$scope.rectitle="records between two particular price"; 
    			document.getElementById("result").style.display="block";
    		}	
	                 
		             })	
	
}
	
	
	
$scope.buyer; $scope.contact;


$scope.byname=function(){
	$http({
		method:"POST",
	    url:"${pageContext.request.contextPath}/cowsell/byname", 
		data:$scope.buyer,
		headers: {"Content-Type":"text/plain","responseType":"application/json"}
		}).then(function(response){
			if(response.data.length==0){
				alert("no record found");
			}
			else{
				$scope.searchres=response.data; 
				$scope.calcultt(); 
				$scope.rectitle="records with a buyer name";
				document.getElementById("result").style.display="block";
			}
		})	
	
	
}

$scope.bycontact=function(){
	
	$http({
		method:"POST",
	    url:"${pageContext.request.contextPath}/cowsell/bycontact", 
		data:$scope.contact,
		headers: {"Content-Type":"text/plain","responseType":"application/json"}
		}).then(function(response){
			if(response.data.length==0){
				alert("no record found");
			}
			else{
				$scope.searchres=response.data; 
				$scope.calcultt();
				$scope.rectitle="records of particular buyer's contact";
				document.getElementById("result").style.display="block";
			}
		})		
	
}
	
	
$scope.totalduefind=function(){
		
	$http({
		method:"GET",
	    url:"${pageContext.request.contextPath}/cowsell/totaldue", 	
		headers: {"Content-Type":"application/json"}
		}).then(function(response){
			if(response.data.length==0){
				alert("no record found");
			}
			else{
				 
				$scope.searchres=response.data; 
				$scope.calcultt(); 
				document.getElementById("result").style.display="block";
				 $scope.rectitle="selling record including customer's the taka";
			}
		})	
	
}	



$scope.clearsell=function(){
	
$scope.bns.buyername="";
$scope.bns.buyercontact="";$scope.bns.stringselldate="";	
	
}	
	
	
$scope.eligibleanimal=function(){
	
	$http({
	method:"GET",
    url:"${pageContext.request.contextPath}/animal/eligibleanimal", 	
	headers: {"Content-Type":"application/json"}
	}).then(function(response){
	  
		$scope.animallist=response.data;
	    
	})
	
}	
	
	
	        	
	        	
})


</script>

<script>

function showdiv(a,b,c,d,e,f,g,h,i){
	document.getElementById(a).style.display="block";
	document.getElementById(b).style.display="none";
	document.getElementById(c).style.display="none";
	document.getElementById(d).style.display="none";
	document.getElementById(e).style.display="none";
	document.getElementById(f).style.display="none";
	document.getElementById(g).style.display="none";
	document.getElementById(h).style.display="none";
	document.getElementById(i).style.display="none";
               }


</script>


<style>


body{
box-sizing:border-box;
background-image:url("/static/theme/sea.jpg");
background-size:1400px 500px;

}
.contain1{
display:grid;
grid-template-columns: 30% 30% 10%;
column-gap:20px;
padding-bottom:30px;
}

span:hover{
color:red;
background-color:skyblue;
}
table td:hover{
background-color:silver; color:green;

}

input:hover{
background-color:maroon; color:white;

}

table{
overflow-x:scroll;
}

table th{
wrap-word:break-word;
background-color:black;
color:white;
padding:8px;
}

table td{
wrap-word:break-word;
background-color:white;
color:black;
text-align:center;
}

a:hover{
background-color:steelblue;

}


.dropdown-menu a:hover{
background-color:steelblue;

}




</style>

</head>
<body  ng-controller="sellcontrol"  ng-app="sellapp"  ng-init="inityear();">
<%
if(session.getAttribute("adminuser")==null && session.getAttribute("adminpass")==null){
	response.sendRedirect("${pageContext.request.contextPath}");
	}

	  %>


	

<nav class="navbar navbar-expand-lg" style="margin-right:7%;margin-left:8%;margin-top:2%;border-radius:8px;background-color:darkslategrey;">
  <a class="navbar-brand" href="#" style="margin-left:5%;color:white;">ANIMAL SELL & FIND RECORDS</a>
   <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon" style="color:white;"><b>click</b></span>
  </button> 

  <div class="collapse navbar-collapse" id="navbarSupportedContent">
    <ul class="navbar-nav mr-auto">
      <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle" href="#" style="margin-left:5%;color:white;" role="button" 
        data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
          search selling
        </a>
        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
          <a class="dropdown-item" href="#" onclick="showdiv('1','2','3','4','5','6','7','8','9');">sell record between two date</a>
          <a class="dropdown-item" href="#" onclick="showdiv('2','3','4','5','6','7','1','8','9');">sell record after a date</a>
          <a class="dropdown-item" href="#" onclick="showdiv('3','4','5','6','7','2','1','8','9');">sell record before a date</a>
         <a class="dropdown-item" href="#" onclick="showdiv('4','5','6','7','1','2','3','8','9');">sell record by animal id</a>
         <a class="dropdown-item" href="#"  data-target="#recindate" data-toggle="modal" >sell record in a date</a>
         <a class="dropdown-item" href="#" onclick="showdiv('5','6','7','1','2','3','4','8','9');">sell record by price </a>
         <a class="dropdown-item" href="#" onclick="showdiv('8','6','7','5','1','2','3','4','9');">sell record by buyer and contact </a>
          </div>
       </li>
   
       <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle" href="#" style="margin-left:5%;color:white;" 
        role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
          sell Now
        </a>
        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
     <a class="dropdown-item" href="#" onclick="showdiv('6','7','1','2','3','4','5','8','9');">insert record</a>
        
        </div>
      </li>     
      
      <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle" href="#" role="button" style="margin-left:5%;color:white;"
        data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
          total should
        </a>
        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
          <a class="dropdown-item" href="#" onclick="showdiv('7','1','2','3','4','5','6','8','9');">total sell</a>
        </div>
      </li>    

      <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle" href="#" role="button" style="margin-left:5%;color:white;"
        data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
          total due
        </a>
        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
          <a class="dropdown-item" href="#"  onclick="showdiv('9','7','1','2','3','4','5','6','8');">total due</a>
        </div>
      </li>    

 
       </ul>
      </div>
</nav>




<div  style="margin-left:8%;background-color:darkseagreen;width:85%;display:none;font-size:0.80em;" id="1">
<h4 style="margin-left:30%;color:white;">record between two date</h4>

<div style="margin-left:20%;" class="contain1">

<div style="background-color:burlywood;padding:5px;text-align:center;">
<b>from</b>
<br/>
<b>day</b>
<select  ng-model="schd" ng-options="c for c in day"  ng-change="sdate();"></select> 
<b>month</b>
<select  ng-model="schm" ng-options="c for c in month"  ng-change="sdate();"></select> 
<b>year</b>
<select  ng-model="schy" ng-options="c for c in year"  ng-change="sdate();"></select> 
</div>

<div style="background-color:burlywood;padding:5px;text-align:center;">
<b>to</b>
<br/>
<b>day</b>
<select  ng-model="schd1" ng-options="c for c in day"  ng-change="sdate2();"></select> 
<b>month</b>
<select  ng-model="schm1" ng-options="c for c in month"  ng-change="sdate2();"></select> 
<b>year</b>
<select  ng-model="schy1" ng-options="c for c in year"  ng-change="sdate2();"></select> 
</div>
<div>
<button  class="btn btn-sm btn-dark" ng-click="selldatebt();">search</button></div>

</div>
</div>



<div  style="margin-left:8%;background-color:pink;width:85%;display:none;font-size:0.80em;padding:20px;" id="2">
<h4 style="margin-left:30%;color:white;">records after a particular date</h4>
<div style="background-color:burlywood;padding:5px;text-align:center;width:40%;margin-left:30%;">
<br/>
<b>day</b>
<select  ng-model="schd" ng-options="c for c in day"  ng-change="sdate();"></select> 
<b>month</b>
<select  ng-model="schm" ng-options="c for c in month"  ng-change="sdate();"></select> 
<b>year</b>
<select  ng-model="schy" ng-options="c for c in year"  ng-change="sdate();"></select> 
<span>      <button class="btn btn-dark btn-sm" style="margin-left:15px;" ng-click="sellafter();">search</button></span>
</div>


</div>





<div  style="margin-left:8%;background-color:darkcyan;width:85%;display:none;font-size:0.80em;padding:20px" id="3">

<h5 style="margin-left:30%;color:white;">records before a particular date</h5>

<div style="background-color:burlywood;padding:5px;text-align:center;width:40%;margin-left:30%;">
<br/>
<b>day</b>
<select  ng-model="schd1" ng-options="c for c in day"  ng-change="sdate2();"></select> 
<b>month</b>
<select  ng-model="schm1" ng-options="c for c in month"  ng-change="sdate2();"></select> 
<b>year</b>
<select  ng-model="schy1" ng-options="c for c in year"  ng-change="sdate2();"></select> 
<span>      <button class="btn btn-dark btn-sm" style="margin-left:15px;" ng-click="sellbefore();">search</button></span>
</div>

</div>





<div  style="margin-left:8%;background-color:gray;width:85%;display:none;font-size:0.80em;padding:20px" id="4">

<h4 style="margin-left:30%;color:white;">records by animal id</h4>

<div style="background-color:burlywood;padding:5px;text-align:center;width:40%;margin-left:30%;">
<br/>
<input type="number" ng-model="anid" />
<span> 
<button class="btn btn-dark btn-sm" style="margin-left:15px;" ng-click="recbyid();">search</button></span>
</div>

</div>









<div  style="margin-left:8%;background-color:burlywood;width:85%;display:none;font-size:0.80em;" id="5">

  <h4 style="text-align:center;color:white;">search by price</h4>

<div style="display:inline;text-align:center;">
<ul style="list-style-type:none;">
<li style="padding:5px;">records with minimum selling price(tk)<input type="number" ng-model="sellprice1"/> 
<button class="btn btn-dark btn-sm" ng-click="priceupper()">search</button></li>

<li style="padding:5px;">record with maximum selling price(tk) <input type="number" ng-model="sellprice2"/> 
<button class="btn btn-dark btn-sm" ng-click="pricelower()">search</button></li>

<li style="padding:5px;">records between two selling price(tk) <input type="number" ng-model="sellp[0]" />
<input type="number" ng-model="sellp[1]" />  
<button  class="btn btn-dark btn-sm" ng-click="pricebt()">search</button>

</li>
</ul>

</div>

</div>


<div  style="margin-left:8%;background-color:lightblue;width:85%;display:none;font-size:0.80em;" id="6">
<div class="row" style="margin-left:7px;margin-right:7px;">
<div class="col" style="text-align:center;background-color:ghostwhite;padding-bottom:15px;">
<br/>
<h4 style="color:maroon;">you can know about a animal before sell it</h4> <br/>
enter the animal id::<input type="number" ng-model="sanid" /> 
<button class="btn btn-dark btn-sm" ng-click="aboutanimal();" data-target="#aboutanimal" data-toggle="modal" >search</button>

</div>
<div class="col" style="text-align:center;background-color:burlywood;padding-bottom:15px;">
<br/>
<h4 style="color:green;">list of animal not sold yet</h4> <br/>
 <button class="btn btn-sm btn-dark" ng-click="eligibleanimal();" data-target="#eligibleanimal" data-toggle="modal">see now</button>
 
</div>
</div>

<br/>
    <h4 style="text-align:center;">add selling record</h4>
<br/>


<div style="margin-left:11%;font-size:0.85em;padding-bottom:35px;">
<table border="1">
<tr>
<th>index</th>
<th> animal id</th>
<th>selling date</th>
<th>selling price</th>
<th>buyer info</th>
<th>operation</th>
</tr>

<tr  ng-repeat="x in sellform">
<td>{{$index+1}}
</td>
<td>
<input type="number"  style="width:80px;" ng-model="x.anid" ng-keyup="checkit($index)" />
<br/>
<b style="color:red;word-break:break-all;">{{x.sms}}</b>
</td>
<td>
<b>day</b><br/>
<select  ng-model="cd[$index]" ng-options="c for c in day"  ng-change="setdat($index);"></select> 
<br/>

<b>month</b><br/>
<select  ng-model="cm[$index]" ng-options="c for c in month"  ng-change="setdat($index);"></select> 
<br/>

<b>year</b><br/>
<select  ng-model="cy[$index]" ng-options="c for c in year"  ng-change="setdat($index);"></select> 
<br/>
</td>

<td>
<b>selling price(tk)</b> <br/>
<input type="number" ng-model="x.sellprice" ng-keyup="checkprice($index);"/>
<br/>

<b>due tk(optional)</b><br/>

<input type="number" ng-model="x.due"/></td>
<td>
<b>(optional)</b><br/>
<input type="text" ng-model="x.buyername" placeholder="buyer name" />

<br/>

<b>(optional)</b><br/><input type="text" ng-model="x.buyercontact" placeholder="buyer phone" /></td>
<td>

<button class="btn btn-sm btn-dark" ng-click="deletesell($index);">delete</button>
<br/>
<br/>
<button  ng-click="addsell($index);" class="btn btn-success btn-sm">add</button>
</td>
</tr>
</table>
<button ng-click="savesell();" class="btn btn-success btn-md" style="margin-left:40%;margin-top:10px;">save records
</button>

</div>

</div>





<div  style="margin-left:8%;background-color:brown;width:85%;display:none;font-size:0.80em;" id="7">
<h2 style="text-align:center;color:white;background-color:black;padding:5px;">total animal sold and total price</h2>
<button class="btn btn-sm btn-dark" ng-click="totalcost()" style="margin-left:50%;">click here</button> <br/>

<div style="text-align:center;">
<h5 style="color:white;">again search in this output resultant table</h5>
<input type="text" ng-model="bns.buyername" placeholder="buyer name" ng-click="clearsell()"/>
<input type="text" ng-model="bns.buyercontact" placeholder="buyer contact" ng-click="clearsell()"/> 
<input type="text" ng-model="bns.stringselldate" placeholder="day/month/year" ng-click="clearsell()"/>
</div>
<br/><br/>
</div>


<div  style="margin-left:8%;background-color:gray;width:85%;display:none;font-size:0.80em;padding:20px;" id="8">
<h2 style="text-align:center;color:white">search by buyer name and contact</h2>
<div style="width:40%;margin-left:30%;background-color:white;border-radius:10px;text-align:center;">
<span>
<br/>
<input type="text" placeholder="buyer name" ng-model="buyer" />  <button ng-click="byname();" class="btn btn-sm btn-dark">search</button></span> <br/>
<br/>
<span>
<input type="text" placeholder="buyer contact" ng-model="contact" />  <button ng-click="bycontact();" class="btn btn-sm btn-dark">search</button></span> <br/>
<br/>


</div>


</div>



<div  style="margin-left:8%;background-color:darkseagreen;width:85%;display:none;font-size:0.80em;padding-bottom:15px;" id="9">
<br/>
<h2 style="text-align:center;color:white;background-color:black;padding:5px;">selling's related to customer due</h2>
<br/>
<div style="width:40%;margin-left:30%;background-color:white;border-radius:10px;text-align:center;">
<button ng-click="totalduefind();" >click</button>

</div>
<div style="text-align:center;">
<h5>again search in this output resultant table</h5>
<input type="text" ng-model="bns.buyername" placeholder="buyer name" ng-click="clearsell()"/>
<input type="text" ng-model="bns.buyercontact" placeholder="buyer contact" ng-click="clearsell()"/> 
<input type="text" ng-model="bns.stringselldate" placeholder="day/month/year" ng-click="clearsell()"/>
</div>
</div>



<div  style="margin-left:8%;background-color:lightblue;width:85%;font-size:0.80em;padding:10px;display:none;" id="result">

 <div style="margin-left:30%;">
 
 <div style="background-color:white;padding:10px;width:60%;text-align:center;">
 <b style="color:gold;background-color:maroon;">{{rectitle}}</b> <br/>
<b style="color:red;">number of animal sold=</b> {{totalanimal}} <br/>
<b style="color:red;">selling  price - due amount=</b> {{totalprice}} <br/>
<b style="color:red;"> due amount=</b>{{totaldue}} <br/>
</div>

<br/>
<table border="1" style="margin-left:-200px;">
<tr ng-if="searchres.length>0">
<th>animal id</th>
<th>selling</th>
<th>buyer info</th>
<th>date</th>
<th>details</th>
</tr>

<tr ng-repeat="x in searchres | filter:bns">
<td> {{x.anid}} <br/>
<button   class="btn btn-info btn-sm" data-toggle="modal" data-target="#myModal" ng-click="updatesell(x)">update</button>
<br/><br/>
</td>
<td>
<b>sell price(tk)</b><br/>
{{x.sellprice}} <br/>
<b>due tk</b><br/>
{{x.due}}tk</td>

<td>
<b>buyer name</b><br/>
{{x.buyername}} <br/>
<b>phone no</b> <br/>
{{x.buyercontact}}</td>

<td>{{x.stringselldate}}</td>
<td><button ng-click="details($index);" class="btn btn-sm btn-dark" data-toggle="modal" data-target="#animal" >details</button></td>
</tr>

</table>
</div>
</div>

 <div id="myModal" class="modal fade" role="dialog" >
        <div class="modal-dialog" style="border-radius:10px;width:420px;">
        <div class="modal-content">
        <div class="modal-header" style="background-color:gray;">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">close</h4>
      </div>
      <div class="modal-body">

<form>
  <div class="form-group">
    <label>anid</label>
    <input type="number" class="form-control" ng-model="upsell.anid" />
  </div>
  <div class="form-group">
    <label for="pwd">sell price:</label>
   <input type="number" class="form-control" ng-model="upsell.sellprice" />
  </div>
  <div class="form-group">
    <label for="pwd">due:</label>
   <input type="number" class="form-control" ng-model="upsell.due" />
  </div>
    <div class="form-group">
    <label for="pwd">buyer name:</label>
   <input type="text" class="form-control" ng-model="upsell.buyername" />
  </div>
  
      <div class="form-group">
    <label for="pwd">buyer contact:</label>
   <input type="text" class="form-control" ng-model="upsell.buyercontact" />
  </div>
  
 <div class="form-group">
   <label for="pwd">sell date(day/month/year):</label>
   <input type="text" class="form-control" placeholder="day/month/year" ng-model="upsell.stringselldate" />
  </div>
  
  <button class="btn btn-default" ng-click="finalsell()">Submit</button>
</form>

     </div>
     <div class="modal-footer" style="background-color:gray;">
    
     </div>
     </div>
     </div>
     </div>











 <div id="animal" class="modal fade" role="dialog" >
        <div class="modal-dialog" style="border-radius:10px;width:420px;">
        <div class="modal-content">
        <div class="modal-header" style="background-color:gray;">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">close</h4>
      </div>
    <div class="modal-body">
<div>
<img  style="height:150px;width:150px;"  src="<c:url value="/static/images/{{animal.filename}}" />" />
</div>
<ul style="list-style-type:none;">
<li><b style="color:green;">animal id::</b> {{animal.anid}}</li>
<li><b style="color:green;">type::</b> {{animal.type}}</li>
<li><b style="color:green;">age::</b>  {{animal.agey}}</li>
<li><b style="color:green;">weight::</b> {{animal.weight}}</li>
<li><b style="color:green;">color::</b> {{animal.color}}</li>
<li><b style="color:green;">gender::</b> {{animal.gender}}</li>
</ul>

     </div>
     <div class="modal-footer" style="background-color:gray;">
    
     </div>
     </div>
     </div>
     </div>




 <div id="recindate" class="modal fade" role="dialog" >
        <div class="modal-dialog" style="border-radius:10px;width:420px;">
        <div class="modal-content">
        <div class="modal-header" style="background-color:gray;">
        <button type="button" class="close" data-dismiss="modal" >&times;</button>
        <h4 class="modal-title">close</h4>
      </div>
    <div class="modal-body">
     <input type="text" placeholder="day/month/year" ng-model="ad"/>  <button ng-click="inadate()">find</button>

 
     <div class="modal-footer" style="background-color:gray;">
    
     </div>
     </div>
     </div>
     </div>
</div>




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

<div id="eligibleanimal" class="modal fade" role="dialog" >
        <div class="modal-dialog" style="border-radius:10px;width:420px;margin-right:20%;">
        <div class="modal-content">
        <div class="modal-header" style="background-color:gray;">
        <button type="button" class="close" data-dismiss="modal" >&times;</button>
        <h4 class="modal-title">close</h4>
      </div>
<div class="modal-body" style="text-align:center;">
<table border="1">
<tr>
<th>id</th>
<th>price</th>
<th>source</th>
<th>weight</th>
<th>gender</th>
<th>more</th>
</tr>

<tr ng-repeat="x in animallist">
<td><b>{{x.anid}}</b>
</td>
<td>{{x.chest}}</td>
<td>{{x.source}}</td>
<td>{{x.weight}}</td>
<td>{{x.gender}}</td>
<td><button class="btn btn-dark btn-sm" ng-click="aboutanimal2(x.anid);" data-target="#aboutanimal" data-toggle="modal" >know more</button></td>
</tr>

</table>
<div class="modal-footer" style="background-color:gray;">
       </div>
     </div>
     </div>
     </div>
</div>



</body>

</html>
