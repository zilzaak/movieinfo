package dairy.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import dairy.model.Animal;
import dairy.model.Firmadmin;
import dairy.model.Sellcow;
import dairy.model.Twillioclass;
import dairy.repo.Adminrepo;
import dairy.repo.Animalrepo;
import dairy.repo.Cowsellrepo;
import dairy.repo.Twiliorepo;
import dairy.service.TwillioService;

@Controller
@RequestMapping("/cowsell")
public class Sellcowcontroll {
@Autowired
private Cowsellrepo srr;
@Autowired
private Animalrepo arr;
@Autowired
private Adminrepo adr;
@Autowired
TwillioService twillioService;
@Autowired
private Twiliorepo trr;

@PostMapping("/existbyanid")
	public ResponseEntity<List<Sellcow>> existsByAnid(@RequestBody int anid) {
	List<Sellcow> lst=srr.findByAnidOrderBySelldateDesc(anid);
	return new ResponseEntity<List<Sellcow>>(lst,HttpStatus.OK);
	}

@PostMapping("/inadate")
public ResponseEntity<List<Sellcow>> existsByAniddsd(@RequestBody String anid) throws ParseException {
	SimpleDateFormat sdf=new SimpleDateFormat("dd/MM/yyyy");
  Date d2=sdf.parse(anid);
List<Sellcow> lst=srr.findBySelldate(d2);

return new ResponseEntity<List<Sellcow>>(lst,HttpStatus.OK);
}





@PostMapping("/findbyanid")
public ResponseEntity<Animal> getByAnid(@RequestBody int anid) {
Animal animal=arr.findById(anid).get();
return new ResponseEntity<Animal>(animal,HttpStatus.OK);
}



	
@PostMapping(value="/savesell")
public ResponseEntity<List<Sellcow>> Savesell(@RequestBody List<Sellcow> sellform) throws ParseException{
String errsms="no";
String dateerr="no";
String sellprice="no";
String aexist="no";
SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
	for(Sellcow sell : sellform){
String err="";
		if(srr.existsByAnid(sell.getAnid())) {
			err="already added,";
			errsms="ye";
		}
		if(sell.getStringselldate().length()!=10 ) {
			dateerr="ye"; err=err+"wrong date,";
		}		
		if(sell.getSellprice()==0){
			sellprice="ye";err=err+"price error,";
		}
		
		if(sell.getSms().contentEquals("duplicate id")){
			sellprice="ye";err=err+"duplicate id,";
		}
		
		if(!arr.existsByAnid(sell.getAnid())){
			aexist="ye";
		err=err+"animal id not exist,";
			
								
		}
		
		sell.setSms(err);
		
		}
	
	if(errsms.contentEquals("ye") || dateerr.contentEquals("ye") || sellprice.contentEquals("ye") || aexist.contentEquals("ye")) {
		
		System.out.println("the dateerr or ersms is exist and value is ye  dateerr: "+dateerr+" errsms: "+errsms);
	                
	}
	
	else {
		    System.out.println("there is no date err or errsms"+dateerr+"  "+errsms);
		    String mailsms="";
		    Firmadmin ad=adr.findAll().get(0);
		 	List<Twillioclass> tls= trr.findByActive("active");
		    for(Sellcow sell : sellform) {
		    	mailsms=mailsms+" animal id: "+sell.getAnid()+" selling price(tk): "+sell.getSellprice()+" due tk:: "+sell.getDue()+" buyer name: "+
		    sell.getBuyercontact()+" phone no: "+sell.getBuyercontact();
		    	sell.setSelldate(sdf.parse(sell.getStringselldate()));
            srr.save(sell);
          Animal anm = arr.getOne(sell.getAnid());  
            anm.setSellstatus("sold");
            arr.save(anm);
		}	
		    mailsms="you have sold "+mailsms+"  successfully";
		    new Sendotp().sendotp(mailsms, ad.getEmail(),"animal selling record", ad.getEmail(), ad.getGmailspass());
			  for(Twillioclass t:tls) {
		twillioService.sendSms(t.getTomy(),t.getFromtwilio(),mailsms,t.getSid(),t.getAuthtoken() );
			
							
			   }   
		    
	}

	return new ResponseEntity<List<Sellcow>>(sellform,HttpStatus.OK);
	
                                                         
}	


@RequestMapping(value="/update",method=RequestMethod.PUT)
public ResponseEntity<Sellcow> update(@RequestBody Sellcow  v){
srr.save(v);
	return new ResponseEntity<Sellcow>(v,HttpStatus.OK);
}




	
	@PostMapping("/sellpricegt")
	public ResponseEntity<List<Sellcow>> SellpriceGreaterThan(@RequestBody float sellprice){
		List<Sellcow> lst=srr.findBySellpriceGreaterThanEqualOrderBySelldateDesc(sellprice);
	
		return new ResponseEntity<List<Sellcow>>(lst,HttpStatus.OK);
	}
	
	
	@GetMapping("/findall")
	public ResponseEntity<List<Sellcow>> findall(){
		List<Sellcow> lst=srr.findAll();
		return new ResponseEntity<List<Sellcow>>(lst,HttpStatus.OK);
	                       }
	
