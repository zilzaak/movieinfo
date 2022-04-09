package kasba.shop.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import kasba.shop.model.Adminmail;
import kasba.shop.model.Emaillist;
import kasba.shop.model.Userreg;
import kasba.shop.repo.Adminmailrepo;
import kasba.shop.repo.Emaillistrepo;
import kasba.shop.repo.Userregrepo;

@Controller
public class Adminparvez {
@Autowired
private Emaillistrepo err;
@Autowired
private Adminmailrepo adrr;
@Autowired
private Userregrepo urr;

	@RequestMapping("/admin")
	public String admin() {
		
		return "admin";
	}
	
	@PostMapping("/adminlogin")
	public ModelAndView admin2(@RequestParam String adminpass) {
		ModelAndView mv = new ModelAndView();
		if(adminpass.contentEquals("aslamhex66")) {
			mv.setViewName("admin2");
			return mv;
		}
		mv.setViewName("admin");
		mv.addObject("sms","wrong password");
		return mv;

	}	
	
	
	@PostMapping("/addemail")
	public ModelAndView addemail(@RequestParam String email) {
ModelAndView mv = new ModelAndView("admin2");
if(err.count()<2 && !err.existsByEmail(email) && email.contains("@gmail.com")) {

	SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
	String d=sdf.format(new Date());
	Emaillist lst=new Emaillist(email,email,d);
	err.save(lst);
	mv.addObject("sms","success fully added email");
	return mv;
                 }

else {
	mv.addObject("sms","duplicate email or wrong email or exced 2");	
	System.out.println("dupplicate email or exceeded 2");
	System.out.println("dupplicate email or exceeded 2");

	return mv;
}
	}	
	
	
	
	@GetMapping("/alluser")
	public ResponseEntity<List<Emaillist>> emaillist() {
		List<Emaillist> lst=err.findAll();
		return new ResponseEntity<List<Emaillist>>(lst,HttpStatus.OK);
		
	                                   }		
	
	@DeleteMapping("/delete")
	public ResponseEntity<Emaillist> deleteemail(@RequestBody Emaillist el) {
		Userreg u=urr.findByEmail(el.getEmail()).get(0);
		urr.delete(u);
		err.delete(el);
		
		return new ResponseEntity<Emaillist>(el,HttpStatus.OK);
		
	                                   }	
	
	@GetMapping("/clearadmin")
	public ResponseEntity<Adminmail> deleteemail() {
        adrr.deleteAll();
		Adminmail ad=new Adminmail("sdfsd","sdfsfds");
	return  new ResponseEntity<Adminmail>(ad,HttpStatus.OK);
		
	                                   }	
	
	@PutMapping("/edit")
	public ResponseEntity<Emaillist> editmail(@RequestBody Emaillist el) {
		SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
		String d=sdf.format(new Date());
		el.setStringdate(d);
		if(el.getEmail().contains("@gmail.com")) {
			Userreg u=urr.findByEmail(el.getDupemail()).get(0);
			u.setEmail(el.getEmail());
			urr.save(u);
			err.save(el);
			el.setStringdate("successfully updated");
		}
		if(!el.getEmail().contains("@gmail.com")) {
			el.setStringdate("wrong email address");
		}

		
		
		return new ResponseEntity<Emaillist>(el,HttpStatus.OK);
		
	                                   }		
	
	@PostMapping("/adminset")
	public ResponseEntity<Adminmail> adminset(@RequestBody Adminmail ad) {
            if(ad.getEmail().contains("@gmail.com") && adrr.findAll().size()<1) {

        		adrr.save(ad);
        		ad.setEmail("successfully added");
        		return new ResponseEntity<Adminmail>(ad,HttpStatus.OK);
            }
            
            if(!ad.getEmail().contains("@gmail.com")) {

        		ad.setEmail("wrong email address");
        		return new ResponseEntity<Adminmail>(ad,HttpStatus.OK);
            }
            
            if(adrr.findAll().size()==1) {
        		ad.setEmail("only one email can be add");
        		return new ResponseEntity<Adminmail>(ad,HttpStatus.OK);
            }
            
    		return new ResponseEntity<Adminmail>(ad,HttpStatus.OK);
		
	                                   }	
	
	
	
	
	
	@GetMapping("/seeadmin")
	public ResponseEntity<Adminmail> seeadmin() {
	
		Adminmail el=adrr.findAll().get(0);
		return new ResponseEntity<Adminmail>(el,HttpStatus.OK);
		
	                                   }	
	
	
	
}
