package com.web.home.course.model;

import java.sql.Date;

public class ReviewDTO {
	private int rb_id;
	private String rb_wid;
	private int rb_lid;
	private String rb_content;
	private int rb_score;
	private Date rb_date;
	
	
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
	public int getRb_lid() {
		return rb_lid;
	}
	public void setRb_lid(int rb_lid) {
		this.rb_lid = rb_lid;
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
	public Date getRb_date() {
		return rb_date;
	}
	public void setRb_date(Date rb_date) {
		this.rb_date = rb_date;
	}
	
	@Override
	public String toString() {
		return "ReviewDTO [rb_id=" + rb_id + ", rb_wid=" + rb_wid + ", rb_lid=" + rb_lid + ", rb_content=" + rb_content
				+ ", rb_score=" + rb_score + ", rb_date=" + rb_date + "]";
	}
}
