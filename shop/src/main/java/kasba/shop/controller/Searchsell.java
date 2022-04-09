package kasba.shop.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import kasba.shop.model.Productsell;
import kasba.shop.model.Sellsearch;
import kasba.shop.repo.Sellrepo;

@Controller

public class Searchsell {
@Autowired
private Sellrepo srr;
	
@RequestMapping("/searchsell")
public String sor() {
	
	return "searchsell";
}




@PostMapping("/sellbyproductname")
public ResponseEntity<Sellsearch> sellbyproductname(@RequestBody String x){
	List<Productsell> lst =srr.findByProductnameContainingIgnoreCaseOrderBySelldateDesc(x);
	float totalsell=0; float due=0;
	for(Productsell ps : lst) {
		totalsell=totalsell+ps.getPrice();
		due=due+ps.getDue();
	}
	Sellsearch sd= new Sellsearch();
	sd.setDue(due);sd.setTotalsell(totalsell);
	sd.setPsl(lst);
return new ResponseEntity<Sellsearch>(sd,HttpStatus.OK);
	
}



@PostMapping("/sellbycompany")
public ResponseEntity<Sellsearch> sellbycompany(@RequestBody String x){
	System.out.println(x);
	List<Productsell> lst =srr.findByCompanyContainingIgnoreCaseOrderBySelldateDesc(x);
	float totalsell=0; float due=0;
	for(Productsell ps : lst) {
		totalsell=totalsell+ps.getPrice();
		due=due+ps.getDue();
	}
	Sellsearch sd= new Sellsearch();
	sd.setDue(due);sd.setTotalsell(totalsell);
	sd.setPsl(lst);
return new ResponseEntity<Sellsearch>(sd,HttpStatus.OK);
	
}



@PostMapping("/sellbyinadate")
public ResponseEntity<Sellsearch> sellbyinadate(@RequestBody String x) throws ParseException{
	SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
	Date d = sdf.parse(x);
	List<Productsell> lst =srr.findBySelldateOrderBySelldateDesc(d);
	float totalsell=0; float due=0;
	for(Productsell ps : lst) {
		totalsell=totalsell+ps.getPrice();
		due=due+ps.getDue();
	}
	Sellsearch sd= new Sellsearch();
	sd.setDue(due);sd.setTotalsell(totalsell);
	sd.setPsl(lst);
return new ResponseEntity<Sellsearch>(sd,HttpStatus.OK);
	
}





@PostMapping("/sellbyafteradate")
public ResponseEntity<Sellsearch> sellbyafteradate(@RequestBody String x) throws ParseException{
	SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
	Date d = sdf.parse(x);
List<Productsell> lst =srr.findBySelldateAfterOrderBySelldateDesc(d);
	float totalsell=0; float due=0;
	for(Productsell ps : lst) {
		totalsell=totalsell+ps.getPrice();
		due=due+ps.getDue();
	}
	
	Sellsearch sd= new Sellsearch();
	sd.setDue(due);sd.setTotalsell(totalsell);
	sd.setPsl(lst);
	
return new ResponseEntity<Sellsearch>(sd,HttpStatus.OK);
	
}



@PostMapping("/sellbybetweenadate")
public ResponseEntity<Sellsearch> sellbybetweendate(@RequestBody String[] asik) throws ParseException{
	SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
	Date d1 = sdf.parse(asik[0]);
	Date d2 = sdf.parse(asik[1]);
List<Productsell> lst =srr.findBySelldateBetweenOrderBySelldateDesc(d1,d2);
	float totalsell=0; float due=0;
	for(Productsell ps : lst) {
		totalsell=totalsell+ps.getPrice();
		due=due+ps.getDue();
	}
	
	Sellsearch sd= new Sellsearch();
	sd.setDue(due);sd.setTotalsell(totalsell);
	sd.setPsl(lst);
	
return new ResponseEntity<Sellsearch>(sd,HttpStatus.OK);
	
}






}
