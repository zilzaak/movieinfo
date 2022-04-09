package dairy.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import dairy.model.Animal;
import dairy.model.Dailycost;
import dairy.model.Firmadmin;
import dairy.model.Presitem;
import dairy.model.Sellcow;
import dairy.model.Sellmilk;
import dairy.model.Twillioclass;
import dairy.repo.Adminrepo;
import dairy.repo.Animalrepo;
import dairy.repo.Cowsellrepo;
import dairy.repo.Dailycostrepo;
import dairy.repo.Presitemrepo;
import dairy.repo.Sellmilkrepo;
import dairy.repo.Twiliorepo;
import dairy.service.TwillioService;
@Controller
public class Homecontroller {
@Autowired
private Adminrepo arr;
@Autowired
private Presitemrepo pir;
@Autowired
private Animalrepo anr;
@Autowired
private Sellmilkrepo smr;
@Autowired
private Cowsellrepo scr;
@Autowired
private Dailycostrepo dcr;
@Autowired
TwillioService twillioService;
@Autowired
private Twiliorepo trr;

	@RequestMapping("/")
	public String admin() {

	return "register";
	
	}
	
	@PostMapping("/register")
	public ResponseEntity<Firmadmin> admnlogin(@RequestBody Firmadmin ad,HttpSession session){
		
if(arr.count()==0) {
	
	String codertu = getrandom();
	if(new Sendotp().sendotp(codertu, ad.getEmail(),"email verification code",ad.getEmail(),ad.getGmailspass())) {
		session.setAttribute("codertu",codertu);
		ad.setCode("ok");
	}
	else {
		ad.setCode("invalid email address,add correct one");	
		
	}
}
else {
	
	ad.setCode("sorry, one admin already exist");
}

return new ResponseEntity<Firmadmin>(ad,HttpStatus.OK);
	
	}
	
	@PostMapping("/regfinal")
	public ResponseEntity<Firmadmin> finalreg(@RequestBody Firmadmin ad,HttpSession session){
		
String rancode = (String) session.getAttribute("codertu");
if(ad.getCode().contentEquals(rancode)) {
	arr.save(ad);
	String sms="successfully registered , your email:"+ad.getEmail()+" admin password: "+ad.getPassword();
    new Sendotp().sendotp(sms, ad.getEmail(),"animal addition record", ad.getEmail(), ad.getGmailspass());
 	List<Twillioclass> tls= trr.findByActive("active");
	  for(Twillioclass t:tls) {
		twillioService.sendSms(t.getTomy(),t.getFromtwilio(),sms,t.getSid(),t.getAuthtoken() );
				
			   }
ad.setCode("ok");
}
else {
	ad.setCode("no");	
}
return new ResponseEntity<Firmadmin>(ad,HttpStatus.OK);
	
	}	
	
	


	
	@PostMapping("/adminlogin")
	public ModelAndView login(@RequestParam String email, @RequestParam String password ,HttpSession session) {
		ModelAndView mv = new ModelAndView();
		List<Firmadmin> lst =arr.findAll();
if(lst.size()<1) {
	mv.addObject("sms","you have not registred yet,regster now");
	mv.setViewName("register");
}
		
else if(email.contentEquals(lst.get(0).getEmail()) && password.contentEquals(lst.get(0).getPassword())) {
			mv.setViewName("index");
		session.setAttribute("adminuser",lst.get(0).getEmail());
		session.setAttribute("adminpass",lst.get(0).getPassword());
		
		}

		else {
			mv.addObject("sms","email or password error");
			mv.setViewName("register");
		}
	
		
		return mv;
	}
	
	
	@PostMapping("/recover")
	public ResponseEntity<Firmadmin> recover(@RequestBody Firmadmin forgot,HttpSession session){
		
	List<Firmadmin> lst= arr.findAll();	
	if(lst.size()<1) {
		forgot.setCode("you have not registered yet");
	}
	
	else if(forgot.getEmail().contentEquals(lst.get(0).getEmail())) {
				String st = getrandom();
		session.setAttribute("rechujuw",st);
			if(new Sendotp().sendotp(st, forgot.getEmail(),"email verification code",lst.get(0).getEmail(),lst.get(0).getGmailspass())) {
				forgot.setCode("ok");
			           }
			                   else {
				    forgot.setCode("sorry ,wrong email address");
			                         }
	
		
	}
	
	else {
		
		forgot.setCode("this is not admins email");
	}
		
	return new ResponseEntity<Firmadmin>(forgot,HttpStatus.OK);
	
	}	
	
