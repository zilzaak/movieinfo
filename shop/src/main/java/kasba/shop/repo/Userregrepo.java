package kasba.shop.repo;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import kasba.shop.model.Userreg;

public interface Userregrepo extends JpaRepository<Userreg,Integer>{

	public boolean existsByEmail(String email);
	public boolean existsByEmailAndPassword(String email, String password);
	public List<Userreg> findByEmail(String email);
	public boolean existsByPassword(String pass);

}
