package dairy.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import dairy.model.Collectmilk;
import dairy.model.Firmadmin;
import dairy.model.Sellmilk;
import dairy.model.Twillioclass;
import dairy.repo.Adminrepo;
import dairy.repo.Animalrepo;
import dairy.repo.Collectmilkrepo;
import dairy.repo.Sellmilkrepo;
import dairy.repo.Twiliorepo;
import dairy.service.TwillioService;

@Controller
@RequestMapping("/milk")
public class Milkcontrol {
@Autowired
private Collectmilkrepo crr;
@Autowired
private Sellmilkrepo srr;
@Autowired
private Animalrepo arr;	
@Autowired
private Adminrepo adr;	
@Autowired
TwillioService twillioService;
@Autowired
private Twiliorepo trr;

@PostMapping("/collectbydate")
public ResponseEntity<List<Collectmilk>>  collectbydate(@RequestBody String cdate) throws ParseException{
	   SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
          Date d=sdf.parse(cdate);
         List<Collectmilk> lst = crr.findByCollectdate(d); 
         System.out.println("the date is as"+cdate);
         System.out.println("the date is as"+cdate);
         System.out.println("the date is as"+cdate);
         System.out.println("list size is as"+lst.size());
         return new ResponseEntity<List<Collectmilk>>(lst,HttpStatus.OK);   
	   }

@RequestMapping(value="/updatecollect" , method=RequestMethod.PUT)
public ResponseEntity<Collectmilk>  collectbydate(@RequestBody  Collectmilk cm){
float totalprice=cm.getAmount()*cm.getRate();
cm.setTotalprice(totalprice);
    	crr.save(cm);
     	return new ResponseEntity<Collectmilk>(cm,HttpStatus.OK);   
	   }


@PostMapping("/addmilk")
public ResponseEntity<List<Collectmilk>> addmilk(@RequestBody List<Collectmilk> milklist){
    SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
	 String err=""; String exist="";
	 String wrongdate="";
	 
    for(Collectmilk cm : milklist){ 
	   if(!arr.existsByAnidAndType(cm.getAnid(), cm.getAnimaltype())) {
		   err=err+" id::"+cm.getAnid() +", type::"+cm.getAnimaltype()+"not found"+", ";
		   
	   }
	   
	   
	    if(crr.existsByAnidAndStringcollectdate(cm.getAnid(), cm.getStringcollectdate())) {
		   exist=exist+","+" id::"+cm.getAnid() +", type::"+cm.getAnimaltype()+"  amount::"+cm.getAmount()+
				   " added in::"+cm.getStringcollectdate()+"already added"+", ";
	            }
	    
	   if(err.contentEquals("") && exist.contentEquals("")){
		 try {
			cm.setCollectdate(sdf.parse(cm.getStringcollectdate()));
		} catch (ParseException e) {
			wrongdate="null date,select again";
			e.printStackTrace();
		                         }
	       
                                    }
                                 }
  
    
     if(err.contentEquals("") && wrongdate.contentEquals("") && exist.contentEquals("")) {
          for(Collectmilk cm : milklist){ 
    	    	crr.save(cm);
    	                            }
    	    milklist.get(0).setStringcollectdate("successfully added record");
            return new ResponseEntity<List<Collectmilk>>(milklist,HttpStatus.OK);
 
                 }
    else {
    	
    	    err=err+exist+wrongdate;
    		System.out.println("there exist invalid record which is not present to animal table");
    		milklist.get(0).setStringcollectdate(err);
            return new ResponseEntity<List<Collectmilk>>(milklist,HttpStatus.OK);
                           
        }
	
	
}






@PostMapping("/sellmilk")
public ResponseEntity<List<Sellmilk>> sellmilk(@RequestBody List<Sellmilk> milks) throws ParseException{
SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
String mailsms="";
 for(Sellmilk sm : milks) {
	 mailsms=mailsms+" milk rate: "+sm.getRate()+" sell to: "+sm.getBuyername()+" amount(kg) "+sm.getAmount()+" total price: "+sm.getTotalprice()+
			 " due tk: "+sm.getDue()+" buyer phone: "+sm.getContact(); 
	 sm.setSelldate(sdf.parse(sm.getStringselldate()));
	 srr.save(sm);
 }
 
mailsms="you have sold "+mailsms;
Firmadmin ad=adr.findAll().get(0);
new Sendotp().sendotp(mailsms, ad.getEmail(),"milk sell reord", ad.getEmail(), ad.getGmailspass());
	List<Twillioclass> tls= trr.findByActive("active");
  for(Twillioclass t:tls) {
	twillioService.sendSms(t.getTomy(),t.getFromtwilio(),mailsms,t.getSid(),t.getAuthtoken() );			
		   }
return new ResponseEntity<List<Sellmilk>>(milks,HttpStatus.OK) ;

}

@PostMapping("/inadate")
public ResponseEntity<List<Sellmilk>> inadate(@RequestBody String  ad) {
List<Sellmilk> lst =new ArrayList<Sellmilk>();
SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
Date d=null;
try {
	d = sdf.parse(ad);
	lst = srr.findBySelldate(d);
} catch (ParseException e) {
	
	// TODO Auto-generated catch block
	e.printStackTrace();
}

return new ResponseEntity<List<Sellmilk>>(lst,HttpStatus.OK) ;
	
}

@PostMapping("/inadatekey")
public ResponseEntity<List<Sellmilk>> inadatekruy(@RequestBody String  ad){
List<Sellmilk> lst =lst = srr.findByStringselldateContaining(ad);
return new ResponseEntity<List<Sellmilk>>(lst,HttpStatus.OK) ;
	
}




@PostMapping("/inamonth")
public ResponseEntity<List<Sellmilk>> inamonth(@RequestBody String[]  ad) throws ParseException{
	String dt="1/"+ad[0]+"/"+ad[1];
SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
  Date d1 = sdf.parse(dt); 
  Calendar cal = Calendar.getInstance();
  cal.setTime(d1);
  int maxdate=cal.getActualMaximum(Calendar.DATE);
  String dt2= Integer.toString(maxdate)+"/"+ad[0]+"/"+ad[1];
  Date d2 = sdf.parse(dt2);
  List<Sellmilk> lst = srr.findBySelldateBetween(d1,d2);
  
  System.out.println("the two date are ass"+dt+"    "+dt2);
  
 return new ResponseEntity<List<Sellmilk>>(lst,HttpStatus.OK) ;
}

@PostMapping("/buyername")
public ResponseEntity<List<Sellmilk>> buyername(@RequestBody String  ad) throws ParseException{

  List<Sellmilk> lst = srr.findByBuyernameContainingIgnoreCase(ad);
	return new ResponseEntity<List<Sellmilk>>(lst,HttpStatus.OK) ;
}



@GetMapping("/tmsell")
public ResponseEntity<List<Sellmilk>> tmsell(){
 List<Sellmilk> lst = srr.findAll();
 System.out.println("the size of list is as"+lst.size());
 System.out.println("the size of list is as"+lst.size());
 System.out.println("the size of list is as"+lst.size());
 System.out.println("the size of list is as"+lst.size());
 return new ResponseEntity<List<Sellmilk>> (lst,HttpStatus.OK) ;
 
}



@PostMapping("/smbt")
public ResponseEntity<List<Sellmilk>> smbt(@RequestBody String[] t) throws ParseException{
SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
Date d1 = sdf.parse(t[0]);
Date d2 = sdf.parse(t[1]);
List<Sellmilk> lst = srr.findBySelldateBetween(d1,d2);
 return new ResponseEntity<List<Sellmilk>> (lst,HttpStatus.OK) ;
 
}


@GetMapping("/collection")
public ResponseEntity<List<Collectmilk>> smbt(){

	List<Collectmilk> lst = crr.findAll(Sort.by(Sort.DEFAULT_DIRECTION.DESC, "collectdate"));
return new ResponseEntity<List<Collectmilk>> (lst,HttpStatus.OK) ;
 
}



@PostMapping("/filterid")
public ResponseEntity<List<Collectmilk>> filterid(@RequestBody Integer t){

List<Collectmilk> lst = crr.findByAnidOrderByCollectdateDesc(t);
 return new ResponseEntity<List<Collectmilk>>(lst,HttpStatus.OK) ;
 
}



@PostMapping("/filt")
public ResponseEntity<List<Collectmilk>> ratefilter(@RequestBody float t){
System.out.println("the value is asssssss"+t);
System.out.println("the value is asssssss"+t);
System.out.println("the value is asssssss"+t);
System.out.println("the value is asssssss"+t);
System.out.println("the value is asssssss"+t);

List<Collectmilk> lst = crr.findByRateOrderByCollectdateDesc(t);
 return new ResponseEntity<List<Collectmilk>> (lst,HttpStatus.OK) ;
 
}

@PostMapping("/filterdate")
public ResponseEntity<List<Collectmilk>> filterdate(@RequestBody String d){
	System.out.println("the value is asssssss"+d);
	System.out.println("the value is asssssss"+d);
	System.out.println("the value is asssssss"+d);
	System.out.println("the value is asssssss"+d);
List<Collectmilk> lst = crr.findByStringcollectdateContaining(d);
 return new ResponseEntity<List<Collectmilk>> (lst,HttpStatus.OK) ;
 
}



@RequestMapping(value="/updatecm",method=RequestMethod.PUT)
public ResponseEntity<Collectmilk> filterdate(@RequestBody Collectmilk  wq){
wq.setTotalprice(wq.getAmount()*wq.getRate());
SimpleDateFormat sdf=new SimpleDateFormat("dd/MM/yyyy");
Date s = null;
boolean x = true;
try {
	s=sdf.parse(wq.getStringcollectdate());

} catch (ParseException e) {
	x=false;
	e.printStackTrace();
}

if(x) {
	crr.save(wq);
	wq.setStringcollectdate("successfull");
}
else {
	wq.setStringcollectdate("wrong date format");
}

return new ResponseEntity<Collectmilk> (wq,HttpStatus.OK) ;
 
}

@PostMapping("/bnys")
public ResponseEntity<List<Sellmilk>> bnsy(@RequestBody String y){
	List<Sellmilk> lst = srr.findByStringselldateContainingOrderBySelldateDesc(y);
	return new ResponseEntity<List<Sellmilk>>(lst,HttpStatus.OK);
 }
 


@PostMapping("/scontact")
public ResponseEntity<List<Sellmilk>> scontact(@RequestBody String y){
          	
	         List<Sellmilk> lst = srr.findByContactContaining(y);
	         return new ResponseEntity<List<Sellmilk>>(lst,HttpStatus.OK);
   
                  }
 


@RequestMapping(value="/upmsell",method=RequestMethod.PUT)

public ResponseEntity<Sellmilk> upmsell(@RequestBody Sellmilk y){
	SimpleDateFormat sdf=new SimpleDateFormat("dd/MM/yyyy");
    y.setTotalprice(y.getAmount()*y.getRate());
     Date s = null; boolean x = true;
     try {
		s=sdf.parse(y.getStringselldate());
	} catch (ParseException e) {
		x=false;
		e.printStackTrace();
	}
     if(x){
    	 y.setSelldate(s);
    	  srr.save(y);
    	  y.setStringselldate("successfully updated");
     }
     else {
    	 y.setStringselldate("sorry!!!, wrong date input");
     }
	return new ResponseEntity<Sellmilk>(y,HttpStatus.OK);
 }
	



}
