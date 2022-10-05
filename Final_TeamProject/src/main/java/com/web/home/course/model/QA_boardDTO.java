package com.web.home.course.model;

import java.sql.Date;

public class QA_boardDTO {
	private int qb_bid;
	private String qb_wid;
	private int qb_lid;
	private String qb_title;
	private String qb_content;
	private Date qb_date;
	
	public int getQb_bid() {
		return qb_bid;
	}
	public void setQb_bid(int qb_bid) {
		this.qb_bid = qb_bid;
	}
	public String getQb_wid() {
		return qb_wid;
	}
	public void setQb_wid(String qb_wid) {
		this.qb_wid = qb_wid;
	}
	public int getQb_lid() {
		return qb_lid;
	}
	public void setQb_lid(int qb_lid) {
		this.qb_lid = qb_lid;
	}
	public String getQb_title() {
		return qb_title;
	}
	public void setQb_title(String qb_title) {
		this.qb_title = qb_title;
	}
	public String getQb_content() {
		return qb_content;
	}
	public void setQb_content(String qb_content) {
		this.qb_content = qb_content;
	}
	public Date getQb_date() {
		return qb_date;
	}
	public void setQb_date(Date qb_date) {
		this.qb_date = qb_date;
	}
	
	@Override
	public String toString() {
		return "QA_boardDTO [qb_bid=" + qb_bid + ", qb_wid=" + qb_wid + ", qb_lid=" + qb_lid + ", qb_title=" + qb_title
				+ ", qb_content=" + qb_content + ", qb_date=" + qb_date + "]";
	}
	
}
