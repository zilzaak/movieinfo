package moviecatalog.model;

public class Rating {
private String mid;
private int rating;
public String getMid() {
	return mid;
}
public void setMid(String mid) {
	this.mid = mid;
}
public int getRating() {
	return rating;
}
public void setRating(int rating) {
	this.rating = rating;
}
public Rating(String mid, int rating) {
	super();
	this.mid = mid;
	this.rating = rating;
}
public Rating() {
	super();
	// TODO Auto-generated constructor stub
}


}
