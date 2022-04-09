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
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import kasba.shop.model.Sampal;
import kasba.shop.repo.Sampalrepo;

@Controller
@RequestMapping("/sample")
public class Sampalcontrol {
	
@Autowired
private Sampalrepo spr; 


@PostMapping("/save")
public ResponseEntity<Sampal> savesample(@RequestBody List<Sampal> lst ){
	
	SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
	String err="";
	for(Sampal sm : lst){
		long count2 = sm.getStringsampledate().codePoints().filter(ch -> ch == '/').count();
		
	if(sm.getPrice()<0 || sm.getProductname().length()<1 || 
	sm.getAmount().length()<1 || count2<2 || sm.getStringsampledate().length()<8 || sm.getStringsampledate().length()>10 ||
	sm.getStringsampledate().contains(" ")){
		
			err="invalid price or product name or product amount or date, make correction";
			break;
		}
		
		else {
			try{
				
				Date dt = sdf.parse(sm.getStringsampledate());
				sm.setSampledate(dt);
				
			}catch(Exception e) {
				
				err="invalid price or product name or product amount or date, make correction";
				Sampal s = new Sampal();
				s.setProductname(err);
			return new ResponseEntity<Sampal>(s,HttpStatus.OK);
				
			}
		
		}
			
	}
	
	if(err.contentEquals("")) {
		
err="successfully added sample's";
		
		for(Sampal sm : lst){
			
		spr.save(sm);	
								}
		
		Sampal s = new Sampal();
		s.setProductname(err);
			
		return new ResponseEntity<Sampal>(s,HttpStatus.OK);
		
	}
	
	
	Sampal s = new Sampal();
	s.setProductname(err);
return new ResponseEntity<Sampal>(s,HttpStatus.OK);

}


@PostMapping("/update")
public ResponseEntity<Sampal> updatesample(@RequestBody Sampal sm ){
	
SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
	String err="";

		long count2 = sm.getStringsampledate().codePoints().filter(ch -> ch == '/').count();
		
		if(sm.getPrice()<0 || sm.getProductname().length()<1 || 
		sm.getAmount().length()<1 || count2<2 || sm.getStringsampledate().length()<8 || sm.getStringsampledate().length()>10 ){
			err="invalid price or product name or product amount or date, make correction";
		
		}
		
if(err.contentEquals("")) {
	try {
		Date d = sdf.parse(sm.getStringsampledate());
		sm.setSampledate(d);
		err="successfully updated sample's";
		spr.save(sm);	
	}catch(Exception e) {
		err="invalid price or product name or product amount or date, make correction";	
		
	}

Sampal s = new Sampal();
s.setProductname(err);
return new ResponseEntity<Sampal>(s,HttpStatus.OK);
		
	}
	
Sampal s = new Sampal();
	s.setProductname(err);
	s.setProductname(err);
	
return new ResponseEntity<Sampal>(s,HttpStatus.OK);

}


@DeleteMapping("/delete")
public ResponseEntity<Sampal> deletesample(@RequestBody Sampal sm ) throws ParseException{

	spr.delete(sm);
Sampal s = new Sampal();
s.setProductname("successfully deleted sample");
return new ResponseEntity<Sampal>(s,HttpStatus.OK);

}

@RequestMapping(value="/sampleinamonth",method = RequestMethod.POST)
public ResponseEntity<Shisab> sampleinamonth(@RequestBody String[] asik) throws ParseException{
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

List<Sampal> l = spr.findBySampledateBetweenOrderBySampledateDesc(d,d2);
float total=0;
for(Sampal s : l) {
	total=total+s.getPrice();
}
Shisab h = new Shisab(total,l);
return new ResponseEntity<Shisab>(h,HttpStatus.OK);	

}	



@PostMapping("/sampleafteradate")
public ResponseEntity<Shisab>sampleafteradate(@RequestBody String x) throws ParseException{
	SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
	Date d = sdf.parse(x);
List<Sampal> l =spr.findBySampledateAfterOrderBySampledateDesc(d);
float total=0;
for(Sampal s : l) {
	total=total+s.getPrice();
}
Shisab h = new Shisab(total,l);

return new ResponseEntity<Shisab>(h,HttpStatus.OK);
	
}




@PostMapping("/sampleinadate")
public ResponseEntity<Shisab>sampleinadate(@RequestBody String x) throws ParseException{
	SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
	Date d = sdf.parse(x);
List<Sampal> l =spr.findBySampledate(d);
float total=0;
for(Sampal s : l) {
	total=total+s.getPrice();
}
Shisab h = new Shisab(total,l);

return new ResponseEntity<Shisab>(h,HttpStatus.OK);
	
}


@GetMapping("/allsample")
public ResponseEntity<Shisab> sampleall() throws ParseException{
List<Sampal> l =spr.findAll();
float total=0;
for(Sampal s : l) {
	
	total=total+s.getPrice();
	
}
Shisab h = new Shisab(total,l);
return new ResponseEntity<Shisab>(h,HttpStatus.OK);
	
}




}
