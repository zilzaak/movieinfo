<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<title>Home page</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="<c:url value="/static/theme/bootstrap431.css" /> " rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="<c:url value="/static/theme/jquery340.js" />" > </script> 
<script src="<c:url value="/static/theme/angular1.8.2.js" />" > </script>
<script src="<c:url value="/static/theme/bootstrap431.js" />" > </script>




<script>

var i=1900; 

var mod = angular.module("myapp",[]);

mod.controller("mycon",function($scope,$http){
	
	$scope.fg={"del":"","pass":""};
	
	$scope.getimage=function(i){
		
		$http({
			method:"POST",
			url:"${pageContext.request.contextPath}/animal/aboutanimal",
			data:$scope.unphoto[i].anid,
			headers: {"Content-Type":"application/json"}}).
			then(function(response){
				
		if(response.data.filename=="not"){
		
			alert("please upload a image to see the image");
			
		}	
		
		if(response.data.filename!="not"){
			$scope.unphoto[i]=response.data;
		angular.forEach($scope.pre,function(v,j){
			
		if(v.anid==$scope.unphoto[i].anid)	{
			
			$scope.pre[j]=$scope.unphoto[i];
		}
			
		})	
	}
		
	   })		
		
	}
	
	$scope.cleardatabase=function(r){
		$scope.fg.del=r;
		var answer = window.confirm("do you want to delete ???");
		if(answer){
			var answer2 = window.confirm("it will delete all data are you agree???");	
			
			if(answer2){
				
				var name = prompt("enter the password to confirm");
				$scope.fg.pass=name;
				
				$http({
					method:"POST",
					url:"${pageContext.request.contextPath}/delete/deleteit",
					data:angular.toJson($scope.fg),
					headers: {"Content-Type":"application/json"}}).
					then(function(response){
		alert(response.data.del);
					
			   })
			   
			}
		}
				}
	
	
	$scope.admininfo=function(){
		$http({
			method:"GET",
			url:"${pageContext.request.contextPath}/getadmin",
			headers: {"Content-Type":"application/json"}}).
			then(function(response){
$scope.admin=response.data;
			
	   })	
		
	}

	
	
	$scope.changepassword=function(){
		var d ="";
		
	if($scope.password1!=$scope.password2){
		
		d=d+"password not match , ";
		
	}	
	
	if($scope.password1.length<6){
		
		d=d+"minimum password length=6";
		
	}	
	

	if(d==""){
		var r = {"email":"","password":$scope.password1,"code":$scope.oldpassword};
		
		$http({
			method:"POST",
			url:"${pageContext.request.contextPath}/changepassword",
			data: angular.toJson(r),
			headers: {"Content-Type":"application/json"}}).
			then(function(response){

				alert(response.data.code);
						        })	
		
	}
	
	
	if(d!=""){
		alert(d);
	}
		
	}
	

	$scope.admin={"email":"","password":"","code":"","gmailspass":""};
	
$scope.changeemail=function(){
	
	$http({
		method:"POST",
		url:"${pageContext.request.contextPath}/changeemail",
		data: angular.toJson($scope.admin),
		headers: {"Content-Type":"application/json"}}).
		then(function(response){

if(response.data.code=="sent"){
	
	document.getElementById("codecheck").style.display="block";
}

if(response.data.code!="sent"){
	
	alert(response.data.code);
}
					       
		})	
					        
		}	
	
	
	
$scope.finalchangeemail=function(){
	
	$http({
		method:"POST",
		url:"${pageContext.request.contextPath}/finalchangeemail",
		data: $scope.submitcode,
		headers: {"Content-Type":"text/plain","responseType":"application/json"}}).
		then(function(response){

		alert(response.data.del);	
			
		})	
		
					        
		}	
	
	$scope.changenumber=function(){
		
		$http({
			method:"POST",
			url:"${pageContext.request.contextPath}/changenumber",
			data: angular.toJson($scope.adminnumber),
			headers: {"Content-Type":"application/json"}}).
			then(function(response){

			alert(response.data.del);	
				
			})	
		
	}
	
$scope.animalform=[];
var an1={
		"gender":"", "type":"","color":"","chest":null,"height":"","hu":"","weight":"","wu":"","source":"",
		"stringbdate":"","extra":"","marketname":"","sellername":"","jaat":""
				
	  };
var an2={
		"gender":"", "type":"","color":"","chest":null,"height":"","hu":"","weight":"","wu":"","source":"",
		"stringbdate":"","extra":"","marketname":"","sellername":"","jaat":""			
				
	  };
$scope.animalform.push(an1);$scope.animalform.push(an2);		

	$scope.years=[];
	$scope.ds=[];
	$scope.ms=[];
	$scope.ys=[];
	$scope.days=['01','02','03','04','05','06','07','08','09','10','11','12','13','14','15','16','17','18','19','20','21','22','23','24','25','26',
		'27','28','29','30','31'];
	
	$scope.mfi=['01','02','03','04','05','06','07','08','09','10','11','12'];
	$scope.brown=[]; 
	$scope.black=[]; 
	$scope.gray=[];
	$scope.white=[];
	
$scope.animalprice=null; $scope.numberofanimal=null;
$scope.brown1="";    $scope.black1="";     $scope.gray1="";     $scope.white1="";
	
	$scope.inityear=function(){
		
		for(var k=i;k<=3000;k++){
			
			$scope.years.push(k);
	
			
		}
		

		for(var k=0;k<=200;k++){
	
			$scope.brown[k]="";
			$scope.black[k]=""; 
			$scope.gray[k]="";
			$scope.white[k]="";
			
				}		
		
		
		
	}
	
	

	
	
	$scope.sdate=function(i){
		
		
	$scope.animalform[i].stringbdate=$scope.ds[i]+"/"+$scope.ms[i]+"/"+$scope.ys[i];

		
	}
	
	
$scope.addrowani=function(){
	
	var x={
			"gender":"", "type":"","color":"","chest":null,"height":"","hu":"","weight":"","wu":"","source":"",
			"stringbdate":"","extra":"","marketname":"","sellername":"","jaat":""		
					
		  }
	
	$scope.animalform.push(x);
	
}



$scope.removerowani=function(){
	var length=$scope.animalform.length;
	$scope.animalform.splice(length-1, 1); 
	
}






$scope.chooseanicolor=function(i,v){
	
if(v=='brown'){
if($scope.brown[i]==""){
	
	$scope.brown[i]='brown';
}	

else{
	$scope.brown[i]="";
}
	

}



if(v=='black'){
	if($scope.black[i]==""){
		
		$scope.black[i]='black';
		
		      }	

	else{
		$scope.black[i]="";
	}
	
}




if(v=='gray'){
	if($scope.gray[i]==""){
		
		$scope.gray[i]='gray';
	}	

	else{
		$scope.gray[i]="";
	}	
	
}

if(v=='white'){
	if($scope.white[i]==""){
		
		$scope.white[i]='white';
	}	

	else{
		$scope.white[i]="";
	}	
	
}

	
	
}



$scope.manage=function(){
	
angular.forEach($scope.animalform,function(v,i){
	
	v.color=$scope.black[i]+$scope.white[i]+$scope.brown[i]+$scope.gray[i];

})	
	
}


$scope.photoupload=function(){

	$http({
		method:"GET",
		url:"${pageContext.request.contextPath}/animal/unphoto",
		headers: {"Content-Type":"application/json"}}).
		then(function(response){
	$scope.unphoto=response.data;
	$scope.pre=response.data;
	$scope.calculateprice();
	
	document.getElementById("cam").click();


		
		        })
	
                    }





$scope.s={
	 "type":"","color":"","agey":"","weight":"","wu":"","height":""	,"anid":null
				
	  }




$scope.choosecolor=function(i){
	
if(i=="black"){
	if($scope.black1=="black"){
		$scope.black1="";
	}
	else{
		$scope.black1="black";
	}
	
	
}	
if(i=="brown"){
	
	if($scope.brown1=="brown"){
		$scope.brown1="";
	}
else{
	$scope.brown1="brown";	
}	

	
}

if(i=="white"){
if($scope.white1=="white"){
	
$scope.white1="";	
}	
else{
	$scope.white1="white";	
}

	
	
}

if(i=="gray"){
	
	if($scope.gray1=="gray"){
		$scope.gray1="";
	}
	
else {
	$scope.gray1="gray";
	}
}
	
}


$scope.calculateprice=function(){
	$scope.animalprice=0;
	$scope.numberofanimal=$scope.unphoto.length;
	angular.forEach($scope.unphoto,function(v,i){
	$scope.animalprice=	$scope.animalprice+v.chest;
		
	})
}


$scope.sbytype=function(){
	
	if($scope.s.type=="all"){
		
		$scope.photoupload();
	}
	
	else{
		
		$http({
			method:"POST",
			url:"${pageContext.request.contextPath}/search/bytype",
			data: angular.toJson($scope.s),
			headers: {"Content-Type":"application/json"}}).
			then(function(response){
				if(response.data.length<1){
					alert("no record found")
				}
		$scope.unphoto=response.data;
		$scope.calculateprice();
			$scope.pre=response.data;

			
			        })
		
	}
	
	
	
	
}





$scope.sbid;


$scope.sbyid=function(){

	$http({
			method:"POST",
			url:"${pageContext.request.contextPath}/search/byid",
			data: angular.toJson($scope.s),
			headers: {"Content-Type":"application/json"}}).
			then(function(response){
	if(response.data.extra=="notfound"){
		alert("animal not found ");
		$scope.sbid=null;
	}
	if(response.data.extra!="notfound"){
		$scope.sbid=response.data;
	}	
				
		
			        })
		
	
}







$scope.filterg=function(i){
	
	$scope.up=[];
	
	if(i=="all"){
		$scope.up=$scope.pre;	
		
	}
	
	else if(i=="---"){
		
		$scope.up=$scope.pre;	
	}
	
	else{
		angular.forEach($scope.pre,function(v,k){
			
			if(v.gender==i){
				$scope.up.push(v);
				  }
			
		})	
		
	}


$scope.unphoto=$scope.up;
$scope.calculateprice();
}

$scope.bytypeageupper=function(){
	$scope.s.color=$scope.black1+$scope.white1+$scope.brown1+$scope.gray1;
	
	$http({
		method:"POST",
		url:"${pageContext.request.contextPath}/search/bytypeageupper",
		data: angular.toJson($scope.s),
		headers: {"Content-Type":"application/json"}}).
		then(function(response){
			if(response.data.length<1){
				alert("no record found")
			}
	$scope.unphoto=response.data;
	$scope.calculateprice();
	$scope.pre=response.data;	

		
		        })
	
	
                   }
                   
                   
                   
$scope.aui=null;


$scope.updateani=function(i){
	$scope.editani=$scope.unphoto[i];
	$scope.aui=i;
		
}

$scope.removefrompre=function(l){

  angular.forEach($scope.pre,function(v,i){
	
	  if(v.anid==$scope.unphoto[l].anid){
		  
		  $scope.pre.splice(i,1);
		  $scope.unphoto.splice(l,1);
		
			alert("you have deleted successfully");
	  }
  })  
  
  
	$scope.calculateprice();
		
}

$scope.updatefrompre=function(){
$scope.unphoto[$scope.aui]=$scope.editani;
	  angular.forEach($scope.pre,function(v,i){
		
		  if(v.anid==$scope.unphoto[$scope.aui].anid){
			  
			v=$scope.unphoto[$scope.aui];			 
		  }
	  }) 
	  	
	  alert("updated animal successfully")
		$scope.calculateprice();
			
	}



$scope.deleteanimal=function(ind){
	
		var answer = window.confirm("want to delete ??");
		
		if(answer){
			var asdf = window.confirm("really want to delete");	
			
			if(asdf){	
				
				var zik=prompt("enter password to delete");
				
				$http({
					method:"POST",
					url:"${pageContext.request.contextPath}/checkuser",
					data:zik,
					headers: {"Content-Type":"plain/text","Response-Type":"application/json"}}).
				    then(function(response){
				 	if(response.data.del=="ok"){
				 		
						$http({
							method:"POST",
							url:"${pageContext.request.contextPath}/delete/deleteanimal",
							data: angular.toJson($scope.unphoto[ind]),
							headers: {"Content-Type":"application/json"}}).
							then(function(response){

				$scope.removefrompre(ind);	
							}) 	
				 		}
				 	
				 	
					if(response.data.del=="no"){
						
					alert("password is wrong");	
					
					}
				 	
				 	
				    });
						
			} 
			
		}
			
	
}


$scope.animalinadate=function(){
		
	$http({
		method:"POST",
		url:"${pageContext.request.contextPath}/search/buyingdate",
		data: $scope.sellerdate,
		headers: {"Content-Type":"text/plain","Response-Type":"application/json"}}).
		then(function(response){
			$scope.unphoto=response.data;
			$scope.calculateprice();
			$scope.pre=response.data;	

		}) 	
}



$scope.animalinadate2=function(){
	$http({
		method:"POST",
		url:"${pageContext.request.contextPath}/search/buyingdate2",
		data:$scope.sellerdate,
		headers: {"Content-Type":"text/plain","Response-Type":"application/json"}}).
		then(function(response){
			if(response.data.length<1){alert("no record found")}
			if(response.data.length>0){			
				$scope.unphoto=response.data;
			$scope.calculateprice();
			$scope.pre=response.data;	
			}


		}) 		
	
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

$scope.finalupdateani=function(){
	$scope.editani.color=$scope.black1+$scope.white1+$scope.brown1+$scope.gray1;
	
	var errday="n";
	var errn="n";
	var dn=$scope.checkdate($scope.editani.stringbdate);
	
	if($scope.editani.stringbdate.length<8 || dn!=2){
		errday="y";
	}
	
	if($scope.editani.chest==null || $scope.editani.color==""){
		
		errn="y";
	}
	
	
	if(errday=="n" && errn=="n"){
		
		$http({
			method:"POST",
			url:"${pageContext.request.contextPath}/animal/updateanimal",
			data: angular.toJson($scope.editani),
			headers: {"Content-Type":"application/json"}}).
			then(function(response){
	
$scope.updatefrompre();

			        })	
		
	}
	
	if(errday=="y" || errn=="y")	{
		
		alert("form input is wrong ,check again");
	}
	
	
}


$scope.bytypeagelower=function(){
	$scope.s.color=$scope.black1+$scope.white1+$scope.brown1+$scope.gray1;

	$http({
		method:"POST",
		url:"${pageContext.request.contextPath}/search/bytypeagelower",
		data: angular.toJson($scope.s),
		headers: {"Content-Type":"application/json"}}).
		then(function(response){
			if(response.data.length<1){
				alert("no record found")
			}
	$scope.unphoto=response.data;
	$scope.calculateprice();
	$scope.pre=response.data;	
		        })
	
	          
	             }
	             
	             
	             
$scope.bytypeandprice=function(){
	$scope.s.color=$scope.black1+$scope.white1+$scope.brown1+$scope.gray1;

	$http({
		method:"POST",
		url:"${pageContext.request.contextPath}/search/bytypeandprice",
		data: angular.toJson($scope.s),
		headers: {"Content-Type":"application/json"}}).
		then(function(response){
			if(response.data.length<1){
				alert("no record found")
			}
	$scope.unphoto=response.data;
	$scope.calculateprice();
	$scope.pre=response.data;	
		        })
	
	          
	             }




$scope.bytypecolorweightupper=function(){
	$scope.s.color=$scope.black1+$scope.white1+$scope.brown1+$scope.gray1;
	
	$http({
		method:"POST",
		url:"${pageContext.request.contextPath}/search/bytypecolorweightupper",
		data: angular.toJson($scope.s),
		headers: {"Content-Type":"application/json"}}).
		then(function(response){
			if(response.data.length<1){
				alert("no record found")
			}
	$scope.unphoto=response.data;
	$scope.calculateprice();
	$scope.pre=response.data;
		
		        })

	
}

$scope.bytypecolorweightlower=function(){
	$scope.s.color=$scope.black1+$scope.white1+$scope.brown1+$scope.gray1;
	
	$http({
		method:"POST",
		url:"${pageContext.request.contextPath}/search/bytypecolorweightlower",
		data: angular.toJson($scope.s),
		headers: {"Content-Type":"application/json"}}).
		then(function(response){
			if(response.data.length<1){
				alert("no record found")
			}
	$scope.unphoto=response.data;	$scope.calculateprice();
	$scope.pre=response.data;
		        })
		
	
}


$scope.bytypecolor=function(){
	$scope.s.color=$scope.black1+$scope.white1+$scope.brown1+$scope.gray1;

	$http({
		method:"POST",
		url:"${pageContext.request.contextPath}/search/bytypecolor",
		data: angular.toJson($scope.s),
		headers: {"Content-Type":"application/json"}}).
		then(function(response){
	$scope.unphoto=response.data;	$scope.calculateprice();
	$scope.pre=response.data;
		        })
		
	
}





$scope.addanimal=function(){
$scope.manage();
var err="no";

angular.forEach($scope.animalform,function(v,i){
	if(v.stringbdate.length!=10 || v.type=="" || v.chest==null || v.chest==0 || v.gender=="" || v.source=="" || v.color==""){
		err="ye";
	}
})

if(err=="ye"){
	
	alert("error form ");
}
if(err=="no"){
	$http({
		method:"POST",
		url:"${pageContext.request.contextPath}/animal/add",
		data: angular.toJson($scope.animalform),
		headers: {"Content-Type":"application/json"}}).
		then(function(response){
		alert('suuccessful');
		location.reload();
		})	
}
		

	
	
}	



	$scope.presrecord=function(v){
		
		$http({
			method:"POST",
			url:"${pageContext.request.contextPath}/prescribe/presrecord",
			data: angular.toJson(v),
			headers: {"Content-Type":"application/json"}}).
			then(function(response){
		
				$scope.presrecords=response.data;
				if($scope.presrecords[0].itemid==""){
					alert("ohhh, sorry ,no record created");
				}
				else{
					document.getElementById("presrecordbtn").click();
				}
				
			
			        })	

			}
	
	$scope.bysellername=function(){
		

		$http({
			method:"POST",
			url:"${pageContext.request.contextPath}/search/bysellername",
			data:$scope.sellername,
			headers: {"Content-Type":"text/plain","Response-Type":"application/json"}}).
			then(function(response){
				$scope.unphoto=response.data;	
				$scope.calculateprice();
				$scope.pre=response.data;

			});	
						
	}
			
	
	$scope.bymarketname=function(){
		$http({
			method:"POST",
			url:"${pageContext.request.contextPath}/search/bymarketname",
			data:$scope.marketname,
			headers: {"Content-Type":"text/plain","Response-Type":"application/json"}}).
			then(function(response){
				$scope.unphoto=response.data;	
				$scope.calculateprice();
				$scope.pre=response.data;	
				
			});

	}	
	
	
	
	$scope.byjaat=function(){

		$http({
			method:"POST",
			url:"${pageContext.request.contextPath}/search/byjaat",
			data:$scope.jaat,
			headers: {"Content-Type":"text/plain","Response-Type":"application/json"}}).
			then(function(response){
				$scope.unphoto=response.data;	
				$scope.calculateprice();
				$scope.pre=response.data;	
				
			});
		
	}	

	
$scope.setr=[];
	
	$scope.updateanimal=function(j){
		
		$http({
			method:"PUT",
			url:"${pageContext.request.contextPath}/prescribe/updateanimal",
			data: angular.toJson(j),
			headers: {"Content-Type":"application/json"}}).
			then(function(response){
               alert("successfully updated");

           
			             })	
	
	}
	
	$scope.setstyle=function(i){
	 
		$scope.setr[i]='t';
	    $scope.photoupload();
		
	}
	
	$scope.checkstyle=function(i){
var z='t';
		if($scope.setr[i]=='t'){

			z='t';
		}
		if($scope.setr[i]==null){

			z='f';
		}
		
		return z;
		
	}
	
	
	$scope.presupdate=function(j){
		var d="rt";
	     alert(j.prestypenumber);
		$http({
				method:"POST",
				url:"${pageContext.request.contextPath}/prescribe/updatepres",
				data: angular.toJson(j),
				headers: {"Content-Type":"application/json"}}).
				then(function(response){
                   alert(response.data.consult);
   
               
				             })	
			
	         			
	               }
	
	var ansc=['one','two','three','four','five','six','seven','eight','nine','ten','eleven','twelve','thirteen','fourteen'];
	
	$scope.hukk=function(x){
		
		$scope.gray1=""; $scope.brown1=""; $scope.black1=""; $scope.white1="";
	for(var i=0;i<ansc.length;i++){
		if(x==ansc[i]){
			document.getElementById(ansc[i]).style.display="block";
		}
		if(x!=ansc[i]){
			document.getElementById(ansc[i]).style.display="none";
		}
	}
	
		
	}
	
	
	
	$scope.dc="";
	$scope.mc="";
	$scope.yc="";	  
	$scope.mrate=null; 
$scope.tamount=0;$scope.tprice=0;
	
$scope.dupidexist=['n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n',
	               'n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n',
		           'n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n']

	$scope.milklist=[];
	
var ml1={"rate":null,"totalprice":null,"amount":null,"animaltype":"","stringcollectdate":"","anid":null}; 
var ml2={"rate":null,"totalprice":null,"amount":null,"animaltype":"","stringcollectdate":"","anid":null}; 
var ml3={"rate":null,"totalprice":null,"amount":null,"animaltype":"","stringcollectdate":"","anid":null};
$scope.milklist.push(ml1);$scope.milklist.push(ml2);$scope.milklist.push(ml3);
	
	$scope.addrowm=function(){
		
		var x={"rate":null,"totalprice":null,"amount":null,"animaltype":"","stringcollectdate":"","anid":null};
		
		if($scope.milklist.length>29){
		alert("can not add 30+ record at a time,save first")	
			
		}
		else{
			$scope.milklist.push(x);	
		}
		
		
		
	                        }
	
	$scope.removerowm=function(){
		var length= $scope.milklist.length;
		if(length>1){
			$scope.milklist.splice(length-1,1);
		}
		
      	}
	

	
	$scope.setprice=function(x,i){
		
		$scope.milklist[i].totalprice=($scope.mrate)*(x.amount);

		
	                               }
	
	$scope.pricerate=function(r){
		angular.forEach($scope.milklist,function(v,i){
			v.totalprice=r*v.amount;
		})
		
       }
	
	
	$scope.checkduplicate=function(j,x){
		var milkerr='n';
	angular.forEach($scope.milklist,function(v,i){
		if(i!=j){
			if(x.anid==v.anid){
			milkerr='y';

			}	
				
		}
  	})
	
	if(milkerr=='y'){
		$scope.dupidexist[j]='y';
                   	}
	if(milkerr=='n'){
	$scope.dupidexist[j]='n';

                   	}
	
	}
	
	
	
	$scope.duplicateid=function(i){
		
	if($scope.dupidexist[i]=='y'){

		return 'ok';
	}
	if($scope.dupidexist[i]=='n'){
		
		return 'no';
	}
		
              }
	
$scope.addmilk=function(){
	
angular.forEach($scope.milklist,function(v,i){
	v.stringcollectdate=$scope.dc+"/"+$scope.mc+"/"+$scope.yc;	
	v.rate=$scope.mrate;	

		})
	
	var errd='n';
	var errf='n';
	angular.forEach($scope.milklist,function(v,i){
			
	if(v.anid==null || v.animaltype==null || v.amount==null || $scope.mrate==null || v.stringcollectdate=="//" || v.stringcollectdate.length!=10){
		errf="blank filed not allowed";
	}	
		
	})
	
		angular.forEach($scope.dupidexist,function(v,i){
		
	if(v=='y'){
		errd="duplicate id invalid";
	}	
		
	})
	

	if(errf=='n' && errd=='n'){
		$http({
			method:"POST",
			url:"${pageContext.request.contextPath}/milk/addmilk",
			data:angular.toJson($scope.milklist),
			headers: {"Content-Type":"application/json"}}).
			then(function(response){
	        
	         alert(response.data[0].stringcollectdate);      
			             })	
	}
	
	if(errf!='n' || errd!='n'){
		alert("ohhh sorry,"+errd+","+errf);
	}
	

			             
	    
}

$scope.bydatebefore=function(){
var s=$scope.checkdate($scope.bdb);
if(s==2 && $scope.bdb.length>7){
	
	$http({
		method:"POST",
		url:"${pageContext.request.contextPath}/search/bydatebefore",
		data:$scope.bdb,
		headers: {"Content-Type":"application/json"}}).
		then(function(response){
	           if(response.data.length<1){
	        	   alert("no record found");
	           }
			$scope.unphoto=response.data;	
			$scope.calculateprice();
			$scope.pre=response.data;	
       
		             })	
		             
}

if(s!=2 && $scope.bdb.length<8){
	alert("wrong date");
	
}

	
}

$scope.bydateafter=function(){
	var s=$scope.checkdate($scope.bda);
	if(s==2 && $scope.bda.length>7){
		$http({
		method:"POST",
		url:"${pageContext.request.contextPath}/search/bydateafter",
		data:$scope.bda,
		headers: {"Content-Type":"application/json"}}).
		then(function(response){
           if(response.data.length<1){
        	   alert("no record found");
           }
			$scope.unphoto=response.data;	
			$scope.calculateprice();
			$scope.pre=response.data;	
		             })		
	}
	if(s!=2 && $scope.bda.length<8){
		alert("wrong date");
	}

	
                    }



$scope.bysource=function(){

	$http({
		method:"POST",
		url:"${pageContext.request.contextPath}/search/bysource",
		data:$scope.animalsource,
		headers: {"Content-Type":"application/json"}}).
		then(function(response){
			$scope.unphoto=response.data;	
			$scope.calculateprice();
			$scope.pre=response.data;	
			
		             })		
	
          }



$scope.updatecmt=function(wq){
	var s="y"
	var k=""; var d="";
	if(wq.stringcollectdate.length!=10){
		k="sorry date must contain 10 character";
		s="n";
	}
	if(wq.amount==null || wq.rate==null){
		d="blank field";
		s="n";
	}
	
if(s=="y"){
	$http({
		method:"PUT",
		url:"${pageContext.request.contextPath}/milk/updatecm",
		data:angular.toJson(wq),
		headers: {"Content-Type":"application/json"}}).
		then(function(response){
			
	      alert(response.data.stringcollectdate); 
	   
		             })		
             }
	
	
	if(s=="n"){
		alert(d+" "+k);
	}
                    }
			  
              
              
              
              
              


	$scope.totalmilk=function(){
		$scope.tamount=0; $scope.tprice=0;
		  angular.forEach($scope.milklist,function(v,i){
		$scope.tamount=v.amount+$scope.tamount;
		$scope.tprice=v.totalprice+$scope.tprice;
		
			  })
		
              
	             }                     
	                     
	                     
	                     
	  $scope.clearmilk=function(){
		  
		  angular.forEach($scope.milklist,function(v,i){
			v.anid=null; v.animaltype=""; v.rate=null; v.amount=null;v.totalprice=null;v.stringcollectdate="";
		  })
		  
		  	angular.forEach($scope.dupidexist,function(v,i){

		     v='n';
                	})
	  }   
	  
	  
	  $scope.tamountc=0;    $scope.tpricec=0;  
	  
	$scope.searchcollectdate=function(){
		
		$http({
			method:"POST",
			url:"${pageContext.request.contextPath}/milk/collectbydate",
			data:$scope.collectdate,
			headers: {"Content-Type":"text/plain","Response-Type":"application/json"}}).
			then(function(response){
	        $scope.recsbydate=response.data;
			  angular.forEach($scope.recsbydate,function(v,i){
					$scope.tamountc=v.amount+$scope.tamountc;
					$scope.tpricec=v.totalprice+$scope.tpricec;
						  })
	        
			             })	
		           
	}  
	  
	$scope.updatecollect=function(i){
		
		$http({
			method:"PUT",
			url:"${pageContext.request.contextPath}/milk/updatecollect",
			data:angular.toJson($scope.recsbydate[i]),
			headers: {"Content-Type":"application/json"}}).
			then(function(response){
	        alert("updated successfully");
	        
			             })	
		           
	}  
	
	$scope.tcm=0; $scope.ttm=0; $scope.cmlst=[]; 
	$scope.coll={"id":"","rate":"","date":""};
	
	$scope.tmilkrecord=0; 
	$scope.tmilktaka=0; 
	$scope.tmilkkg=0;
	$scope.collectm=function(){	
		
			$http({
			method:"GET",
			url:"${pageContext.request.contextPath}/milk/collection",
			headers: {"Content-Type":"application/json"}}).
		    then(function(response){
	      $scope.cmlst=response.data;
	      $scope.tmilkrecord=response.data.length;
	 angular.forEach($scope.cmlst,function(v,i){
			
			$scope.tmilktaka=$scope.tmilktaka+v.totalprice; 
			$scope.tmilkkg=$scope.tmilkkg+v.amount;
		 
	 });
	      
	      
	        $scope.tpa();
	      
			             })	
			             
			             
		           
                  	} 
	
	
	
	$scope.filterid=function(){

		
		$http({
			method:"POST",
			url:"${pageContext.request.contextPath}/milk/filterid",
			data:angular.toJson($scope.coll.id),
			headers: {"Content-Type":"application/json"}}).
		    then(function(response){
	      $scope.cmlst=response.data;	   
	        $scope.tpa();
	      
			             })	
			             
	         
                     }  
	
	
	
	$scope.filterrate=function(){
	
	$http({
		method:"POST",
		url:"${pageContext.request.contextPath}/milk/filt",
		data:angular.toJson($scope.coll.rate),
		headers: {"Content-Type":"application/json"}}).
	    then(function(response){
      $scope.cmlst=response.data;
   
        $scope.tpa();
      
		             })	 
	
         	}  	
	
	
	
	$scope.filteryear=function(){
		

		$http({
			method:"POST",
			url:"${pageContext.request.contextPath}/milk/filterdate",
			data:$scope.coll.date,
			headers: {"Content-Type":"plain/text","Response-Type":"application/json"}}).
		    then(function(response){
	      $scope.cmlst=response.data;
	       $scope.tpa();
	      
			             })		
	                          
	                       }
	
	
	$scope.tpa=function(){
		$scope.tcm=0; $scope.ttm=0;
	angular.forEach($scope.cmlst,function(v,i){
		$scope.tcm=$scope.tcm+v.amount;
		$scope.ttm=$scope.ttm+v.totalprice;
		
		})
			
     	} 
	
	
	
	  
$scope.selld="";$scope.sellm="";$scope.selly="";	  
$scope.sellrate=null;	  
	$scope.tsellprice; $scope.tsellamount; $scope.mselldue; 
$scope.sellmilk=[];	  
 var x1={"buyername":"", "amount":null, "rate":null, "totalprice":null, "due":"", "stringselldate":null,"contact":""};
var y1={"buyername":"", "amount":null, "rate":null, "totalprice":null, "due":"", "stringselldate":null,"contact":""};
var z1={"buyername":"", "amount":null, "rate":null, "totalprice":null, "due":"", "stringselldate":null,"contact":""};
	 $scope.sellmilk.push(x1);  $scope.sellmilk.push(y1);  $scope.sellmilk.push(z1); 
	  

	 
	 $scope.totalsell=function(){
	$scope.tsellprice=0; $scope.tsellamount=0; $scope.mselldue=0; 

	  angular.forEach($scope.sellmilk,function(v,i){
		  
		  $scope.tsellprice=$scope.tsellprice+v.totalprice-v.due;
		  $scope.mselldue=$scope.mselldue+v.due;
		  $scope.tsellamount=$scope.tsellamount+v.amount;
		  
		  })	
	
}	    	
	 
	 	 
$scope.addsellrow=function(){
	
	  var x={"buyername":"", "amount":null, "rate":null, "totalprice":null, "due":"", "stringselldate":null,"contact":""};
	  if($scope.sellmilk.length>29){
		  alert("can not add 30+ record at a time");
	  }
	  else{
		  $scope.sellmilk.push(x);  
	  }
	        
}	  
	  
$scope.removesellrow=function(){
	var length= $scope.sellmilk.length;
	if(length>1){
		 $scope.sellmilk.splice(length-1,1);	
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




$scope.setsellprice=function(){

	angular.forEach($scope.sellmilk,function(v,i){
		v.rate=$scope.sellrate;
		v.totalprice=$scope.sellrate*v.amount;	
	  
	})
	}
	

$scope.setsellprice2=function(i){
	$scope.sellmilk[i].rate=$scope.sellrate;
	$scope.sellmilk[i].totalprice=$scope.sellrate*$scope.sellmilk[i].amount;
               }

$scope.clearsel=function(){
	angular.forEach($scope.sellmilk,function(v,i){
  v.buyername=""; 
  v.amount=null; 
  v.rate=null;
  v.totalprice=null;
  v.due=""; 
  v.stringselldate=""; 
  v.contact="";
	  
	})	
	
}

  $scope.sellmilksave=function(){
	
       var err='n';
       var err2='n';
       if($scope.selld=="" || $scope.sellm=="" || $scope.selly=="" || $scope.sellrate==null){
    	   err='y';
    	 
       }
       
       
   	angular.forEach($scope.sellmilk,function(v,i){
     if(v.amount==null || v.buyername=="" || v.contact==""){
    	 err2='y'; 
    	 
    	     }

	})   
     
	if(err=='y' || err2=='y'){
		alert("sorry,blank field not allowed");
	}
	  
   	if(err=='n' && err2=='n'){
   angular.forEach($scope.sellmilk,function(v,i){
   	   
     	v.stringselldate=$scope.selld+"/"+$scope.sellm+"/"+$scope.selly;
     	
   		}) 
   		
  	  $http({
			method:"POST",
			url:"${pageContext.request.contextPath}/milk/sellmilk",
			data: angular.toJson($scope.sellmilk),
			headers: {"Content-Type":"application/json"}}).
			
			then(function(response){
	           $scope.lko=response.data;
	           
	       alert("successfully saved");
			             })	 
   		
     	}
   	
         }



  
 $scope.pregnant=[]; $scope.pregd=[]; $scope.pregm=[];$scope.pregy=[];
 var p1={"anid":null,"type":"", "stringconcivedate":"", 
		 "stringpossibledate":"","sms":"","pregnantno":null,"stringnextconcive":"","dateerr":""} ;
 
 var p2={"anid":null,"type":"", "stringconcivedate":"", 
		 "stringpossibledate":"","sms":"","pregnantno":null,"stringnextconcive":"","dateerr":""} ;
 
 var p3={"anid":null,"type":"", "stringconcivedate":"", 
		 "stringpossibledate":"","sms":"","pregnantno":null,"stringnextconcive":"","dateerr":""} ;
 
 $scope.pregnant.push(p1); $scope.pregnant.push(p2); $scope.pregnant.push(p3);
  
 
 $scope.addpreg=function(){
	  var ps={"anid":null,"type":"", "stringconcivedate":"", 
		"stringpossibledate":"","sms":"","pregnantno":null,"stringnextconcive":"","dateerr":""} ;
	  $scope.pregnant.push(ps);  
	  
                         }
  
  $scope.removepreg=function(){
	  var length=$scope.pregnant.length;
	  $scope.pregnant.splice(length-1,1);
                    }
  
  $scope.delform=function(i){
	 
	  $scope.pregnant.splice(i,1);
                    }
  
 $scope.setconcivedate=function(i){
  	 
	$scope.pregnant[i].stringconcivedate=$scope.pregd[i]+"/"+$scope.pregm[i]+"/"+$scope.pregy[i]; 
	
	if($scope.pregnant[i].stringconcivedate.length==10 && $scope.pregnant[i].anid!=null){
		$http({
			method:"POST",
			url:"${pageContext.request.contextPath}/pregnant/pregdate",
			data: angular.toJson($scope.pregnant[i]),
			headers: {"Content-Type":"application/json"}}).
			then(function(response){
	 $scope.pregnant[i]=response.data;

			})	  
               }
	
                   
               } 
  
 
 $scope.checkpreganimalid=function(j){
	 $scope.pregnant[j].sms="";
	 var x=$scope.pregnant[j].anid;
	
	 angular.forEach($scope.pregnant,function(v,i){
								
        if(i!=j){
        	if(x==v.anid){
        	$scope.pregnant[j].sms="id:-"+x+",already added";	
        	}
  
        	
        }
		
	           	})	
	 
	 
	 $http({
			method:"POST",
			url:"${pageContext.request.contextPath}/pregnant/preganimalid",
			data: angular.toJson($scope.pregnant[j]),
			headers: {"Content-Type":"application/json"}}).
			then(function(response){
$scope.pregnant[j].sms=$scope.pregnant[j].sms+response.data.sms;

			             })	   
		if($scope.pregnant[j].stringconcivedate.length==10){
			$scope.setconcivedate(j);
		}	             
		             
         }
 
 
  
 $scope.postpregnant=function(){
	  var err="no";
	  angular.forEach($scope.pregnant,function(v,i){
		  if(v.anid==null || v.stringconcivedate=="" || v.type=="" || v.stringnextconcive=="" || v.pregnantno==null || v.dateerr!="" || v.sms!=""){
			  err="ye";  
		  }
		 
		    }) 
		    
	  if(err=="no"){
		  $http({
				method:"POST",
				url:"${pageContext.request.contextPath}/pregnant/postpreg",
				data: angular.toJson($scope.pregnant),
				headers: {"Content-Type":"application/json"}
				
		  }).
				then(function(response){
		       if(response.data[0].sms!=""){
		    	   alert("sorry something wrong");
		       }else{
		    	   alert("successfully saved pregnant report"); 
		       }
		        
				             })	   	  
		  
	       }
	  
	  else{
		  alert("sorry!!,error input or exist blank field")
	  }    
 }
  
  
 
 $scope.msells=[]; $scope.tm=0;$scope.tt=0; $scope.tdue=0;
 
 $scope.caltta=function(){

	 $scope.tm=0;$scope.tt=0; $scope.tdue=0;
	angular.forEach($scope.msells,function(v,i){
		$scope.tm=$scope.tm+v.amount;
		$scope.tt=$scope.tt+v.totalprice-v.due;
		$scope.tdue=$scope.tdue+v.due;
	}) 
	 
 }
 
 

	    
 
 $scope.inadate=function(){
	
	 $http({
			method:"POST",
			url:"${pageContext.request.contextPath}/milk/inadate",
			data:$scope.bn.stringselldate,
			headers: {"Content-Type":"text/plain", "Response-Type":"application/json"}
			
	  }).then(function(response){
	   if(response.data.length<1){
		   alert("no record fouynd");
		   $scope.msells=response.data;   
			  $scope.caltta(); 
	   }
	   else{
		   $scope.msells=response.data;   
		  $scope.caltta(); 
		   		   
	       }
		    })	 
	 
 }
 
 
 
 $scope.inadatekey=function(){
		
	 $http({
			method:"POST",
			url:"${pageContext.request.contextPath}/milk/inadatekey",
			data:$scope.bn.stringselldate,
			headers: {"Content-Type":"text/plain", "Response-Type":"application/json"}
			
	  }).then(function(response){

		   $scope.msells=response.data;   
		  $scope.caltta(); 
		   		   
	       
		    })	 
	 
 }
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 $scope.buyername=function(){
	 
	 $http({
			method:"POST",
			url:"${pageContext.request.contextPath}/milk/buyername",
			data:$scope.bn.buyername,
			headers: {"Content-Type":"text/plain","Response-Type":"application/json"}
			
	  }).then(function(response){
	  
	      $scope.msells=response.data;   
			   $scope.caltta(); 
		       
			    })	 
	 
           }
 
 
$scope.inamonth=function(){
	 var s=[];
	 s[0]=$scope.am; 
	 s[1]=$scope.ay;
	 $http({
			method:"POST",
			url:"${pageContext.request.contextPath}/milk/inamonth",
			data: angular.toJson(s),
			headers: {"Content-Type":"application/json"}
			
	  }).then(function(response){
		   if(response.data.length<1){
			   alert("no record fouynd");
		   }
		   else{
			   $scope.msells=response.data;   
			   $scope.caltta(); 
		       }
			    })	 
	 
           }
 
 
 
 
 $scope.bnys=function(){
		
		$http({
			method:"POST",
			url:"${pageContext.request.contextPath}/milk/bnys",
			data: $scope.bn.year ,
			headers: {"Content-Type":"plain/text","Response-Type":"application/json"}}).
		    then(function(response){
		 	   $scope.msells=response.data;   
			   $scope.caltta(); 
	       
	      
			             })	
	 		  		
		
                     } 
 
 
 $scope.deletemilk=function(i,ms){
	 
	 var ans=window.confirm("want to delete it?");
	 
 if(ans){
	var an=window.confirm("this milk sell record will be lost, agree to delete??");
	
	if(an){
		var user=prompt("enter password to confirm");
		
		$http({
			method:"POST",
			url:"${pageContext.request.contextPath}/checkuser",
			data:user,
			headers: {"Content-Type":"plain/text","Response-Type":"application/json"}}).
		    then(function(response){
		 	if(response.data.del=="ok"){
		 		
				$http({
					method:"POST",
					url:"${pageContext.request.contextPath}/delete/deletemilk",
					data:angular.toJson(ms) ,
					headers: {"Content-Type":"application/json"}}).
				    then(function(response){
				 	   $scope.msells.splice(i,1);  
					   $scope.caltta(); 
			       		alert("successfully deleted");	      
				        })					 		
		 		
		 	}
		 	if(response.data.del=="no"){
		 		alert("wrong password");
		 	}
		 	
			 
	       	       })		
		
		
	
	}
		 
		 
	}
	
	 
 }
 
 
 
 
 
 
 
 $scope.scontact=function(){
	
	 $http({
			method:"POST",
			url:"${pageContext.request.contextPath}/milk/scontact",
			data: $scope.bn.contact ,
			headers: {"Content-Type":"plain/text","Response-Type":"application/json"}}).
		    then(function(response){
		 	   $scope.msells=response.data;   
			   $scope.caltta(); 
	       
	      
			             })	
	 		  		
                 } 
 
 
 
 $scope.upmsell=function(w){
	 var t="y";
	 
	 if(w.rate==null || w.amount==null || w.stringselldate.length!=10 ){
		 t="n";
	 }
		if(t=="y"){
			$http({
				method:"PUT",
				url:"${pageContext.request.contextPath}/milk/upmsell",
				data:angular.toJson(w) ,
				headers: {"Content-Type":"application/json"}}).
			    then(function(response){
			    	
alert(response.data.stringselldate);
			    	
		  		             })		
		}
 		  		
         if(t=="n"){
		  alert("blank field or date must contain 10 character in size");
	               }	
		
		
                  } 
 

 
 
 $scope.smbt=function(){
var t=[];
t[0]=$scope.sm1; t[1]=$scope.sm2;
	 $http({
			method:"POST",
			url:"${pageContext.request.contextPath}/milk/smbt",
			data: angular.toJson(t),
			headers: {"Content-Type":"application/json"}
		  }).then(function(response){
		   if(response.data.length<1){
			   alert("no record fouynd");
		   }
		   else{
			   $scope.msells=response.data;   
			   $scope.caltta(); 
		       }
			    })	 
	 
           }
 
 

 
 
 
 $scope.tmsell=function(){
		 $http({
			method:"GET",
			url:"${pageContext.request.contextPath}/milk/tmsell",
			headers:{"Content-Type":"application/json"}}
		 ).then(function(response){
		  
			   if(response.data.length<1){
				   alert("no record fouynd");
			   }
			   else{
				   $scope.msells=response.data;   
				   $scope.caltta(); 
			       }
				    })	
		  	 
           }
 
 $scope.clearbn=function(){
	 
	 $scope.bns.buyername="";$scope.bns.contact="";$scope.bns.stringselldate="";
 }
 
 $scope.clearitbn=function(){
	 
	 $scope.bn.buyername="";$scope.bn.contact="";$scope.bn.stringselldate="";$scope.bn.year="";
 }
 
 
 
 $scope.upchild=function(){
	 
	 $http({
			method:"GET",
			url:"${pageContext.request.contextPath}/pregnant/upchild",
			headers:{"Content-Type":"application/json"}}
		 ).then(function(response){
		  $scope.upchildlist=response.data;
		
			   })
	 
 
 
 }
 
 
$scope.findemp={
	"name":"","age":"","phone":"","address":"","nid":"",
	"designation":"", "salary":"", "stringjoinddate":""	
}

$scope.emp={"name":"","age":"","phone":"","address":"","nid":"",
		"designation":"", "salary":"", "stringjoinddate":"" }; 
 
 $scope.clearemp=function(){
	 $scope.emp.name="";$scope.emp.age="";$scope.emp.phone="";$scope.emp.address="";
	 $scope.emp.nid="";$scope.emp.designation="";$scope.emp.salary="";$scope.emp.stringjoindate="";
 }
 
 $scope.addemp=function(){
	 var errd=$scope.checkdate($scope.emp.stringjoindate);
	var dateerr=""; var errnid=""; 	 var errage="" ;	 var errsalary="" ; 	 var errphone="";
	 
	if(errd!=2){
		
		dateerr=",date error,";
	}
	 if(isNaN($scope.emp.age)){
		 errage=",age error,"
	 }
	
	 if(isNaN($scope.emp.nid)){
		 errnid=",nid is wrong,";
	 }
	 if(isNaN($scope.emp.phone) || $scope.emp.phone.length!=11){
		 errphone=",wrong phone,";
	 } 
	 if(isNaN($scope.emp.salary)){
		 errsalary=",wrong amount salary,";
	 }
	 
	 if(dateerr=="" && errage=="" && errnid=="" && errphone=="" && errsalary=="" && $scope.emp.stringjoindate.length>7){
		 
		 $http({
				method:"POST",
				url:"${pageContext.request.contextPath}/employee/addemp",
				data:angular.toJson($scope.emp),
				headers:{"Content-Type":"application/json"}}
			 ).then(function(response){
			 alert(response.data.address);
			
				   })
		 		 			 
	 }
	 

	 if(dateerr!="" || errnid!="" || errphone!="" || errsalary!="" || errage!=""){
		  alert(dateerr+errnid+errphone+errsalary+errage);
	 }
	 	
	
 }
 
 $scope.totalsalary=0;
 
$scope.searchemp=function(){
	
		 $http({
			method:"POST",
			url:"${pageContext.request.contextPath}/employee/searchemp",
			data:angular.toJson($scope.findemp),
			headers:{"Content-Type":"application/json"}}
		 ).then(function(response){
              $scope.empres=response.data;
			 angular.forEach($scope.empres,function(v,i){
				
				 $scope.totalsalary= $scope.totalsalary+v.salary;	 
				 
			 })
			 
		
			   })
	
} 
 
 
$scope.editempbtn=function(i){
	
	$scope.editemp=$scope.empres[i];
	
} 
 
$scope.deleteemp=function(i){
	
	
	var dele=window.confirm("wan to delete this employee??");
	if(dele){
		var edc=prompt("enter password to delete employee");
	
		$http({
			method:"POST",
			url:"${pageContext.request.contextPath}/checkuser",
			data:edc,
			headers: {"Content-Type":"plain/text","Response-Type":"application/json"}}).
		    then(function(response){
		 	if(response.data.del=="ok"){
		 		 $http({
		 			method:"DELETE",
		 			url:"${pageContext.request.contextPath}/employee/deleteemp",
		 			data:angular.toJson($scope.empres[i]),
		 			headers:{"Content-Type":"application/json"}}
		 		 ).then(function(response){
		        alert("deleted successfully")
		        $scope.empres.splice(i,1);
		 		 angular.forEach($scope.empres,function(v,i){
		 				
		 			 $scope.totalsalary= $scope.totalsalary+v.salary;	 
		 			 
		 		 })
		 			 })		
	 		
		 	}
		 	
		 	if(response.data.del!="ok"){
		 	alert("password is wrong");	
		 	}
		 	
		 	})
			}
	
				 
} 

 
 $scope.editempfinal=function(){
	 
	 var errd=$scope.checkdate($scope.editemp.stringjoindate);
		var dateerr=""; var errnid=""; 	 var errage="" ;	 var errsalary="" ; 	 var errphone="";
		 
		if(errd!=2){
			
			dateerr=",date error,";
		}
		 if(isNaN($scope.editemp.age)){
			 errage=",age error,"
		 }
		
		 if(isNaN($scope.editemp.nid)){
			 errnid=",nid is wrong,";
		 }
		 if(isNaN($scope.editemp.phone) || $scope.editemp.phone.length!=11){
			 errphone=",wrong phone,";
		 } 
		 if(isNaN($scope.editemp.salary)){
			 errsalary=",wrong amount salary,";
		 }
		 
		 if(dateerr=="" && errage=="" && errnid=="" && errphone=="" && errsalary=="" && $scope.editemp.stringjoindate.length>7){
			 
			 $http({
					method:"PUT",
					url:"${pageContext.request.contextPath}/employee/editemp",
					data:angular.toJson($scope.editemp),
					headers:{"Content-Type":"application/json"}}
				 ).then(function(response){
				 alert(response.data.address);
				
					   })
			 		 			 
		 }
		 

		 if(dateerr!="" || errnid!="" || errphone!="" || errsalary!="" || errage!=""){
			  alert(dateerr+errnid+errphone+errsalary+errage);
		 }
	 
	 
 }
 
 $scope.tl={
		 "fromtwilio":"","tomy":"","authtoken":"","sid":""
 }
 
 
 $scope.addtwillio=function(){
	 
	if($scope.tl.fromtwilio=="" || $scope.tl.tomy=="" || $scope.tl.authtoken=="" || $scope.tl.sid==""){
		alert("error form , fill the form correctly");
	}
	
	if($scope.tl.fromtwilio!="" || $scope.tl.tomy!="" || $scope.tl.authtoken!="" || $scope.tl.sid!=""){
	
		 $http({
				method:"POST",
				url:"${pageContext.request.contextPath}/addtwilio",
				data:angular.toJson($scope.tl),
				headers:{"Content-Type":"application/json"}}
			 ).then(function(response){
			 alert("successfull you added a new twillio number");
			
				   })	
	}	
	
 }
 

$scope.alltwillio=function(){
	 $http({
			method:"GET",
			url:"${pageContext.request.contextPath}/alltwillio",
			headers:{"Content-Type":"application/json"}}
		 ).then(function(response){
			 if(response.data.length<1){
				 alert("no number availavle add number from settings");
			 }
			 if(response.data.length>0){
					$scope.atn=response.data;
			 }

		
			   })		
	
} 
 
$scope.updatetw=function(tx){
	 $http({
			method:"PUT",
			url:"${pageContext.request.contextPath}/updatetw",
			data:angular.toJson(tx),
			headers:{"Content-Type":"application/json"}}
		 ).then(function(response){

alert("updated twilio number information successfully");
		
			   })		
	
}  
 
$scope.deletetw=function(i){
	
	var atd=window.confirm("delete it?? you can inactive this number instead deleting")
	
	if(atd){
				
		var twpass=prompt("enter password to confirm deleting");
		
		$http({
			method:"POST",
			url:"${pageContext.request.contextPath}/checkuser",
			data:twpass,
			headers: {"Content-Type":"plain/text","Response-Type":"application/json"}}).
		    then(function(response){
		 	if(response.data.del=="ok"){	
				$http({
					method:"DELETE",
					url:"${pageContext.request.contextPath}/deletetw",
					data:angular.toJson($scope.atn[i]),
					headers:{"Content-Type":"application/json"}}
				 ).then(function(response){

		alert("deleted successfully");
		$scope.atn.splice(i,1);
				
					   })	
		
		 	}
		 	if(response.data.del!="ok"){
		 		alert("password does not match");
		 		}
		 	});
	
		}
	
	}  
 
 
 
 
 
	
})



document.addEventListener("DOMContentLoaded", function(){
  document.querySelectorAll('.sidebar .nav-link').forEach(function(element){
    
    element.addEventListener('click', function (e) {

      let nextEl = element.nextElementSibling;
      let parentEl  = element.parentElement;	

        if(nextEl) {
            e.preventDefault();	
            let mycollapse = new bootstrap.Collapse(nextEl);
            
            if(nextEl.classList.contains('show')){
              mycollapse.hide();
            } else {
                mycollapse.show();
                // find other submenus with class=show
                var opened_submenu = parentEl.parentElement.querySelector('.submenu.show');
                // if it exists, then close all of them
                if(opened_submenu){
                  new bootstrap.Collapse(opened_submenu);
                }
            }
        }
    }); // addEventListener
  }) // forEach
});




var dp=['d1','d2','d3','d4','d5','d6','d7','d8'];

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
	                  
	   




function styleofcheckcode(){
	
	document.getElementById("codecheck").style.display="none";
	
}

	function callpregnantbtn(){
		
		document.getElementById("pregnantmodalbtn").click();
	              }
	                 
	
	</script>

<style>

#ar:hover{

background-color:darkslategrey;

}

.sidebar li .submenu{ 
	list-style: none; 
	margin: 0; 
	padding: 0; 
	padding-left: 0%;
	padding-right: 0%;

}


.sidebar li .submenu a{ 
color:green;
paddinh:0%;
margin:0%;
}

.sidebar li .nav-link{ 
padding:2px;
color:white;

margin:0%;

}


.sidebar li .nav-link:hover{ 
background-color:skyblue;
color:black;

}



.nav-item .submenu li a:hover{
background-color:black;
color:white;
}

.nav-item{
background-color:steelblue;
paddinh:0%;
margin:0%;
}

.container{
margin:2%;
background-color:skyblue;
border:1px solid black;
padding:1% 0%;
padding-top:0%;
display:inline;
}






.alt{
  background-color:black;
}



.grid-contain{
display:grid;
grid-template-columns: 80% 20%;
background-color:green;
}


.grid-contain:hover{
 filter: blur(0.5px);

}

.grid-contain div{
background-color:darkslategrey;
padding:10px;
color:white;
word-wrap: break-word;
display:inline;
}


.grid-contain2{
display:grid;
grid-template-columns: 20% 80%;

}



#arf{
display:grid;
width:25%;
color:white;
background-color:lightgray;
grid-template-columns: 50% 50%;
margin-left:3%;
}

#arf div{
word-wrap: break-word;
margin:0;
background-color:white;
}


