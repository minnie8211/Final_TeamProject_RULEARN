package com.web.home.community.board.model;

import java.sql.Date;

public class CommunityBoardDTO {
	private int cb_bid;			// 게시판 id(식별자)
	private String cb_wid;		// 게시판 등록한 회원id(외래키) -> set 안됨
	private int cb_catid;		// 게시판 카테고리(외래키) -> 탭 이동? 가능?
	private String cb_title;	// 게시판 제목
	private String cb_content;	// 게시판 내용
	private int cb_like;		// 추천수
	private Date cb_date;		// 작성일 SYSDATE
	private int cb_commentNum;	// 댓글 숫자(DB테이블에 없는 변수) - get만 가능
	private String cb_nickName; // 게시글 작성자의 닉네임
	
	public String getCb_nickName() {
		return cb_nickName;
	}

	public int getCb_commentNum() {
		return cb_commentNum;
	}

	public int getCb_bid() {
		return cb_bid;
	}
	public void setCb_bid(int cb_bid) {
		this.cb_bid = cb_bid;
	}
	public String getCb_wid() {
		return cb_wid;
	}
	public void setCb_wid(String cb_wid) {
		this.cb_wid = cb_wid;
	}
	public int getCb_catid() {
		return cb_catid;
	}
	public void setCb_catid(int cb_catid) {
		this.cb_catid = cb_catid;
	}
	public String getCb_title() {
		return cb_title;
	}
	public void setCb_title(String cb_title) {
		this.cb_title = cb_title;
	}
	public String getCb_content() {
		return cb_content;
	}
	public void setCb_content(String cb_content) {
		this.cb_content = cb_content;
	}
	public int getCb_like() {
		return cb_like;
	}
	public void setCb_like(int cb_like) {
		this.cb_like = cb_like;
	}
	public Date getCb_date() {
		return cb_date;
	}
	public void setCb_date(Date cb_date) {
		this.cb_date = cb_date;
	}

	@Override
	public String toString() {
		return "CommunityBoardDTO [cb_bid=" + cb_bid + ", cb_wid=" + cb_wid + ", cb_catid=" + cb_catid + ", cb_title="
				+ cb_title + ", cb_content=" + cb_content + ", cb_like=" + cb_like + ", cb_date=" + cb_date
				+ ", cb_commentNum=" + cb_commentNum + ", cb_nickName=" + cb_nickName + "]";
	}
}
