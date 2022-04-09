package dairy.repo;
import java.util.Date;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import dairy.model.Collectmilk;
import dairy.model.Sellmilk;
public interface Sellmilkrepo extends JpaRepository<Sellmilk,Integer> {

	public List<Sellmilk> findBySelldate(Date d);
	public List<Sellmilk> findBySelldateBetween(Date d1 , Date d2);
	public List<Sellmilk> findByBuyernameContainingIgnoreCase(String bn);
	public List<Sellmilk> findByStringselldateContainingOrderBySelldateDesc(String y);
	public List<Sellmilk> findByContactContaining(String y);
	public List<Sellmilk> findByStringselldateContaining(String ad);

	
}