#arf div button:hover{
color:white;
background-color:lightseagreen;
}


.grid-contain2 .dv1{
margin:0%;
margin-top:0%;
padding:0%;
}

.grid-contain2 div{
background-color:skyblue;
padding:10px;
color:white;
word-wrap: break-word;
display:inline
}

table{
margin:2%;
overflow-x:scroll;
}

table th{
background-color:black;
color:white;
word-wrap: break-word;
}

table td{
padding:7px;
word-wrap: break-word;
}


input:hover{
background-color:maroon;
color:white;
}


h:hover {
  color:red;
  text-shadow:1px 1px;
}


#im{
height:50px;;
width:150px;
}

#sop:hover{

background-color:mediumseagreen;

}

#allanimal #tb td{

word-wrap: break-word;

}

#allanimal #tb td:hover{
background-color:silver; color:green;

}

#allanimal #sp p:hover{

color:gold;
display:inline;
}

</style>

</head>

<body ng-app="myapp" ng-controller="mycon"  style="background-color:gray;">

<%
if(session.getAttribute("adminuser")==null && session.getAttribute("adminpass")==null){
	response.sendRedirect("${pageContext.request.contextPath}");
	}

	  %>

<button id="cam" onclick="disit('d2');" style="display:none;">allanimal</button>
 <div class="container" ng-init="inityear();">

