package dairy.service;

import java.text.ParseException;
import java.util.Date;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import dairy.model.Animal;
import dairy.repo.Animalrepo;

@Service
public class Updateage {

@Autowired
private Animalrepo anr;
	

public void ageHeightWeightUpdater(Date d) throws ParseException {
	List<Animal> lst=anr.findAll();

for(Animal a : lst) {
	
	if(a.getType().contentEquals("cow")) {
		float month = a.getAgem()+1;
	    float year= month/12;
	    a.setAgem(month);a.setAgey(year);
	    if(month<25) {
	     float weight=(float) (a.getWeight()+6.5); //add 10 kg every month
	     float height = a.getHeight()+3; // grow 3 inch every month
	     a.setWeight(height);a.setHeight(height);	
			}
	    anr.save(a);
	    }
	
	if(a.getType().contentEquals("buffelo")) {
		float month = a.getAgem()+1;
	    float year= month/12;
	    a.setAgem(month);a.setAgey(year);
	    if(month<32) {
	     float weight=a.getWeight()+11; //add 10 kg every month
	     float height = a.getHeight()+3; // grow 3 inch every month
	     a.setWeight(height);a.setHeight(height);	
			}
	    anr.save(a);
	    }
		
	
	if(a.getType().contentEquals("goat")) {
		float month = a.getAgem()+1;
	    float year= month/12;
	    a.setAgem(month);a.setAgey(year);
		  if(month<13) {
			float w=(float) (a.getAgem()+2.2);
			float h=(float)(a.getAgem()+1.65);
			a.setWeight(w);a.setHu("inch");
			a.setHeight(h);a.setWu("kg");
		}
	    anr.save(a);
	    }
		
	if(a.getType().contentEquals("vera")) {
		float month = a.getAgem()+1;
	    float year= month/12;
	    a.setAgem(month);a.setAgey(year);
	    if(month<13) {
	     float weight=(float) (a.getWeight()+2.2); //add 10 kg every month
	     float height = (float) (a.getHeight()+1.55); // grow 3 inch every month
	     a.setWeight(height);a.setHeight(height);	
			}
	    anr.save(a);
	    }
	}
	
}


	
}
