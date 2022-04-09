package dairy.controller;


import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.Period;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.google.gson.Gson;

import dairy.model.Animal;
import dairy.model.Animalpres;
import dairy.model.Firmadmin;
import dairy.model.Presitem;
import dairy.model.Twillioclass;
import dairy.repo.Adminrepo;
import dairy.repo.Animalrepo;
import dairy.repo.Twiliorepo;
import dairy.service.TwillioService;



@Controller
@RequestMapping("/animal")

public class Animalcontrol {
@Autowired
Animalrepo anr;
@Autowired
private Adminrepo adr;
@Autowired
TwillioService twillioService;
@Autowired
private Twiliorepo trr;
	
	@PostMapping("/add")
public ResponseEntity<List<Animal>> addanimal(@RequestBody List<Animal> animalform) throws ParseException{
	SimpleDateFormat format =new SimpleDateFormat("dd/MM/yyyy HH:mm");
	  Date ck= new Date();
      String s = format.format(ck);
     Date d =format.parse(s);
     String emailsms="";
     Firmadmin ad=adr.findAll().get(0);
 	List<Twillioclass> tls= trr.findByActive("active");
   for(Animal p:animalform) {
	   emailsms=emailsms+" ,animal type:  " +p.getType()+"  ,price(tk)"+p.getChest()+" "+"  ,color: "+p.getColor()+"  ,source:"
			   +p.getSource()+"  ,gender: "+p.getGender();
    p.setCreatedstring(s);
	p.setCreated(d);
	p.setSellstatus("notsold");
	SimpleDateFormat f=new SimpleDateFormat("dd/MM/yyyy");
       Date f2 = f.parse(p.getStringbdate());
       p.setBdate(f2);
	  p = getage(p.getStringbdate(),p);
	  p = calculateheightweight(p);
	     p.setFilename("not");
        anr.save(p);
   
   		      }
     emailsms="you have added  "+emailsms+"  to database";
     new Sendotp().sendotp(emailsms, ad.getEmail(),"animal addition record", ad.getEmail(), ad.getGmailspass());
	  for(Twillioclass t:tls) {
		twillioService.sendSms(t.getTomy(),t.getFromtwilio(),emailsms,t.getSid(),t.getAuthtoken());

				
			   }
     
     
return new ResponseEntity<List<Animal>>(animalform,HttpStatus.OK);
	
}
	
	
public Animal calculateheightweight(Animal a){
	if(a.getType().contentEquals("cow")){
		  if(a.getAgem()<25) {
			float w=(float) (26+a.getAgem()*6.5);
			float h=21+a.getAgem()*3;
			a.setWeight(w);a.setHu("inch");
			a.setHeight(h);a.setWu("kg");
		}
		  else {
				a.setWeight(135);a.setHu("inch");
				a.setHeight(48);a.setWu("kg");	  
			  	
		  }
			}
	
	
	if(a.getType().contentEquals("goat")){
		
		  if(a.getAgem()<13) {
			float w=(float) (2+a.getAgem()*2.5);
			float h=(float)(8+a.getAgem()*1.65);
			a.setWeight(w);a.setHu("inch");
			a.setHeight(h);a.setWu("kg");
		}
		  else {
				a.setWeight(35);a.setHu("inch");
				a.setHeight((float) 2.5);a.setWu("kg");	  
			  	
		  }	
				
	}
	
	
	
	if(a.getType().contentEquals("buffelo")){
		  if(a.getAgem()<32) {
			float w=30+a.getAgem()*11;
			float h=21+a.getAgem()*3;
			a.setWeight(w);a.setHu("inch");
			a.setHeight(h);a.setWu("kg");
		}
		  else {
				a.setWeight(170);a.setHu("inch");
				a.setHeight(60);a.setWu("kg");	  
			  	
		  }	
		}	
	
	
	if(a.getType().contentEquals("vera")){
		  if(a.getAgem()<12) {
			float w=(float) (4+a.getAgem()*2.2);
			float h=(float)(4+a.getAgem()*1.35);
			a.setWeight(w);a.setHu("inch");
			a.setHeight(h);a.setWu("kg");
		}
		  else {
				a.setWeight(25);a.setHu("inch");
				a.setHeight((float) 2.5);a.setWu("kg");	  
			  	
		  }		
		}
	
	
return a;	
}
	
	
	
	
	
	

	
	@GetMapping("/photoid/{id}")
public String  photoid(@PathVariable int id ,HttpSession session){
session.setAttribute("id",id);
	
return "upload";
	
}		
		
	@GetMapping("/eligibleanimal")
public ResponseEntity<List<Animal>> eligibleanmalforsell(){
		System.out.println("the name of the id is ");
		System.out.println("the name of the id is ");
		System.out.println("the name of the id is ");
		System.out.println("the name of the id is ");
List<Animal> lst = anr.findBySellstatus("notsold");
return new ResponseEntity<List<Animal>>(lst,HttpStatus.OK);
	}
	
	
	
	@PostMapping("/aboutanimal")
public ResponseEntity<Animal> photoiderfer(@RequestBody int sanid){
		 Animal sa=new Animal();
		 if(!anr.existsByAnid(sanid)) {
			  sa.setSellstatus("not");
			return new ResponseEntity<Animal>(sa,HttpStatus.OK);
		 }	
  sa=anr.findById(sanid).get();
 return new ResponseEntity<Animal>(sa,HttpStatus.OK); 

	
}		
	
	@RequestMapping("/photoid")
	public String prescr(@RequestParam int anid,HttpSession session){
	session.setAttribute("id",anid);
		
		return "upload";
	            
		          }
	
	
	@PostMapping("/updateanimal")
	public ResponseEntity<Animal> prescr(@RequestBody Animal p) throws ParseException{
		SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
		p.setBdate(sdf.parse(p.getStringbdate()));
		  p = getage(p.getStringbdate(),p);
		  p = calculateheightweight(p);
anr.save(p);
 return new ResponseEntity<Animal>(p,HttpStatus.OK); 
	            
		          }	
	
	
	
	
	
	
	
	@GetMapping("/unphoto")
public ResponseEntity<List<Animal>> unphoto() throws ParseException{

List<Animal> lst = anr.findAllByOrderByCreatedDesc();
return new ResponseEntity<List<Animal>>(lst,HttpStatus.OK);
	
                                      
}	
	
	

	public Animal getage(String age,Animal a) throws ParseException{
		  
		  SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
		  Date d = sdf.parse(age);
		  Calendar c = Calendar.getInstance();
		  c.setTime(d);
		  int year = c.get(Calendar.YEAR);
		  int month = c.get(Calendar.MONTH) + 1;
		  int date = c.get(Calendar.DATE);
		  LocalDate l1 = LocalDate.of(year, month, date);
		  LocalDate now1 = LocalDate.now();
		  Period diff1 = Period.between(l1, now1);
	      a.setAgey(diff1.getYears());
	      a.setAgem(diff1.getMonths());
	      a.setDay(diff1.getDays());
	      float mth = a.getAgey()*12+a.getAgem()+(a.getDay()/30);
	       a.setAgem(mth);

	     return a;
	                   	}
	
	
}