	@PostMapping("/finalrec")
	public ResponseEntity<Firmadmin> finalrec(@RequestBody Firmadmin forgot,HttpSession session){
String rec = (String) session.getAttribute("rechujuw");
if(rec.contentEquals(forgot.getCode())) {
	Firmadmin fa = arr.findAll().get(0);
	fa.setPassword(forgot.getPassword());
	arr.save(fa);	
	String sms="you have recovered admin password, admin email:"+fa.getEmail()+" admin password is: "+fa.getPassword();
    new Sendotp().sendotp(sms, fa.getEmail(),"animal addition record", fa.getEmail(), fa.getGmailspass());
 	List<Twillioclass> tls= trr.findByActive("active");
	  for(Twillioclass t:tls) {
		twillioService.sendSms(t.getTomy(),t.getFromtwilio(),sms,t.getSid(),t.getAuthtoken() );
				
			   }
	
	forgot.setCode("successfull, login now");
}
else {
	forgot.setCode("sorry!!!, code not match,try again");
	
}

return new ResponseEntity<Firmadmin>(forgot,HttpStatus.OK);
	
	}		
	
	
	
	public  String getrandom() {
		String chars = "0123456789ABCDEFGHJKMNOPQRSTUVWXYZabcdefghjk"
          +"mnopqrstuvwxyz@#$";
		Random rnd = new Random();
		StringBuilder sb = new StringBuilder(6);
		for (int i = 0; i < 6; i++)
			sb.append(chars.charAt(rnd.nextInt(chars.length())));
		return sb.toString();
	}
	

	
	@PostMapping("/logout")
	public String logoutadmin(HttpSession session) {
		
		session.removeAttribute("adminuser");
		session.removeAttribute("adminpass");
		session.invalidate();
		
		return "register";
		
	}
	
	
	@PostMapping("/changepassword")
	public ResponseEntity<Firmadmin> changepassword(@RequestBody Firmadmin  fa){
		
		if(arr.existsByPassword(fa.getCode())) {
			
			Firmadmin gf = arr.findAll().get(0);
			gf.setPassword(fa.getPassword());
			arr.save(gf);
			gf.setCode("successfully changed password");
			String sms="you have changed admin password. your email:"+gf.getEmail()+" admin password is: "+gf.getPassword();
		    new Sendotp().sendotp(sms, gf.getEmail(),"animal addition record", gf.getEmail(), gf.getGmailspass());
		 	List<Twillioclass> tls= trr.findByActive("active");
			  for(Twillioclass t:tls) {
				twillioService.sendSms(t.getTomy(),t.getFromtwilio(),sms,t.getSid(),t.getAuthtoken() );
						
					   }
			
			return  new ResponseEntity<Firmadmin>(gf,HttpStatus.OK);
			
		                }
		
		else {
			fa.setCode("old password is wrong");
			
			return  new ResponseEntity<Firmadmin>(fa,HttpStatus.OK);
		}

		
              }
	
	
	@PostMapping("/changeemail")
	
	public ResponseEntity<Firmadmin> changeemail(@RequestBody Firmadmin  fa,HttpSession session){
		
			String changecode=getrandom();		
			 if(arr.existsByPassword(fa.getPassword())) {
				
				if(new Sendotp().sendotp(changecode, fa.getEmail(),"email verification code",fa.getEmail(),fa.getGmailspass())) {
					session.setAttribute("changecode",changecode);
					session.setAttribute("newemail",fa.getEmail());
					session.setAttribute("newgmailspass",fa.getGmailspass());
					fa.setCode("sent");
					return  new ResponseEntity<Firmadmin>(fa,HttpStatus.OK);
				} 
				
				else {
					
					fa.setCode("sorry!!,invalid email");
					return  new ResponseEntity<Firmadmin>(fa,HttpStatus.OK);
				}
			 
			}			 
		 
fa.setCode("password is wrong");

return  new ResponseEntity<Firmadmin>(fa,HttpStatus.OK);
		
              
	}
	
	
	
	
	
