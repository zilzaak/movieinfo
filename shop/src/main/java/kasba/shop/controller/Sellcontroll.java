package kasba.shop.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.YearMonth;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kasba.shop.model.Adminmail;
import kasba.shop.model.Productorder;
import kasba.shop.model.Productsell;
import kasba.shop.model.Userreg;
import kasba.shop.repo.Adminmailrepo;
import kasba.shop.repo.Sellrepo;
import kasba.shop.repo.Userregrepo;

@RequestMapping("/sell")

@Controller
public class Sellcontroll {
    @Autowired
	private Sellrepo srr;
	@Autowired
	private Userregrepo urr;
	@Autowired
	private Adminmailrepo adr;

		@PostMapping("/savesell")
		public ResponseEntity<List<Productsell>> saveorder(@RequestBody List<Productsell> lst) throws ParseException{
			 SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
			 String sell="";
				for(Productsell po: lst) {
				Date d = sdf.parse(po.getStringselldate());
				po.setSelldate(d);
				srr.save(po);
				sell=sell+po.getProductname()+","+po.getCompany()+","+"amount::"+po.getAmount()+","+"price::"+po.getPrice()+", ";
				
				}
	sell="you have sold these item , "+sell;
	sendmail(sell);
	return new ResponseEntity<List<Productsell>>(lst,HttpStatus.OK);	
			
		}
	
		@RequestMapping(value="/sellinamonth",method = RequestMethod.POST)
		public ResponseEntity<List<Productsell>> orderinamonth(@RequestBody String[] asik) throws ParseException{
			if(asik[0].contentEquals("january")) {
				asik[0]="01";
			}
			if(asik[0].contentEquals("february")) {
				asik[0]="02";
			}
			if(asik[0].contentEquals("march")) {
				asik[0]="03";
			}
			if(asik[0].contentEquals("april")) {
				asik[0]="04";
			}
			if(asik[0].contentEquals("may")) {
				asik[0]="05";
			}
			if(asik[0].contentEquals("june")) {
				asik[0]="06";
			}
			if(asik[0].contentEquals("july")) {
				asik[0]="07";
			}
			if(asik[0].contentEquals("august")) {
				asik[0]="08";
			}
			if(asik[0].contentEquals("september")) {
				asik[0]="09";
			}
			if(asik[0].contentEquals("october")) {
				asik[0]="10";
			}
			if(asik[0].contentEquals("november")) {
				asik[0]="11";
			}
			if(asik[0].contentEquals("december")) {
				asik[0]="12";
			}

			YearMonth yearMonthObject = YearMonth.of(Integer.parseInt(asik[1]),Integer.parseInt(asik[0]));
			int daysInMonth = yearMonthObject.lengthOfMonth();  

	SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
	String dt = "01"+"/"+asik[0]+"/"+asik[1];
	String dt2=String.valueOf(daysInMonth)+"/"+asik[0]+"/"+asik[1];
	Date d = sdf.parse(dt);
	Date d2 = sdf.parse(dt2);
   
List<Productsell> lst = srr.findBySelldateBetweenOrderBySelldateDesc(d,d2);
	return new ResponseEntity<List<Productsell>>(lst,HttpStatus.OK);	

	}	
			
		@RequestMapping(value="/updatesell",method = RequestMethod.POST)
		public ResponseEntity<Productsell> updatesell(@RequestBody Productsell po) throws ParseException{
			long count2 = po.getStringselldate().codePoints().filter(ch -> ch == '/').count();
			if(count2<2) {
				po.setProductname("Sorry!!!, write correct date , for example 01/02/2021");
				return new ResponseEntity<Productsell>(po,HttpStatus.OK);	
			}
			
			if(po.getStringselldate().length()<8){
				po.setProductname("Sorry!!!, date length is wrong , make correction");
				return new ResponseEntity<Productsell>(po,HttpStatus.OK);	
			}
		
			if(po.getStringselldate().length()<8){
				po.setProductname("Sorry!!!,date length is wrong , make correction");
				return new ResponseEntity<Productsell>(po,HttpStatus.OK);	
			}
			
			if(po.getProductname().length()<1 || 
			 po.getAmount().length()<1 || po.getCompany().length()<1) {
				
				po.setProductname("Sorry!!!, fill the productname , company , amount field");
				return new ResponseEntity<Productsell>(po,HttpStatus.OK);			
				
			}
			
			
			if(po.getPrice()<0 || po.getPrice()<0 || po.getPrice()<po.getDue()){
				
				po.setProductname("Sorry!!!, invalid product price or due , make correction");
				return new ResponseEntity<Productsell>(po,HttpStatus.OK);			
				
			}
			
			SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
			Date dt = sdf.parse(po.getStringselldate());
			po.setSelldate(dt);
			srr.save(po);
	po.setProductname("Successfully updated record");
			
			
	return new ResponseEntity<Productsell>(po,HttpStatus.OK);	

	}		
		
	
		
		@RequestMapping(value="/byduesell",method = RequestMethod.GET)
		public ResponseEntity<List<Productsell>> byduesell() throws ParseException{
			List<Productsell> lst=srr.findByDueGreaterThanOrderBySelldateDesc(1);

	return new ResponseEntity<List<Productsell>>(lst,HttpStatus.OK);	

	}		
				
		
		
		
		@RequestMapping(value="/deletesell",method = RequestMethod.POST)
		public ResponseEntity<Productsell> deletesell(@RequestBody Productsell po) throws ParseException{
	
srr.delete(po);
po.setProductname("Deleted Successfully");
return new ResponseEntity<Productsell>(po,HttpStatus.OK);	

	}			
		
		
		public void sendmail(String sms) {
			Adminmail am = adr.findAll().get(0);
			Userreg fa =urr.findAll().get(0);
			Userreg fa2 =urr.findAll().get(1);
		    new Sendotp().sendotp(sms, fa.getEmail(),"selling details",am.getEmail(),
		    		am.getPassword());	
		    new Sendotp().sendotp(sms, fa2.getEmail(),"selling details",am.getEmail(),
		    		am.getPassword());	
		}		
		
		
		
	
}
