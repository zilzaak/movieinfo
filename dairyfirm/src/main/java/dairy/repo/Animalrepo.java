package dairy.repo;
import java.util.Date;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import dairy.model.Animal;

public interface Animalrepo extends JpaRepository<Animal,Integer>{

public List<Animal> findByFilename(String name);	
	public List<Animal> findByBdateBefore(Date d);
	public List<Animal> findAllByOrderByCreatedDesc();
	public List<Animal> findByTypeAndWeightLessThanAndWu(String type, float weight ,String wu);
	public List<Animal> findByTypeAndWeightLessThanAndWuAndColor(String type, float weight ,String wu,String color);
	
	public List<Animal> findByTypeAndWeightGreaterThanAndWu(String type, float weight ,String wu);
	public List<Animal> findByTypeAndWeightGreaterThanAndWuAndColor(String type, float weight ,String wu,String color);
	public List<Animal> findByTypeOrderByCreatedDesc(String type);
	public List<Animal> findByTypeAndColorOrderByCreatedDesc(String type,String color);
	public List<Animal> findBySource(String source);
	public boolean existsByAnidAndType(int i,String type);
	public boolean existsByAnid(int i);	
	public boolean existsBySource(String source);
	public List<Animal> findBySellstatus(String string);
	
	
	public List<Animal> findByTypeAndAgemGreaterThan(String type, float mt);
	public List<Animal> findByTypeAndAgemGreaterThanAndColor(String type, float agey, String color);
	public List<Animal> findByTypeAndAgemLessThan(String type, float ag);
	public List<Animal> findByTypeAndColorAndAgemLessThan(String type, String color, float ag);
	public List<Animal> findByTypeAndChestBetween(String type,float f1,float p2);
	public List<Animal> findByTypeAndChest(String type, float height);
	public List<Animal> findByTypeAndChestGreaterThan(String type, float height);
	public List<Animal> findByTypeAndChestLessThan(String type, float height);
	public List<Animal> findByCreatedstringContaining(String p);
	public List<Animal> findByCreated(String p);
	public List<Animal> findBySellernameContaining(String p);
	public List<Animal> findByJaatContaining(String p);
	public List<Animal> findByMarketnameContaining(String p);
	public List<Animal> findByCreatedBefore(Date parse);
	public List<Animal> findByCreatedAfter(Date parse);

}
