package com.web.home.course.model;

import java.sql.Date;

public class QA_answerDTO {
	private int qaa_lid;
	private String qaa_wid;
	private int qaa_bid;
	private String qaa_content;
	private Date qaa_date;
	
	
	public int getQaa_lid() {
		return qaa_lid;
	}
	public void setQaa_lid(int qaa_lid) {
		this.qaa_lid = qaa_lid;
	}
	public String getQaa_wid() {
		return qaa_wid;
	}
	public void setQaa_wid(String qaa_wid) {
		this.qaa_wid = qaa_wid;
	}
	public int getQaa_bid() {
		return qaa_bid;
	}
	public void setQaa_bid(int qaa_bid) {
		this.qaa_bid = qaa_bid;
	}
	public String getQaa_content() {
		return qaa_content;
	}
	public void setQaa_content(String qaa_content) {
		this.qaa_content = qaa_content;
	}
	public Date getQaa_date() {
		return qaa_date;
	}
	public void setQaa_date(Date qaa_date) {
		this.qaa_date = qaa_date;
	}
	
	@Override
	public String toString() {
		return "QA_answerDTO [qaa_lid=" + qaa_lid + ", qaa_wid=" + qaa_wid + ", qaa_bid=" + qaa_bid + ", qaa_content="
				+ qaa_content + ", qaa_date=" + qaa_date + "]";
	}
}
