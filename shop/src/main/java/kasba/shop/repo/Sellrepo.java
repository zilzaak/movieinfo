package kasba.shop.repo;

import java.util.Date;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import kasba.shop.model.Productorder;
import kasba.shop.model.Productsell;

public interface Sellrepo extends JpaRepository<Productsell,Integer>{
	
	List<Productsell> findBySelldateBetweenOrderBySelldateDesc(Date d, Date d2);
	
	List<Productsell> findByStringselldateContainingOrderBySelldateDesc(String asik);
	
	List<Productsell> findBySelldateAfterOrderBySelldateDesc(Date d);
   
	List<Productsell> findByCompanyContainingIgnoreCaseOrderBySelldateDesc(String x);
	
    List<Productsell> findByProductnameContainingIgnoreCaseOrderBySelldateDesc(String x);

	List<Productsell> findByDueGreaterThanOrderBySelldateDesc(float i);

	List<Productsell> findBySelldateOrderBySelldateDesc(Date d);

}
