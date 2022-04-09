package dairy.repo;
import java.util.Date;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import dairy.model.Presitem;
public interface Presitemrepo extends JpaRepository<Presitem,Integer>{

	public List<Presitem> findByPrestypenumberGreaterThan(int ptn);

	public List<Presitem> findByDoctorContainingOrderByLastdateDesc(
			String doctorname);

	public List<Presitem> findByDrugtypeOrderByLastdateDesc(String doctorname);

	public List<Presitem> findByDrugnameContainingOrderByLastdateDesc(String doctorname);

	public List<Presitem> findByLastdateAfter(Date dt);

	public List<Presitem> findByLastdateBefore(Date dt);
	public boolean existsByItemid(int it);
	
}