<div class="grid-contain">
<div>
<span><img id="im"  src="<c:url value="/static/theme/cow2.jpg" />"/>
<h>your dairy firm , dream is here...</h></span>
</div>
<div style="text-align:right;">

<form action="/logout" method="post">
 <button class="btn btn-sm btn-success" type="submit">logout</button>
</form>
</div>

</div>
<div class="grid-contain2">


<div class="dv1">
<nav class="sidebar card py-2 mb-4" style="display:inline;float:left;background-color:steelblue;">
<ul class="nav flex-column" id="nav_accordion">

	<li class="nav-item has-submenu">
		<a class="nav-link" href="#">animal & prescription</a>
		<ul class="submenu collapse" style="background-color:white;">
			<li><a   class="nav-link" href="#" onclick="disit('d1');">add animal</a></li>
			<li><a   class="nav-link" href="#" ng-click="photoupload()">all animals</a></li>
			<li><a class="nav-link" href="#" onclick="window.open('${pageContext.request.contextPath}/prescribe/searchpres')" >search prescription</a> 
			</li>
		</ul>
	</li>
	

	
	<li class="nav-item">
		<a class="nav-link" href="#">sell milk & collect</a>
	 <ul class="submenu collapse" style="background-color:white;">
		<li><a class="nav-link" href="#" onclick="disit('d3');">collect milk</a></li>
		<li><a class="nav-link" href="#" ng-click="collectm()" data-target="#cm" data-toggle="modal">total collected milk</a></li>
			<li><a class="nav-link" href="#"  onclick="disit('d4');">sell milk</a></li>
			<li><a class="nav-link" href="#" data-toggle="modal" data-target="#tsm" ng-click="tmsell();">total sold milk (tk)</a></li>
			<li><a class="nav-link" href="#" data-target="#msell" data-toggle="modal" ng-click="">search sell record</a></li>
		</ul>
	</li>
	
	
		<li class="nav-item has-submenu">
		<a class="nav-link" href="#">create pregnent report</a>
		<ul class="submenu collapse" style="background-color:white;">
			<li><a class="nav-link" href="#" onclick="callpregnantbtn();">make report</a></li>
			<li><a class="nav-link" href="#"  data-toggle="modal"  data-target="#cc" ng-click="upchild();" >upcoming child</a></li>
			<li>
	<a class="nav-link" href="#" onclick="window.open('${pageContext.request.contextPath}/pregnant/searchrecord')" >search record</a></li>
			 
		</ul>
	</li>
	      <li class="nav-item">		
  <a class="nav-link" href="#" onclick="window.open('${pageContext.request.contextPath}/costprofit')" >cost & profit</a>
		  
	      </li>
	      
	      	      <li class="nav-item">		
  <a class="nav-link" href="#" onclick="window.open('${pageContext.request.contextPath}/sellcow')" >sell animal</a>
		  
	      </li>
	      	      	      <li class="nav-item">		
  <a class="nav-link" href="#"  data-toggle="modal" data-target="#delete" >delete record</a>
		  
	      </li>
	      	   <li class="nav-item">	
	   <a class="nav-link" href="#">employee</a>
  	<ul class="submenu collapse" style="background-color:white;">
			<li><a class="nav-link" href="#" onclick="disit('d5');">add employee</a></li>
			<li><a class="nav-link" href="#" onclick="disit('d6');">find employee</a></li>
            <li><a class="nav-link" href="#" >other</a></li>
          </ul>
		  
	      </li>  
	   <li class="nav-item">	
	   	
  <a class="nav-link" href="#">settings</a>
  	<ul class="submenu collapse" style="background-color:white;">
			<li><a class="nav-link" href="#"  data-toggle="modal" data-target="#changepassword">change password</a></li>
			<li><a class="nav-link" href="#" data-toggle="modal" data-target="#changeemail" onclick="styleofcheckcode();">change email or phone</a></li>
            <li><a class="nav-link" href="#"  data-toggle="modal" data-target="#changenumber">change number</a></li>
            <li><li><a class="nav-link" href="#"  data-toggle="modal" data-target="#admininfo" ng-click="admininfo()">personal information</a></li>
