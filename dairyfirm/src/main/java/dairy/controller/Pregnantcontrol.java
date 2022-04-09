package dairy.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.Period;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import dairy.model.Animal;
import dairy.model.Firmadmin;
import dairy.model.Pregnantreport;
import dairy.repo.Adminrepo;
import dairy.repo.Animalrepo;
import dairy.repo.Pregnantreportrepo;

@Controller
@RequestMapping("/pregnant")
public class Pregnantcontrol {
	@Autowired
	private Pregnantreportrepo prr;
		public final int din=280;
	@Autowired
	private Animalrepo arr;
	@Autowired
	private Adminrepo adr;
		@PostMapping("/pregdate")
public ResponseEntity<Pregnantreport> getpossibledate(@RequestBody Pregnantreport pregnant) throws ParseException{
List<Pregnantreport> lst = prr.findByAnid(pregnant.getAnid());
SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
Date choosedcondate=sdf.parse(pregnant.getStringconcivedate());
Date lastconcived=null;

if(!lst.isEmpty()){
 lastconcived=lst.get(0).getConcivedate();	
   for(Pregnantreport pn : lst) {
	 if(pn.getConcivedate().after(lastconcived)) {
	lastconcived=pn.getConcivedate();
	                                 
	           }
	          }
   int del=datediffrent(lastconcived,choosedcondate);
   if(del>325){
	   int serialno=lst.size()+1;
	   pregnant.setConcivedate(choosedcondate);
	   pregnant=getupdated(pregnant);
	   pregnant.setPregnantno(serialno);
	   pregnant.setDateerr(""); 
         } 
   else{	
	   int delta=325-del;
        	Calendar ca = Calendar.getInstance();
			ca.setTime(choosedcondate);
			ca.add(Calendar.DATE, delta);
			Date dk = ca.getTime();
		  pregnant.setDateerr("error,choose after::"+sdf.format(dk));  
	   
       }
   
}

else {
	   pregnant.setConcivedate(choosedcondate);
	   pregnant=getupdated(pregnant);
	   pregnant.setPregnantno(1);
	   pregnant.setDateerr(""); 
	   
}

  return new ResponseEntity<Pregnantreport>(pregnant,HttpStatus.OK);
	
}
	

private int datediffrent(Date lastconcived , Date choosedcondate){
int day=0;
	 if(choosedcondate.before(lastconcived)) {
    	System.out.println("choosed date is before last concived date"+lastconcived);
    	System.out.println("choosed date is before last concived date"+lastconcived);
    }
    
    else {
    	System.out.println("choosed date is after last concived date"+lastconcived);
    	System.out.println("choosed date is after last concived date"+lastconcived);
    	long difference = choosedcondate.getTime()-lastconcived.getTime();
         day = (int) (difference / (1000*60*60*24));	
         day=day+45;
      

     	}

	return day; 
	
}
	 
