package kasba.shop.model;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class Sampal {

private int sid;
private String productname;
private String amount;
private float price;
private String stringsampledate;
private Date sampledate;

@Id
@GeneratedValue(strategy=GenerationType.IDENTITY)
public int getSid() {
	return sid;
}
public void setSid(int sid) {
	this.sid = sid;
}
public String getProductname() {
	return productname;
}
public void setProductname(String productname) {
	this.productname = productname;
}
public String getAmount() {
	return amount;
}
public void setAmount(String amount) {
	this.amount = amount;
}
public float getPrice() {
	return price;
}
public void setPrice(float price) {
	this.price = price;
}
public String getStringsampledate() {
	return stringsampledate;
}
public void setStringsampledate(String stringsampledate) {
	this.stringsampledate = stringsampledate;
}
public Date getSampledate() {
	return sampledate;
}
public void setSampledate(Date sampledate) {
	this.sampledate = sampledate;
}
public Sampal(String productname, String amount, float price, String stringsampledate, Date sampledate) {
	super();
	this.productname = productname;
	this.amount = amount;
	this.price = price;
	this.stringsampledate = stringsampledate;
	this.sampledate = sampledate;
}
public Sampal() {
	super();
	// TODO Auto-generated constructor stub
}

	
}
