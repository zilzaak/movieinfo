package kasba.shop.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

@Table
@Entity
public class Adminmail {

	private int id;
	private String email;
	private String password;
	
	
	@Id
	@GeneratedValue
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public Adminmail() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Adminmail(String email, String password) {
		super();
		this.email = email;
		this.password = password;
	}
	
	
	
}
