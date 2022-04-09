package kasba.shop.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import kasba.shop.model.Cleardt;
import kasba.shop.repo.Orderrepo;
import kasba.shop.repo.Sampalrepo;
import kasba.shop.repo.Sellrepo;
import kasba.shop.repo.Userregrepo;

@RequestMapping("/clear")
@Controller

public class Clearcontrol {
	
	@Autowired
	private Sellrepo srr;
	@Autowired
	private Orderrepo orr;
	@Autowired
	private Sampalrepo spr;
	@Autowired
	private Userregrepo urr;
	
	@DeleteMapping("/clearsell")
	public ResponseEntity<Cleardt> clearsell(@RequestBody Cleardt cl){
		if(urr.existsByEmailAndPassword(cl.getEmail(),cl.getPass())) {
			srr.deleteAll();
			cl.setSms("successfully cleared selling");
			return new ResponseEntity<Cleardt>(cl,HttpStatus.OK);	
		}
		
		cl.setSms("wrong email or password");
		return new ResponseEntity<Cleardt>(cl,HttpStatus.OK);	
	}
	
	@DeleteMapping("/clearorder")
	public ResponseEntity<Cleardt> clearsorder(@RequestBody Cleardt cl){
		if(urr.existsByEmailAndPassword(cl.getEmail(),cl.getPass())) {
			orr.deleteAll();
			cl.setSms("successfully cleared order");
			return new ResponseEntity<Cleardt>(cl,HttpStatus.OK);	
		}
		
		cl.setSms("wrong email or password");
		return new ResponseEntity<Cleardt>(cl,HttpStatus.OK);	
	}
	
	
	@DeleteMapping("/clearsample")
	public ResponseEntity<Cleardt> clearsampal(@RequestBody Cleardt cl){
		if(urr.existsByEmailAndPassword(cl.getEmail(),cl.getPass())) {
			spr.deleteAll();
			cl.setSms("successfully cleared sample");
			return new ResponseEntity<Cleardt>(cl,HttpStatus.OK);	
		}
		
		cl.setSms("wrong email or password");
		return new ResponseEntity<Cleardt>(cl,HttpStatus.OK);	
	}

}
