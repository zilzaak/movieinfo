package dairy.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Table 
@Entity
public class Firmadmin {
	
	
private int adminid;
private String email;
private String gmailspass;
private String password;
private String code;
private String phone;

public String getCode() {
	return code;
}


public void setCode(String code) {
	this.code = code;
}


public String getEmail() {
	return email;
}


@Id
@GeneratedValue(strategy=GenerationType.IDENTITY)
public int getAdminid() {
	return adminid;
}
public void setAdminid(int adminid) {
	this.adminid = adminid;
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


public String getPhone() {
	return phone;
}


public void setPhone(String phone) {
	this.phone = phone;
}



public String getGmailspass() {
	return gmailspass;
}


public void setGmailspass(String gmailspass) {
	this.gmailspass = gmailspass;
}


public Firmadmin( String email, String password, String code, String phone,String gmailspass) {
	super();
	this.email = email;
	this.password = password;
	this.code = code;
	this.phone = phone;
	this.gmailspass=gmailspass;
}


public Firmadmin() {
	super();

}






}
