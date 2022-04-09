package scheduler2.scheduler2;

import org.springframework.scheduling.SchedulingException;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

@Component
public class Hourdayscheduler {

	@Scheduled(cron="0 0 00/01 * * ?")

	public void hourly() {
		try {
			System.out.println("second schedler give the date value as "+new java.util.Date());
			
		}
		catch(SchedulingException e) {
			
		System.out.println(e);	
		}
	
		
	}
	
	
}
