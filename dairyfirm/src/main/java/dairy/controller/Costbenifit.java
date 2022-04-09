package dairy.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import dairy.model.Animal;
import dairy.model.Costprofithelper;
import dairy.model.Cprofit;
import dairy.model.Dailycost;
import dairy.model.Sellcow;
import dairy.model.Sellmilk;
import dairy.repo.Animalrepo;
import dairy.repo.Cowsellrepo;
import dairy.repo.Dailycostrepo;
import dairy.repo.Sellmilkrepo;

@Controller
@RequestMapping("/costprofit")
public class Costbenifit {
@Autowired
private Animalrepo arr;
@Autowired
private Cowsellrepo crr;
@Autowired
private Sellmilkrepo srr;
@Autowired
private Dailycostrepo drr;

final SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");

@PostMapping("/thisab")
public ResponseEntity<Cprofit> thisab(@RequestBody Cprofit cps){

List<Animal> lst = arr.findBySource("from market"); 
List<Dailycost> lst2 = drr.findAll();     
List<Sellmilk> lst3 = srr.findAll();  
List<Sellcow> lst4 = crr.findAll(); 

float soldmilk=0 , soldcow=0 , dailycost=0 , animalcost=0,dueinmilk=0,dueincow=0;
for(Animal a : lst) {
	animalcost=animalcost+a.getChest();
}
for(Dailycost dc : lst2) {
	dailycost=dailycost+dc.getCost();
}

for(Sellmilk sm : lst3) {
	soldmilk=soldmilk+sm.getTotalprice()-sm.getDue();
	dueinmilk=dueinmilk+sm.getDue();
}

for(Sellcow dc : lst4) {
	soldcow=soldcow+dc.getSellprice()-dc.getDue();
	dueincow=dueincow+dc.getDue();
}

float totalcost=animalcost+dailycost;
float totalsell=soldcow+soldmilk;
float totalprofit=totalsell-totalcost;
float totaldue=dueinmilk+dueincow;

cps.setTcost(totalcost);
cps.setTcostanimal(animalcost);
cps.setTcostdaily(dailycost);
cps.setTsellcow(soldcow);
cps.setTsellmilk(soldmilk);
cps.setTsold(totalsell);
cps.setTprofit(totalprofit);
cps.setDueincow(dueincow);
cps.setDueinmilk(dueinmilk);
cps.setTotaldue(totaldue);

return new ResponseEntity<Cprofit>(cps,HttpStatus.OK);

}	



	
	@PostMapping("/dailycost")
public String  photoid(@RequestBody Dailycost dc ){

		
		
return "upload";
	
}	
	
	
	@PostMapping("/saveit")
public ResponseEntity <List<Dailycost>>  saveit(@RequestBody List<Dailycost> dc ) throws ParseException{
		
String sms=""; String err="no";
		for(Dailycost c : dc){
			if(drr.existsByItemnameIgnoreCaseAndStringcostdate(c.getItemname(), c.getStringcostdate())) {
				sms=sms+" iterm::"+c.getItemname()+" ,";
				err="ye";
			}
			else{
				c.setCostdate(sdf.parse(c.getStringcostdate()));
			}
			
		   }

		if(err.contentEquals("no")) {
			for(Dailycost c : dc){
		drr.save(c);

		                	   }	
			dc.get(0).setItemname("successfull");	
			
		}
		else {
			sms=sms+" these item already added in this date,try diffrent date or update record";
			dc.get(0).setItemname(sms);		
		}

		return new 	ResponseEntity <List<Dailycost>>(dc,HttpStatus.OK);
		
         }	
	
	
	
	
	
	
	@PostMapping("/inamonth")
	public ResponseEntity<Costprofithelper> inamonth(@RequestBody String[] ad) throws ParseException{
		String dt="1/"+ad[0]+"/"+ad[1];
		SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
		  Date d1 = sdf.parse(dt); 
		  Calendar cal = Calendar.getInstance();
		  cal.setTime(d1);
		  int maxdate=cal.getActualMaximum(Calendar.DATE);
		  String dt2= Integer.toString(maxdate)+"/"+ad[0]+"/"+ad[1];
		  Date d2 = sdf.parse(dt2);
		  
		  List<Dailycost> dc = drr.findByCostdateBetween(d1,d2);
		  List<Sellcow> sc=crr.findBySelldateBetween(d1,d2);
		  List<Sellmilk> sm=srr.findBySelldateBetween(d1,d2);
		  Costprofithelper cph = new Costprofithelper();
		  cph.setDc(dc);cph.setSc(sc);cph.setSm(sm);
		return new ResponseEntity<Costprofithelper>(cph,HttpStatus.OK);
		
	}
	
	
	
	@PostMapping("/inadate")
	public ResponseEntity<Costprofithelper> indate(@RequestBody String ad) throws ParseException{
	SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
    Date d1 = sdf.parse(ad); 
    List<Dailycost> dc = drr.findByCostdate(d1);
    List<Sellcow> sc=crr.findBySelldate(d1);
    List<Sellmilk> sm=srr.findBySelldate(d1);
    Costprofithelper cph = new Costprofithelper();
	  cph.setDc(dc);cph.setSc(sc);cph.setSm(sm);
    return new ResponseEntity<Costprofithelper>(cph,HttpStatus.OK);
	
	
	}
	
	
	
	
	
