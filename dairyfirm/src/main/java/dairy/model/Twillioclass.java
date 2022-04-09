package dairy.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Table
@Entity
public class Twillioclass {

	private int tid;
	private String authtoken;
	private String sid;
	private String fromtwilio;
	private String tomy;
	private String active;
	private String addingdate;
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	public int getTid() {
		return tid;
	}
	public void setTid(int tid) {
		this.tid = tid;
	}
	
	
	public String getAuthtoken() {
		return authtoken;
	}
	public void setAuthtoken(String authtoken) {
		this.authtoken = authtoken;
	}
	public String getSid() {
		return sid;
	}
	public void setSid(String sid) {
		this.sid = sid;
	}
	public String getFromtwilio() {
		return fromtwilio;
	}
	public void setFromtwilio(String fromtwilio) {
		this.fromtwilio = fromtwilio;
	}
	public String getTomy() {
		return tomy;
	}
	public void setTomy(String tomy) {
		this.tomy = tomy;
	}
	
public String getActive() {
		return active;
	}
	public void setActive(String active) {
		this.active = active;
	}
		
	public String getAddingdate() {
		return addingdate;
	}
	public void setAddingdate(String addingdate) {
		this.addingdate = addingdate;
	}
	
	public Twillioclass(String authtoken, String sid, String fromtwilio, String tomy,String active,String addingdate) {
		super();
		this.authtoken = authtoken;
		this.sid = sid;
		this.fromtwilio = fromtwilio;
		this.tomy = tomy;
		this.active=active;
		this.addingdate=addingdate;
	}
	public Twillioclass() {
		super();
	
	}

	
	
	
}
