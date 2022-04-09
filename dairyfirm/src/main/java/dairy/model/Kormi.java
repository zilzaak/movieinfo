package dairy.model;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
@Table
@Entity
public class Kormi {
private int empid;
private String name;
private int age;
private String  nid;
private String phone;
private String address;
private float salary;
private Date joindate;
private String stringjoindate;
private String designation;
private String stringsalary;
private String leftdate;
private String activestatus;

@Id
@GeneratedValue(strategy=GenerationType.IDENTITY)
public int getEmpid() {
	return empid;
}
public void setEmpid(int empid) {
	this.empid = empid;
}
public String getName() {
	return name;
}
public void setName(String name) {
	this.name = name;
}
public int getAge() {
	return age;
}
public void setAge(int age) {
	this.age = age;
}
public String getNid() {
	return nid;
}
public void setNid(String nid) {
	this.nid = nid;
}
public String getPhone() {
	return phone;
}
public void setPhone(String phone) {
	this.phone = phone;
}
public String getAddress() {
	return address;
}
public void setAddress(String address) {
	this.address = address;
}
public float getSalary() {
	return salary;
}
public void setSalary(float salary) {
	this.salary = salary;
}
public Date getJoindate() {
	return joindate;
}
public void setJoindate(Date joindate) {
	this.joindate = joindate;
}
public String getStringjoindate() {
	return stringjoindate;
}
public void setStringjoindate(String stringjoindate) {
	this.stringjoindate = stringjoindate;
}
public String getDesignation() {
	return designation;
}
public void setDesignation(String designation) {
	this.designation = designation;
}
public Kormi(String name, int age, String nid, String phone, String address, float salary, Date joindate,
		String stringjoindate, String designation,String stringsalary,String leftdate,String activestatus) {
	super();
	this.name = name;
	this.age = age;
	this.nid = nid;
	this.phone = phone;
	this.address = address;
	this.salary = salary;
	this.joindate = joindate;
	this.stringjoindate = stringjoindate;
	this.designation = designation;
	this.stringsalary=stringsalary;
	this.activestatus = activestatus;
	this.leftdate = leftdate;
}

public Kormi() {
	super();

}

public String getStringsalary() {
	return stringsalary;
}
public void setStringsalary(String stringsalary) {
	this.stringsalary = stringsalary;
}
public String getLeftdate() {
	return leftdate;
}
public void setLeftdate(String leftdate) {
	this.leftdate = leftdate;
}
public String getActivestatus() {
	return activestatus;
}
public void setActivestatus(String activestatus) {
	this.activestatus = activestatus;
}


}
