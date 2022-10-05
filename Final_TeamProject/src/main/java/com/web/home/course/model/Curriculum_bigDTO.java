package com.web.home.course.model;

public class Curriculum_bigDTO {
	private int cur_big_lid;
	private int cur_big_chapid;
	private String cur_big_title;
	
	
	public int getCur_big_lid() {
		return cur_big_lid;
	}
	public void setCur_big_lid(int cur_big_lid) {
		this.cur_big_lid = cur_big_lid;
	}
	
	
	public int getCur_big_chapid() {
		return cur_big_chapid;
	}
	public void setCur_big_chapid(int cur_big_chapid) {
		this.cur_big_chapid = cur_big_chapid;
	}
	public String getCur_big_title() {
		return cur_big_title;
	}
	public void setCur_big_title(String cur_big_title) {
		this.cur_big_title = cur_big_title;
	}
	@Override
	public String toString() {
		return "Curriculum_bigDTO [cur_big_lid=" + cur_big_lid + ", cur_big_chapid=" + cur_big_chapid
				+ ", cur_big_title=" + cur_big_title + "]";
	}
	
}
