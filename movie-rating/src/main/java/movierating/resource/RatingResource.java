package movierating.resource;

import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import movierating.model.Rating;

@RestController
@RequestMapping("/rating")
public class RatingResource {

	
@RequestMapping("/{rid}")
public Rating mrating(@PathVariable String rid) {
	
return new Rating(rid,4);	
}

	
}
