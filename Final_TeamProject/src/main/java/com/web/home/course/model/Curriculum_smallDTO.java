package com.web.home.course.model;

public class Curriculum_smallDTO {
	private int cur_small_lid;
	private int cur_small_chapid;
	private int cur_small_curid;
	private String cur_small_title;
	private String cur_small_type;
	private String cur_small_running_time;
	
	
	public int getCur_small_lid() {
		return cur_small_lid;
	}
	public void setCur_small_lid(int cur_small_lid) {
		this.cur_small_lid = cur_small_lid;
	}
	public int getCur_small_chapid() {
		return cur_small_chapid;
	}
	public void setCur_small_chapid(int cur_small_chapid) {
		this.cur_small_chapid = cur_small_chapid;
	}
	public int getCur_small_curid() {
		return cur_small_curid;
	}
	public void setCur_small_curid(int cur_small_curid) {
		this.cur_small_curid = cur_small_curid;
	}
	public String getCur_small_title() {
		return cur_small_title;
	}
	public void setCur_small_title(String cur_small_title) {
		this.cur_small_title = cur_small_title;
	}
	public String getCur_small_type() {
		return cur_small_type;
	}
	public void setCur_small_type(String cur_small_type) {
		this.cur_small_type = cur_small_type;
	}
	public String getCur_small_running_time() {
		return cur_small_running_time;
	}
	public void setCur_small_running_time(String cur_small_running_time) {
		this.cur_small_running_time = cur_small_running_time;
	}
	@Override
	public String toString() {
		return "Curriculum_smallDTO [cur_small_lid=" + cur_small_lid + ", cur_small_chapid=" + cur_small_chapid
				+ ", cur_small_curid=" + cur_small_curid + ", cur_small_title=" + cur_small_title + ", cur_small_type="
				+ cur_small_type + ", cur_small_running_time=" + cur_small_running_time + "]";
	}
	
}
