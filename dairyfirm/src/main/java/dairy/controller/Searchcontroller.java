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
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import dairy.model.Animal;
import dairy.repo.Animalrepo;

@Controller
@RequestMapping("/search")

public class Searchcontroller {
@Autowired
private Animalrepo anr;
	@PostMapping("/bytypeageupper")
public ResponseEntity<List<Animal>> bytypeageupper(@RequestBody Animal s){
	
		if(s.getColor().contentEquals("")) {
			
			 if(s.getWu().contentEquals("year")) {
				 float mt=s.getAgey()*12;
			List<Animal> lst =anr.findByTypeAndAgemGreaterThan(s.getType(), mt);
			return new ResponseEntity<List<Animal>>(lst,HttpStatus.OK);	 
			 }
			 
			 else{
				 List<Animal> lst =anr.findByTypeAndAgemGreaterThan(s.getType(), s.getAgey());
			       return new ResponseEntity<List<Animal>>(lst,HttpStatus.OK);	 
			 }
				
		}
		
		else {
			if(s.getWu().contentEquals("month")) {
				
				List<Animal> lst =anr.findByTypeAndAgemGreaterThanAndColor(s.getType(),s.getAgey(),s.getColor());
			       return new ResponseEntity<List<Animal>>(lst,HttpStatus.OK);	
			}
			else {
				 float mt=s.getAgey()*12;
				List<Animal> lst =anr.findByTypeAndAgemGreaterThanAndColor(s.getType(),mt,s.getColor());
			       return new ResponseEntity<List<Animal>>(lst,HttpStatus.OK);	
			}
				
		}

}
	
	@PostMapping("/bytypeagelower")
public ResponseEntity<List<Animal>> bytypeagelower(@RequestBody Animal s){
		if(s.getColor().contentEquals("")) {
			 if(s.getWu().contentEquals("year")) {
				 float ag = s.getAgey()*12; 
					List<Animal> lst = anr.findByTypeAndAgemLessThan(s.getType(),ag); 
					return new ResponseEntity<List<Animal>>(lst,HttpStatus.OK);
			 }
			 
	List<Animal> lst = anr.findByTypeAndAgemLessThan(s.getType(),s.getAgey());  
	return new ResponseEntity<List<Animal>>(lst,HttpStatus.OK);			 
				
		}
		
		else {
			
			 if(s.getWu().contentEquals("year")) {
				 float ag = s.getAgey()*12; 
					List<Animal> lst = anr.findByTypeAndColorAndAgemLessThan(s.getType(),s.getColor(),ag); 
					return new ResponseEntity<List<Animal>>(lst,HttpStatus.OK);
			 }
			 
		List<Animal> lst = anr.findByTypeAndColorAndAgemLessThan(s.getType(),s.getColor(),s.getAgey());  
		return new ResponseEntity<List<Animal>>(lst,HttpStatus.OK);			 
							
				}

				 
}
	
	
	@PostMapping("/bytypecolorweightupper")
public ResponseEntity<List<Animal>> bytypecolorweightupper(@RequestBody Animal s){
		
		if(s.getColor().contentEquals("")) {
			float wt=0;
			if(s.getWu().contentEquals("mon")) {
				wt=s.getWeight()*40;s.setWeight(wt);
			}
			if(s.getWu().contentEquals("gm")) {
				wt=s.getWeight()/1000;s.setWeight(wt);
			}
			
			List<Animal> lst = anr.findByTypeAndWeightGreaterThanAndWu(s.getType(),s.getWeight(),"kg");
			return new ResponseEntity<List<Animal>>(lst,HttpStatus.OK);
			
				}
		else {
			float wt=0;
			if(s.getWu().contentEquals("mon")) {
				wt=s.getWeight()*40;s.setWeight(wt);
			}
			if(s.getWu().contentEquals("gm")) {
				wt=s.getWeight()/1000;s.setWeight(wt);
			}
						
	List<Animal> lst = anr.findByTypeAndWeightGreaterThanAndWuAndColor(s.getType(),s.getWeight(),"kg",s.getColor());
	return new ResponseEntity<List<Animal>>(lst,HttpStatus.OK);
			
			}
	
		
}
	
	@PostMapping("/bytypecolorweightlower")
public ResponseEntity<List<Animal>> bytypecolorweightlower(@RequestBody Animal s){

		if(s.getColor().contentEquals("")) {
			float wt=0;
			if(s.getWu().contentEquals("mon")) {
				wt=s.getWeight()*40;
				s.setWeight(wt);
			}
			if(s.getWu().contentEquals("gm")) {
				wt=s.getWeight()/1000;
				s.setWeight(wt);
			}
			
			
		  	List<Animal> lst = anr.findByTypeAndWeightLessThanAndWu(s.getType(),s.getWeight(),"kg");
			return new ResponseEntity<List<Animal>>(lst,HttpStatus.OK);	
					}
		else{
			float wt=0;
			if(s.getWu().contentEquals("mon")) {
				wt=s.getWeight()*40;s.setWeight(wt);
			}
			if(s.getWu().contentEquals("gm")) {
				wt=s.getWeight()/1000;s.setWeight(wt);
			}
			
		
			List<Animal> lst = anr.findByTypeAndWeightLessThanAndWuAndColor(s.getType(),s.getWeight(),"kg",s.getColor());
			return new ResponseEntity<List<Animal>>(lst,HttpStatus.OK);		
			
		}
		
}
	
	
	@PostMapping("/bytype")
public ResponseEntity<List<Animal>> bytype(@RequestBody Animal s){
		List<Animal> lst =anr.findByTypeOrderByCreatedDesc(s.getType());
	
		return new ResponseEntity<List<Animal>>(lst,HttpStatus.OK);
}	
	

	
	@PostMapping("/bytypeandprice")
public ResponseEntity<List<Animal>> bytypeandprice(@RequestBody Animal s){
		if(s.getWu().contentEquals("bt")) {
			List<Animal> lst =anr.findByTypeAndChestBetween(s.getType(),s.getHeight(),s.getChest());
			return new ResponseEntity<List<Animal>>(lst,HttpStatus.OK);
		}
		else if(s.getWu().contentEquals("eq")) {
			List<Animal> lst =anr.findByTypeAndChest(s.getType(),s.getHeight());
			return new ResponseEntity<List<Animal>>(lst,HttpStatus.OK);
		}
		else if(s.getWu().contentEquals("gt")) {
			List<Animal> lst =anr.findByTypeAndChestGreaterThan(s.getType(),s.getHeight());
			return new ResponseEntity<List<Animal>>(lst,HttpStatus.OK);
		}
		
		else{
			List<Animal> lst =anr.findByTypeAndChestLessThan(s.getType(),s.getHeight());
			return new ResponseEntity<List<Animal>>(lst,HttpStatus.OK);
		}
		
}	
	
	
	
