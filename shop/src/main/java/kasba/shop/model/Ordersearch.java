package kasba.shop.model;

import java.util.List;

public class Ordersearch {
private float totalorder;
private float due;
private List<Productorder> pol;
public float getTotalorder() {
	return totalorder;
}
public void setTotalorder(float totalorder) {
	this.totalorder = totalorder;
}
public float getDue() {
	return due;
}
public void setDue(float due) {
	this.due = due;
}
public List<Productorder> getPol() {
	return pol;
}
public void setPol(List<Productorder> pol) {
	this.pol = pol;
}



}