<li><a class="nav-link" href="#" onclick="disit('d7');" >other settings</a></li>
<li><a class="nav-link" href="#" onclick="disit('d8');" >all twillio numbers</a></li>		 
		</ul>
		  
	      </li>  
	      
	  <li class="nav-item">
		<a class="nav-link" href="#">download records</a>
	 <ul class="submenu collapse" style="background-color:white;">
		<li><a class="nav-link"  href="${pageContext.request.contextPath}/download/milksell">milk sell record</a></li>
		<li><a class="nav-link" href="${pageContext.request.contextPath}/download/cowsell">animal sell record</a></li>
		<li><a class="nav-link" href="${pageContext.request.contextPath}/download/dailycost">daily cost record</a></li>
		<li><a class="nav-link" href="${pageContext.request.contextPath}/download/animal">animal record</a></li>
		<li><a class="nav-link" href="${pageContext.request.contextPath}/download/pres">prescription record</a></li>
		<li><a class="nav-link" href="${pageContext.request.contextPath}/costprofit/download">total cost & profit</a></li>
		</ul>
	</li>
	      
	      
	      
	      	</ul>
</nav>

</div>

<div class="row" id="dis" style="margin-right:2px;overflow-x:auto;">

<!-- --add animal list -->



<div id="d1" style="font-size:0.80em;margin-right:7%;display:none;">

<div id="arf">
<div><button class="btn btn-sm" ng-click="addrowani()">add field</button></div>
<div><button class="btn btn-sm" ng-click="removerowani()">remove field</button></div>
</div>
<br/>
<span style="background-color:white;"><b style="color:red;">NOTE::height and weight will be automatic taken by the system according to the age</b></span>
<table border="1" >
  <tr>
<th>gender</th>
<th>type & source</th>
<th>color</th>
<th>price</th>
<th>birth date</th>
<th>extra note</th>

  </tr>
  
  <tr ng-repeat="animal in animalform">
  
  <td ng-if="$index%2==0" style="background-color:darkseagreen;">
  <b>index no:-{{$index+1}}</b><br/>
  <select ng-model="animal.gender">
  <option value="male">male</option>
   <option value="female">female</option>
  </select>
  </td>
    <td ng-if="$index%2==1">
  <b>index no:-{{$index+1}}</b><br/>
  <select ng-model="animal.gender">
  <option value="male">male</option>
   <option value="female">female</option>
  </select>
  </td>
  
  
  
      <td ng-if="$index%2==0" style="background-color:darkseagreen;">
      <b>animal type</b> <br/>
      <select ng-model="animal.type">
  <option value="cow">গরু</option>
<option value="goat">ছাগল </option>
<option value="buffelo">মহিষ </option>
<option value="vera">ভেড়া  </option>


          </select> 
          <br/>
          <b>source</b> <br/>
      <select ng-model="animal.source">
      <option value="from market">from market</option>
      <option value="from my firm">from my firm</option>
         </select>  
         
         <br/>
       
      <input ng-if="animal.source=='from market'" type="text" ng-model="animal.sellername" placeholder="seller name"/>    
      <br/>
      <input ng-if="animal.source=='from market'" type="text" ng-model="animal.marketname" placeholder="market name"/> <br/>
        <input type="text" ng-model="animal.jaat" placeholder="প্রানির জাত"/> 
          
          </td>
          
    <td ng-if="$index%2==1" >
     <b>animal type</b> <br/>
    <select ng-model="animal.type">
<option value="cow">গরু</option>
<option value="goat">ছাগল </option>
<option value="buffelo">মহিষ </option>
<option value="vera">ভেড়া  </option>

         </select>
         <br/>
                  <b>source</b> <br/>
      <select ng-model="animal.source">
           <option value="from market">from market</option>
      <option value="from my firm">from my firm</option>
         </select>  
           <br/>
       
      <input ng-if="animal.source=='from market'" type="text" ng-model="animal.sellername" placeholder="seller name"/>    
      <br/>
      <input ng-if="animal.source=='from market'" type="text" ng-model="animal.marketname" placeholder="market name"/> <br/>
      <input type="text" ng-model="animal.jaat" placeholder="প্রানির জাত"/>      
         
         </td>  
          
          
          
  <td style="height:20px;overflow:hidden;background-color:cornsilk;">
      <input type="checkbox"   ng-click="chooseanicolor($index,'brown')"><div style="background-color:brown;"></div>
</input>
      <input type="checkbox"    ng-click="chooseanicolor($index,'gray')"><div style="background-color:gray;"></div>
</input>
      <input type="checkbox"   ng-click="chooseanicolor($index,'black')"><div style="background-color:black;"></div>
</input>

      <input type="checkbox"   ng-click="chooseanicolor($index,'white')"><div style="background-color:white;border:1px solid green;"></div>
</input>

 </td>
 
 
  <td ng-if="$index%2==0" style="background-color:darkseagreen;"> 
   <b>price</b> <br/>
      <input style="width:80px;"  type="number" ng-model="animal.chest" />
      </td>
     <td ng-if="$index%2==1"> 
   <b>price</b> <br/>
      <input style="width:80px;"  type="number" ng-model="animal.chest" />
      </td>   
      
           
   
        <td>
       <b>day</b> <br/>
<select ng-options="c for c in days" ng-model="ds[$index]" ng-change="sdate($index)"></select>
     
      <br/>
<b>month</b><br/>
<select ng-options="c for c in mfi" ng-model="ms[$index]" ng-change="sdate($index)"></select>
<br/>
      <b>year</b><br/>
      <select ng-options="c for c in years" ng-model="ys[$index]" ng-change="sdate($index)"></select>
      <br/>
      </td>
     <td>
      <br/>
            <b>note</b>
<textarea rows="3" cols="10" ng-model="animal.extra"></textarea> 
      </td>  
      
    </tr>

</table>
<button class="btn btn-sm btn-success" ng-click="addanimal()">submit</button>
</div>



<!--  all animal search -->




<div id="d2" style="display:none;">

<ul id="sc2">
<b  style="background-color:black;">Select Search option</b>
<li>
<select ng-change="hukk(mg)" ng-model="mg">
<option value="---">------</option>
<option value="one">by type,color,and age upper</option>
<option value="two">by type,color,and age lower</option>
<option value="three">by type,color and weight upper</option>
<option value="four">by type ,color and weight lower</option>
<option value="five">by type</option>
<option value="eight">by price and type</option>
<option value="six">by id</option>
<option value="nine">by record creation date</option>
<option value="seven">by type and color</option>
<option value="ten">by animal species</option>
<option value="eleven">by seller name</option>
<option value="twelve">by market name</option>
<option value="thirteen"> by animal source</option>
<option value="fourteen">by before or after a date</option>
</select>
</li>
<li style="background-color:white;color:black;margin-top:7px;margin-bottom:7px;">
<b>total animal::</b>{{numberofanimal}} <b> total price::</b>{{animalprice}}
</li>
</ul>

<br/>
<br/>

<div id="one"  class="row" style="background-color:mediumseagreen;width:70%;display:none;padding:10px;margin-left:10px;font-size:0.80em;">

<ul id="sc2">
<li><b>type</b><select ng-model="s.type">
<option value="cow">গরু</option>
<option value="goat">ছাগল </option>
<option value="buffelo">মহিষ </option>
<option value="vera">ভেড়া  </option>
</select></li>
<li>
<b>color</b> <input type="checkbox" ng-click="choosecolor('brown')"><div style="background-color:brown;"></div></li>
<li><input type="checkbox" ng-click="choosecolor('gray')"><div style="background-color:gray;"></div></li>
<li><input type="checkbox" ng-click="choosecolor('black')"><div style="background-color:black;"></div></li>
<li><input type="checkbox" ng-click="choosecolor('white')"><div style="background-color:white;border:1px solid green;"></div></li>
<li>
<b style="color:gold;">(opional)</b></li>
</ul>


<ul id="sc2">
<li><bold>year</bold><input type="number" placeholder="minimum age" ng-model="s.agey"/></li>
<li><b>unit</b></li>
<li><select ng-model="s.wu"><option value="month">month</option>
<option value="year">year</option> 
</select></li>
<li><button ng-click="bytypeageupper();" style="margin-left:3px;" id="sbtn">search</button></li>
</ul>
<br/>
<div style="background-color:darkslategrey;color:white;border-left:2px solid black;padding-bottom:5px;font-size:0.80em;">
<b>select gender</b><select ng-model="g" ng-change="filterg(g)">
<option value="---">---</option>
<option value="male">male</option>
<option value="female">female</option>
<option value="all">all</option>
</select> <b>(optional)</b>
</div>
</div>







