package kasba.shop.controller;

import java.util.List;

import kasba.shop.model.Sampal;

public class Shisab {

	private float total;
	private List<Sampal> sampals;
	public float getTotal() {
		return total;
	}
	public void setTotal(float total) {
		this.total = total;
	}
	
	public Shisab(float total, List<Sampal> sampals) {
		super();
		this.total = total;
		this.sampals = sampals;
	}
	
	public List<Sampal> getSampals() {
		return sampals;
	}
	public void setSampals(List<Sampal> sampals) {
		this.sampals = sampals;
	}
	public Shisab() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	
	
}
