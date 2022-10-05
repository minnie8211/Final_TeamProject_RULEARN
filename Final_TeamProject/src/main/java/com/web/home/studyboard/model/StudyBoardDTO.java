package com.web.home.studyboard.model;

import java.sql.Date;

public class StudyBoardDTO {
	private int sb_bId;			//게시글 아이디(자동생성)
	private String sb_wId;		//게시글 작성자 아이디
	private String sb_wName;	//게시글 작성자 닉네임
	private int sb_catId;		//카테고리 분류
	private String sb_title;	//게시글 제목
	private String sb_content;	//게시글 내용
	private int sb_like;		//게시글 추천수
	private boolean sb_isDone;	//모집중 or 모집완료
	private Date sb_date;		//게시글 작성일
	private int total_reply;	//게시글에 달린 댓글의 수
	
	public int getSb_bId() {
		return sb_bId;
	}
	
	public void setSb_bId(int sb_bId) {
		this.sb_bId = sb_bId;
	}
	
	public String getSb_wId() {
		return sb_wId;
	}
	
	public void setSb_wId(String sb_wId) {
		this.sb_wId = sb_wId;
	}
	
	public String getSb_wName() {
		return sb_wName;
	}
	
	public void setSb_wName(String sb_wName) {
		this.sb_wName = sb_wName;
	}
	
	public int getSb_catId() {
		return sb_catId;
	}
	
	public void setSb_catId(int sb_catId) {
		this.sb_catId = sb_catId;
	}
	
	public String getSb_title() {
		return sb_title;
	}
	
	public void setSb_title(String sb_title) {
		this.sb_title = sb_title;
	}
	
	public String getSb_content() {
		return sb_content;
	}
	
	public void setSb_content(String sb_content) {
		this.sb_content = sb_content;
	}
	
	public int getSb_like() {
		return sb_like;
	}
	
	public void setSb_like(int sb_like) {
		this.sb_like = sb_like;
	}

	public boolean isSb_isDone() {
		return sb_isDone;
	}

	public void setSb_isDone(boolean sb_isDone) {
		this.sb_isDone = sb_isDone;
	}

	public Date getSb_date() {
		return sb_date;
	}
	
	public void setSb_date(Date sb_date) {
		this.sb_date = sb_date;
	}

	public int getTotal_reply() {
		return total_reply;
	}

	public void setTotal_reply(int total_reply) {
		this.total_reply = total_reply;
	}

	@Override
	public String toString() {
		return "StudyBoardDTO [sb_bId=" + sb_bId + ", sb_wId=" + sb_wId + ", sb_wName=" + sb_wName + ", sb_catId="
				+ sb_catId + ", sb_title=" + sb_title + ", sb_content=" + sb_content + ", sb_like=" + sb_like
				+ ", sb_isDone=" + sb_isDone + ", sb_date=" + sb_date + ", total_reply=" + total_reply + "]";
	}

}
