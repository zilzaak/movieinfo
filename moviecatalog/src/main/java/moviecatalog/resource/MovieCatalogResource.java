package moviecatalog.resource;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.reactive.function.client.WebClient;

import moviecatalog.model.Catalogitem;
import moviecatalog.model.Movie;
import moviecatalog.model.Rating;

@Controller
@RequestMapping("/catalog")
public class MovieCatalogResource {
	
	
	@Autowired
private RestTemplate rstc;
	@Autowired

	WebClient.Builder builder = WebClient.builder();
	
		@RequestMapping("/{userid}")
		@ResponseBody
public List<Catalogitem> catalogi(@PathVariable String userid){
		RestTemplate rt = new RestTemplate();
		//Movie movie=rstc.getForObject("http://info-service/movies/"+userid, Movie.class);
		Movie movie=builder.build().get().uri("info-service/movies/"+userid).retrieve()
	     .bodyToMono(Movie.class).block();
		
		List<Rating> ratings=Arrays.asList(
			new Rating("122",4),	new Rating("123",3),
			new Rating("120",2),	new Rating("119",5)
				);
				
List<Catalogitem> lst= new ArrayList<Catalogitem>();
 Catalogitem c1=new Catalogitem(movie.getMname(),"war type",4);
 Catalogitem c2=new Catalogitem(movie.getMname(),"war type",4);
 Catalogitem c3=new Catalogitem(movie.getMname(),"war type",4);
	
	lst.add(c1);
lst.add(c2);
	lst.add(c3);
	return lst;
}
	
		
		
		
		@RequestMapping("/rate/{rid}")
		
	public @ResponseBody Rating catalo(@PathVariable int rid){
		
	return new Rating("gdfgdfgdfg",rid);
}
		
		
		
		
		
		@RequestMapping("/all")
public @ResponseBody List<Movie> allmovie(){
		
	List<Movie> lst = Arrays.asList(new Movie("4","gfhgf"),new Movie("4","gfhgf"),new Movie("4","gfhgf"));


	return lst;
}		
	
		@RequestMapping("/")
public String index() {
	
	return "index";
}
		
		
	
	
}
