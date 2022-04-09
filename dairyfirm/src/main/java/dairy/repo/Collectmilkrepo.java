package dairy.repo;
import java.util.Date;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import dairy.model.Collectmilk;

public interface Collectmilkrepo extends JpaRepository<Collectmilk,Long> {

	public boolean existsByAnidAndStringcollectdate(int x,String d);
	public List<Collectmilk> findByRateOrderByCollectdateDesc(float t);
	public List<Collectmilk> findByAnidOrderByCollectdateDesc(Integer t);
	public List<Collectmilk> findByStringcollectdateContaining(String d);
	public List<Collectmilk> findByCollectdate(Date d);
}
