package dairy.controller;
import dairy.model.Agecal;
import dairy.model.Firmadmin;
import dairy.model.Presitem;
import dairy.model.Twillioclass;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.SchedulingException;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import dairy.repo.Adminrepo;
import dairy.repo.Agecalrepo;
import dairy.repo.Animalrepo;
import dairy.repo.Presitemrepo;
import dairy.repo.Twiliorepo;
import dairy.service.TwillioService;
import dairy.service.Updateage;
//private String from="+12055518048";
//private String to="+8801753181186";
//private String ACCOUNT_SID="ACe9b95eae6f6e814f42fe1353062a9687";
//private String AUTH_TOKEN="9df635bdd726b77ad91ebad9e88d26f1";
@Component
public class PrescriptionScheduler {
@Autowired
private Presitemrepo pir;
@Autowired
private Adminrepo arr;
@Autowired
private Agecalrepo agr;
@Autowired
private Updateage uag;
@Autowired
private Twiliorepo trr;
@Autowired
TwillioService twillioService;
//@Scheduled(cron = "0 0/2 * * * *") //every 2 minite later
//@Scheduled(cron="0 0 1 * * *") // every day at 1 pm
@Scheduled(cron="0 0 10 * * *") //every day at 10 am
public void dailttask() throws ParseException {
	HashMap<Integer,String> smsWithanid = new HashMap<Integer,String>();			
	List<Presitem> pi = pir.findByPrestypenumberGreaterThan(1);		
	List<Twillioclass> tls= trr.findByActive("active");
	
		try {
			Date presentdate= simpletypedate(new Date());	
for(Presitem p : pi){
if(p.getLastdate().after(presentdate)){
if(msgbeforetwodateornot(p,presentdate)){

		Calendar cal = Calendar.getInstance(); //add 2 days which date is perfect to take drug it means after twodays later need to take frug
		cal.setTime(presentdate);
		cal.add(Calendar.DATE, 2);
		Date NBdate = cal.getTime(); 
		
		
	String  notification="animal id:- "+p.getAp().getAnid()+",animal type:- "+p.getAp().getType()+"\n"
		            +"drug id:-"+p.getItemid()+"Dr name::-"+p.getDoctor()+"---drug details--- "+"\n"+
		            ",drug name:- "+p.getDrugname()+",Type:- "+p.getDrugtype()+",rules :- "+p.getRules()+",advice :- "+p.getConsult()+"\n"+
		            "drug taking date: "+NBdate+" \n";	 
	

	if(smsWithanid.containsKey(p.getAp().getAnid())) {
		
		notification=notification+smsWithanid.get(p.getAp().getAnid());
		smsWithanid.put(p.getAp().getAnid(),notification);
	}
	if(!smsWithanid.containsKey(p.getAp().getAnid())) {
				smsWithanid.put(p.getAp().getAnid(), notification);	
	}
}
}
			                 	
} 


if(arr.findAll().size()>0) {
	Firmadmin ad = arr.findAll().get(0);
	for(Map.Entry<Integer,String> m : smsWithanid.entrySet()) {
		String sms = (String) m.getValue();
		new Sendotp().sendotp(sms, ad.getEmail(),"drug take reminder",ad.getEmail(),ad.getGmailspass());

		  for(Twillioclass t:tls) {
			twillioService.sendSms(t.getTomy(),t.getFromtwilio(),sms,t.getSid(),t.getAuthtoken() );
			System.out.println("omar borkan al gala");	
			System.out.println("omar borkan al gala");	
					
				   }
		}
}




agecalculate(presentdate);	
		
		}
		catch(SchedulingException e) {
			System.out.println(e);	
		}
	
		
	}
	

	public void agecalculate(Date d) throws ParseException {
		System.out.println("present date is "+d);
			if(!agr.findAll().isEmpty()){
			Agecal ak=agr.findAll().get(0);
			   long difference = d.getTime() - ak.getAgedate().getTime();
			    int day = (int) (difference / (1000*60*60*24));	
			if(day>29) {
			
				  ak.setAgedate(d);
				  agr.save(ak);
				uag.ageHeightWeightUpdater(d);	
			               }
			       	     	}
			if(agr.findAll().isEmpty()){
				Agecal ak= new Agecal(d);
				agr.save(ak);
				
			}
		
		                      	} 
	

public boolean msgbeforetwodateornot(Presitem p,Date d1) throws ParseException {
	boolean x = false;
	Date presentdateplus2=add2(d1,2);
	int del=datediffrent(p.getStartingdate(),presentdateplus2);
	int divisor=p.getPrestypenumber()+1;
				int rem=del%divisor;	
					if(rem==0) {
					System.out.println("the modluer division result by "+divisor+" is"+rem);	
					x= true;
					}
				  return x;
				  
				  
                         }


int datediffrent(Date startdate , Date presentdateplus2) throws ParseException {
	long difference = presentdateplus2.getTime() - startdate.getTime();
    int day = (int) (difference / (1000*60*60*24));	
	   return day;
          }  

public Date add2(Date f,int din) {
	
	Calendar cal = Calendar.getInstance();
	cal.setTime(f);
	cal.add(Calendar.DATE, din);
	Date dm = cal.getTime();
	return dm;
              }


public Date simpletypedate(Date d) throws ParseException {
	              SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
	                        Date sd = sdf.parse(sdf.format(d));	
	                                 return sd;
                            }

	
}
