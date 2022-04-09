package kasba.shop.repo;

import java.util.Date;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import kasba.shop.model.Sampal;

public interface Sampalrepo extends JpaRepository<Sampal,Integer>{

	List<Sampal> findBySampledateBetweenOrderBySampledateDesc(Date d, Date d2);

	List<Sampal> findBySampledateAfterOrderBySampledateDesc(Date d);

	List<Sampal> findBySampledate(Date d);

	
}