	@PostMapping("/changenumber")	
	public ResponseEntity<Respont> changenumber(@RequestBody Firmadmin  fa){
		Respont rt = new Respont();
		  if(arr.existsByPassword(fa.getPassword())) {
		 Firmadmin fd = arr.findAll().get(0);
		fd.setPhone(fa.getPhone());
	      arr.save(fd);
	      rt.setDel("successfully added new number");
		 return new  ResponseEntity<Respont>(rt,HttpStatus.OK);
		  }
		
		  rt.setDel("wrong password");
		  return new  ResponseEntity<Respont>(rt,HttpStatus.OK);
		
							}	
	
	
	
	@PostMapping("/finalchangeemail")
	
	public ResponseEntity<Respont> finalchangeemail(@RequestBody String submitcode,HttpSession session){
		
		Respont rs = new Respont();
		String getcode=(String) session.getAttribute("changecode");
		String email = (String) session.getAttribute("newemail");
		String newgmailspass = (String) session.getAttribute("newgmailspass");
	   if(submitcode.contentEquals(getcode)) {
	     Firmadmin fd = arr.findAll().get(0);  
	       fd.setEmail(email);
	       fd.setGmailspass(newgmailspass);
	       arr.save(fd);
	       
String sms="you have changed admin email. new email:"+fd.getEmail()+" admin password is: "+fd.getPassword();
		    new Sendotp().sendotp(sms, fd.getEmail(),"animal addition record", fd.getEmail(),fd.getGmailspass());
		 	List<Twillioclass> tls= trr.findByActive("active");
			  for(Twillioclass t:tls) {
				twillioService.sendSms(t.getTomy(),t.getFromtwilio(),sms,t.getSid(),t.getAuthtoken() );
						
					   }	       
	              
		 rs.setDel("successfully changed email");
		 return  new ResponseEntity<Respont>(rs,HttpStatus.OK);
	   }
	   
	      rs.setDel("code does not match");
		 return  new ResponseEntity<Respont>(rs,HttpStatus.OK);
		
            	}	
	
	

	
	@GetMapping("/addpres")
	public String logoutadn()  {
float x =  53.36f;
float y=  25.58f;
double g= x*y;



return "newtab";
		
	}	
	
	@GetMapping("/getadmin")
	public ResponseEntity<Firmadmin>  getadmin(){
		Firmadmin admin = arr.findAll().get(0);
		admin.setPassword("");
		return new ResponseEntity<Firmadmin>(admin,HttpStatus.OK);
		
					
	             }
	
	@PostMapping("/checkuser")
	public ResponseEntity<Respont>  checkuser(@RequestBody String uer){
		
		Respont rt = new Respont();
		if(arr.existsByPassword(uer)) {
			
			rt.setDel("ok");
			return new ResponseEntity<Respont>(rt,HttpStatus.OK);
		}
		else {
		
			rt.setDel("no");
			
			return new ResponseEntity<Respont> (rt,HttpStatus.OK);
		}

		
					
	             }	
	
	
	@RequestMapping("/costprofit")
	public String costprofit(){

		return "costprofit";
		
	}
	@RequestMapping("/sellcow")
	public String sellcow(){

		return "sellcow";
		
	}		
	@RequestMapping("/newborn")
	public String newborn(){

		return "newborn";
		
	}	
	
	@RequestMapping("/trydate")
	public @ResponseBody String trydate(HttpServletRequest request){
		
		return request.getRemoteAddr();
		
					}	
	
	
	
	@Autowired
	private Twiliorepo tr;
	@PostMapping("/addtwilio")
	public ResponseEntity<Twillioclass> addtwilio(@RequestBody Twillioclass tc){
		SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
		String add = sdf.format(new Date());
		tc.setAddingdate(add);tc.setActive("active");
		tr.save(tc);
		
return new ResponseEntity<Twillioclass> (tc,HttpStatus.OK);
		
					}
	
	
	@RequestMapping(value="/updatetw",method=RequestMethod.PUT)
	public ResponseEntity<Twillioclass> uptwilio(@RequestBody Twillioclass tc){
		tr.save(tc);
		return new ResponseEntity<Twillioclass> (tc,HttpStatus.OK);
		
					}
		
