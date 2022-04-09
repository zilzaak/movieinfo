package movieinfo.model;

public class Movie {
private String mid;
private String mname;
public String getMid() {
	return mid;
}
public void setMid(String mid) {
	this.mid = mid;
}
public String getMname() {
	return mname;
}
public Movie() {
	

}
public Movie(String mid, String mname) {

	this.mid = mid;
	this.mname = mname;
}
public void setMname(String mname) {
	this.mname = mname;
}



}
