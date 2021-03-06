package movieinfo.resource;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.reactive.function.client.WebClient;

import movieinfo.model.Movie;
import movieinfo.model.Rating;

@RestController
@RequestMapping("movies/")
public class Movieresource {
	@Autowired
    WebClient.Builder builder = WebClient.builder();
	@Autowired
	RestTemplate rt ;
	
	@RequestMapping("/{mid}")
	public Movie getmovieinfo(@PathVariable String mid) {
		
		return new Movie(mid, "Tere Naam");
	}
	
	
	
	
	@RequestMapping("/rate/{rate}")
	public Rating getmovierating(@PathVariable String rate) {
	
		Rating ra=rt.getForObject("http://catalog-service/catalog/rate/"+rate,Rating.class);
		
		//Rating ra=builder.build().get().uri("catalog-service/catalog/rate"+rate).retrieve()
			   //  .bodyToMono(Rating.class).block();
		
		return ra;
		
	}
	
	
	
	@RequestMapping("/all")
	public @ResponseBody List<Movie> getmovierating() {
	
		List<Movie> mv=rt.getForObject("http://catalog-service/catalog/all",List.class);
				//getForObject("http://catalog-service/catalog/allmovie/", List.class);
		
		//Rating ra=builder.build().get().uri("movie-rating-service/ratings/"+rate).retrieve()
			    // .bodyToMono(Rating.class).block();
		
		return mv;
		
	}
	
	
	
	
	
	
	
}
