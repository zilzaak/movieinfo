package dairy.repo;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import dairy.model.Twillioclass;

public interface Twiliorepo extends JpaRepository<Twillioclass,Integer> {

	List<Twillioclass> findByActive(String active);

	
}
