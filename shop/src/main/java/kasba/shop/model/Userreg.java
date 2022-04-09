package kasba.shop.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table
public class Userreg {
	
private int uid;	
private String email;
private String password;
private String code;

@Id
@GeneratedValue
public int getUid() {
	return uid;
}
public void setUid(int uid) {
	this.uid = uid;
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


public String getCode() {
	return code;
}
public void setCode(String code) {
	this.code = code;
}
public Userreg(String email, String password,String code) {
	super();
	this.email = email;
	this.password = password;
	this.code=code;
}
public Userreg() {
	super();

}


}
