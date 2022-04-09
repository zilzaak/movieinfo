package kasba.shop.controller;



public class Hisab {

	private float totalorder;
	private float totalsell;
	
	private float orderdue;
	
	private float selldue;
	private float profit;
	

	
	public float getTotalorder() {
		return totalorder;
	}

	public void setTotalorder(float totalorder) {
		this.totalorder = totalorder;
	}

	public float getTotalsell() {
		return totalsell;
	}

	public void setTotalsell(float totalsell) {
		this.totalsell = totalsell;
	}

	public float getOrderdue() {
		return orderdue;
	}

	public void setOrderdue(float orderdue) {
		this.orderdue = orderdue;
	}

	public float getSelldue() {
		return selldue;
	}

	public void setSelldue(float selldue) {
		this.selldue = selldue;
	}

	public float getProfit() {
		return profit;
	}

	public void setProfit(float profit) {
		this.profit = profit;
	}

	public Hisab(float totalorder, float totalsell, float orderdue, float selldue, float profit) {
		super();
		this.totalorder = totalorder;
		this.totalsell = totalsell;
		this.orderdue = orderdue;
		this.selldue = selldue;
		this.profit = profit;
	}

	public Hisab() {
		super();
		
	}


	
	
	
}
