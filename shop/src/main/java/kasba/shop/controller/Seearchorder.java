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

import kasba.shop.model.Productorder;
import kasba.shop.model.Ordersearch;
import kasba.shop.repo.Orderrepo;



@Controller
public class Seearchorder {
	@Autowired
	private Orderrepo srr;
	@RequestMapping("/searchorder")
	public String sor() {
		
		return "searchorder";
	}
	

	@PostMapping("/orderbyproductname")
	public ResponseEntity<Ordersearch> orderbyproductname(@RequestBody String x){
		List<Productorder> lst =srr.findByProductnameContainingIgnoreCaseOrderByOrderdateDesc(x);
		float totalorder=0; float due=0;
		for(Productorder ps : lst) {
			totalorder=totalorder+ps.getPrice();
			due=due+ps.getDue();
		}
		Ordersearch sd= new Ordersearch();
		sd.setDue(due);sd.setTotalorder(totalorder);
		sd.setPol(lst);
	return new ResponseEntity<Ordersearch>(sd,HttpStatus.OK);
		
	}



	@PostMapping("/orderbycompany")
	public ResponseEntity<Ordersearch> orderbycompany(@RequestBody String x){
		System.out.println(x);
		List<Productorder> lst =srr.findByCompanyContainingIgnoreCaseOrderByOrderdateDesc(x);
		float totalorder=0; float due=0;
		for(Productorder ps : lst) {
			totalorder=totalorder+ps.getPrice();
			due=due+ps.getDue();
		}
		Ordersearch sd= new Ordersearch();
		sd.setDue(due);sd.setTotalorder(totalorder);
		sd.setPol(lst);
	return new ResponseEntity<Ordersearch>(sd,HttpStatus.OK);
		
	}



	@PostMapping("/orderbyinadate")
	public ResponseEntity<Ordersearch> orderbyinadate(@RequestBody String x) throws ParseException{
		SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
		Date d = sdf.parse(x);
		List<Productorder> lst =srr.findByOrderdateOrderByOrderdateDesc(d);
		float totalorder=0; float due=0;
		for(Productorder ps : lst) {
			totalorder=totalorder+ps.getPrice();
			due=due+ps.getDue();
		}
		Ordersearch sd= new Ordersearch();
		sd.setDue(due);sd.setTotalorder(totalorder);
		sd.setPol(lst);
	return new ResponseEntity<Ordersearch>(sd,HttpStatus.OK);
		
	}





	@PostMapping("/orderbyafteradate")
	public ResponseEntity<Ordersearch> orderbyafteradate(@RequestBody String x) throws ParseException{
		SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
		Date d = sdf.parse(x);
	List<Productorder> lst =srr.findByOrderdateAfterOrderByOrderdateDesc(d);
		float totalorder=0; float due=0;
		for(Productorder ps : lst) {
			totalorder=totalorder+ps.getPrice();
			due=due+ps.getDue();
		}
		
		Ordersearch sd= new Ordersearch();
		sd.setDue(due);sd.setTotalorder(totalorder);
		sd.setPol(lst);
		
	return new ResponseEntity<Ordersearch>(sd,HttpStatus.OK);
		
	}



	@PostMapping("/orderbybetweenadate")
	public ResponseEntity<Ordersearch> orderbybetweendate(@RequestBody String[] asik) throws ParseException{
		SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
		Date d1 = sdf.parse(asik[0]);
		Date d2 = sdf.parse(asik[1]);
	List<Productorder> lst =srr.findByOrderdateBetweenOrderByOrderdateDesc(d1,d2);
		float totalorder=0; float due=0;
		for(Productorder ps : lst) {
			totalorder=totalorder+ps.getPrice();
			due=due+ps.getDue();
		}
		
		Ordersearch sd= new Ordersearch();
		sd.setDue(due);sd.setTotalorder(totalorder);
		sd.setPol(lst);
		
	return new ResponseEntity<Ordersearch>(sd,HttpStatus.OK);
		
	}

	
	
	
	
	
	
}
