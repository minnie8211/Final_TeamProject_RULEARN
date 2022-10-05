package com.web.home.course.model;

public class CourseDTO {
	private int l_id;
	private int l_catid;
	private String l_wid;
	private String l_title;
	private String l_content;
	private int l_price;
	private String l_thumbnail;
	private String l_lesson_category;
	
	private int amount;
	private float avg;
	
	
	public int getAmount() {
		return amount;
	}
	public void setAmount(int amount) {
		this.amount = amount;
	}
	public float getAvg() {
		return avg;
	}
	public void setAvg(float avg) {
		this.avg = avg;
	}
	public int getL_id() {
		return l_id;
	}
	public void setL_id(int l_id) {
		this.l_id = l_id;
	}
	public int getL_catid() {
		return l_catid;
	}
	public void setL_catid(int l_catid) {
		this.l_catid = l_catid;
	}
	public String getL_wid() {
		return l_wid;
	}
	public void setL_wid(String l_wid) {
		this.l_wid = l_wid;
	}
	public String getL_title() {
		return l_title;
	}
	public void setL_title(String l_title) {
		this.l_title = l_title;
	}
	public String getL_content() {
		return l_content;
	}
	public void setL_content(String l_content) {
		this.l_content = l_content;
	}
	public int getL_price() {
		return l_price;
	}
	public void setL_price(int l_price) {
		this.l_price = l_price;
	}
	public String getL_thumbnail() {
		return l_thumbnail;
	}
	public void setL_thumbnail(String l_thumbnail) {
		this.l_thumbnail = l_thumbnail;
	}
	public String getL_lesson_category() {
		return l_lesson_category;
	}
	public void setL_lesson_category(String l_lesson_category) {
		this.l_lesson_category = l_lesson_category;
	}
	@Override
	public String toString() {
		return "CourseDTO [l_id=" + l_id + ", l_catid=" + l_catid + ", l_wid=" + l_wid + ", l_title=" + l_title
				+ ", l_content=" + l_content + ", l_price=" + l_price + ", l_thumbnail=" + l_thumbnail
				+ ", l_lesson_category=" + l_lesson_category + ", amount=" + amount + ", avg=" + avg + "]";
	}
	
}
