package movieinfo.model;

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
	this.mid = mid;
	this.rating = rating;
}
public Rating() {

}


}
