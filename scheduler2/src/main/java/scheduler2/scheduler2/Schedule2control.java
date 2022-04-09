package scheduler2.scheduler2;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class Schedule2control {

@RequestMapping("/")

	public String index() {
	System.out.println("second schedler give the date value as "+new java.util.Date());
	return "index";
	
	}
	
	
}
