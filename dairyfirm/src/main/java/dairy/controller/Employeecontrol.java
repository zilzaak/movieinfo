package dairy.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import dairy.model.Firmadmin;
import dairy.model.Kormi;
import dairy.model.Twillioclass;
import dairy.repo.Adminrepo;
import dairy.repo.Employeerepo;
import dairy.repo.Twiliorepo;
import dairy.service.TwillioService;


@Controller
@RequestMapping("/employee")
public class Employeecontrol {
	@Autowired
	private Employeerepo err;
	@Autowired
	private Adminrepo adr;
	@Autowired
	TwillioService twillioService;
	@Autowired
	private Twiliorepo trr;
	
	@PostMapping("/addemp")
public ResponseEntity<Kormi> addemployee(@RequestBody Kormi emp){
		boolean ed=false;
		boolean enid=false;
		
	SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
		try {
			Date d = sdf.parse(emp.getStringjoindate());
			emp.setJoindate(d);
		} catch (ParseException e) {
			ed=true;
			e.printStackTrace();
		}
		if(err.existsByNid(emp.getNid())) {
			enid=true;
		}
		
		
		if(ed || enid) {
			emp.setAddress("invalid date or NID already exist");
			return new  ResponseEntity<Kormi>(emp,HttpStatus.OK);
		}
		
		else{
		
			Firmadmin ad=adr.findAll().get(0);			
	String s = Integer.toString((int) emp.getSalary());
	emp.setStringsalary(s);
	emp.setActivestatus("active worker");
		err.save(emp);	
		String mailsms="you have added new employee as: "+" name:"+
		emp.getName()+" address:"+emp.getAddress()+" designation:"+
		emp.getDesignation()+" phone: "+emp.getPhone()+" NID: "+
		emp.getNid();	
		new Sendotp().sendotp(mailsms, ad.getEmail(),"new employee reord", ad.getEmail(), ad.getGmailspass());
		List<Twillioclass> tls= trr.findByActive("active");
		  for(Twillioclass t:tls) {
			twillioService.sendSms(t.getTomy(),t.getFromtwilio(),mailsms,t.getSid(),t.getAuthtoken() );			
				   }
		emp.setAddress("successfully added employee");
		return new  ResponseEntity<Kormi>(emp,HttpStatus.OK);
		
		}
	
		}
	

	
	@PostMapping("/searchemp")
public ResponseEntity<List<Kormi>> empsearch(@RequestBody Kormi emp){
		List<Kormi> lst =new ArrayList<Kormi>();
	if(emp.getNid().contentEquals("name")) {
		lst=err.findByNameContaining(emp.getName());
		return new ResponseEntity<List<Kormi>>(lst,HttpStatus.OK);
	}
	
	if(emp.getNid().contentEquals("phone")) {
		lst=err.findByPhoneContaining(emp.getPhone());
		return new ResponseEntity<List<Kormi>>(lst,HttpStatus.OK);
	}
	
	if(emp.getNid().contentEquals("address")) {
		lst=err.findByAddressContaining(emp.getAddress());
		return new ResponseEntity<List<Kormi>>(lst,HttpStatus.OK);
	}
	
	if(emp.getNid().contentEquals("left")) {
		lst=err.findByActivestatus("left job");
		return new ResponseEntity<List<Kormi>>(lst,HttpStatus.OK);
	}
	
	if(emp.getNid().contentEquals("active")) {
		lst=err.findByActivestatus("active worker");
		return new ResponseEntity<List<Kormi>>(lst,HttpStatus.OK);
	}
	if(emp.getNid().contentEquals("all")) {
		lst=err.findAll();
		return new ResponseEntity<List<Kormi>>(lst,HttpStatus.OK);
	}
	if(emp.getNid().contentEquals("salary")) {
		lst=err.findByStringsalaryContaining(emp.getStringsalary());
		return new ResponseEntity<List<Kormi>>(lst,HttpStatus.OK);
	}
	
	
	if(emp.getNid().contentEquals("designation")) {
		lst=err.findByDesignationContaining(emp.getDesignation());
		return new ResponseEntity<List<Kormi>>(lst,HttpStatus.OK);
	}
	
	return new ResponseEntity<List<Kormi>>(lst,HttpStatus.OK);
	
		}	
	
	@RequestMapping(value="/editemp",method=RequestMethod.PUT)
public ResponseEntity<Kormi> editemp(@RequestBody Kormi emp){
		boolean ed=false;
	SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
		try {
			Date d = sdf.parse(emp.getStringjoindate());
			emp.setJoindate(d);
		} catch (ParseException e) {
			ed=true;
			e.printStackTrace();
		}

		
		if(ed) {
			emp.setAddress("invalid date or NID already exist");
			return new  ResponseEntity<Kormi>(emp,HttpStatus.OK);
		}
		
		else{
			if(emp.getActivestatus().contentEquals("left job")) {
			String d = sdf.format(new Date());
			emp.setLeftdate(d);
			}
	String s = Integer.toString((int) emp.getSalary());
	emp.setStringsalary(s);
		err.save(emp);	
		emp.setAddress("employee edited successfully");
		return new  ResponseEntity<Kormi>(emp,HttpStatus.OK);
		
		}
	
		}
	
	@DeleteMapping("/deleteemp")
public ResponseEntity<Kormi> deleteemp(@RequestBody Kormi emp){
	err.delete(emp);
	
	return new  ResponseEntity<Kormi>(emp,HttpStatus.OK);
		}	

}