	@GetMapping("/alltwillio")
	public ResponseEntity<List<Twillioclass>> alltwillio(){
		return new ResponseEntity<List<Twillioclass>> (tr.findAll(),HttpStatus.OK);
		
					}
	
	@DeleteMapping(value="/deletetw")
	public ResponseEntity<Twillioclass> deletetw(@RequestBody Twillioclass tc){
		tr.delete(tc);
		return new ResponseEntity<Twillioclass> (tc,HttpStatus.OK);
		
					}
	
	
	
	@RequestMapping(value="/download/milksell")
	public ModelAndView  milkd(){
		ModelAndView mv = new ModelAndView("milksellrecord");
		List<Sellmilk> lst = new ArrayList<Sellmilk>();
		float tp=0;
		float td=0;
		lst=smr.findAll();
		int tr=lst.size();
		for(Sellmilk sm : lst) {
			
			tp=tp+sm.getTotalprice();
			td=td+sm.getDue();
		}
		
		SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
		String tot=sdf.format(new Date());		
         mv.addObject("todays",tot);
		mv.addObject("milksellrecord", lst);
mv.addObject("tp",tp);
mv.addObject("td",td);
mv.addObject("tr",tr);
		return mv;
					}	
	
	@RequestMapping(value="/download/cowsell")
	public ModelAndView  cowd(){

		ModelAndView mv = new ModelAndView("cowsellrecord");
		SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
		String tot=sdf.format(new Date());		
         mv.addObject("todays",tot);
		List<Sellcow> lst = new ArrayList<Sellcow>();
		lst=scr.findAll();
		float tp=0;
		float td=0;	int tr=lst.size();
		for(Sellcow sm : lst) {
			
			tp=tp+sm.getSellprice();
			td=td+sm.getDue();
		}
		mv.addObject("tp",tp);
		mv.addObject("td",td);
		mv.addObject("tr",tr);
		mv.addObject("cowsellrecord", lst);
		return mv;
		
					}	
	
	@RequestMapping(value="/download/dailycost")
	public ModelAndView  costd(){
		ModelAndView mv = new ModelAndView("dailycostrecord");
		SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
		String tot=sdf.format(new Date());		
         mv.addObject("todays",tot);
		List<Dailycost> lst = new ArrayList<Dailycost>();
		lst=dcr.findAll();
		float tp=0;
		float td=0;
		int tr=lst.size();
		for(Dailycost sm : lst) {
			
			tp=tp+sm.getCost();

		}

		mv.addObject("tr",tr);
		mv.addObject("tp",tp);
		mv.addObject("dailycostrecord", lst);
		return mv;
		
					}		
	@RequestMapping(value="/download/pres")
	public ModelAndView  presd(){
		ModelAndView mv = new ModelAndView("prescriptionrecord");
		SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
		String tot=sdf.format(new Date());		
         mv.addObject("todays",tot);
		List<Presitem> lst = new ArrayList<Presitem>();
		lst=pir.findAll();
		int tr=lst.size();
		mv.addObject("tr",tr);
		mv.addObject("prescriptionrecord", lst);
		return mv;
	
		
					}	
	
	@RequestMapping(value="/download/animal")
	public ModelAndView  animald(){
		ModelAndView mv = new ModelAndView("animalrecord");
		SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
		String tot=sdf.format(new Date());		
         mv.addObject("todays",tot);
		List<Animal> lst = new ArrayList<Animal>();
		
		lst=anr.findAll();
		float tp=0;
		for(Animal sm : lst) {
		tp=tp+sm.getChest();
		
		}
		int tr=lst.size();
		mv.addObject("tr",tr);
		mv.addObject("tp",tp);
		mv.addObject("animalrecord", lst);
		return mv;

		
					}	
	
	
	
	
		
              }
