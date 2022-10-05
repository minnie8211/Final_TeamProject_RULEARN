package com.web.home.course.vo;

public class ReviewVO {
	private int rb_id;
	private String rb_wid;
	private int rb_lid;
	private String rb_content;
	private int rb_score;
	
	
	public int getRb_lid() {
		return rb_lid;
	}
	public void setRb_lid(int rb_lid) {
		this.rb_lid = rb_lid;
	}
	public int getRb_id() {
		return rb_id;
	}
	public void setRb_id(int rb_id) {
		this.rb_id = rb_id;
	}
	public String getRb_wid() {
		return rb_wid;
	}
	public void setRb_wid(String rb_wid) {
		this.rb_wid = rb_wid;
	}
	public String getRb_content() {
		return rb_content;
	}
	public void setRb_content(String rb_content) {
		this.rb_content = rb_content;
	}
	public int getRb_score() {
		return rb_score;
	}
	public void setRb_score(int rb_score) {
		this.rb_score = rb_score;
	}
	
	@Override
	public String toString() {
		return "ReviewVO [rb_id=" + rb_id + ", rb_score=" + rb_score + ", rb_wid=" + rb_wid + ", rb_content="
				+ rb_content + "]";
	}
}