	@PostMapping("/bytypecolor")
public ResponseEntity<List<Animal>> bytypecolor(@RequestBody Animal s){
		List<Animal> lst =anr.findByTypeAndColorOrderByCreatedDesc(s.getType(),s.getColor());
	
		return new ResponseEntity<List<Animal>>(lst,HttpStatus.OK);
}	
	
	@PostMapping("/byid")
public ResponseEntity<Animal> byid(@RequestBody Animal s){
		Animal a = new Animal();
		
		if(!anr.existsByAnid(s.getAnid())) {
			a.setExtra("notfound");
		}
		if(anr.existsByAnid(s.getAnid())){
		a=anr.findById(s.getAnid()).get();	
		
		}

	
		return new ResponseEntity<Animal>(a,HttpStatus.OK);
}	
		

	@PostMapping("/byidd")
public ResponseEntity<Animal> byid2(@RequestBody int s){
		Animal animal =anr.findById(s).get();
	return new ResponseEntity<Animal>(animal,HttpStatus.OK);
}		
	
	
	
	@PostMapping("/buyingdate")
	public ResponseEntity<List<Animal>> buyingdate(@RequestBody String p){
		List<Animal> lst=anr.findByCreatedstringContaining(p);
		System.out.println("data is coming from the jsp page");
		System.out.println("data is coming from the jsp page");
		System.out.println("data is coming from the jsp page");
 return new ResponseEntity<List<Animal>>(lst,HttpStatus.OK); 
	            
		          }		
	
	
	@PostMapping("/buyingdate2")
	public ResponseEntity<List<Animal>> buyingdate2(@RequestBody String p){
		SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
		Date d =null;
		List<Animal> lst=new ArrayList<Animal>();
		try {
			
	     d = sdf.parse(p);
	    lst=anr.findByCreated(p);
			
		} catch (ParseException e) {

			e.printStackTrace();
		}
		
		System.out.println("data is coming from the jsp page");
		System.out.println("data is coming from the jsp page");
		System.out.println("data is coming from the jsp page");
 return new ResponseEntity<List<Animal>>(lst,HttpStatus.OK); 
	            
		          }			
	
	@PostMapping("/bysellername")
	public ResponseEntity<List<Animal>> byseller(@RequestBody String p){
		List<Animal> lst=anr.findBySellernameContaining(p);
		System.out.println("data is coming from the jsp page");

 return new ResponseEntity<List<Animal>>(lst,HttpStatus.OK); 
	            
		          }		
	
	
	@PostMapping("/byjaat")
	public ResponseEntity<List<Animal>> byjaat(@RequestBody String p){
		System.out.println("data is coming from the jsp page");
		List<Animal> lst=anr.findByJaatContaining(p);
return new ResponseEntity<List<Animal>>(lst,HttpStatus.OK); 
	            
		          }		
	
	
	@PostMapping("/bymarketname")
	public ResponseEntity<List<Animal>> bymarketname(@RequestBody String p){
		System.out.println("data is coming from the jsp page");
		List<Animal> lst=anr.findByMarketnameContaining(p);

 return new ResponseEntity<List<Animal>>(lst,HttpStatus.OK); 
	            
		          }		
	
	
	@PostMapping("/bydatebefore")
	public ResponseEntity<List<Animal>> bydatebefore(@RequestBody String p){
		SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
		List<Animal> lst=new ArrayList<Animal>();
		try {
			lst = anr.findByCreatedBefore(sdf.parse(p));
		} catch (ParseException e) {
	
			e.printStackTrace();
		}
		
return new ResponseEntity<List<Animal>>(lst,HttpStatus.OK); 
	            
		          }		
	
	@PostMapping("/bydateafter")
	public ResponseEntity<List<Animal>> bydateafter(@RequestBody String p){
		SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
		List<Animal> lst=new ArrayList<Animal>();
		try {
			lst = anr.findByCreatedAfter(sdf.parse(p));
		} catch (ParseException e) {
	
			e.printStackTrace();
		}
		
return new ResponseEntity<List<Animal>>(lst,HttpStatus.OK); 
	            
		          }
	
	@PostMapping("/bysource")
	public ResponseEntity<List<Animal>> bysource(@RequestBody String p){
	List<Animal> lst=anr.findBySource(p);
		
return new ResponseEntity<List<Animal>>(lst,HttpStatus.OK); 
	            
		          }			
	
		
	
}
