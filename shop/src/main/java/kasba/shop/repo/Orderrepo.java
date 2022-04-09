package kasba.shop.repo;

import java.util.Date;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import kasba.shop.model.Productorder;

public interface Orderrepo extends JpaRepository<Productorder,Integer> {

	List<Productorder> findByOrderdateGreaterThanEqual(String dt);

	List<Productorder> findByOrderdateBetweenOrderByOrderdateDesc(Date d, Date d2);

	List<Productorder> findByStringorderdateContainingOrderByOrderdateDesc(String asik);

	List<Productorder> findByProductnameContainingIgnoreCaseOrderByOrderdateDesc(String x);


	List<Productorder> findByOrderdateAfterOrderByOrderdateDesc(Date d);

	List<Productorder> findByCompanyContainingIgnoreCaseOrderByOrderdateDesc(String x);

	List<Productorder> findByDueGreaterThanOrderByOrderdateDesc(float i);

	List<Productorder> findByOrderdateOrderByOrderdateDesc(Date d);



}
