package dairy.controller;

import org.springframework.web.multipart.MultipartFile;

public class Filehandle {

	private MultipartFile fl;
	private int anid;
	public MultipartFile getFl() {
		return fl;
	}
	public void setFl(MultipartFile fl) {
		this.fl = fl;
	}
	public int getAnid() {
		return anid;
	}
	public void setAnid(int anid) {
		this.anid = anid;
	}
	public Filehandle(MultipartFile fl, int anid) {
		super();
		this.fl = fl;
		this.anid = anid;
	}
	public Filehandle() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	
	
	
}