<div id="two" style="background-color:mediumseagreen;width:70%;display:none;margin-bottom:4px;margin-left:10px;padding:10px;" class="row">
<style>
#sc2{
  list-style-type: none;
  margin: 0;
  padding:0;
  overflow: hidden;

}

 #sc2 li {

  display:inline;
}


</style>


<ul id="sc2">
<li><bold>type</bold> <select ng-model="s.type">
<option value="cow">গরু</option>
<option value="goat">ছাগল </option>
<option value="buffelo">মহিষ </option>
<option value="vera">ভেড়া  </option>
</select></li>
<li><bold>year</bold><input type="number" placeholder="maximum age" ng-model="s.agey"/>
<b>unit</b> <select ng-model="s.wu">
<option value="month">month</option>
<option value="year">year</option> 
      </select></li>
     
</ul>

<ul style="list-style-type:none;" id="sc2">
<li><input type="checkbox" ng-click="choosecolor('brown')"><div style="background-color:brown;"></div></li>
<li> <input type="checkbox" ng-click="choosecolor('gray')"><div style="background-color:gray;"></div></li>
<li><input type="checkbox" ng-click="choosecolor('black')"><div style="background-color:black;"></div></li>
<li><input type="checkbox" ng-click="choosecolor('white')"><div style="background-color:white;border:1px solid green;"></div></li>
<li><b style="color:gold;">(opional)</b></li>
<li><button ng-click="bytypeagelower();" style="margin-left:3px;" id="sbtn">search</button></li>
</ul>

<div style="background-color:darkslategrey;color:white;border-left:2px solid black;padding:3px;font-size:0.80em;">
<b>select gender</b><select ng-model="g" ng-change="filterg(g)">
<option value="---">---</option>
<option value="male">male</option>
<option value="female">female</option>
<option value="all">all</option>
</select><b>(optional)</b>
</div>
</div>


<div id="three" style="background-color:mediumseagreen;width:70%;display:none;margin-bottom:4px;font-size:0.80em;margin-left:10px;">
<table>
<tr>
<th>type</th>
<th>weight</th>
<th>unit</th>
</tr>

<tr>
<td><select ng-model="s.type">
<option value="cow">গরু</option>

<option value="goat">ছাগল </option>

<option value="buffelo">মহিষ </option>

<option value="vera">ভেড়া  </option>

</select></td>

<td><input type="number" ng-model="s.weight" placeholder="minimum weight"></td>
<td><select ng-model="s.wu">
<option value="kg">কেজি</option>
<option value="gm">গ্রাম</option> 
<option value="mon">মন</option>
</select></td>
</tr>
</table>
<br/>
<div style="background-color:mediumseagreen;"> 

<input type="checkbox" ng-click="choosecolor('brown')"><div style="background-color:brown;"></div>
</input>
 <input type="checkbox" ng-click="choosecolor('gray')"><div style="background-color:gray;"></div>
</input>
 <input type="checkbox" ng-click="choosecolor('black')"><div style="background-color:black;"></div>
</input>
<input type="checkbox" ng-click="choosecolor('white')"><div style="background-color:white;border:1px solid green;"></div>
</input>
<b style="color:gold;">(color opional)</b>
<button style="margin:5px;margin-left:3px;" ng-click="bytypecolorweightupper();"  id="sbtn">search</button>
</div>

<br/> <br/>
<div style="background-color:darkslategrey;color:white;border-left:2px solid black;font-size:0.80em;" class="col">
<b>select gender</b><select ng-model="g" ng-change="filterg(g)">
<option value="---">---</option>
<option value="male">male</option>
<option value="female">female</option>
<option value="all">all</option>
</select><b>(optional)</b> 
</div>

</div>


<div id="four" style="background-color:mediumseagreen;width:70%;display:none;font-size:0.80em;margin-left:10px;" class="row">

<table>
<tr>
<th>type</th>
<th>weight</th>
<th>unit</th>
</tr>
<tr>
<td><select ng-model="s.type">
<option value="cow">গরু</option>
<option value="goat">ছাগল </option>
<option value="buffelo">মহিষ </option>
<option value="vera">ভেড়া  </option>

</select></td>

<td><input type="number" ng-model="s.weight" placeholder="weight"></td>
<td><select ng-model="s.wu">
<option value="kg">কেজি</option>
<option value="gm">গ্রাম</option> 
<option value="mon">মন</option>
</select></td>
</tr>
</table>
<br/>
<b style="color:gold;">(opional)</b>
<div style="background-color:mediumseagreen;"> 

<input type="checkbox" ng-click="choosecolor('brown')"><div style="background-color:brown;"></div>
</input>
 <input type="checkbox" ng-click="choosecolor('gray')"><div style="background-color:gray;"></div>
</input>
 <input type="checkbox" ng-click="choosecolor('black')"><div style="background-color:black;"></div>
</input>
<input type="checkbox" ng-click="choosecolor('white')"><div style="background-color:white;border:1px solid green;"></div>
</input>
<button style="margin:5px;margin-left:3px;" ng-click="bytypecolorweightlower();"  id="sbtn">search</button>
</div>

<br/> <br/>

<div style="background-color:darkslategrey;color:white;border-left:2px solid black;margin:3px;font-size:0.80em;" class="col">
<b>select gender</b><select ng-model="g" ng-change="filterg(g)">
<option value="---">---</option>
<option value="male">male</option>
<option value="female">female</option>
<option value="all">all</option>
</select><b>(optional)</b>
</div>

</div>


<div id="five" style="background-color:mediumseagreen;width:70%;display:none;font-size:0.80em;margin-left:10px;" class="row">

<ul id="sc2">
<li><bold>type</bold> </li>
<li><select ng-model="s.type">
<option value="all"> all </option> 
<option value="cow">গরু</option>
<option value="goat">ছাগল </option>
<option value="buffelo">মহিষ </option>
<option value="vera">ভেড়া  </option>
</select></li>
<li><button ng-click="sbytype();" style="margin-left:3px;" id="sbtn">search</button></li>
</ul>


<b>select gender</b> <select ng-model="g" ng-change="filterg(g)">
<option value="---">---</option>
<option value="male">male</option>
<option value="female">female</option>
<option value="all">all</option>
</select><b>(optional)</b>


</div>




<div id="seven" style="background-color:mediumseagreen;width:70%;display:none;font-size:0.80em;margin-left:10px;" class="row">

<ul id="sc2">
<li style="padding-bottom:8px;"><bold>type</bold> <select ng-model="s.type">
<option value="cow">গরু</option>
<option value="goat">ছাগল </option>
<option value="buffelo">মহিষ </option>
<option value="vera">ভেড়া  </option>
</select>
</li>
<li><input type="checkbox" ng-click="choosecolor('brown')"><div style="background-color:brown;"></div></li>
<li>
 <input type="checkbox" ng-click="choosecolor('gray')"><div style="background-color:gray;"></div>
 </li>
 
<li>
 <input type="checkbox" ng-click="choosecolor('black')"><div style="background-color:black;"></div>
</li>
<li>
<input type="checkbox" ng-click="choosecolor('white')"><div style="background-color:white;border:1px solid green;"></div>
</li>
<li><button  ng-click="bytypecolor();" style="margin-left:3px;" id="sbtn">search</button></li>
</ul>


<ul id="sc2">
<li><b>select gender</b> </li>
<li><select ng-model="g" ng-change="filterg(g)">
<option value="---">---</option>
<option value="male">male</option>
<option value="female">female</option>
<option value="all">all</option>
</select><b></li>
<li><b>(optional)</b></li>
</ul>

</div>


<div id="nine" style="background-color:mediumseagreen;width:70%;display:none;font-size:0.80em;margin-left:10px;" class="row">

<h4>seach by record creation date</h4>
<input type="text" ng-model="sellerdate" placeholder="selling date" ng-keyup="animalinadate()"/> 
<button ng-click="animalinadate2()">search</button>

</div>

<div id="ten" style="background-color:mediumseagreen;width:70%;display:none;font-size:0.80em;margin-left:10px;" class="row">

<h4>seach by animal species</h4>
<input type="text" ng-model="jaat" placeholder="প্রানির জাত" ng-keyup="byjaat()"/> 

<b>select gender</b><select ng-model="g" ng-change="filterg(g)">
<option value="---">---</option>
<option value="male">male</option>
<option value="female">female</option>
<option value="all">all</option>
</select> <b>(optional)</b>


</div>
<div id="eleven" style="background-color:mediumseagreen;width:70%;display:none;font-size:0.80em;margin-left:10px;" class="row">

<h4>seach by seller name</h4>
<input type="text" ng-model="sellername" placeholder="seller name" ng-keyup="bysellername()"/> 
<b>select gender</b><select ng-model="g" ng-change="filterg(g)">
<option value="---">---</option>
<option value="male">male</option>
<option value="female">female</option>
<option value="all">all</option>
</select> <b>(optional)</b>

</div>
<div id="twelve" style="background-color:mediumseagreen;width:70%;display:none;font-size:0.80em;margin-left:10px;" class="row">

<h4>seach by market name</h4>
<input type="text" ng-model="marketname" placeholder="market name" ng-keyup="bymarketname()"/> 
<b>select gender</b><select ng-model="g" ng-change="filterg(g)">
<option value="---">---</option>
<option value="male">male</option>
<option value="female">female</option>
<option value="all">all</option>
</select> <b>(optional)</b>

</div>

<div id="thirteen" style="background-color:mediumseagreen;width:70%;display:none;font-size:0.80em;margin-left:10px;" class="row">

<h4>seach by animal source</h4>
<b>select the animal source</b>
<select ng-change="bysource()" ng-model="animalsource">
<option  value="---">--</option>
<option value="from market">from market</option>
<option value="from my firm">from my firm</option>
</select>
<b>select gender</b><select ng-model="g" ng-change="filterg(g)">
<option value="---">---</option>
<option value="male">male</option>
<option value="female">female</option>
<option value="all">all</option>
</select> <b>(optional)</b>

</div>


<div id="fourteen" style="background-color:mediumseagreen;width:70%;display:none;font-size:0.80em;margin-left:10px;" class="row">

<h4>record before a date</h4>
<input type="text" ng-model="bdb" placeholder="day/month/year" /> <button ng-click="bydatebefore()">search</button>
<h4>record after a date</h4>
<input type="text" ng-model="bda" placeholder="day/month/year" /> <button  ng-click="bydateafter()">search</button>

<b>select gender</b><select ng-model="g" ng-change="filterg(g)">
<option value="---">---</option>
<option value="male">male</option>
<option value="female">female</option>
<option value="all">all</option>
</select> <b>(optional)</b>

</div>


<div id="eight" style="background-color:mediumseagreen;width:80%;display:none;font-size:0.80em;margin-left:10px;" class="row">
<div class="col" class="col" style="margin:3px;background-color:mediumseagreen;padding:10px;">
<script type="text/javascript">
function seeprice(){
	var spo=['bt','eq','gt','lt'];
	var d = document.getElementById("gp").value;
	for(var i=0;i<spo.length;i++){
		
	if(d==spo[i]){
		document.getElementById(spo[i]).style.display="block";
	}	
	if(d!=spo[i]){
		document.getElementById(spo[i]).style.display="none";
	}	
	}
		
}

</script>

<div  style="padding:10px;">
<select ng-model="s.wu" id="gp" onchange="seeprice();">
<option value="bt">between two price</option>
<option value="eq">particular price </option>
<option value="gt">greter than a partucular price </option>
<option value="lt">lessthan a particular price </option></select>
</div>  
<br/><br/>

<div id="bt" style="display:none;background-color:brown;">
<b>1st price:</b><input type="text" ng-model="s.height" /> <b>2nd price:</b><input type="text" ng-model="s.chest" />
</div>
<div id="eq"  style="display:none;background-color:gray;">
<b>particular price:</b><input type="text" ng-model="s.height" />
</div>
<div id="gt"  style="display:none;background-color:stealblue;">
<b>greater than a price:</b><input type="text" ng-model="s.height" />
</div>
<div id="lt"  style="display:none;background-color:darkseagreen;">
<b>less than a price:</b><input type="text" ng-model="s.height" />
</div>
</div>
<br/><br/>
<div class="col" style="padding:10px;">
<bold>type</bold> <select ng-model="s.type">
<option value="cow">গরু</option>
<option value="goat">ছাগল </option>
<option value="buffelo">মহিষ </option>
<option value="vera">ভেড়া  </option>
</select>
</div>
<button class="btn btn-success btn-sm" ng-click="bytypeandprice()">search</button>
<br/> <br/>
<div style="background-color:darkslategrey;color:white;margin:3px;padding:10px;" class="col">
<b>select gender</b> <select ng-model="g" ng-change="filterg(g)">
<option value="---">---</option>
<option value="male">male</option>
<option value="female">female</option>
<option value="all">all</option>
</select><b>(optional)</b>
</div>


</div>



<div id="six"  class="row" style="background-color:brown;width:70%;display:none;margin-bottom:4px;margin-left:10px;font-size:0.80em;">

<ul id="sc2">
<li><input type="text" ng-model="s.anid" placeholder="animal id" /> </li>
<li><button ng-click="sbyid();" style="margin-left:3px;">search</button></li>
</ul>
<br/>
<img  ng-if="sbid!=null" style="height:110px;width:170px;" src="<c:url value="/static/images/{{sbid.filename}}" />"/> <br/>

<ul id="sc2" ng-if="sbid!=null">
<li style="color:black;">animal id={{sbid.anid}}</li>
<li >type={{sbid.type}}</li>
<li  style="color:black;">price={{sbid.chest}}</li>
<li>gender={{sbid.gender}}</li>
<li  style="color:black;">age={{sbid.agem}}(month)</li>
<li>weight={{sbid.weight}}(kg)</li>
<li  style="color:black;">height={{sbid.height}}(inch)</li>
<li>
<form method="get" target="_blank" action="/prescribe/pres">
 <input type="number"  name="anid" value="{{sbid.anid}}" style="display:none;">
   <input type="submit"  value="create new" />
</form></li>
<li>
<br/>
<a  href="#" ng-click="presrecord(sbid.anid)" style="text-decoration:none;"><button>prescriptions</button></a></li>
</ul>

</div>

<table border="1" id="tb" style="font-size:0.80em;" align="center">

<tr ng-if="unphoto.length>0">
<th>index</th>
<th>id</th>
<th>price & <br/>
other
</th>
<TH>basic info <br/>
& note</th>
<th>photo</th>
<th>prescription</th>
<th>operate</th>
</tr>


<tr ng-repeat="x in unphoto">

<td ng-if="checkstyle($index)=='t' " style="background-color:#838996;color:gold;">  
{{$index+1}}
</td> 
<td ng-if="checkstyle($index)=='f' "  style="background-color:ghostwhite;color:black"> 
{{$index+1}}
</td> 

<td ng-if="checkstyle($index)=='t' " style="background-color:#838996;color:gold;">  
{{x.anid}}
</td> 
<td ng-if="checkstyle($index)=='f' "  style="background-color:ghostwhite;color:black"> 
{{x.anid}}
</td> 


<td ng-if="checkstyle($index)=='t' " style="background-color:#838996;color:gold;">  
<b>price:</b>
{{x.chest}} (tk) <br/>
<b>record date::</b>
{{x.createdstring}} <br/>
<b>source:</b>{{x.source}}
<p ng-if="x.source=='from market'">seller name::
{{x.sellername}} </p> 
<p  ng-if="x.source=='from market'">market name::
{{x.marketname}} </p>
</td> 

<td ng-if="checkstyle($index)=='f' "  style="background-color:ghostwhite;color:black"> 
<b>price:</b>
{{x.chest}} (tk) <br/>
<b>record date::</b>
{{x.createdstring}} <br/>
<b>source:</b>{{x.source}}
<p ng-if="x.source=='from market'">seller name::
{{x.sellername}} </p> 
<p  ng-if="x.source=='from market'">market name::
{{x.marketname}} </p>
</td> 

<td ng-if="checkstyle($index)=='t' " style="background-color:#838996;color:gold;">  
<b style="color:red;">Animal type:</b>{{x.type}} <br/>
<b style="color:red;">Animal species:</b>{{x.jaat}} <br/>
<b style="color:red;">gender:</b>{{x.gender}} <br/>
<b style="color:red;">color:</b>{{x.color}} <br/>
<b style="color:red;">weight:</b>{{x.weight}} <br/>
<b style="color:red;">height:</b>{{x.height}}
</td> 

<td ng-if="checkstyle($index)=='f' "  style="background-color:ghostwhite;color:black"> 
<b style="color:red;">Animal type:</b>{{x.type}} <br/>
<b style="color:red;">Animal species:</b>{{x.jaat}} <br/>
<b style="color:red;">gender:</b>{{x.gender}} <br/>
<b style="color:red;">color:</b>{{x.color}} <br/>
<b style="color:red;">weight:</b>{{x.weight}} <br/>
<b style="color:red;">height:</b>{{x.height}} <br/>
<b style="color:red;">age(month):</b>{{x.agem}} <br/>
<b>extra note::</b><br/>
{{x.extra}}
</td> 


