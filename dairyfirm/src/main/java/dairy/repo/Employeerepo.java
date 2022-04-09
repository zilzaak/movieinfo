package dairy.repo;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import dairy.model.Kormi;

public interface Employeerepo extends JpaRepository<Kormi,Integer>{

	boolean existsByNid(String nid);

	List<Kormi> findByNameContaining(String name);

	List<Kormi> findByPhoneContaining(String phone);

	List<Kormi> findByAddressContaining(String address);

	List<Kormi> findByStringsalaryContaining(String salary);

	List<Kormi> findByDesignationContaining(String designation);

	List<Kormi> findByActivestatus(String string);

}
