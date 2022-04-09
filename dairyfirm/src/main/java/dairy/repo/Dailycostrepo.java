package dairy.repo;
import java.util.Date;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import dairy.model.Dailycost;
public interface Dailycostrepo extends JpaRepository<Dailycost,Integer>{

	public List<Dailycost> findByCostdateBetween(Date d1,Date d2);
	public List<Dailycost> findByCostdate(Date d1);
	 public List<Dailycost> findByStringcostdateContaining(String ad);
	 public List<Dailycost> findByItemnameContaining(String ad);
	public boolean existsByItemnameIgnoreCaseAndStringcostdate(String itemname, String stringcostdate);
	
}