<td > 
<button ng-click="getimage($index)">refresh image</button>
<br/><br/>
<img  style="height:110px;width:170px;" src="<c:url value="/static/images/{{x.filename}}" />"/> <br/>
<br/>



<form method="get" target="_blank" action="/animal/photoid">
 <input type="number"  name="anid" value="{{x.anid}}" style="display:none;">
   <input type="submit"  value="upload"/>
</form>

</td>

<td ng-if="checkstyle($index)=='t' " style="background-color:#838996;color:gold;">  
<form method="get" target="_blank" action="/prescribe/pres">
 <input type="number"  name="anid" value="{{x.anid}}" style="display:none;">
   <input type="submit"  value="create new" ng-click="setstyle($index);" />
</form>
<br/>
<a   href="#" ng-click="presrecord(x.anid)" style="text-decoration:none;"><button>prescription</button></a>
</td> 
<td ng-if="checkstyle($index)=='f' "  style="background-color:ghostwhite;color:black" > 
<form method="get" target="_blank" action="/prescribe/pres">
 <input type="number"  name="anid" value="{{x.anid}}" style="display:none;">
   <input type="submit"  value="create new" ng-click="setstyle($index);"/>
</form>
<br/>
<a   href="#" ng-click="presrecord(x.anid)" style="text-decoration:none;"><button>prescription</button></a>
</td> 


<td>
<button ng-click="deleteanimal($index)" class="btb btn-dark btn-sm">delete</button> <br/><br/>
<button ng-click="updateani($index)" class="btb btn-success btn-sm" data-target="#editani" data-toggle="modal" >update</button>
</td>
</tr>
</table>
</div>


<!--  collect milk div  -->


<div id="d3" style="font-size:0.80em;margin-right:7%;display:none;" >
<br/>
<h3 style="color:maroon;">Save milk collection records</h3> 
<br/>
<div style="display:inline;margin-left:10%;">
<div>
<button id="ar" ng-click="removerowm()"><i class="fa fa-trash fa-fas" ></i></button>
</div>
<div style="display:inline; border-left:2px solid green;">
<button ng-click="addrowm()" id="ar"><i class="fa fa-plus fa-fas" aria-hidden="true"></i></button>
</div>
<div style="display:inline; border-left:2px solid green;">
<button ng-click="clearmilk()" id="ar">clear all</button>
</div>
<div style="display:inline; border-left:2px solid green;">
<button id="ar" ng-click="totalmilk();" >total</button>
</div>
</div>

<table border="1">
<tr>
<th>day</th>
<th>month</th>
<th>year</th>
<th  style="text-align:center;">milk rate</th>
<th  style="text-align:center;">total milk(kg)</th>
<th  style="text-align:center;">total price(tk)</th>
</tr>
<tr>
<td><select  ng-model="dc"  ng-options="c for c in days"  ></select></td>
<td><select  ng-model="mc"  ng-options="c for c in mfi"    ></select></td>
<td><select  ng-model="yc"  ng-options="c for c in years"   ></select></td>
<td>
<input type="number" ng-model="mrate" ng-keyup="pricerate(mrate)" ng-click="pricerate(mrate)" />
</td>
<td style="color:black;background-color:white;">{{tamount}}</td>  
<td style="color:black;background-color:white;">{{tprice}}</td>
</tr>
</table>


<table id="aslam">
<tr>
<th style="text-align:center;">animal id</th>
<th style="text-align:center;">animal type</th>
<th style="text-align:center;">amount(kg)</th>
<th style="text-align:center;">price</th>
</tr>
<tr ng-repeat="x in milklist">

<td ng-if="duplicateid($index)=='ok'"   style="background-color:red;color:white;">
<input type="number" ng-model="x.anid" ng-keyup="checkduplicate($index,x)" ng-click="checkduplicate($index,x)" />

</td>
<td ng-if="duplicateid($index)=='no'">
<input type="number" ng-model="x.anid" ng-keyup="checkduplicate($index,x)"  ng-click="checkduplicate($index,x)" />
</td>

<td ng-if="duplicateid($index)=='ok';"  style="background-color:red;color:white;">
<select ng-model="x.animaltype" ng-change="checkduplicate($index,x)">
<option value="cow">গরু</option>
<option value="goat">ছাগল </option>
<option value="buffelo">মহিষ </option>
<option value="vera">ভেড়া  </option>

</select>
</td>
<td ng-if="duplicateid($index)=='no';">
<select ng-model="x.animaltype" ng-change="checkduplicate($index,x)">

<option value="cow">গরু</option>
<option value="goat">ছাগল </option>
<option value="buffelo">মহিষ </option>
<option value="vera">ভেড়া  </option>

</select>
</td>

<td  ng-if="duplicateid($index)=='ok';" style="background-color:red;color:white;">
<input type="number" ng-model="x.amount"    ng-keyup="setprice(x,$index);"  ng-click="setprice(x,$index);" />
</td>

<td  ng-if="duplicateid($index)=='no';">
<input type="number" ng-model="x.amount"    ng-keyup="setprice(x,$index);"  ng-click="setprice(x,$index);" />
</td>

<td ng-if="duplicateid($index)=='ok';"   style="background-color:red;color:white;">
<input type="number" ng-model="x.totalprice"   disabled />
</td>
<td ng-if="duplicateid($index)=='no';">
<input type="number" ng-model="x.totalprice"   disabled />
</td>
</tr>
</table>
<br/>
<button class="btn btn-success btn-sm" ng-click="addmilk();">save</button>


<span><h4 style="color:maroon;">search milk collection records by date</h4>
<input type="text" ng-model="collectdate" placeholder="day/month/year" />
<button ng-click="searchcollectdate();"  data-toggle="modal" data-target="#tcpmodal" >search</button></span>


</div>

<!-- - sell milk div -->


<div id="d4" style="font-size:0.80em;margin-right:7%;display:none;" class="row">
<br/>
<h3 style="color:black">Save milk selling records</h3> 
<br/>

<div style="display:inline;margin-left:10%;">
<div>
<button id="ar" ng-click="removesellrow()"><i class="fa fa-trash fa-fas" ></i></button>
</div>
<div style="display:inline; border-left:2px solid green;">
<button ng-click="addsellrow()" id="ar"><i class="fa fa-plus fa-fas" aria-hidden="true"></i></button>
</div>
<div style="display:inline; border-left:2px solid green;">
<button id="ar" ng-click="clearsel()">clear all</button>
</div>
<div style="display:inline; border-left:2px solid green;">
<button id="ar" ng-click="totalsell()">total</button>
<table border="1">
<tr><th>total price except due(tk)</th><th>total amount(kg)</th>
<th>total due(tk)</th> </tr>
<tr><td style="background-color:white;color:black;">{{tsellprice}} tk</td>
<td style="background-color:white;color:black;">{{tsellamount}} kg</td>
<td style="background-color:white;color:black;">{{mselldue}} kg</td></tr>
</table>
</div>
</div>
<div>
<b style="color:black;">*rate(Taka):</b><input type="number" ng-model="sellrate"  placeholder="rate" 
ng-keyup="setsellprice()" />

<b style="color:black;">Date(day/month/year):</b><div>
<select  ng-model="selld"  ng-options="c for c in days"  ></select>
<select  ng-model="sellm"  ng-options="c for c in mfi"   ></select>
<select  ng-model="selly"  ng-options="c for c in years"  ></select>
</div>
</div>

<table border="1">
<tr>
<th style="text-align:center;">No</th>
<th style="text-align:center;">buyer info*</th>
<th style="text-align:center;">amount*</th>
<th style="text-align:center;">total price</th>
<th style="text-align:center;">due</th>
</tr>
<tr ng-repeat="x in sellmilk">
<td>
{{$index+1}}
</td>
<td>
<input type="text" ng-model="x.buyername"  placeholder="buyername"/><br/>
<input type="text" ng-model="x.contact"  placeholder="contact"/>
</td>
<td>
<input type="number" ng-model="x.amount" placeholder="amount" 
ng-keyup="setsellprice2($index)"  ng-click="setsellprice2($index)" /><br/>

</td>
<td >
<input type="number" ng-model="x.totalprice" disabled />
</td>
<td >
<input type="number" ng-model="x.due" />
</td>
</tr>
</table>
<button class="btn btn-sm btn-primary" ng-click="sellmilksave()">save reord</button>
</div>




<!-- add employee -->

<div id="d5" style="font-size:0.80em;margin-right:7%;display:none;background-color:burlywood;text-align:center;" class="row">
<br/>
<h3 style="color:black;background-color:white;">add employee records</h3> 
<br/>

<style>
#kk{
  list-style-type: none;
  margin: 0;
  padding: 0;
  overflow: hidden;

}

 #kk li {

  display:inline;
}


</style>
<ul id="kk">
<li>
<ul style="list-style-type:none;">
<li><input type="text" ng-model="emp.name" placeholder="name"></li>
<li><input type="text" ng-model="emp.age"  placeholder="age" /></li>
<li><input type="text" ng-model="emp.phone"  placeholder="phone"/></li>
</ul>
</li>
<li>
<ul style="list-style-type:none;">

<li><input type="text" ng-model="emp.nid" placeholder="NID"/></li>

<li><input type="text" ng-model="emp.address" placeholder="address"/></li>
<li><input type="text" ng-model="emp.designation" placeholder="designation" /></li>
</ul>
</li>
<li>
<ul style="list-style-type:none;">
<li><input type="text" ng-model="emp.salary" placeholder="salary" /></li>
<li><input type="text" ng-model="emp.stringjoindate" placeholder="joining date" /></li>
</ul>
</li>
</ul>
<br/>
<button class="btn btn-sm btn-primary" ng-click="addemp()">save reord</button> <button style="margin-left:50px;" class="brn btn-dark btn-sm"ng-click="clearemp();">clear</button>
</div>





<!-- find employee -->

<div id="d6" style="font-size:0.80em;margin-right:7%;display:none;" class="row">

<script type="text/javascript">
var eds=['name','address','phone','designation','salary','left','active','all'];

function sendemp(){
	var gid=document.getElementById("gid").value;
	
	for(var i=0;i<eds.length;i++){
	if(gid==eds[i]){
		document.getElementById(eds[i]).style.display="block";
	}	
	if(gid!=eds[i]){
		document.getElementById(eds[i]).style.display="none";
	}	
		
	}
	
}

</script>

<div class="row"> 
<b style="color:red;">employee searching </b>
<b style="margin-left:100px;">select find option</b> <select id="gid" ng-model="findemp.nid" onchange="sendemp();"> <br/>
<option value="name" >search by name</option>
<option value="address">search by address</option>
<option value="phone">search by phone</option>
<option value="designation">search by designation</option>
<option value="salary">search by salary</option>
<option value="left">job lefted employee</option>
<option value="active">active employee</option>
<option value="all">all employee</option>
</select>
</div>
<br/>
<b style="margin-left:50px;">total salary::{{totalsalary}}</b>
<div id="name" style="text-align:center;display:none;background-color:olive;" class="row">
<h5>search by name</h5>
<input type="text" ng-model="findemp.name" ng-keyup="searchemp()" placeholder="name" > <br/>
</div>

<div id="address" style="text-align:center;display:none;background-color:ghostwhite;" class="row">
<h5>search by address</h5>
<input type="text" ng-model="findemp.address" ng-keyup="searchemp()" placeholder="address"> 
</div>
<div id="phone" style="text-align:center;display:none;background-color:ghostwhite;color:black;" class="row">
<h4>search by phone</h4>
<input type="text" ng-model="findemp.phone" ng-keyup="searchemp()" placeholder="phone"> 
</div>
<div id="designation" style="text-align:center;display:none;background-color:burlywood;color:maroon;" class="row">
<h5>search by designation</h5>
<input type="text" ng-model="findemp.designation" ng-keyup="searchemp()" placeholder="designation"> 
</div>
<div id="salary" style="text-align:center;display:none;background-color:green;" class="row">
<h5>search by salary</h5>
<input type="text" ng-model="findemp.stringsalary" ng-keyup="searchemp()" placeholder="salary"> 
</div>
<div id="left" style="text-align:center;display:none;background-color:pink;" class="row">
<button ng-click="searchemp()">see now</button> 
</div>
<div id="active" style="text-align:center;display:none;background-color:darkblue;" class="row">
<button ng-click="searchemp()">see now</button>
</div>
<div id="all" style="text-align:center;display:none;background-color:darkblue;" class="row">
<button ng-click="searchemp()">see now</button>
</div>
<br/>
<div class="row">
<style>
#k{
  list-style-type: none;
  margin: 0;
  padding: 0;
  overflow: hidden;

}

 #k li{
  display:inline;
}



</style>

<ul id="k"  ng-repeat="em in empres">
<li ng-if="$index%2==0">
<ul style="list-style-type:none;border:1px solid green;background-color:darkslategrey;color:white;">
<li style="padding:7px;"><b style="color:pink;">name::</b>{{em.name}}</li>
<li style="padding:7px;"><b style="color:pink;">age::</b>{{em.age}}</li>
<li style="padding:7px;"><b style="color:pink;">phone::</b>{{em.phone}}</li>
<li style="padding:7px;"><b style="color:pink;">nid::</b>{{em.nid}}</li>
<li style="padding:7px;" ng-if="em.activestatus=='left job'"><b style="color:orange;">left job::</b>{{em.leftdate}}</li>
</ul>
</li>
<li ng-if="$index%2==0">
<ul style="list-style-type:none;border:1px solid green;background-color:darkslategrey;color:white;">
<li style="padding:7px;"><b style="color:pink;">address::</b>{{em.address}}</li>
<li style="padding:7px;"> <b style="color:pink;">designation::</b>{{em.designation}}</li>
<li style="padding:7px;"><b style="color:pink;">salary::</b>{{em.salary}}</li>
<li style="padding:7px;"><b style="color:pink;">join date::</b>{{em.stringjoindate}}</li>
</ul>
</li>

<li ng-if="$index%2==1">
<ul style="list-style-type:none;border:1px solid green;background-color:#AFEEEE;color:maroon;">
<li style="padding:7px;"><b style="color:black;">name::</b>{{em.name}}</li>
<li style="padding:7px;"><b style="color:black;">age::</b>{{em.age}}</li>
<li style="padding:7px;"><b style="color:black;">phone::</b>{{em.phone}}</li>
<li style="padding:7px;"><b style="color:black;">nid::</b>{{em.nid}}</li>
<li style="padding:7px;" ng-if="em.activestatus=='left job'"><b style="color:orange;">left job::</b>{{em.leftdate}}</li>
</ul>
</li>
<li ng-if="$index%2==1">
<ul style="list-style-type:none;border:1px solid green;background-color:#AFEEEE;color:maroon;">
<li><b style="color:black;">address::</b>{{em.address}}</li>
<li><b style="color:black;">designation::</b>{{em.designation}}</li>
<li><b style="color:black;">salary::</b>{{em.salary}}</li>
<li><b style="color:black;">join date::</b>{{em.stringjoindate}}</li>
</ul>
</li>
<li>
<ul style="list-style-type:none;border:1px solid green;background-color:darkslategrey;color:white;">
<li><button data-target="#editemp" data-toggle="modal" ng-click="editempbtn($index);">edit</button>
<button  ng-click="deleteemp($index);">delete</button>
</li>
</ul>
</li>
</ul>
</div>
</div>




<div id="d7" style="font-size:0.80em;margin-right:7%;display:none;background-color:burlywood;text-align:center;" class="row">
<h4>add the twillio account information for phone messaging</h4>
<ul style="list-style-type:none;background-color:darkseareen;">
<li><input type="text" ng-model="tl.authtoken" placeholder="auth token" /></li>
<li><input type="text" ng-model="tl.sid" placeholder="sid"  /></li>
<li><input type="text" ng-model="tl.fromtwilio" placeholder="twilio number" /></li>
<li><input type="text" ng-model="tl.tomy" placeholder="my bd number"  /></li>
</ul>
<button class="btn btn-sm btn-primary" ng-click="addtwillio()">submit</button> 

</div>

<div id="d8" style="font-size:0.80em;margin-right:7%;display:none;background-color:burlywood;text-align:center;" class="row">
<style>
#tw{
  list-style-type: none;
  margin: 0;
  padding: 0;
  overflow: hidden;

}

 #tw li{
  display:inline;
}
p{
color:red;
}
</style>
<h4>sell all twillio number and BD number</h4>
<p>note::the notification to take drug will be send only active number list.</p>
<p>if you dont need notification to a number then inactive that number or delete it</p>
<button class="btn btn-sm btn-success" ng-click="alltwillio()">see all</button> 
<br/><br/>
<ul id="tw" ng-repeat="x in atn" style="padding:10px;">

<li ng-if="$index%2==0" >
<ul style="background-color:darkslategrey;color:white;padding:10px;">
<li>Twilio number:-<input type="text" ng-model="x.fromtwilio" /></li> 
<li>BD number:-<input type="text" ng-model="x.tomy" /></li>
<li>auth token:-<input type="text" ng-model="x.authtoken" /></li>
</ul>
</li>

