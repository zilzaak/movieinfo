package kasba.shop.model;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
@Table
@Entity
public class Productsell {
    private int sellid;
	private String stringselldate;
	private String company;
	private String productname;
	private Date selldate;
	private String amount;
	private float price;
	private float due;
	private String note;
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	public int getSellid() {
		return sellid;
	}
	public void setSellid(int sellid) {
		this.sellid = sellid;
	}
	public String getStringselldate() {
		return stringselldate;
	}
	public void setStringselldate(String stringselldate) {
		this.stringselldate = stringselldate;
	}

	public String getProductname() {
		return productname;
	}
	public void setProductname(String productname) {
		this.productname = productname;
	}
	public Date getSelldate() {
		return selldate;
	}
	public void setSelldate(Date selldate) {
		this.selldate = selldate;
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
	
	
public Productsell(String stringselldate,String productname, Date selldate,
			String amount, float price, float due, String note,String company) {
		super();
		this.stringselldate = stringselldate;

		this.productname = productname;
		this.selldate = selldate;
		this.amount = amount;
		this.price = price;
		this.due = due;
		this.note = note;
		this.company=company;
	}
	public Productsell() {
		super();
	
	}
	public float getDue() {
		return due;
	}
	public void setDue(float due) {
		this.due = due;
	}
	public String getNote() {
		return note;
	}
	public void setNote(String note) {
		this.note = note;
	}
	public String getCompany() {
		return company;
	}
	public void setCompany(String company) {
		this.company = company;
	}
	
	
	
}
