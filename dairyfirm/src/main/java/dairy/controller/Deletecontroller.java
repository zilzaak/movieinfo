package dairy.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import dairy.model.Animal;
import dairy.model.Dailycost;
import dairy.model.Presitem;
import dairy.model.Sellmilk;
import dairy.repo.Adminrepo;
import dairy.repo.Animalpresrepo;
import dairy.repo.Animalrepo;
import dairy.repo.Cowsellrepo;
import dairy.repo.Dailycostrepo;
import dairy.repo.Presitemrepo;
import dairy.repo.Sellmilkrepo;

@Controller
@RequestMapping("/delete")

public class Deletecontroller {
@Autowired
private Animalrepo arr;
@Autowired
private Sellmilkrepo mrr;

@Autowired
private Cowsellrepo crr;

@Autowired
private Dailycostrepo drr;

@Autowired
private Animalpresrepo anpr;

@Autowired
private Presitemrepo prr;	
@Autowired
private Adminrepo adr;	

	@PostMapping("/deleteit")
public  ResponseEntity<Respont> deleteit(@RequestBody Respont item,HttpSession session){
		
	if(adr.existsByPassword(item.getPass())) {
		if(item.getDel().contentEquals("animal")) {
			List<Animal> lst = arr.findAll();
			for(Animal as : lst) {
				String path=session.getServletContext().getRealPath("/")+"static/"+"images/"+File.separator+as.getFilename();
				   try { 
			             File file = new File(path);
			             if(file.delete()) { 
			                System.out.println(file.getName() + " is deleted!");
			             } else {
			                System.out.println("Delete operation is failed.");
			                }
			          }
			            catch(Exception e)
			            {
			                System.out.println("Failed to Delete image !!");
			            }	
				
			}

             arr.deleteAll();
			item.setDel("succeessfully deleted animals");
			return new ResponseEntity<Respont>(item,HttpStatus.OK);	
			
		}
		
		if(item.getDel().contentEquals("cowsell")) {
			
			crr.deleteAll();
			item.setDel("succeessfully deleted cow selling data");
			return new ResponseEntity<Respont>(item,HttpStatus.OK);	
		}
		if(item.getDel().contentEquals("milksell")) {
			
			mrr.deleteAll();
			item.setDel("succeessfully deleted milk selling data");
			return new ResponseEntity<Respont>(item,HttpStatus.OK);	
		}
		if(item.getDel().contentEquals("dailycost")) {
			drr.deleteAll();
			item.setDel("succeessfully deleted dailycost data");
			return new ResponseEntity<Respont>(item,HttpStatus.OK);	
		}
		
		if(item.getDel().contentEquals("prescription")) {
			
			prr.deleteAll();
			anpr.deleteAll();
			item.setDel("succeessfully deleted prescription record");
			return new ResponseEntity<Respont>(item,HttpStatus.OK);	
		}
		
	}
		
		
	item.setDel("wrong password, try again");

return new ResponseEntity<Respont>(item,HttpStatus.OK);	

}
	


	@PostMapping("/deleteanimal")
public  ResponseEntity<Animal> deleteit(@RequestBody Animal item,HttpSession session){
		String path=session.getServletContext().getRealPath("/")+"static/"+"images/"+File.separator+item.getFilename();
		   try { 
	             File file = new File(path);
	             if(file.delete()) { 
	                System.out.println(file.getName() + " is deleted!");
	             } else {
	                System.out.println("Delete operation is failed.");
	                }
	          }
	            catch(Exception e)
	            {
	                System.out.println("Failed to Delete image !!");
	            }
	arr.delete(item);
return new ResponseEntity<Animal>(item,HttpStatus.OK);	

}	
	

	@PostMapping("/deletepresbyid")
public  ResponseEntity<Presitem> deleteit(@RequestBody Presitem item){
	prr.delete(item);	
	item.setRules("successfully delete");
	return new ResponseEntity<Presitem>(item,HttpStatus.OK);	

}	
	
	
	@PostMapping("/deletemilk")
public  ResponseEntity<Sellmilk> deletemilk(@RequestBody Sellmilk item){
	mrr.delete(item);
return new ResponseEntity<Sellmilk>(item,HttpStatus.OK);	

}		
	
	@RequestMapping(value="/deletedailycost",method=RequestMethod.DELETE)
public  ResponseEntity<Dailycost> deletedailycost(@RequestBody Dailycost item){
	drr.delete(item);
	return new ResponseEntity<Dailycost>(item,HttpStatus.OK);	

}	
	
	
	
}