<li  ng-if="$index%2==0" >
<ul  style="background-color:darkslategrey;color:white;padding:10px;">
<li>adding date:- <input type="text" ng-model="x.addingdate" disabled /></li>
<li>sid:- <input type="text" ng-model="x.sid" /></li>
<li>Active:<select ng-model="x.active">
<option value="active">active</option>
<option value="inactive">inactive</option>
</select>
</li>
<li><button ng-click="updatetw(x)" class="btn btn-success btn-sm">update</button></li>
<li><button ng-click="deletetw($index)" class="btn btn-success btn-sm">delete</button></li>
</ul>
</li>



<li ng-if="$index%2==1" >
<ul style="background-color:black;color:white;padding:10px;">
<li>Twilio number:-<input type="text"  ng-model="x.fromtwilio" /></li> 
<li>BD number:-<input type="text" ng-model="x.tomy" /></li>
<li>auth token:-<input type="text" ng-model="x.authtoken" /></li>
</ul>
</li>

<li  ng-if="$index%2==1" >
<ul style="background-color:black;color:white;padding:10px;">
<li>adding date:- <input type="text" ng-model="x.addingdate" disabled /></li>
<li>sid:- <input type="text" ng-model="x.sid" /></li>
<li>Active:<select ng-model="x.active">
<option value="active">active</option>
<option value="inactive">inactive</option>
</select>
</li>
<li><button ng-click="updatetw(x)" class="btn btn-success btn-sm">update</button></li>
<li><button ng-click="deletetw(x)" class="btn btn-success btn-sm">delete</button></li>
</ul>
</li>
</ul>


</div>



</div> <!-- - omar borkan al gala  -->

</div>


 

    
 <!-- Prescription records -->   
    
    <button style="display:none;" id="presrecordbtn" data-toggle="modal" data-target="#presrecordmodal"></button>
    <div id="presrecordmodal" class="modal fade" role="dialog">
  <div class="modal-dialog" style="width:550px;margin-left:150px;" >
 <!-- Modal content-->
      <div class="modal-content" style="width:550px;">
      <div class="modal-header" style="background-color:gray;">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">prescription records</h4>
      </div>

  <div class="modal-body" >
      <b>Animal info & prescription</b>
<div ng-repeat="x in presrecords" style="font-size:0.80em;">

<div ng-if="$index==0" style="background-color:darkslategray;color:white;margin-bottom:4px;" class="row">
<div class="col-sm-7"><ul style="list-style-type:none;">
<li><b style="color:black;">animal id::-</b>{{x.ap.anid}} <b>doctor name::</b>{{x.ap.doctor}}</li>
<li><b style="color:black;">color::-</b>{{x.ap.color}}</li>
<li><b style="color:black;">age::-</b>{{x.ap.age}}</li>
<li><b style="color:black;">type::-</b>{{x.ap.type}} <b>   gender::-</b>{{x.doctor}}</li>
<li><b style="color:black;">weight::-</b><input type="number" ng-model="x.ap.weight"/></li>
<li><button ng-click="updateanimal(x.ap);">update</button></li>
</ul></div>
<div class="col-sm-4">
<img  style="height:150px;width:150px;"  src="<c:url value="/static/images/{{x.ap.filename}}" />"/>
</div>

<br/>
</div>
<b ng-if="$index==0">time condition** </b> <p ng-if="$index==0">it means if '0' then the drug need to take every day
otherwise the medicine need to take every 1 day later or  or 2 day later or 'N' 
day later etc</p>
<p style="color:green;">use 10 digit to edit the date , date format (day/month/year)</p>
<table border="1" style="width:60%;font-size:0.85em;">
<tr ng-if="$index==0">
<th><b>starting date</b></th>
<th><b>drug type</b></th>
<th><b>drug name</b></th>
<th><b>continue til</b></th>
<th><b>rules</b></th>
<th><b>other</b></th>
</tr>
<tr >
<td>
<b style="color:maroon;">dd/mm/yyyy</b><input type="text" ng-model="x.stringstartingdate" style="width:80px;height:20px;"/>
</td>


<td>

{{x.drugtype}}
</td>
<td >
{{x.drugname}}
</td>


<td>
<b style="color:maroon;">dd/mm/yyyy</b><input type="text" ng-model="x.stringlastdate" style="width:80px;background-color:skyblue;height:20px;"/>
</td>
<td>

<input type="text" ng-model="x.rules"/>


</td>



<td>
<b>advice</b><input type="text" ng-model="x.consult"/><br/>
<b style="color:maroon;">time condition</b><input type="number" ng-model="x.prestypenumber"/><br/>
<button ng-click="presupdate(x)">update</button>

</td>

</tr>

</table>
</div>

 </div>
    
  <div class="modal-footer">
   <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
      </div>
    </div>

  </div>
</div>
    
    
 <button style="display:none;" id="pregnantmodalbtn" data-toggle="modal" data-target="#pregnantmodal"></button>
  <div id="pregnantmodal" class="modal fade" role="dialog" >
  <div class="modal-dialog"  >
       <!-- Modal content-->
  <div class="modal-content" style="width:500px;font-size:0.80em;margin-left:">
  <div class="modal-header" style="background-color:gray;">
  <button type="button" class="close" data-dismiss="modal">&times;</button>
  <h4 class="modal-title">pregnant report</h4>
  </div>
  <div class="modal-body" >

<button  class="btn btn-sm btn-primary" ng-click="addpreg()">addrow</button> <button  ng-click="removepreg()" class="btn btn-sm btn-primary">remove</button>
       
        <br/> <br/>
        
         <div ng-repeat="p in pregnant" >
         
        <div ng-if="$index%2==0" style="border:1px solid green;background-color:skyblue;">
        <br/>
     <b style="color:red;">{{p.sms}}</b>
         <b>animalid</b><input type="number" ng-model="p.anid" ng-keyup="checkpreganimalid($index)"/>
         <b>type</b><select  ng-model="p.type" ng-change="checkpreganimalid($index);">
         
<option value="cow">গরু</option>
<option value="goat">ছাগল </option>
<option value="buffelo">মহিষ </option>
<option value="vera">ভেড়া  </option>

         </select>
        
       <br/> <br/>
        <b style="color:red;">{{p.dateerr}}</b>
 <b>concive date(dd/mm/yyyy)</b> <select ng-model="pregd[$index]" ng-options="c for c in days" ng-change="setconcivedate($index);"> </select> 
        <select ng-model="pregm[$index]" ng-options="c for c in mfi" ng-change="setconcivedate($index);"> </select> 
        <select ng-model="pregy[$index]" ng-options="c for c in years" ng-change="setconcivedate($index);"> </select> <br/>  <br/> 
             <b>next concive date</b><input type="text" ng-model="p.stringnextconcive" disabled/> <br/>
         <b>pregnancy serial no</b><input type="number" ng-model="p.pregnantno" disabled/> <button ng-click="delform($index);">delete this form</button><br/>
    <b>predicted child birth</b><input type="text" ng-model="p.stringpossibledate" disabled/> <b>(record no:- {{$index+1}})</b>
           <br/><br/>
	   </div>
	
	   <div ng-if="$index%2==1" style="border:1px solid black;background-color:darkseagreen;">
	    <br/>     
	          <b style="color:red;">{{p.sms}}</b>
	            <b>animalid</b><input type="number" ng-model="p.anid" ng-keyup="checkpreganimalid($index);"/>
            <b>type</b><select  ng-model="p.type" ng-change="checkpreganimalid($index);" >
            
<option value="cow">গরু</option>
<option value="goat">ছাগল </option>
<option value="buffelo">মহিষ </option>
<option value="vera">ভেড়া  </option>
         </select>
        
       <br/>  <br/> 
	 <b style="color:red;">{{p.dateerr}}</b>
	 <b>concive date(dd/mm/yyyy)</b> <select ng-model="pregd[$index]" ng-options="c for c in days" ng-change="setconcivedate($index);"> </select> 
        <select ng-model="pregm[$index]" ng-options="c for c in mfi" ng-change="setconcivedate($index);"> </select> 
        <select ng-model="pregy[$index]" ng-options="c for c in years" ng-change="setconcivedate($index);"> </select> <br/>  <br/> 
        <b>next concive date</b><input type="text" ng-model="p.stringnextconcive" disabled/> <br/>
        <b>pregnancy serial no</b><input type="number" ng-model="p.pregnantno" disabled/><button ng-click="delform($index);">delete this form</button> <br/>
        <b>predicted child birth</b><input type="text" ng-model="p.stringpossibledate" disabled/> <b>(record no:- {{$index+1}})</b>
	   <br/><br/>
	   </div>
	  <br/> <br/>
   </div>
  <div class="modal-footer">
  <button  style="float:left;"class="btn btn-success" ng-click="postpregnant();">save</button>  <button  class="btn btn-default" data-dismiss="modal">Close</button>
      </div>
    </div>

  </div>
</div>   
    
</div>

 <div id="tcpmodal" class="modal fade" role="dialog" >
  <div class="modal-dialog"  >
       <!-- Modal content-->
  <div class="modal-content" style="width:500px;font-size:0.80em;">
  <div class="modal-header" style="background-color:gray;">
  <button type="button" class="close" data-dismiss="modal">&times;</button>
  <h4 class="modal-title">cost & profit</h4>
  </div>
  <div class="modal-body" >
  <b>total amount :: {{tamountc}} kg</b> <br/>
  <b>total taka:: {{tpricec}}</b>
  <table border="1" style="width:500px;overflow:auto;">
  <tr>
  <th>animal id</th>
  <th>collected milk</th>
  <th>animal type</th>
  <th>total price</th>
  <th>rate</th>
  <th>update</th>
  </tr>
  <tr ng-repeat="r in recsbydate">
  <td> {{r.anid}}</td> 
   <td><input   style="width:80px;" type="number" ng-model="r.amount"/></td>
    <td><input  style="width:80px;" type="text" ng-model="r.animaltype" /></td>
     <td><input style="width:80px;" type="number" ng-model="r.totalprice"/></td>
      <td><input style="width:80px;" type="number" ng-model="r.rate"/></td>
       <td><button ng-click="updatecollect($index)"></button></td>
  </tr>
  </table>
  
  </div>
  <div class="modal-footer">
   <button  class="btn btn-default" data-dismiss="modal">Close</button>
      </div>
    </div>

  </div>