	public Pregnantreport getupdated(Pregnantreport pregnant) {
			SimpleDateFormat sdf=new SimpleDateFormat("dd/MM/yyyy");
			Date f=null;
			try {
				f = sdf.parse(pregnant.getStringconcivedate());
			} catch (ParseException e) {
			
				e.printStackTrace();
			}
			
				Calendar cal = Calendar.getInstance();
				cal.setTime(f);
				cal.add(Calendar.DATE, din);
				Date dm = cal.getTime();
				cal.add(Calendar.DATE, 45);
				Date d2=cal.getTime();
			
			pregnant.setNextconcive(d2);
			pregnant.setStringnextconcive(sdf.format(d2));
			pregnant.setPossibledate(dm);
			pregnant.setStringpossibledate(sdf.format(dm));   
			return pregnant;
		}
		
		
		
@PostMapping("/postpreg")
public ResponseEntity<List<Pregnantreport>> postpreg(@RequestBody List<Pregnantreport> pregnant){
          boolean x=true;	
          String mailsms="";
          
	for(Pregnantreport pr : pregnant) {
		if(prr.existsByAnidAndStringconcivedate(pr.getAnid(), pr.getStringconcivedate())){
			x=false;
			pr.setDateerr("this record already exist in database");
		}		
		}
	if(x) {
		for(Pregnantreport pr : pregnant) {
			mailsms=mailsms+" animal id: "+pr.getAnid()+"animal type: "+pr.getType()+ " concive date: "+pr.getStringconcivedate()+
					"possible date of bear child "+pr.getStringpossibledate();
	prr.save(pr);
			}
		
		mailsms="you have added animal pregnancy record as: "+mailsms;
		Firmadmin ad=adr.findAll().get(0);
		new Sendotp().sendotp(mailsms, ad.getEmail(),"animal pregnancy reord", ad.getEmail(), ad.getGmailspass());
	}
	else {
		pregnant.get(0).setSms("ohh");
	}
	
	return new ResponseEntity<List<Pregnantreport>>(pregnant,HttpStatus.OK);
	
}		

@PostMapping("/preganimalid")
public ResponseEntity<Pregnantreport> CHECKPREGANIMALID(@RequestBody Pregnantreport pregnant){
	if(pregnant.getType().contentEquals("")) {
		
		if(arr.existsByAnid(pregnant.getAnid())) {
			pregnant.setSms("");
		}
		else {
			pregnant.setSms("id:-"+pregnant.getAnid()+" not exist in database");
		}	
	}
	
	else {
		if(arr.existsByAnidAndType(pregnant.getAnid(),pregnant.getType())) {
			pregnant.setSms("");
		}
		else {
			pregnant.setSms("id:-"+pregnant.getAnid()+" not a"+pregnant.getType());
		}
		
	}

	return new ResponseEntity<Pregnantreport>(pregnant,HttpStatus.OK);
	
}	


@GetMapping("/upchild")
public ResponseEntity<List<Pregnantreport>> upchild() throws ParseException{
		SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
	Date d = new Date();
	Date d2 = sdf.parse(sdf.format(d));
	List<Pregnantreport> lst = prr.findByPossibledateAfter(d2);
return new ResponseEntity<List<Pregnantreport>> (lst,HttpStatus.OK);
	
	}	


@GetMapping("/searchrecord")
public String  searchrecord(){

return "pregnant";
	
	}	


@PostMapping("/byanid")
public ResponseEntity<List<Pregnantreport>>  byanid(@RequestBody int anid){
	List<Pregnantreport> lst = prr.findByAnid(anid);
return new ResponseEntity<List<Pregnantreport>>(lst,HttpStatus.OK);

}	

@PostMapping("/bytype")
public ResponseEntity<List<Pregnantreport>>  bytype(@RequestBody String type){
	List<Pregnantreport> lst = prr.findByType(type);
return new ResponseEntity<List<Pregnantreport>>(lst,HttpStatus.OK);

}	

@PostMapping("/byconcive")
public ResponseEntity<List<Pregnantreport>>  byconcive(@RequestBody String concive){
	List<Pregnantreport> lst = prr.findByStringconcivedateContaining(concive);
return new ResponseEntity<List<Pregnantreport>>(lst,HttpStatus.OK);

}	
	

@PostMapping("/byconcive2")
public ResponseEntity<List<Pregnantreport>>  byconcive2(@RequestBody String concive) throws ParseException{
	SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
	Date d = sdf.parse(concive);
	List<Pregnantreport> lst = prr.findByConcivedate(d);
return new ResponseEntity<List<Pregnantreport>>(lst,HttpStatus.OK);

}	


@PostMapping("/byconcivebt")
public ResponseEntity<List<Pregnantreport>>  byconcivebt(@RequestBody String[] con) throws ParseException{
	SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
	Date d1 = sdf.parse(con[0]);	
	Date d2 = sdf.parse(con[1]);
	System.out.println(con[0]+"      "+con[1]);
List<Pregnantreport> lst = prr.findByConcivedateBetween(d1,d2);
return new ResponseEntity<List<Pregnantreport>>(lst,HttpStatus.OK);

}	



@PostMapping("/bypregnant")
public ResponseEntity<List<Pregnantreport>>  byconcivep(@RequestBody String concive){
	List<Pregnantreport> lst = prr.findByStringpossibledateContaining(concive);
return new ResponseEntity<List<Pregnantreport>>(lst,HttpStatus.OK);

}	
	

@PostMapping("/bypregnant2")
public ResponseEntity<List<Pregnantreport>>  byconcive2p(@RequestBody String concive) throws ParseException{
	SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
	Date d = sdf.parse(concive);
	List<Pregnantreport> lst = prr.findByPossibledate(d);
return new ResponseEntity<List<Pregnantreport>>(lst,HttpStatus.OK);

}	


@PostMapping("/bypregnantbt")
public ResponseEntity<List<Pregnantreport>>  byconcivebtp(@RequestBody String[] con) throws ParseException{
	SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
	Date d1 = sdf.parse(con[0]);	
	Date d2 = sdf.parse(con[1]);
	System.out.println(con[0]+"      "+con[1]);
List<Pregnantreport> lst = prr.findByPossibledateBetween(d1,d2);
return new ResponseEntity<List<Pregnantreport>>(lst,HttpStatus.OK);

}	

@GetMapping("/byall")
public ResponseEntity<List<Pregnantreport>>  byall(){
	List<Pregnantreport> lst = prr.findAll();
return new ResponseEntity<List<Pregnantreport>>(lst,HttpStatus.OK);

}	


@DeleteMapping("/deletethis")
public ResponseEntity<Pregnantreport>  deletethis(@RequestBody Pregnantreport df){
prr.delete(df);
return new ResponseEntity<Pregnantreport>(df,HttpStatus.OK);

}	

}
