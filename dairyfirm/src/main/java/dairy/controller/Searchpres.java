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
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import dairy.model.Presitem;
import dairy.repo.Presitemrepo;

@Controller
@RequestMapping("/searchpres")

public class Searchpres {
	
	@Autowired
	private Presitemrepo prr;
	
	
@RequestMapping(value="/update",method=RequestMethod.PUT)	
public ResponseEntity<Presitem> update(@RequestBody Presitem mpi) throws ParseException {
	boolean errstd=false,errlstd=false;

	SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
    Date present= sdf.parse(sdf.format(new Date()));
    
	try {
		mpi.setStartingdate(sdf.parse(mpi.getStringstartingdate()));
	} catch (ParseException e) {
		 errstd=true;
		e.printStackTrace();
	}
	try {
		mpi.setLastdate(sdf.parse(mpi.getStringlastdate()));
	} catch (ParseException e) {
		errlstd=true;
		e.printStackTrace();
	}
	
	if(!errstd && !errlstd) {
		
		if(mpi.getLastdate().after(present)  && mpi.getLastdate().after(mpi.getStartingdate())) {
			
			prr.save(mpi);
			mpi.setPrestype("successfully updated");
			return new  ResponseEntity<Presitem>(mpi,HttpStatus.OK);
		}
		
		mpi.setPrestype("sorry!!,wrong last date or starting date");
		return new  ResponseEntity<Presitem>(mpi,HttpStatus.OK);
		
	
	       
	                }
	
	else {
		
		mpi.setPrestype("input date error!!");
		
		return new  ResponseEntity<Presitem>(mpi,HttpStatus.OK);	
		
	}
		
}
	
	
@PostMapping("/bydoctorname")	
public ResponseEntity<List<Presitem>> findbydoctorname(@RequestBody String doctorname){

	List<Presitem> lst = prr.findByDoctorContainingOrderByLastdateDesc(doctorname);
	return new  ResponseEntity<List<Presitem>>(lst,HttpStatus.OK);
	
}
	


@PostMapping("/bydrugname")	
public ResponseEntity<List<Presitem>> findbydrugname(@RequestBody String doctorname){
	
	List<Presitem> lst = prr.findByDrugnameContainingOrderByLastdateDesc(doctorname);
	return new  ResponseEntity<List<Presitem>>(lst,HttpStatus.OK);
     
                }



@PostMapping("/bydrugtype")	

public ResponseEntity<List<Presitem>> findbydrugtype(@RequestBody String doctorname){
	
	List<Presitem> lst = prr.findByDrugtypeOrderByLastdateDesc(doctorname);
	return new  ResponseEntity<List<Presitem>>(lst,HttpStatus.OK);
	
}

@GetMapping("/byallpres")	

public ResponseEntity<List<Presitem>> findbyallpres(){
	
	List<Presitem> lst = prr.findAll();
	return new  ResponseEntity<List<Presitem>>(lst,HttpStatus.OK);
	
}


@PostMapping("/bydrugid")	

public ResponseEntity<Presitem> findbydrugid(@RequestBody int drid){
	Presitem i = new Presitem();
if(!prr.existsByItemid(drid)) {
	i.setRules("no");
	System.out.println("null value is found in item pres");
	System.out.println("null value is found in item pres");

}
else {
	i=prr.findById(drid).get();
	
}
	return new  ResponseEntity<Presitem>(i,HttpStatus.OK);
	
}

@GetMapping("/byrunning")	

public ResponseEntity<List<Presitem>> findbyrunning() throws ParseException{
	Date d = new Date();
	SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
	Date dt = sdf.parse(sdf.format(d));
	List<Presitem> lst = prr.findByLastdateAfter(dt);
	return new  ResponseEntity<List<Presitem>>(lst,HttpStatus.OK);
	
}



@GetMapping("/bydateover")	
public ResponseEntity<List<Presitem>> findbydateover() throws ParseException{
	Date d = new Date();
	SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
	Date dt = sdf.parse(sdf.format(d));
	List<Presitem> lst = prr.findByLastdateBefore(dt);
	return new  ResponseEntity<List<Presitem>>(lst,HttpStatus.OK);
	
	
}

@PostMapping("/byanid")	
public ResponseEntity<List<Presitem>> findbyanid(@RequestBody int anid){

	List<Presitem> pilst=new ArrayList<Presitem>();
	List<Presitem> lst = prr.findAll();
	for(Presitem pi : lst) {
		if(pi.getAp().getAnid()==anid) {
			pilst.add(pi);
		}
		}

	return new  ResponseEntity<List<Presitem>>(pilst,HttpStatus.OK);
	
	
}

	

}
