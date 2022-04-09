package scheduler2.scheduler2;


import org.springframework.boot.SpringApplication;

import org.springframework.boot.autoconfigure.SpringBootApplication;

import org.springframework.scheduling.annotation.EnableScheduling;


@SpringBootApplication

@EnableScheduling

public class Scheduler2Application {

	
public static void main(String[] args) {
		
SpringApplication.run(Scheduler2Application.class, args);
	

}

}
