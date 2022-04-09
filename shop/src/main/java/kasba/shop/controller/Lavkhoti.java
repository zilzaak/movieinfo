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
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import kasba.shop.model.Productorder;
import kasba.shop.model.Productsell;
import kasba.shop.repo.Orderrepo;
import kasba.shop.repo.Sellrepo;

@Controller
@RequestMapping("/cp")
public class Lavkhoti {

	@Autowired
	private Orderrepo orr;
	@Autowired
	private Sellrepo srr;
	
	
	@PostMapping("/cpinamonth")
	public ResponseEntity<Hisab> costprofitinamonth(@RequestBody String[] asik) throws ParseException{
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
List<Productsell> lst2 = srr.findBySelldateBetweenOrderBySelldateDesc(d,d2);

 float totalorder=0; float orderdue=0; 
 float totalsell=0;  float selldue=0; 
 


 float profit=0; 

for(Productorder po : lst){
	totalorder=totalorder+po.getPrice();
	orderdue=orderdue+po.getDue() ; 
}

for(Productsell ps : lst2){
	totalsell=totalsell+ps.getPrice();
	selldue=selldue+ps.getDue(); 
}

profit=totalsell-totalorder;
Hisab h=new Hisab(); 
h.setOrderdue(orderdue);h.setSelldue(selldue);
h.setTotalorder(totalorder);h.setProfit(profit);
h.setTotalsell(totalsell);
return new ResponseEntity<Hisab>(h,HttpStatus.OK) ;
	}
	
	
	@PostMapping("/cpinayear")
	public ResponseEntity<Hisab> costprofitinayear(@RequestBody String asik){
		List<Productorder> lst = orr.findByStringorderdateContainingOrderByOrderdateDesc(asik);
		List<Productsell> lst2 = srr.findByStringselldateContainingOrderBySelldateDesc(asik);

		 float totalorder=0; float orderdue=0; 
		 float totalsell=0;  float selldue=0; 
		
		 float profit=0; 

		for(Productorder po : lst){
			totalorder=totalorder+po.getPrice();
			orderdue=orderdue+po.getDue() ; 
		}

		for(Productsell ps : lst2){
			totalsell=totalsell+ps.getPrice();
			selldue=selldue+ps.getDue(); 
		}

		profit=totalsell-totalorder;
		Hisab h=new Hisab(); 
		h.setOrderdue(orderdue);h.setSelldue(selldue);
		h.setTotalorder(totalorder);h.setProfit(profit);
		h.setTotalsell(totalsell);
		return new ResponseEntity<Hisab>(h,HttpStatus.OK) ;
	
	}
	
	
	@GetMapping("/cptotal")
	public ResponseEntity<Hisab> totalcostprofit(){
		System.out.println("the total record is ");
		List<Productorder> lst = orr.findAll();
		List<Productsell> lst2 = srr.findAll();

		 float totalorder=0; float orderdue=0; 
		 float totalsell=0;  float selldue=0; 
		 


		 float profit=0; 

		for(Productorder po : lst){
			totalorder=totalorder+po.getPrice();
			orderdue=orderdue+po.getDue() ; 
		}

		for(Productsell ps : lst2){
			totalsell=totalsell+ps.getPrice();
			selldue=selldue+ps.getDue(); 
		}

		profit=totalsell-totalorder;
		Hisab h=new Hisab(); 
		h.setOrderdue(orderdue);h.setSelldue(selldue);
		h.setTotalorder(totalorder);h.setProfit(profit);
		h.setTotalsell(totalsell);
		return new ResponseEntity<Hisab>(h,HttpStatus.OK) ;
		
	}
	
	
	
}