</div>  



 <div id="msell" class="modal fade" role="dialog" >
  <div class="modal-dialog" style="position:absolute;left:100;">
       <!-- Modal content-->
  <div class="modal-content" style="width:900px;font-size:0.80em;margin-left:100px;" >
  <div class="modal-header" style="background-color:gray;">
  <button type="button" class="close" data-dismiss="modal">&times;</button>
  <h4 class="modal-title">milk sell record</h4>
  </div>
  <div class="modal-body" >
    <script>
  function takeval(){
	  
	  var d = document.getElementById("cs").value;
	  var asd=["x","y","z","w","w1","w2","w3"];
	  
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
  <div style="text-align:center;">
  <b>select search option:</b><select name="cs" id="cs" onchange="takeval()">
  <option value="--">---</option>
<option value="x">search by date</option>
<option value="y">search by month</option>
<option value="z">search buyername</option>
<option value="w">search by phone number</option>
<option value="w1">search between two date</option>
<option value="w2">search by year</option>
<option value="w3">all selling history</option>
</select>

    </div>
  <br/>
  
  <div id="w3"  style="background-color:darkseagreen;padding:10px;text-align:center;display:none;">
  <b>all milk selling record </b> <br/>
  <button ng-click="tmsell()" class="btn btn-dark btn-sm">all selling</button> 
  </div>
  
  <div  id="x" style="background-color:burlywood;padding:10px;text-align:center;display:none;">
  <b>search by date::</b><input type="text" ng-model="bn.stringselldate" placeholder="day/month/year" ng-keyup="inadatekey()"/> <button ng-click="inadate()" class="btn btn-sm btn-dark">search</button>
  </div>
  
  
   <div id="y"  style="background-color:gray;display:none;padding:10px;text-align:center;">
  <b style="color:white;">search by month:-</b>  <b>month</b> <select ng-model="am" ng-options="c for c in mfi" ></select>
  <b>year</b><select ng-model="ay" ng-options="c for c in years" ></select>

  <button ng-click="inamonth()" class="btn btn-sm btn-dark">search</button>
  </div>
  
  
  <div id="z"  style="background-color:skyblue;display:none;padding:10px;text-align:center;">
  <b>type buyername::</b><input type="text" ng-model="bn.buyername" placeholder="buyer name" ng-keyup="buyername()" ng-click="clearitbn()"/> <br/>
  <br/>
  </div>
  
  <div id="w2"  style="background-color:skyblue;display:none;padding:10px;text-align:center;">
  
  <b>type the year::</b><input type="text" ng-model="bn.year" placeholder="year" ng-keyup="bnys()" ng-click="clearitbn()" /> <br/>
  
  </div>


   <div id="w"  style="background-color:mediumseagreen;display:none;padding:10px;text-align:center;">
  
  type contact:-<input type="text" ng-model="bn.contact" placeholder="contact" ng-keyup="scontact()" ng-click="clearitbn()" /><br/>
  <br/>
 </div>
  
  
  
  <div id="w1" style="background-color:silver;color:maroon;padding:10px;text-align:center;display:none;">
   <b> search between two date:: </b> <br/>
    
   first date:-  <input type="text" ng-model="sm1" placeholder="day/month/year"  /> 
      second date:-  <input type="text" ng-model="sm2" placeholder="day/month/year"  />
 
 <button ng-click="smbt()" >search</button> 
      </div>
      
      

    <div style="text-align:center;color:maroon;background-color:gold;">
    
    <b>total - due=</b> {{tt}} tk <b> , 
    total amount in kg=</b>{{tm}} kg <b>,
     total due=</b>{{tdue}} tk
     <br/>
     <b>{{mselltitle}}</b>
    
    </div>
  
  <table border="1" style="text-align:center;" id="ttt">
  <tr ng-if="msells.length>0">
  <th>buyer name</th>
   <th>contact</th>
   <th>amount</th>
    <th>milk rate</th>
     <th>totalprice</th>
      <th>due</th>
      <th>selldate</th>
      <th>task</th>
   </tr>
   
  <tr ng-repeat="x in msells">
  <td><input type="text"      ng-model="x.buyername" style="width:100px;" /></td>
   <td><input type="text"      ng-model="x.contact" style="width:100px;" /></td>
  <td><input type="number"    ng-model="x.amount"  style="width:70px;" /></td>
  <td><input type="number"    ng-model="x.rate"  style="width:70px;" /></td>
  <td><input type="number"    ng-model="x.totalprice"  style="width:80px;" /></td>
  <td><input type="number"    ng-model="x.due" style="width:80px;" /></td>
  <td><input type="text"      ng-model="x.stringselldate" style="width:100px;" /></td>
  <td><button class="btn btn-primary btn-sm" ng-click="upmsell(x);">update</button>
  <br/><br/>
<button class="btn btn-primary btn-sm" ng-click="deletemilk($index,x);">delete</button>
  </td>
  </tr> 
  
  </table>
  
  
  
  </div>
  <div class="modal-footer">
   <button  class="btn btn-default" data-dismiss="modal">Close</button>
      </div>
    </div>

  </div>
</div>  



 <div id="tsm" class="modal fade" role="dialog" >
  <div class="modal-dialog">
       <!-- Modal content-->
  <div class="modal-content" style="width:500px;font-size:0.80em;margin-lrft:50px;">
  <div class="modal-header" style="background-color:gray;">
  <button type="button" class="close" data-dismiss="modal">&times;</button>
  <h4 class="modal-title">milk sell record</h4>
  </div>
  <div class="modal-body" style="text-align:center;">
  
  <div style="background-color:maroon;color:white;padding:20px;">
  <h4>total selling records</h4>
 <b>total sold except due::</b> {{tt}} tk 
  <br/>
 <b> total amount of milk in ::</b>{{tm}} kg <br/>
 <b>total due::{{tdue}} tk</b>
  </div>

 
 
  <br/>
 search by buyername:: <input type="text" ng-model="bns.buyername" placeholder="buyername" ng-click="clearbn()" /> <br/>
    search by contact::<input type="text" ng-model="bns.contact" placeholder="contact" ng-click="clearbn()" /> <br/>
    search by date::  <input type="text" ng-model="bns.stringselldate" placeholder="selldate" ng-click="clearbn()" /><br/>
  <table border="1" style="textr-align:center;">
  
 <tr>
 <th>buyer name</th>
  <th>contact</th>
 <th>amount</th>
 <th>rate </th>
 <th>price</th>
 <th>tota due</th>
 <th>date</th>
  </tr>
  
  <tr ng-repeat="x in msells | filter:bns">
  <td>{{x.buyername}}</td>
  <td>
  {{x.contact}}</td>
   <td>{{x.amount}}</td>
    <td>{{x.rate}}</td>
    <td>{{x.totalprice}}</td>
    <td>{{x.due}}</td>
      <td>{{x.stringselldate}}</td>
  </tr>
  </table>
  
</div>
  <div class="modal-footer">
   <button  class="btn btn-default" data-dismiss="modal">Close</button>
      </div>
    </div>

  </div>
</div>  







 <div id="cm" class="modal fade" role="dialog" >
  <div class="modal-dialog" style="position:absolute;left:100;">
       <!-- Modal content-->
  <div class="modal-content" style="width:700px;font-size:0.80em;margin-left:100px;">
  <div class="modal-header" style="background-color:gray;">
  <button type="button" class="close" data-dismiss="modal">&times;</button>
  <h4 class="modal-title">milk collection record</h4>
  </div>
  <div class="modal-body" style="text-align:center;">
 
  <br/>
  <div>
  <h4>total collection information</h4>
    <b> total collected milk in :: {{tmilkkg}} kg</b><br/>
 <b>total taka:: {{tmilktaka}} tk</b> <br/>
 <b>total records:: {{tmilkrecord}} </b>
  	
	
	
  </div>
  
  <div style="background-color:burlywood;">
  search by animal id:: <input type="text" ng-model="coll.id" placeholder="animal id" ng-keyup="filterid();" /> <br/>
 
 search by  rate::<input type="text" ng-model="coll.rate" placeholder="rate" ng-keyup="filterrate();" /> <br/>
 
 search by date::  <input type="text" ng-model="coll.date" placeholder="day/month/year" ng-keyup="filteryear();" />
  </div>
<br/>
 <b style="color:red">note:: use two digit for day & month. for example 02 or 05  or 20 or 31  etc</b>
  <br/>
 <br/>
 

 <div style="background-color:skyblue;">
  <h4 style="color:green;">search result</h4>
  <b> searched milk in :: {{tcm}} kg</b><br/>
 <b> taka:: {{ttm}} tk</b> <br/>
 <b> records:: {{cmlst.length}}</b>
 </div>
 

  <table border="1" style="textr-align:center;">
  <tr ng-repeat="x in cmlst">
 <th ng-if="$index==0">animal id</th>
 <th ng-if="$index==0">amount</th>
 <th ng-if="$index==0">rate</th>
 <th ng-if="$index==0">total price</th>
 <th ng-if="$index==0">date</th>
  <th ng-if="$index==0">update</th>
  </tr>
  <tr ng-repeat="x in cmlst">
     <td><input style="width:100px;" type="number" ng-model="x.anid" /></td>
   <td><input style="width:100px;" type="number" ng-model="x.amount" /></td>
   <td><input style="width:100px;" type="number" ng-model="x.rate" /></td>
   <td><input style="width:100px;" type="number" ng-model="x.totalprice" /></td>
 <td><input style="width:100px;" type="text" ng-model="x.stringcollectdate" /></td>
 <td><button ng-click="updatecmt(x)" class="btn btn-success btn-sm">update</button></td>
  </tr> 
  </table>
  </div>
  <div class="modal-footer">
   <button  class="btn btn-default" data-dismiss="modal">Close</button>
      </div>
    </div>

  </div>
</div>  




 <div id="cc" class="modal fade" role="dialog"   >
  <div class="modal-dialog" >
       <!-- Modal content-->
  <div class="modal-content" style="width:500px;font-size:0.80em;">
  <div class="modal-header" style="background-color:gray;">
  <button type="button" class="close" data-dismiss="modal">&times;</button>
  <h4 class="modal-title">upcoming bearing animal</h4>
  </div>
  <div class="modal-body" style="text-align:center;">
 <table   border="1">
 <tr ng-if="upchildlist.length>0">
 <th>animal id</th>
 <th>type</th>
 <th>estimated bear date</th>
 <th>next concive date</th>
 <th>details</th>
 </tr>
 
  <tr ng-repeat="x in upchildlist">
 <td>{{x.anid}}</td>
 <td>{{x.type}}</td>
 <td>{{x.stringpossibledate}}</td>
 <td>{{x.stringnextconcive}}</td>
 <td>
 <button class="btn btn-dark btn-sm" ng-click="aboutanimal(x.anid);" data-target="#aboutanimal" data-toggle="modal" >
 more</button>
 </td>
 </tr>
 
 </table>

 
  </div>
  <div class="modal-footer">
   <button  class="btn btn-default" data-dismiss="modal">Close</button>
      </div>
    </div>

  </div>
</div> 








 <div id="delete" class="modal fade" role="dialog" >
  <div class="modal-dialog" style="margin-left:100px;" >
       <!-- Modal content-->
  <div class="modal-content" style="width:500px;font-size:0.80em;">
  <div class="modal-header" style="background-color:gray;">
  <button type="button" class="close" data-dismiss="modal">&times;</button>
  <h4 class="modal-title">delete record</h4>
  </div>
 <div class="modal-body" style="text-align:center;">
<script>

function test(x){
	
	
	x.style.color="red";
	
	
}

function test2(x){
	
	
x.style.color="blue";

	
}

</script>

<ul style="list-style-type:none;color:maroon;padding:10px;">
<li style="padding:10px;background-color:gray;"><button style="width:200px;" 
onmouseover="test(this);" onmouseleave="test2(this);" ng-click="cleardatabase('animal');" >clear animal data</button></li>
<li style="padding:10px;background-color:green;"><button style="width:200px;"
 onmouseover="test(this);" onmouseleave="test2(this);" ng-click="cleardatabase('cowsell');">clear cow seeling data</button></li>
<li style="padding:10px;background-color:gray;"><button style="width:200px;" 
onmouseover="test(this);" onmouseleave="test2(this);" ng-click="cleardatabase('milksell');">clear milk selling data</button></li>
<li style="padding:10px;background-color:green;"><button style="width:200px;" 
onmouseover="test(this);" onmouseleave="test2(this);" ng-click="cleardatabase('dailycost');">clear daily cost data</button></li>
<li style="padding:10px;background-color:gray;"><button style="width:200px;" 
onmouseover="test(this);" onmouseleave="test2(this);" ng-click="cleardatabase('prescription');">clear prescription data</button></li>
</ul>

 
 </div>
 <div class="modal-footer">
  <button  class="btn btn-default" data-dismiss="modal">Close</button>
  
  
  </div>
  </div>

  </div>
</div> 








 <div id="changepassword" class="modal fade" role="dialog"   >
  <div class="modal-dialog" style="margin-left:100px;" >
       <!-- Modal content-->
  <div class="modal-content" style="width:500px;font-size:0.80em;">
  <div class="modal-header" style="background-color:gray;">
  <button type="button" class="close" data-dismiss="modal">&times;</button>
  <h4 class="modal-title">change password</h4>
  </div>
 <div class="modal-body" style="text-align:center;">
 <b>enter old password::</b> <br/><br/>
 <input type="password" ng-model="oldpassword" />
 <br/>
 <br/>
 <b>enter new password</b> <br/><br/>
<input type="password" ng-model="password1" />
 <br/>
 <br/>
 <b>confirm new password</b> <br/><br/>
<input type="password" ng-model="password2" />
<br/>
<br/>
<button ng-click="changepassword()" class="btn btn-success btn-sm">change</button>

 
 </div>
 <div class="modal-footer">
  <button  class="btn btn-default" data-dismiss="modal">Close</button>
  
  
  </div>
  </div>

  </div>
</div> 



<div id="changeemail" class="modal fade" role="dialog"   >
  <div class="modal-dialog" style="margin-left:100px;" >
       <!-- Modal content-->
  <div class="modal-content" style="width:500px;font-size:0.80em;">
  <div class="modal-header" style="background-color:gray;">
  <button type="button" class="close" data-dismiss="modal">&times;</button>
  <h4 class="modal-title">change email</h4>
  </div>
 <div class="modal-body" style="text-align:center;">
 <div style="background-color:skyblue;padding:10px;">
  <h4 style="color:red;">note::</h4><b>if dont get code then change setting of your email "Access for less secure app=turn on"</b>
 </div>

 <br/>
 <br/>
 <div style="background-color:darkseagreen;padding:10px;">
  <b style="color:green;">enter new email::</b> <br/><br/>
 <input type="text" ng-model="admin.email" />
 <br/>
 <br/>
 <b style="color:green;">enter admin password for security</b> <br/><br/>
<input type="password" ng-model="admin.password" />
<br/>
<br/>
 <b style="color:green;">enter new gmail's password to get code</b> <br/><br/>
<input type="password" ng-model="admin.gmailspass" />
<br/>
<br/>
<button ng-click="changeemail()" class="btn btn-success btn-sm">change</button>

<br/><br/>
 </div>


<div style="display:none;" id="codecheck">
<b>enter the code sent to your email</b> <br/>
<br/>
<input type="text" ng-model="submitcode" placeholder="your code"/> 
<br/>
<br/>

<button ng-click="finalchangeemail()">final submit</button>
</div>

</div>

 <div class="modal-footer">
<button  class="btn btn-default" data-dismiss="modal">Close</button>
</div>
</div>
</div>
</div> 


<div id="othersettings" class="modal fade" role="dialog"   >
  <div class="modal-dialog" style="margin-left:100px;" >
       <!-- Modal content-->
  <div class="modal-content" style="width:500px;font-size:0.80em;">
  <div class="modal-header" style="background-color:gray;">
  <button type="button" class="close" data-dismiss="modal">&times;</button>
  <h4 class="modal-title">other settings</h4>
  </div>
 <div class="modal-body" style="text-align:center;">



 
 </div>
 <div class="modal-footer">
  <button  class="btn btn-default" data-dismiss="modal">Close</button>
  
  
  </div>
  </div>

  </div>
</div> 

<div id="admininfo" class="modal fade" role="dialog"   >
  <div class="modal-dialog" style="margin-left:100px;" >
       <!-- Modal content-->
  <div class="modal-content" style="width:500px;font-size:0.80em;">
  <div class="modal-header" style="background-color:gray;">
  <button type="button" class="close" data-dismiss="modal">&times;</button>
  <h4 class="modal-title">other settings</h4>
  </div>
 <div class="modal-body" style="text-align:center;">
 <style rel="stylesheet">
 #l{
 background-color:brown;
 color:white;
 }
 </style>
 <div id="l">
 <ul style="list-style-type:none;">
<li>email:-{{admin.email}}</li>
<li>phone:-{{admin.phone}}</li>
</ul>
 
 </div>

</div>
 <div class="modal-footer">
  <button  class="btn btn-default" data-dismiss="modal">Close</button>
  
  
  </div>
  </div>

  </div>
</div> 

<div id="changenumber" class="modal fade" role="dialog"   >
  <div class="modal-dialog" style="margin-left:100px;" >
       <!-- Modal content-->
  <div class="modal-content" style="width:500px;font-size:0.80em;">
  <div class="modal-header" style="background-color:gray;">
  <button type="button" class="close" data-dismiss="modal">&times;</button>
  <h4 class="modal-title">add new number</h4>
  </div>
 <div class="modal-body" style="text-align:center;">
 <script type="text/javascript">
 
 function checknum(){
	 
	var s = document.getElementById("x").value;
if(isNaN(s)){
	document.getElementById("n").innerHTML="must be a number";
}

if(s.length<11){
	document.getElementById("nl").innerHTML="number size shoiuld be 11";
}


if(!isNaN(s)){
	document.getElementById("n").innerHTML="";
}

if(s.length==11){
	document.getElementById("nl").innerHTML="";
}

 }
 
 </script>
 
<ul style="list-style-type:none;">
<li>enter number</li>
<li><input type="text" ng-model="adminnumber.phone"  id="x" onkeyup="checknum()"/> <br/>
<span id="n" style="color:red;"></span>
<span id="nl" style="color:red;"></span>
</li>

<li>enter password for security</li>
<li><input type="password" ng-model="adminnumber.password" /></li>
<li><br/><button ng-click="changenumber()" class="btn btn-success btn-sm">change number</button></li>
</ul>

</div>
 <div class="modal-footer">
  <button  class="btn btn-default" data-dismiss="modal">Close</button>
  
  
  </div>
  </div>

  </div>
</div> 








<div id="editani" class="modal fade" role="dialog"   >
  <div class="modal-dialog" style="margin-left:100px;" >
       <!-- Modal content-->
  <div class="modal-content" style="width:900px;font-size:0.80em;">
  <div class="modal-header" style="background-color:gray;">
  <button type="button" class="close" data-dismiss="modal">&times;</button>
  <h4 class="modal-title">edit animal</h4>
  </div>
 <div class="modal-body" style="text-align:center;">



<table border="1" >
  <tr>
<th>type & source</th>
<th>gender</th>
<th>color</th>
<th>price</th>
<th>height</th>
<th>weight</th>
<th>birth date</th>
<th>extra note</th>
  </tr>
  
  <tr>
  
      <td>
      <b>animal type</b>
      <select ng-model="editani.type">
      
<option value="cow">গরু</option> 
<option value="goat">ছাগল </option>
<option value="buffelo">মহিষ </option>
<option value="vera">ভেড়া  </option>
       
         </select> 
         <br/>
          <b>source</b>
      <select ng-model="editani.source">
      <option value="from market">from market</option>
      <option value="from my firm">from my firm</option>
         </select>   
         <br/>
         <input ng-if="editani.source=='from market'"  type="text" ng-model="editani.sellername" placeholder="seller name" /><br/>
           <input ng-if="editani.source=='from market'"  type="text" ng-model="editani.marketname" placeholder="market name"  /><br/>
           
            <input type="text" ng-model="editani.jaat" type="text" placeholder="প্রানির জাত" /><br/> 
          
          </td>
          
          <td>
   <select ng-model="editani.gender">
  <option value="male">male</option>
   <option value="female">female</option>
  </select>
          </td>
          
      <td style="background-color:green;">
      <input type="checkbox"   ng-click="choosecolor('brown')" > 
       <b style="background-color:brown;">brown</b>
<br/> <br/>
      <input type="checkbox"    ng-click="choosecolor('gray')" >
      <b style="background-color:gray;">gray</b>
      <br/> <br/>
      <input type="checkbox"   ng-click="choosecolor('black')" >

      <b style="background-color:black;">black</b> <br/> <br/>
    <input type="checkbox"   ng-click="choosecolor('white')" >

      <b style="color:white;">white</b>
      <br/> <br/>
 </td>
 
 
  <td> 
   <b>price</b>
      <input style="width:80px;"  type="number" ng-model="editani.chest" />
      
      </td>

         <td>
         
       <b>height</b> <br/>
      <input  style="width:50px;"  type="number" ng-model="editani.height" />
      <br/>
            <select ng-model="editani.hu">
<option value="cm">cm</option>
<option value="inch">inch</option>
<option value="feet">feet</option>
      </select>
      </td>    
      

        <td>
       <b>weight</b> <br/>
      <input style="width:50px;"  type="number" ng-model="editani.weight" />
      <br/>
            <select ng-model="editani.wu">
<option value="kg">কেজি</option>
<option value="gm">গ্রাম</option> 
<option value="mon">মন</option>
      </select>
      <br/>

      </td> 
      
      
      <td>
      <input type="text" ng-model="editani.stringbdate" style="width:100px;" placeholder="day/month/year"/>
      </td>
      
       <td>
       <b>note</b>
<textarea rows="3" cols="10" ng-model="editani.extra"></textarea> 
       </td>     
    </tr>

</table>
<button class="btn btn-sm btn-success" ng-click="finalupdateani()">submit</button>
</div>
</div>
 <div class="modal-footer">
  <button  class="btn btn-default" data-dismiss="modal">Close</button>
  
  
  </div>
  </div>

  </div>
</div> 




<div id="editemp" class="modal fade" role="dialog"   >
 <div class="modal-dialog" style="margin-left:100px;" >
 <div class="modal-content" style="width:500px;font-size:0.80em;">
 <div class="modal-header" style="background-color:gray;">
 <button type="button" class="close" data-dismiss="modal">&times;</button>
 <h4 class="modal-title">edit employee</h4>
 </div>
 <div class="modal-body" style="text-align:center;">
 <style>
 
 #m{
 display:block;
overflow:hidden;
margin:0;
padding:0;
 }
 #m li{
 display:inline;
 
 }
 
 </style>
<ul id="m">
<li><input type="text" ng-model="editemp.name" placeholder="name" /></li>
<li><input type="text" ng-model="editemp.designation" placeholder="designation" /></li>
<li><input type="text" ng-model="editemp.age" placeholder="age" /></li>
<li><input type="text" ng-model="editemp.phone" placeholder="phone" /></li>
<li><input type="text" ng-model="editemp.salary" placeholder="salary" /></li>
<li><input type="text" ng-model="editemp.nid" placeholder="NID" /></li>
<li><input type="text" ng-model="editemp.address" placeholder="address" /></li>
<li><input type="text" ng-model="editemp.stringjoindate" placeholder="joindate" /></li>
<li><select  ng-model="editemp.activestatus" placeholder="active">
<option value="active worker">active employee</option>
<option value="left job">left job</option>
</select>
</li>
</ul>
<br/>
<button ng-click="editempfinal();">submit</button>

</div>
 <div class="modal-footer">
  <button  class="btn btn-default" data-dismiss="modal">Close</button>
   </div>
  </div>
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