	@PostMapping("/inbetween")
	public ResponseEntity<Costprofithelper> inbetween(@RequestBody String[] ad) throws ParseException{
		
		SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
		  Date d1 = sdf.parse(ad[0]); 
		  Date d2 = sdf.parse(ad[1]);
		  
		  List<Dailycost> dc = drr.findByCostdateBetween(d1,d2);
		  List<Sellcow> sc=crr.findBySelldateBetween(d1,d2);
		  
		  
		  
		  List<Sellmilk> sm=srr.findBySelldateBetween(d1,d2);
		  Costprofithelper cph = new Costprofithelper();
		  cph.setDc(dc);cph.setSc(sc);cph.setSm(sm);
		  System.out.println("the size of the daily cost is"+dc.size());
		  System.out.println("the size of the cow sell  is"+sc.size());
		  System.out.println("the size of the sell milk is"+sm.size());
		  System.out.println("the two date are as  "+d1+"  "+d2);
	return new ResponseEntity<Costprofithelper>(cph,HttpStatus.OK);
	
	
	}
	
		
	@GetMapping("/costrecord")
	public ResponseEntity<List<Dailycost>> costrecord() {
		List<Dailycost> lst = drr.findAll();
   return new ResponseEntity<List<Dailycost>>(lst,HttpStatus.OK);
	
		}
	
	@RequestMapping(value="/updatecost",method=RequestMethod.PUT)
	public ResponseEntity<Dailycost>  updatecost(@RequestBody Dailycost dc) throws ParseException {
	dc.setCostdate(sdf.parse(dc.getStringcostdate()));
		drr.save(dc);
    return new ResponseEntity<Dailycost>(dc,HttpStatus.OK);
	
		}	
	
	
	@PostMapping("/cfitem")
	public ResponseEntity<List<Dailycost>>  cfitem(@RequestBody String ad){
		  List<Dailycost> dc = drr.findByItemnameContaining(ad);
       return new  ResponseEntity<List<Dailycost>>(dc,HttpStatus.OK);
		}	
	
	
	@PostMapping("/cfdate")
	public ResponseEntity<List<Dailycost>>  cfitemds(@RequestBody String ad){
		  List<Dailycost> dc = drr.findByStringcostdateContaining(ad);
       return new  ResponseEntity<List<Dailycost>>(dc,HttpStatus.OK);
	
	
	}	
	
	@GetMapping("/today")
	public ResponseEntity<List<Dailycost>> today() throws ParseException{
	System.out.println("omar borkan al gala");
	System.out.println("omar borkan al gala");
	System.out.println("omar borkan al gala");
	System.out.println("omar borkan al gala");
	
		SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
             Date dt = sdf.parse(sdf.format(new Date()));
            List<Dailycost> cph = drr.findByCostdate(dt);
		return new ResponseEntity<List<Dailycost>>(cph,HttpStatus.OK);
		
	}
	
	@PostMapping("/dailycostbt")
	public ResponseEntity<List<Dailycost>>  dailycostbt(@RequestBody String[] ad) throws ParseException{
			SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
		  Date d1 = sdf.parse(ad[0]); 
		  Date d2 = sdf.parse(ad[1]);
  List<Dailycost> dc = drr.findByCostdateBetween(d1,d2);
	return new ResponseEntity<List<Dailycost>>(dc,HttpStatus.OK);
		
	}
	
	
	
	@RequestMapping("/download")
	public ModelAndView thisab2(){
Cprofit cps=new Cprofit();
ModelAndView mv = new  ModelAndView("costprofitrecord");
	List<Animal> lst = arr.findBySource("from market"); 
	List<Dailycost> lst2 = drr.findAll();     
	List<Sellmilk> lst3 = srr.findAll();  
	List<Sellcow> lst4 = crr.findAll(); 

	float soldmilk=0 , soldcow=0 , dailycost=0 , animalcost=0,dueinmilk=0,dueincow=0;
	for(Animal a : lst) {
		animalcost=animalcost+a.getChest();
	}
	for(Dailycost dc : lst2) {
		dailycost=dailycost+dc.getCost();
	}

	for(Sellmilk sm : lst3) {
		soldmilk=soldmilk+sm.getTotalprice()-sm.getDue();
		dueinmilk=dueinmilk+sm.getDue();
	}

	for(Sellcow dc : lst4) {
		soldcow=soldcow+dc.getSellprice()-dc.getDue();
		dueincow=dueincow+dc.getDue();
	}

	float totalcost=animalcost+dailycost;
	float totalsell=soldcow+soldmilk;
	float totalprofit=totalsell-totalcost;
	float totaldue=dueinmilk+dueincow;

	cps.setTcost(totalcost);
	cps.setTcostanimal(animalcost);
	cps.setTcostdaily(dailycost);
	cps.setTsellcow(soldcow);
	cps.setTsellmilk(soldmilk);
	cps.setTsold(totalsell);
	cps.setTprofit(totalprofit);
	cps.setDueincow(dueincow);
	cps.setDueinmilk(dueinmilk);
	cps.setTotaldue(totaldue);
	
	SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
	String todays = sdf.format(new Date());
mv.addObject("cpr",cps);
mv.addObject("todays",todays);
	return mv;

	}		
	

	
}
