package dairy.repo;
import java.util.Date;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import dairy.model.Pregnantreport;

public interface Pregnantreportrepo extends JpaRepository<Pregnantreport,Integer> {

	public List<Pregnantreport> findByAnid(int anid);
	public boolean existsByAnidAndStringconcivedate(int anid,String condate);
	public List<Pregnantreport> findByPossibledateAfter(Date d2);
	public List<Pregnantreport> findByType(String type);
	public List<Pregnantreport> findByStringconcivedateContaining(String concive);
	public List<Pregnantreport> findByConcivedate(Date d);
	public List<Pregnantreport> findByConcivedateBetween(Date d1, Date d2);
	public List<Pregnantreport> findByStringpossibledateContaining(String concive);
	public List<Pregnantreport> findByPossibledate(Date d);
	public List<Pregnantreport> findByPossibledateBetween(Date d1, Date d2);
	
  }
