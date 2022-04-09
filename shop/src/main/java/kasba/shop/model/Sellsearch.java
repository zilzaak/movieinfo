package kasba.shop.model;

import java.util.List;

public class Sellsearch {

	private float totalsell;
	private float due;
	private List<Productsell> psl;
	public float getTotalsell() {
		return totalsell;
	}
	public void setTotalsell(float totalsell) {
		this.totalsell = totalsell;
	}
	public float getDue() {
		return due;
	}
	public void setDue(float due) {
		this.due = due;
	}
	public List<Productsell> getPsl() {
		return psl;
	}
	public void setPsl(List<Productsell> psl) {
		this.psl = psl;
	}
	
	
	
	
}
