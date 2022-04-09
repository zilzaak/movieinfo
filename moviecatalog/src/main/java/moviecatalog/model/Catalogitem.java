package moviecatalog.model;

public class Catalogitem {
private String name;
private String desc;
private int rating;
public String getName() {
	return name;
}
public void setName(String name) {
	this.name = name;
}
public String getDesc() {
	return desc;
}
public void setDesc(String desc) {
	this.desc = desc;
}
public int getRating() {
	return rating;
}
public void setRating(int rating) {
	this.rating = rating;
}
public Catalogitem(String name, String desc, int rating) {
	super();
	this.name = name;
	this.desc = desc;
	this.rating = rating;
}
public Catalogitem() {
	super();
	// TODO Auto-generated constructor stub
}


}
