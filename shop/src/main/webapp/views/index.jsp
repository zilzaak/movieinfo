<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<title>my favourite shop</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="<c:url value="/static/theme/bootstrap431.css" /> " rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="<c:url value="/static/theme/jquery340.js" />" > </script> 
<script src="<c:url value="/static/theme/angular1.8.2.js" />" > </script>
<script src="<c:url value="/static/theme/bootstrap431.js" />" > </script>


<script>
var module=angular.module("sellapp",[]);
module.controller("sellcontrol",function($scope,$http){
	$scope.ya=[];
	
	$scope.inityear=function(){
		for(i=2015;i<2040;i++){
			$scope.ya.push(i);
		}
			}
	
	
	$scope.d=['01','02','03','04','05','06','07','08','09','10','11','12','13','14','15','16','17','18','19','20','21','22','23','24','25','26',
		'27','28','29','30','31'];
	$scope.day=[];
	$scope.month=[];
	$scope.year=[];
	$scope.m=['01','02','03','04','05','06','07','08','09','10','11','12'];
$scope.y=['2015','2016','2017','2018','2019','2020','2021','2022','2023','2024','2025','2026','2027','2028','2029','2030','2031','2032','2033','2034','2035'];
	
	var o1={"productname":"", "amount":"","price":"","stringorderdate":"","note":"","due":"","company":""};
	var o2={"productname":"", "amount":"","price":"","stringorderdate":"","note":"","due":"","company":""};
	var o3={"productname":"", "amount":"","price":"","stringorderdate":"","note":"","due":"","company":""};
	
	$scope.order=[];
	$scope.order.push(o1); $scope.order.push(o2);$scope.order.push(o3);
	
	
	$scope.plusorder=function(i){
		var o={"productname":"", "amount":"","price":"","stringorderdate":"","note":"","due":"","company":""};	
		$scope.order.splice(i,0,o);
		
	}
	
	
	
	$scope.minusorder=function(i){
		
	if($scope.order.length>1){
		$scope.order.splice(i,1);	
		
	}
		
	}
	
	
	
	$scope.suborder=function(){
		var erro=""; var errd="";
	 
angular.forEach($scope.order,function(v,k){
	
	$scope.order[k].stringorderdate=$scope.day[0]+"/"+$scope.month[0]+"/"+$scope.year[0];
	
	})
	
	angular.forEach($scope.order,function(v,k){
		
		if(v.stringorderdate.length!=10){
			
			errd=errd+",date input is wrong";
		}
		
		
	if(v.productname=="" || v.amount=="" || v.price=="" || v.company==""){
		erro=erro+",empty field exist in record no "+(k+1);
		
	}
	
	})
	
	if(erro=="" && errd==""){
		document.getElementById("mbd").style.display="none";
		$http({ 
			method:"POST" , 
			url:"${pageContext.request.contextPath}/order/saveorder", 
		  	data:angular.toJson($scope.order),
		    headers:{"Content-Type":"application/json"}	
			
		        }).then(function(response){
		        	
	alert("successfully added record");
	document.getElementById("mbd").style.display="block";
	  
		        	})	
		        	
		        	
		        	
	}
	
if(erro!="" || errd!=""){
	
	alert(erro+errd);
}


	}
	
	$scope.ma=["january","february","march","april","may","june","july","august","september","october","november","december"];
		
	$scope.ma1="";$scope.ya1="";$scope.ma2=""; $scope.ya2="";$scope.ma3="",$scope.ya3=""; $scope.ya4="";
	$scope.orders1=[];
	
	$scope.tpm=null;	$scope.tpm1=null;
	$scope.tdm=null; $scope.tdm1=null;
	
	$scope.tpdinmonth=function(){
		$scope.tpm=null;
		$scope.tdm=null;
		angular.forEach($scope.orders1,function(v,k){
			
			$scope.tpm=$scope.tpm+v.price;	
			$scope.tdm=$scope.tdm+v.due;	
			
		})
		
	}
	
	$scope.tpdinmonth1=function(){
		$scope.tpm1=null;
		$scope.tdm1=null;
		angular.forEach($scope.sells1,function(v,k){
			
			$scope.tpm1=$scope.tpm1+v.price;	
			$scope.tdm1=$scope.tdm1+v.due;	
			
		})
		
	}
	
	
	$scope.orderinamonth=function(){
		$scope.s=[$scope.ma1,$scope.ya1];
		
		$http({ 
			method:"POST" , 
			url:"${pageContext.request.contextPath}/order/orderinamonth", 
		  	data:angular.toJson($scope.s),
		    headers:{"Content-Type":"application/json"}	
			
		        }).then(function(response){
		        	if(response.data.length<1){
		        		alert("no record found");
		        	}
		    $scope.orders1=response.data;
		    $scope.tpdinmonth();
		    
		        	
		         })	
		        	
		              }
	
	$scope.sellinamonth=function(){
		$scope.s1=[$scope.ma2,$scope.ya2];
		
		$http({ 
			method:"POST" , 
			url:"${pageContext.request.contextPath}/sell/sellinamonth", 
		  	data:angular.toJson($scope.s1),
		    headers:{"Content-Type":"application/json"}	
			
		        }).then(function(response){
		        	
		        	if(response.data.length<1){
		        		alert("no record found");
		        	}
		        	
		    $scope.sells1=response.data;
		    $scope.tpdinmonth1();
		    
		        	
		         })	
		        	
		              }
	
	
	$scope.cpinamonth=function(){
		$scope.s2=[$scope.ma3,$scope.ya3];
		
		$http({ 
			method:"POST" , 
			url:"${pageContext.request.contextPath}/cp/cpinamonth", 
		  	data:angular.toJson($scope.s2),
		    headers:{"Content-Type":"application/json"}	
			
		        }).then(function(response){

		    $scope.hisab1=response.data;
	
		   		        	
		         })	
		        	
		              }
	
	$scope.cpinayear=function(){
	
		$http({ 
			method:"POST" , 
			url:"${pageContext.request.contextPath}/cp/cpinayear", 
		  	data:$scope.ya4,
		    headers:{"Response-Type":"application/json","Content-Type":"text/plain"}	
			
		        }).then(function(response){
		        	
		    $scope.hisab2=response.data;
	
		    
		        	
		         })	
		        	
		              }
	
	$scope.cptotal=function(){
	
		$http({ 
			method:"GET" , 
			url:"${pageContext.request.contextPath}/cp/cptotal", 
		    headers:{"Content-Type":"application/json"}	
			
		        }).then(function(response){
		        	
		    $scope.hisab3=response.data;

		    
		        	
		         })	
		        	
		              }
	
	
	$scope.updateorder=function(p,v2){
		document.getElementById("mbd").style.display="none";
		$http({ 
			method:"POST" , 
			url:"${pageContext.request.contextPath}/order/updateorder", 
		  	data:angular.toJson(p),
		    headers:{"Content-Type":"application/json"}	
			
		        }).then(function(response){
		        	
		  alert(response.data.productname);
		  document.getElementById("mbd").style.display="block";
		  document.getElementById(v2).click();
		         })	
		        	
		       
	            }
	
	$scope.deleteorder=function(v1,v2){
		
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
					url:"${pageContext.request.contextPath}/order/deleteorder", 
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
	
	
	$scope.updatesell=function(as,v2){
		
		document.getElementById("mbd").style.display="none";
		$http({ 
			method:"POST" , 
			url:"${pageContext.request.contextPath}/sell/updatesell", 
		  	data:angular.toJson(as),
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
	
	
	
	$scope.sday=[];
	$scope.smonth=[];
	$scope.syear=[];
	
	var s1={"productname":"", "amount":"","price":"","stringselldate":"","due":"","note":"","company":""};
	var s2={"productname":"", "amount":"","price":"","stringselldate":"","due":"","note":"","company":""};
	var s3={"productname":"", "amount":"","price":"","stringselldate":"","due":"","note":"","company":""};
	 $scope.sells=[];
	 $scope.sells.push(s1);  $scope.sells.push(s2); $scope.sells.push(s3);
		
	 $scope.plussell=function(i){
	var s={"productname":"", "amount":"","price":"","stringselldate":"","due":"","note":"","company":""};
			$scope.sells.splice(i,0,s);
			
		}
		
	$scope.minussell=function(i){
			
		if($scope.sells.length>1){
			$scope.sells.splice(i,1);	
			
		}
			
		}
		
		
			
		$scope.subsell=function(){
		
			var errd=""; var erro="";
			angular.forEach($scope.sells,function(v,k){
				
				$scope.sells[k].stringselldate=$scope.sday[0]+"/"+$scope.smonth[0]+"/"+$scope.syear[0];

				
					})
					
			angular.forEach($scope.sells,function(v,k){
		
		if(v.stringselldate.length!=10){
			
			errd=errd+",date input is wrong ";
		}
		
		
	if(v.productname=="" || v.amount=="" || v.price=="" || v.company==""){
		erro=erro+",empty field exist in record no "+(k+1);
		
	}
	
	})			
					
if(erro=="" && errd==""){
	
	document.getElementById("mbd").style.display="none";
		$http({ 
			method:"POST" , 
			url:"${pageContext.request.contextPath}/sell/savesell", 
		  	data:angular.toJson($scope.sells),
		    headers:{"Content-Type":"application/json"}	
			
		        }).then(function(response){
		        	
	alert("successfully added record")
	document.getElementById("mbd").style.display="block";
		        	})	
		        	
		        	
		       }	
	
			
			if(erro!="" || errd!=""){
				alert(erro+errd);
					        	
					       }		
	
					
					
				}
		
	$scope.duesells=[];    $scope.dueorders=[];
	
	$scope.totalselldue=null;$scope.totalorderdue=null;
   $scope.byduesell=function(){
	   
	   $scope.totalselldue=null;
	   
	   $http({ 
			method:"GET" , 
			url:"${pageContext.request.contextPath}/sell/byduesell", 
		    headers:{"Content-Type":"application/json"}	
			
		        }).then(function(response){
		           	if(response.data.length<1){
		        		alert("no record found");
		        	}
		           	
		        	$scope.duesells=response.data; 
		        	
		     angular.forEach($scope.duesells,function(v,k){
		    	 
		    	 $scope.totalselldue= $scope.totalselldue+v.due;
		     })   	
		        	
	
		        	})	   
	   
		        	
		        	
		        	
		
	                    }
	
	     $scope.bydueorder=function(){
	    	 $scope.totalorderdue=null;
		        $http({ 
				   method:"GET" , 
				   url:"${pageContext.request.contextPath}/order/bydueorder", 		
			       headers:{"Content-Type":"application/json"}	
				
			        }).then(function(response){
			        	if(response.data.length<1){
			        		alert("no record found");
			        	}
			        		
			        	$scope.dueorders=response.data; 
			            angular.forEach($scope.dueorders,function(v,k){
					    	 
					    	 $scope.totalorderdue= $scope.totalorderdue+v.due;
					     })  
		
			        	})	  	
		
		         	}
	     
	    var vs1={"productname":"",
	      "amount":"","price":"","stringsampledate":""};
	    var vs2={"productname":"",
	  	      "amount":"","price":"","stringsampledate":""};
	    
	    var vs3={"productname":"",
	  	  	      "amount":"","price":"","stringsampledate":""};      
	$scope.samples=[];      
	 $scope.samples.push(vs1);     $scope.samples.push(vs2);    $scope.samples.push(vs3); 
	 
	 $scope.addsample=function(i){
		 
		    var vs={"productname":"",
			  	      "amount":"","price":"","stringsampledate":""};
					$scope.samples.splice(i,0,vs);
					
				}
				
			$scope.minussample=function(i){
					
				if($scope.samples.length>1){
					$scope.samples.splice(i,1);	
					
				}
					
				}
			
	     
	     $scope.savesample=function(){
	    	 
	    	 
	    	  angular.forEach($scope.samples,function(v,k){
	    		  
	    		  v.stringsampledate=$scope.samples[0].stringsampledate;
	    	  });
	    	 
	    		document.getElementById("mbd").style.display="none";
		        $http({ 
				   method:"POST" , 
				   url:"${pageContext.request.contextPath}/sample/save", 
				   data:angular.toJson($scope.samples),
			       headers:{"Content-Type":"application/json"}	
				
			        }).then(function(response){
	
			       alert(response.data.productname); 		
			   	document.getElementById("mbd").style.display="block";
			        	        	})	 
			        	        	
				         	}     
	    
	 $scope.shisab1=[]; $scope.shisab2=[]; $scope.shisab3=[]; $scope.shisab4=[];    
	 
	  $scope.smm="";
	  $scope.smy="";
	  
	  $scope.dtd="";  $scope.dtm="";   $scope.dty="";
	  
     $scope.sampleinadate=function(){
       	 var r=$scope.dtd+"/"+$scope.dtm+"/"+$scope.dty;   
    	 if(r.length!=10){
    		 alert("wrong date format, make correction")
    	 }
    	 if(r.length==10){
    		
 	        $http({ 
 			   method:"POST" , 
 			   url:"${pageContext.request.contextPath}/sample/sampleinadate", 
 			   data:r,
 		       headers:{"Content-Type":"text/plain","Response-Type":"application/json"}	
 			
 		        }).then(function(response){

 		      	if(response.data.sampals.length<1){
 		      		alert("no record found");
 		      	}	
 		      	$scope.shisab1=response.data;
 		      	
 		        	        	})	 
    		 
    	 }
    	 
  	
			         	}   
     
	  $scope.dtd1="";  $scope.dtm1="";   $scope.dty1="";
	  
	     $scope.sampleafteradate=function(){
	       	 var r=$scope.dtd1+"/"+$scope.dtm1+"/"+$scope.dty1; 
	       	 
	    	 if(r.length!=10){
	    		 alert("wrong date format, make correction")
	    	 }
	    	 if(r.length==10){
	    		
	 	        $http({ 
	 			   method:"POST" , 
	 			   url:"${pageContext.request.contextPath}/sample/sampleafteradate", 
	 			   data:r,
	 		       headers:{"Content-Type":"text/plain","Response-Type":"application/json"}	
	 			
	 		        }).then(function(response){

	 		      	if(response.data.sampals.length<1){
	 		      		alert("no record found");
	 		      	}	
	 		      	$scope.shisab3=response.data;
	 		      	
	 		        	        	})	 
	    		 
	    	 }
	    	 
	  	
				         	}  
	     
     $scope.sampleinamonth=function(){
    
 
       	 var r=[$scope.smm , $scope.smy];
	 		
	        $http({ 
			   method:"POST" , 
			   url:"${pageContext.request.contextPath}/sample/sampleinamonth", 
			   data:angular.toJson(r),
		       headers:{"Content-Type":"application/json"}	
			
		        }).then(function(response){
		           	if(response.data.sampals.length<1){
			      		alert("no record found");
			      	}	
		      		
		           	$scope.shisab2=response.data;
		
		        	        	})	  	
			   
     
                             }  
     
     $scope.allsample=function(){
    	    
           $http({ 
			   method:"GET" , 
			   url:"${pageContext.request.contextPath}/sample/allsample", 
			 headers:{"Content-Type":"application/json"}	
			
		        }).then(function(response){
		           	if(response.data.sampals.length<1){
			      		alert("no record found");
			      	}	
		      		
		           	$scope.shisab4=response.data;
		
		        	        	})	  	
			         	}  
     
     
     
     $scope.updatesample=function(x,i){
    	 
	        $http({ 
				   method:"POST" , 
				   url:"${pageContext.request.contextPath}/sample/update", 
				   data:angular.toJson(x),
			       headers:{"Content-Type":"application/json"}	
				
			        }).then(function(response){
			        
			      		alert(response.data.productname);
			      	  document.getElementById(i).click();
			        	        	})	
    	
 	
			         	}      
  
     
     $scope.deletesample=function(x,i){
    	 
    	 var ans=window.confirm("really want to delete?");
    	 
    	 if(ans){
    		 var ans2=window.confirm("click ok to delete");
    		 if(ans2){
    		      $http({ 
   				   method:"DELETE" , 
   				   url:"${pageContext.request.contextPath}/sample/delete", 
   				   data:angular.toJson(x),
   			       headers:{"Content-Type":"application/json"}	
   				
   			        }).then(function(response){
   			        
   			      alert(response.data.productname);
   			      document.getElementById(i).click();
   			        	        	})	  
    			 
    		 }
 	  
    		 
    	 }
    	 

 	         	}   
     
     
     
	     
	     
	  })
	  
	  

var arr=["1","2","3","4","5","6","7","8","9","c","d","e"];
function showdiv(i){
	for(var x=0;x<12;x++){
		
		if(arr[x]==i){
			
			
		document.getElementById(arr[x]).style.display="block";
		
		
		}
		
		if(arr[x]!=i){
			
			
			document.getElementById(arr[x]).style.display="none";
			
			
			}
	}
	
}


</script>


 <script type="text/javascript">
 var ss=["p","q","r","s","t"];
 
 function shos(i,el){
	 	 
	for(var x=0;x<5;x++){
		
		if(ss[x]==i){
			document.getElementById(ss[x]).style.display="block";
		
		}
		if(ss[x]!=i){
			document.getElementById(ss[x]).style.display="none";
	
		}	
		
	} 
	
	var chil = document.getElementById("fat").children;
	
	var l=chil.length;
	
	for(var t=0;t<l;t++){

		chil[t].style.background="skyblue";
		
		if(el==chil[t]){
		el.style.background="green";	el.style.color="white";
		
		}


		}
	

	
	
	
	 
 }
 
 
 </script>

<style>


body{
box-sizing:border-box;
background-image:url("/static/theme/sea.jpg");
background-size:1400px 500px;

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
<body  ng-controller="sellcontrol"  ng-app="sellapp"  ng-init="inityear();" id="mbd">
<%
if(session.getAttribute("adminuser")==null && session.getAttribute("adminpass")==null){
	response.sendRedirect("${pageContext.request.contextPath}"); 
	}

	  %>


	

<nav class="navbar navbar-expand-lg" style="margin-right:7%;margin-left:8%;margin-top:2%;border-radius:8px;background-color:darkslategrey;">
  <a class="navbar-brand" href="#" style="margin-left:5%;color:maroon;background-color:orange;">দোকানের হিসাব খাতা </a>
   <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon" style="color:white;"><b>click</b></span>
  </button> 

  <div class="collapse navbar-collapse" id="navbarSupportedContent">
    <ul class="navbar-nav mr-auto">
      <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle" href="#" style="margin-left:5%;color:white;" role="button" 
        data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
          মাল অর্ডার
        </a>
        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
          <a class="dropdown-item" href="#" onclick="showdiv('1');">মাল এর  অর্ডার  লিখুন</a>
          <a class="dropdown-item" href="#" onclick="showdiv('2');">নির্দিষ্ট মাসের মোট অর্ডার দেখুন </a>
          <a class="dropdown-item" href="#" onclick="window.open('${pageContext.request.contextPath}/searchorder')">অর্ডার ইতিহাস   সার্চ করুন </a>
             </div>
       </li>
    
       <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle" href="#" style="margin-left:5%;color:white;" role="button" 
        data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
          মাল বিক্রি 
        </a>
        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
          <a class="dropdown-item" href="#" onclick="showdiv('4');">মাল বিক্রির তথ্য   লিখুন</a>
          <a class="dropdown-item" href="#" onclick="showdiv('5');">নির্দিষ্ট মাসের  মোট বিক্রি দেখুন</a> 
   <a class="dropdown-item" href="#" onclick="window.open('${pageContext.request.contextPath}/searchsell')">বিক্রির  ইতিহাস   সার্চ করুন </a>
      
        </div>
       </li>     
      
      
    <li class="nav-item dropdown" style="padding-left:20px;">
      <a class="nav-link" href="#" style="margin-left:5%;color:white;" role="button"  onclick="showdiv('e');"
        data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
        সেম্পল </a>

     </li> 
             
              <li class="nav-item dropdown" style="padding-left:20px;">
      <a class="nav-link" href="#" style="margin-left:5%;color:white;" role="button" 
        data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
         বকেয়া </a>
               <div class="dropdown-menu" aria-labelledby="navbarDropdown">
         <a class="dropdown-item" href="#" onclick="showdiv('c');">বিক্রির  বকেয়া</a>
         <a class="dropdown-item" href="#" onclick="showdiv('d');">অর্ডারের বকেয়া </a>

            </div>
             </li>   
      
       
          <li class="nav-item dropdown" style="padding-left:20px;">
      <a class="nav-link" href="#" style="margin-left:5%;color:white;" role="button" 
        data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
        লাভ ক্ষতি </a>
               <div class="dropdown-menu" aria-labelledby="navbarDropdown">
         <a class="dropdown-item" href="#" onclick="showdiv('7');">মাসিক লাভ ক্ষতি</a>
         <a class="dropdown-item" href="#" onclick="showdiv('8');">বাতসরিক লাভ ক্ষতি</a>
       <a class="dropdown-item" href="#" onclick="showdiv('9');">মোট লাভ ক্ষতি</a>
            </div>
     </li>   
     
     
               <li class="nav-item dropdown" style="padding-left:20px;">
      <a class="nav-link" href="#" style="margin-left:5%;color:white;" role="button"  onclick="showdiv('3');"
        data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
        ক্যালকুলেটর  </a>

     </li> 
        </ul>
      </div>
</nav>


 <div  style="margin-left:8%;text-align:center;background-color:white;width:85%;display:none;font-size:0.80em;padding-bottom:15px;" id="e">

 
 <br/>
<h4>সেম্পলের   হিসাব </h4> <br/>
<div class="row" style="border:1px solid red;margin-left:2%;margin-right:2%;height:5%;" id="fat">
<div class="col" style="border:1px solid black;padding:8px;" onclick="shos('p',this);"> 
<b>সেম্পল জমা</b>
<br/>


</div>
<div class="col" style="border:1px solid black;padding:8px;" onclick="shos('q',this);">
 <b>নির্দিষ্ট তারিখের রেকর্ড</b>  
</div>

<div class="col" style="border:1px solid black;padding:8px;" onclick="shos('r',this);">
<b>নির্দিষ্ট মাসের  রেকর্ড </b> 
</div>
<div class="col" style="border:1px solid black;padding:8px;" onclick="shos('s',this);">
<b >নির্দিষ্ট  তারিখ  পরবর্তী রেকর্ড </b>  
</div>
<div class="col" style="border:1px solid black;padding:8px;" onclick="shos('t',this);">
<b>মোট সেম্পল </b> 
</div>
</div>

<div id="p" style="display:none;">
<br/>
<br/>
<h4>সেম্পল জমা</h4>
<br/>

<span> 
<b>তারিখ :(দিন/মাস/বছর)</b>
 <input type="text" ng-model="samples[0].stringsampledate"/> <br/></span><br/>
 <br/>
 
<table align="center" border="1">
<tr>
<th>ক্রমিক</th>
<th>পণ্যের <br/>
 বর্ণনা 
</th>
<th>task</th>
</tr>

<tr ng-repeat="x in samples">
<td>{{$index+1}}</td>
<td> পণ্যের  নাম <br/>
<input type="text" ng-model="x.productname"/> <br/>
  পরিমান <br/>
  <input type="text" ng-model="x.amount"/> <br/>
   
 মুল্য   <br/>
   <input type="number" ng-model="x.price"/> <br/>
   </td>
  
<td>
<button ng-click="addsample($index);">add more</button> <br/>
<br/>
<button ng-click="minussample($index);">remove</button> 
</td> 

</tr>

</table>
<br/>
<br/>
<button ng-click="savesample();">submit</button>


</div>

<div id="q" style="display:none;">
<br/>

<h4>নির্দিষ্ট  তারিখের  রেকর্ড</h4> <br/>
day<select ng-model="dtd" ng-options="c for c in d"></select>

month<select ng-model="dtm" ng-options="c for c in m"></select> 
year <select ng-model="dty" ng-options="c for c in ya"></select>

<button ng-click="sampleinadate()" class="btn btn-sm btn-dark" id="sbt1" >submit</button> <br/>
 <h4 ng-if="shisab1.sampals.length>0">Total::{{shisab1.total}}TK</h4><br/>
<table align="center" border="1" ng-if="shisab1.sampals.length>0">
<tr>
<th>ক্রমিক</th>
<th>পণ্যের <br/>
 বর্ণনা 
</th>

<th>তারিখ</th>
<th>task</th>
</tr>

<tr ng-repeat="x in shisab1.sampals">
<td>{{$index+1}}</td>
<td> পণ্যের  নাম <br/>
<input type="text" ng-model="x.productname"/> <br/>
  পরিমান <br/>
  <input type="text" ng-model="x.amount"/> <br/>
   
 মুল্য   <br/>
   <input type="number" ng-model="x.price"/> <br/>
   </td>
   
<td> 
তারিখ :(দিন/মাস/বছর)<br/>
 <input type="text" ng-model="x.stringsampledate"/> <br/></td>

<td>
<button ng-click="updatesample(x,'sbt1');">update</button> <br/>
<br/>
<button ng-click="deletesample(x,'sbt1');">delete</button> 
</td> 

</tr>

</table>

</div>


<div id="r" style="display:none;">
<br/>
<br/>
<h4>নির্দিষ্ট মাসের  রেকর্ড </h4><br/>
<br/>
 
select month <select ng-model="smm" ng-options="c for c in ma"></select> select year <select ng-model="smy" ng-options="c for c in ya"></select>

<button ng-click="sampleinamonth()" class="btn btn-sm btn-dark" id="sbt2" >submit</button> <br/>
<br/>
 <h4 ng-if="shisab2.sampals.length>0">Total::{{shisab2.total}}TK</h4> <br/>
<table align="center" border="1" ng-if="shisab2.sampals.length>0">
<tr>
<th>ক্রমিক</th>
<th>পণ্যের <br/>
 বর্ণনা 
</th>

<th>তারিখ</th>
<th>task</th>
</tr>

<tr ng-repeat="x in shisab2.sampals">
<td>{{$index+1}}</td>
<td> পণ্যের  নাম <br/>
<input type="text" ng-model="x.productname"/> <br/>
  পরিমান <br/>
  <input type="text" ng-model="x.amount"/> <br/>
   
 মুল্য   <br/>
   <input type="number" ng-model="x.price"/> <br/>
   </td>
   
<td> 
তারিখ :(দিন/মাস/বছর)<br/>
 <input type="text" ng-model="x.stringsampledate"/> <br/></td>

<td>
<button ng-click="updatesample(x,'sbt2');">update</button> <br/>
<br/>
<button ng-click="deletesample(x,'sbt2');">delete</button> 
</td> 

</tr>

</table>
 
</div>

<div id="s" style="display:none;">
<br/>
<h4>নির্দিষ্ট  তারিখ  পরবর্তী রেকর্ড</h4> <br/>
day<select ng-model="dtd1" ng-options="c for c in d"></select>
month<select ng-model="dtm1" ng-options="c for c in m"></select> 
year <select ng-model="dty1" ng-options="c for c in ya"></select>

<button ng-click="sampleafteradate()" class="btn btn-sm btn-dark" id="sbt3" >submit</button> <br/>
<br/>
 <h4 ng-if="shisab3.sampals.length>0">Total::{{shisab3.total}}TK</h4><br/>
<table align="center" border="1" ng-if="shisab3.sampals.length>0">
<tr>
<th>ক্রমিক</th>
<th>পণ্যের <br/>
 বর্ণনা 
</th>

<th>তারিখ</th>
<th>task</th>
</tr>

<tr ng-repeat="x in shisab3.sampals">
<td>{{$index+1}}</td>
<td> পণ্যের  নাম <br/>
<input type="text" ng-model="x.productname"/> <br/>
  পরিমান <br/>
  <input type="text" ng-model="x.amount"/> <br/>
   
 মুল্য   <br/>
   <input type="number" ng-model="x.price"/> <br/>
   </td>
   
<td> 
তারিখ :(দিন/মাস/বছর)<br/>
 <input type="text" ng-model="x.stringsampledate"/> <br/></td>

<td>
<button ng-click="updatesample(x,'sbt3');">update</button> <br/>
<br/>
<button ng-click="deletesample(x,'sbt3');">delete</button> 
</td> 

</tr>

</table>


</div>


<div id="t" style="display:none;">
<br/>
<h4>মোট সেম্পল</h4> 
<button ng-click="allsample()" id="sbt4">see all</button>
 <br/><br/>
 <h4 ng-if="shisab4.sampals.length>0">Total::{{shisab4.total}}TK</h4>
 <table align="center" border="1" ng-if="shisab4.sampals.length>0">
<tr>
<th>ক্রমিক</th>
<th>পণ্যের <br/>
 বর্ণনা 
</th>

<th>তারিখ</th>
<th>task</th>
</tr>

<tr ng-repeat="x in shisab4.sampals">
<td>{{$index+1}}</td>
<td> পণ্যের  নাম <br/>
<input type="text" ng-model="x.productname"/> <br/>
  পরিমান <br/>
  <input type="text" ng-model="x.amount"/> <br/>
   
 মুল্য   <br/>
   <input type="number" ng-model="x.price"/> <br/>
   </td>
   
<td> 
তারিখ :(দিন/মাস/বছর)<br/>
 <input type="text" ng-model="x.stringsampledate"/> <br/></td>

<td>
<button ng-click="updatesample(x,'sbt4');">update</button> <br/>
<br/>
<button ng-click="deletesample(x,'sbt4');">delete</button> 
</td> 
</tr>
</table>

</div>




</div>
 
 

 
 <div style="text-align:center;background-color:white;width:85%;display:none;font-size:0.80em;margin-left:8%;" id="3">
 
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
 
<h4 style="color:white;">মাল এর  অর্ডার   লিখুন</h4>
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
 
 
 <div  style="text-align:center;background-color:darkseagreen;width:85%;display:none;font-size:0.80em;margin-left:8%;" id="1">
<h4 style="color:white;">মাল এর  অর্ডার   লিখুন</h4>
<div>
<b>তারিখঃ-- *দিন/মাস/বছর</b> <br/>
<select ng-model="day[0]"  ng-options="c for c in d"></select> 

<select ng-model="month[0]" ng-options="c for c in m"></select>

<select ng-model="year[0]"  ng-options="c for c in y"></select>
</div> <br/>
<br/>
<table border="1" align="center">

<tr> 
<th>ক্রমিক নং</th>
<th>মালের বর্ণনা </th>
<th>নোট </th>
<th>task</th>
</tr>

<tr ng-repeat="x in order">
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
<b>নোট </b> <br/>
<textarea ng-model="x.note" rows="3" cols="20"></textarea> <br/>
</td>
<td>
<button ng-click="plusorder($index)" class="btn btn-sm btn-success">যোগ </button>
<br/> <br/>
<button ng-click="minusorder($index)" class="btn btn-sm btn-dark">ডিলিট </button>
</td>
</tr>
</table> <br/>

<button style="margin-left:30%;" ng-click="suborder();" class="btn btn-dark btn-sm">সাবমিট </button>
<br/><br/>
</div>



<div  style="margin-left:8%;background-color:skyblue;width:85%;display:none;font-size:0.80em;padding:20px;text-align:center;" id="2">
<h4>নির্দিষ্ট মাসের  মোট অর্ডার দেখুন</h4>

 মাসের নাম    <select ng-model="ma1" ng-options="c for c in ma"></select>
বছর   <select ng-model="ya1" ng-options="c for c in ya"></select> 
<button ng-click="orderinamonth()" class="btn btn-sm btn-dark" id="a" >find</button>
<br/>
<br/>

<div ng-if="orders1.length>0" style="padding:20px;background-color:white;border:2px solid green;">
এ মাসের মোট প্রোডাক্ট ক্রয় হয়েসে <p>{{tpm}} টাকা</p> 
এ মাসের মোট বকেয়া  <p>{{tdm}} টাকা</p> 
</div>


<br/>
<br/>
<table border="1" align="center" ng-if="orders1.length>0">
<tr> 
<th>ক্রমিক নং</th>
<th>পন্নের বর্ণনা </th>
<th>তারিখ</th>
<th>নোট </th>
<th>task</th>
</tr>

<tr ng-repeat="x in orders1">
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
<input type="text" ng-model="x.stringorderdate">
</td>
<td>
<b>নোট </b> <br/>
<textarea ng-model="x.note" rows="3" cols="20"></textarea> <br/>
</td>
<td>
<button ng-click="updateorder(x,'a')" class="btn btn-sm btn-success">আপডেট </button>
<br/> <br/>
<button ng-click="deleteorder(x,'a')" class="btn btn-sm btn-dark">ডিলিট </button>
</td>
</tr>
</table> <br/>

</div>





<div  style="margin-left:8%;background-color:darkcyan;width:85%;display:none;font-size:0.80em;padding:20px" id="3">

<h5 style="margin-left:30%;color:white;">আরও  অর্ডারের তথ্য খুজুন</h5>
	 



</div>



<div  style="text-align:center;margin-left:8%;background-color:gray;width:85%;display:none;font-size:0.80em;padding:20px" id="c">


<div>
<button ng-click="byduesell()" id="btc">বিক্রির বকেয়া   </button> 
</div> 
<br/><br/>

<h4 ng-if="duesells.length>0" style="color:red;background-color:white;" >total {{totalselldue}}TK</h4> <br/><br/>
<table border="1" align="center" ng-if="duesells.length>0">
<tr> 
<th>ক্রমিক নং</th>
<th>পন্নের বর্ণনা </th>
<th>তারিখ</th>
<th>নোট </th>
<th>task</th>
</tr>

<tr ng-repeat="x in duesells">
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
</td>
<td>
<b>নোট </b> <br/>
<textarea ng-model="x.note" rows="3" cols="20"></textarea> <br/>
</td>
<td>
<button ng-click="updatesell(x,'btc')" class="btn btn-sm btn-success">আপডেট </button>
<br/> <br/>
<button ng-click="deletesell(x,'btc')" class="btn btn-sm btn-dark">ডিলিট </button>
</td>
</tr>
</table> <br/>


</div>

<div  style="text-align:center;margin-left:8%;background-color:gray;width:85%;display:none;font-size:0.80em;padding:20px" id="d">


<div>
<button ng-click="bydueorder()" id="bts">অর্ডারের  বকেয়া </button> 
</div> 
<br/>
<br/>
<h4 ng-if="dueorders.length>0" style="color:red;background-color:white;">total {{totalorderdue}}TK</h4> <br/>
<br/><br/>
<table border="1" align="center" ng-if="dueorders.length>0">
<tr> 
<th>ক্রমিক নং</th>
<th>পন্নের বর্ণনা </th>
<th>তারিখ</th>
<th>নোট </th>
<th>task</th>
</tr>

<tr ng-repeat="x in dueorders">
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
<input type="text" ng-model="x.stringorderdate">
</td>
<td>
<b>নোট </b> <br/>
<textarea ng-model="x.note" rows="3" cols="20"></textarea> <br/>
</td>
<td>
<button ng-click="updateorder(x,'bts')" class="btn btn-sm btn-success">আপডেট </button>
<br/> <br/>
<button ng-click="deleteorder(x,'bts')" class="btn btn-sm btn-dark">ডিলিট </button>
</td>
</tr>
</table> <br/>


</div>

<div  style="text-align:center;margin-left:8%;background-color:gray;width:85%;display:none;font-size:0.80em;padding:20px" id="4">


<h4 style="color:white;">বিক্রির  তথ্য লিখুন</h4>

<div>
<b style="color:white;">তারিখঃ-- *দিন/মাস/বছর</b> <br/> 
<select ng-model="sday[0]"  ng-options="c for c in d"></select> 

<select ng-model="smonth[0]" ng-options="c for c in m"></select>

<select ng-model="syear[0]"  ng-options="c for c in y"></select>
</div> <br/><br/>

<table border="1" align="center">
<tr> 
<th>ক্রমিক নং</th>
<th>পন্নের বর্ণনা </th>
<th>নোট </th>
<th>task</th>
</tr>

<tr ng-repeat="x in sells">
<td>{{$index+1}}</td>
<td><b>*পন্যের নাম</     b><br/>
<input type="text" ng-model="x.productname"/> <br/>
<b>*কম্পানি </b><br/>
<input type="text" ng-model="x.company"/> <br/>
<b>*পরিমান</b><br/>
<input type="text" ng-model="x.amount"/> <br/>
<b>*দাম</b><br/>
<input type="number" ng-model="x.price"/> <br/>
<b>বকেয়া </b><br/>
<input type="number" ng-model="x.due"/> <br/>
</td>

<td>
<b>নোট </b> <br/>
<textarea ng-model="x.note" rows="3" cols="20"></textarea> <br/>
</td>
<td>
<button ng-click="plussell($index)" class="btn btn-sm btn-success">যোগ </button>
<br/> <br/>
<button ng-click="minussell($index)" class="btn btn-sm btn-dark">ডিলিট </button>
</td>
</tr>
</table> <br/>

<button  style="margin-left:30%;"  ng-click="subsell()" class="btn btn-success btn-sm">সাবমিট </button>

</div>






<div  style="margin-left:8%;text-align:center;background-color:burlywood;width:85%;display:none;font-size:0.80em;" id="5">
</br>
  <h4 style="text-align:center;color:white;">নির্দিষ্ট মাসের বিক্রি হিসাব </h4>

 মাসের নাম    <select ng-model="ma2" ng-options="c for c in ma"></select>
বছর   <select ng-model="ya2" ng-options="c for c in ya"></select> 
<button ng-click="sellinamonth()" class="btn btn-sm btn-dark" id="b" >find</button>
<br/>
<br/>

<div ng-if="sells1.length>0" style="padding:20px;background-color:white;border:2px solid green;">
এ মাসের মোট প্রোডাক্ট বিক্রি  হয়েসে <p>{{tpm1}} টাকা</p> 
এ মাসের মোট বকেয়া  <p>{{tdm1}} টাকা</p> 
</div>


<br/>
<br/>
<table border="1" align="center" ng-if="sells1.length>0">
<tr> 
<th>ক্রমিক নং</th>
<th>পন্নের বর্ণনা </th>
<th>তারিখ</th>
<th>নোট </th>
<th>task</th>
</tr>

<tr ng-repeat="x in sells1">
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
</td>
<td>
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


<div  style="margin-left:8%;background-color:lightblue;width:85%;display:none;font-size:0.80em;" id="6">





</div>


<div  style="margin-left:8%;text-align:center;background-color:white;width:85%;display:none;font-size:0.80em;padding-bottom:15px;" id="7">
<br/>
<h4>নির্দিষ্ট মাসের লাভ ক্ষতি</< </h4> <br/>
<br/>
 মাসের নাম    <select ng-model="ma3" ng-options="c for c in ma"></select>
বছর   <select ng-model="ya3" ng-options="c for c in ya"></select> <button ng-click="cpinamonth()" class="btn btn-sm btn-dark">find</button>
<br/>
<br/>
<table border="1" align="center">
<tr>
<th>মোট  প্রোডাক্ট অর্ডার </th>
<th>{{hisab1.totalorder}} টাকা </th>
</tr>
<tr>
<th>প্রোডাক্ট অর্ডারের বকেয়া  </th>
<th>{{hisab1.orderdue}} টাকা </th>
</tr>
<tr>
<th>মোট   বিক্রি </th>
<th>{{hisab1.totalsell}} টাকা </th>
</tr>
<tr>
<th>কাস্টমারের বকেয়া </th>
<th>{{hisab1.selldue}} টাকা  </th>
</tr>

<tr>

<th>লাভ=মোট বিক্রি - মোট প্রোডাক্ট  অর্ডার </th>
<th>{{hisab1.profit}} টাকা </th>
</tr>

</table>
</div>

<div  style="margin-left:8%;text-align:center;background-color:white;width:85%;display:none;font-size:0.80em;padding-bottom:15px;" id="8">
<br/>
     <h4>বার্ষিক  লাভ ক্ষতি</h4>  <br/>
   বছর   <select ng-model="ya4" ng-options="c for c in ya"></select> <button ng-click="cpinayear()" class="btn btn-sm btn-dark">find</button>  
     
<br/><br/>
<table border="1" align="center">
<tr>
<th>মোট  প্রোডাক্ট অর্ডার </th>
<th>{{hisab2.totalorder}} টাকা  </th>
</tr>
<tr>
<th>প্রোডাক্ট অর্ডারের বকেয়া  </th>
<th>{{hisab2.orderdue}} টাকা  </th>
</tr>
<tr>
<th>মোট   বিক্রি </th>
<th>{{hisab2.totalsell}} টাকা </th>
</tr>
<tr>
<th>কাস্টমারের বকেয়া </th>
<th>{{hisab2.selldue}} টাকা </th>
</tr>

<tr>

<th>লাভ=মোট বিক্রি - মোট প্রোডাক্ট  অর্ডার </th>
<th>{{hisab2.profit}} টাকা </th>
</tr>

</table>

</div>

<div  style="margin-left:8%;text-align:center;background-color:white;width:85%;display:none;font-size:0.80em;padding-bottom:15px;" id="9">
<br/>
<h4>মোট  লাভ ক্ষতি </h4><br/>
<br/>
<button ng-click="cptotal()" class="btn btn-sm btn-dark">find</button>  <br/><br/>

<table border="1" align="center">
<tr>
<th>মোট  প্রোডাক্ট অর্ডার </th>
<th>{{hisab3.totalorder}} টাকা  </th>
</tr>
<tr>
<th>প্রোডাক্ট অর্ডারের বকেয়া  </th>
<th>{{hisab3.orderdue}} টাকা  </th>
</tr>
<tr>
<th>মোট   বিক্রি </th>
<th>{{hisab3.totalsell}} টাকা </th>
</tr>
<tr>
<th>কাস্টমারের বকেয়া </th>
<th>{{hisab3.selldue}} টাকা </th>
</tr>

<tr>

<th>লাভ=মোট বিক্রি - মোট প্রোডাক্ট  অর্ডার </th>
<th>{{hisab3.profit}} টাকা </th>
</tr>

</table>


</div>



</body>

</html>
