package com.web.home.course.vo;

import java.sql.Date;

public class QnAVO {

	//QnA보드
	private int qb_lid;
	private int qb_bid;
	private String qb_wid;
	private String qb_title;
	private String qb_content;
	private Date qb_date;
	
	//QnA 답변
	private String qaa_wid;
	private String qaa_content;
	private Date qaa_date;
	
	
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
	public String getQaa_wid() {
		return qaa_wid;
	}
	public void setQaa_wid(String qaa_wid) {
		this.qaa_wid = qaa_wid;
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
		return "QnAVO [qb_lid=" + qb_lid + ", qb_bid=" + qb_bid + ", qb_wid=" + qb_wid + ", qb_title=" + qb_title
				+ ", qb_content=" + qb_content + ", qb_date=" + qb_date + ", qaa_wid=" + qaa_wid + ", qaa_content="
				+ qaa_content + ", qaa_date=" + qaa_date + "]";
	}
}