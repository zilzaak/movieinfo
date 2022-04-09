package kasba.shop.model;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Table
@Entity
public class Productorder {

	private int id;
	private String productname;
	private String company;
	private float due;
	private String amount;
	private float price;
	private String stringorderdate;
	private Date orderdate;
	private String note;
	

	
	public Productorder(String productname, String company, float due, String amount, float price,
			String stringorderdate, Date orderdate, String note) {
		super();
		this.productname = productname;
		this.company = company;
		this.due = due;
		this.amount = amount;
		this.price = price;
		this.stringorderdate = stringorderdate;
		this.orderdate = orderdate;
		this.note = note;
	}
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
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
	public String getStringorderdate() {
		return stringorderdate;
	}
	public void setStringorderdate(String stringorderdate) {
		this.stringorderdate = stringorderdate;
	}
	public Date getOrderdate() {
		return orderdate;
	}
	public void setOrderdate(Date orderdate) {
		this.orderdate = orderdate;
	}
	
	
	
	


	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}

	public Productorder() {
		super();
		
	}

	public String getCompany() {
		return company;
	}

	public void setCompany(String company) {
		this.company = company;
	}

	public float getDue() {
		return due;
	}

	public void setDue(float due) {
		this.due = due;
	}
	
	
	
}
