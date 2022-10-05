package com.web.home.course.model;

import java.sql.Date;

public class LessonManagerDTO {
	private int lm_id;
	private int lm_lid;
	private String lm_wid;
	private Date lm_date;
	
	public LessonManagerDTO() {};
	public LessonManagerDTO(String ac_ID, int id) {
		this.lm_wid = ac_ID;
		this.lm_lid = id;
	}
	public int getLm_id() {
		return lm_id;
	}
	public void setLm_id(int lm_id) {
		this.lm_id = lm_id;
	}
	public int getLm_lid() {
		return lm_lid;
	}
	public void setLm_lid(int lm_lid) {
		this.lm_lid = lm_lid;
	}
	public String getLm_wid() {
		return lm_wid;
	}
	public void setLm_wid(String lm_wid) {
		this.lm_wid = lm_wid;
	}
	public Date getLm_date() {
		return lm_date;
	}
	public void setLm_date(Date lm_date) {
		this.lm_date = lm_date;
	}
	
	@Override
	public String toString() {
		return "LessonManagerDTO [lm_id=" + lm_id + ", lm_lid=" + lm_lid + ", lm_wid=" + lm_wid + ", lm_date=" + lm_date
				+ "]";
	}
}
