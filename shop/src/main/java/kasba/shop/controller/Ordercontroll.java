package kasba.shop.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.YearMonth;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import kasba.shop.model.Adminmail;
import kasba.shop.model.Productorder;
import kasba.shop.model.Productsell;
import kasba.shop.model.Userreg;
import kasba.shop.repo.Adminmailrepo;
import kasba.shop.repo.Orderrepo;
import kasba.shop.repo.Userregrepo;

@RequestMapping("/order")
@Controller
public class Ordercontroll {
@Autowired
private Orderrepo orr;
@Autowired
private Userregrepo urr;
@Autowired
private Adminmailrepo adr;

	@PostMapping("/saveorder")
	public ResponseEntity<List<Productorder>> saveorder(@RequestBody List<Productorder> lst) throws ParseException{
		String order="";
		 SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
		for(Productorder po: lst) {
		Date d = sdf.parse(po.getStringorderdate());
		po.setOrderdate(d);
		order=order+po.getProductname()+","+po.getCompany()+","+"amount::"+po.getAmount()+","+"price::"+po.getPrice()+", ";
		orr.save(po);
		
		}
		
	order="you have ordered these item,"+order;	
    sendmail(order);
		
return new ResponseEntity<List<Productorder>>(lst,HttpStatus.OK);	

}
	
	@RequestMapping(value="/orderinamonth",method = RequestMethod.POST)
	public ResponseEntity<List<Productorder>> orderinamonth(@RequestBody String[] asik) throws ParseException{
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

List<Productorder> lst = orr.findByOrderdateBetweenOrderByOrderdateDesc(d,d2);
return new ResponseEntity<List<Productorder>>(lst,HttpStatus.OK);	

}	
	

	@RequestMapping(value="/updateorder",method = RequestMethod.POST)
	public ResponseEntity<Productorder> updateorder(@RequestBody Productorder po) throws ParseException{
		long count2 = po.getStringorderdate().codePoints().filter(ch -> ch == '/').count();
		if(count2<2) {
			po.setProductname("Sorry!!!, write correct date , for example 01/02/2021");
			return new ResponseEntity<Productorder>(po,HttpStatus.OK);	
		}
		
		if(po.getStringorderdate().length()<8){
			po.setProductname("Sorry!!!, date length is wrong , make correction");
			return new ResponseEntity<Productorder>(po,HttpStatus.OK);	
		}
	

		
		if(po.getProductname().length()<1 || 
		po.getCompany().length()<1 || po.getAmount().length()<1 ) {
			
			po.setProductname("Sorry!!!, fill the productname , company , amount field");
			return new ResponseEntity<Productorder>(po,HttpStatus.OK);			
			
		}
		
		
		if(po.getPrice()<0 || po.getPrice()==0 || po.getPrice()<po.getDue()){
			
			po.setProductname("Sorry!!!, invalid product price or due , make correction");
			return new ResponseEntity<Productorder>(po,HttpStatus.OK);			
			
		}
		
		SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
		Date dt = sdf.parse(po.getStringorderdate());
		po.setOrderdate(dt);
		orr.save(po);
        po.setProductname("Successfully updated record");
return new ResponseEntity<Productorder>(po,HttpStatus.OK);	

}		
	
	
	@RequestMapping(value="/bydueorder",method = RequestMethod.GET)
	public ResponseEntity<List<Productorder>> bydueorder() throws ParseException{
		List<Productorder> lst=orr.findByDueGreaterThanOrderByOrderdateDesc(1);

return new ResponseEntity<List<Productorder>>(lst,HttpStatus.OK);	

}		
	
	
	
	
	
	
	@RequestMapping(value="/deleteorder",method = RequestMethod.POST)
	public ResponseEntity<Productorder> deletesell(@RequestBody Productorder po) throws ParseException{
orr.delete(po);
po.setProductname("Deleted Successfully");
return new ResponseEntity<Productorder>(po,HttpStatus.OK);	

}	
	
	public void sendmail(String sms) {
		Adminmail am = adr.findAll().get(0);
		List<Userreg> lst=urr.findAll();
for(Userreg fa : lst) {
    new Sendotp().sendotp(sms, fa.getEmail(),"order details",am.getEmail(),
    		am.getPassword());		
	
}


	    	
	}
	
	
}