	@PostMapping("/sellpricelt")
	public ResponseEntity<List<Sellcow>> SellpriceLessThan(@RequestBody float sellprice){
		List<Sellcow> lst=srr.findBySellpriceLessThanEqualOrderBySelldateDesc(sellprice);
		return new ResponseEntity<List<Sellcow>>(lst,HttpStatus.OK);
	                       }
	
	@PostMapping("/sellpricebt")
	public ResponseEntity<List<Sellcow>> Sellpricebetween(@RequestBody float[] sell){
		List<Sellcow> lst=srr.findBySellpriceBetweenOrderBySelldateDesc(sell[0],sell[1]);
		return new ResponseEntity<List<Sellcow>>(lst,HttpStatus.OK);
	                       }
	
	
	
	@PostMapping(value="/selldatebt")
	public ResponseEntity<List<Sellcow>> Stringselldate(@RequestBody String[] dt) throws ParseException{
		SimpleDateFormat sdf=new SimpleDateFormat("dd/MM/yyyy");
		Date d1=sdf.parse(dt[0]);  Date d2=sdf.parse(dt[1]);
		System.out.println(dt[0]);
		System.out.println(dt[0]);
		System.out.println(dt[1]);
		System.out.println(dt[1]);
		List<Sellcow> lst=srr.findBySelldateBetweenOrderBySelldateDesc(d1, d2);
		System.out.println("okkkkkkkkkkkkkkkkkkkkkk"+d1+"      "+d2);
		System.out.println("okkkkkkkkkkkkkkkkkkkkkk"+d1+"      "+d2);
		System.out.println("okkkkkkkkkkkkkkkkkkkkkk"+d1+"      "+d2);
		return new ResponseEntity<List<Sellcow>>(lst,HttpStatus.OK);
		
	                                                             }
	@PostMapping(value="/sellafter")
	public ResponseEntity<List<Sellcow>> Stringselldateafter(@RequestBody  String d) throws ParseException{
		SimpleDateFormat sdf=new SimpleDateFormat("dd/MM/yyyy");
		System.out.println(d);
		Date d1=sdf.parse(d); 
        List<Sellcow> lst=srr.findBySelldateAfterOrderBySelldateDesc(d1);
        return new ResponseEntity<List<Sellcow>>(lst,HttpStatus.OK);	
        		
	                          }	
	
	@PostMapping("/byname")
	public ResponseEntity<List<Sellcow>> getByname(@RequestBody String buyer){
		List<Sellcow> lst= srr.findByBuyernameContainingIgnoreCaseOrderBySelldateDesc(buyer);
	return new ResponseEntity<List<Sellcow>>(lst,HttpStatus.OK);
	
	}
	
	@PostMapping("/bycontact")
	public ResponseEntity<List<Sellcow>> getBycontact(@RequestBody String contact) {
		List<Sellcow> lst= srr.findByBuyercontactOrderBySelldateDesc(contact);
	return new ResponseEntity<List<Sellcow>>(lst,HttpStatus.OK);
	
	}
	
	@PostMapping(value="/sellbefore")
	public ResponseEntity<List<Sellcow>> Stringselldatebefore(@RequestBody String s) throws ParseException{
		SimpleDateFormat sdf=new SimpleDateFormat("dd/MM/yyyy");
		 Date d1=sdf.parse(s);
		List<Sellcow> lst=srr.findBySelldateBeforeOrderBySelldateDesc(d1);
		return new ResponseEntity<List<Sellcow>>(lst,HttpStatus.OK);
		
	         
	
	}	
	@GetMapping("/totaldue")
	public ResponseEntity<List<Sellcow>> totaldue(){

		List<Sellcow> lst=srr.findByDueGreaterThanOrderBySelldateDesc(5);
		System.out.println(lst.size());
		System.out.println(lst.size());
		System.out.println(lst.size());
		System.out.println(lst.size());
		System.out.println(lst.size());
		return new ResponseEntity<List<Sellcow>>(lst,HttpStatus.OK);
		
	                                                             }	
	
	
		
	@RequestMapping("/updateanimal")
	public String upanml() {
		
		List<Animal> lst = arr.findAll();
		
for(Animal a : lst) {
	
if(srr.existsByAnid(a.getAnid())) {
	a.setSellstatus("sold");
	arr.save(a);
}else {
	a.setSellstatus("notsold");
	arr.save(a);
}


}
		
	return "register";
	}
	
	
}
