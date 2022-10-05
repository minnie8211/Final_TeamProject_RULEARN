package com.web.home.studyboard.comment.model;

import java.sql.Date;

public class StudyCommentDTO {

	private int sc_id;				// 댓글 아이디(자동생성)
	private String sc_wId;			// 댓글 작성자 아이디
	private String sc_wName;		// 댓글 작성자 닉네임
	private int sc_bId;				// 학습 게시글 아이디(자동생성)
	private int sc_gId;				// 계층형 댓글 그룹
	private int sc_sort;			// 계층형 댓글 정렬
	private int sc_depth;			// 계층형 댓글 깊이
	private int sc_child;			// 자식 댓글 갯수
	private int sc_parents;			// 부모 댓글 아이디(sc_id)
	private String sc_parentsName;	// 부모 댓글 닉네임
	private String sc_content;		// 댓글 내용
	private boolean sc_deleted;		// 댓글 삭제 여부
	private int sc_like;			// 댓글 추천수
	private Date sc_date;			// 댓글 작성일
	
	public int getSc_id() {
		return sc_id;
	}
	
	public void setSc_id(int sc_id) {
		this.sc_id = sc_id;
	}
	
	public String getSc_wId() {
		return sc_wId;
	}
	
	public void setSc_wId(String sc_wId) {
		this.sc_wId = sc_wId;
	}
	
	public String getSc_wName() {
		return sc_wName;
	}
	
	public void setSc_wName(String sc_wName) {
		this.sc_wName = sc_wName;
	}
	
	public int getSc_bId() {
		return sc_bId;
	}
	
	public void setSc_bId(int sc_bId) {
		this.sc_bId = sc_bId;
	}
	
	public int getSc_gId() {
		return sc_gId;
	}
	
	public void setSc_gId(int sc_gId) {
		this.sc_gId = sc_gId;
	}
	
	public int getSc_sort() {
		return sc_sort;
	}
	
	public void setSc_sort(int sc_sort) {
		this.sc_sort = sc_sort;
	}
	
	public int getSc_depth() {
		return sc_depth;
	}
	
	public void setSc_depth(int sc_depth) {
		this.sc_depth = sc_depth;
	}
	
	public int getSc_child() {
		return sc_child;
	}

	public void setSc_child(int sc_child) {
		this.sc_child = sc_child;
	}

	public int getSc_parents() {
		return sc_parents;
	}

	public void setSc_parents(int sc_parents) {
		this.sc_parents = sc_parents;
	}
	
	public String getSc_parentsName() {
		return sc_parentsName;
	}

	public void setSc_parentsName(String sc_parentsName) {
		this.sc_parentsName = sc_parentsName;
	}

	public String getSc_content() {
		return sc_content;
	}
	
	public void setSc_content(String sc_content) {
		this.sc_content = sc_content;
	}
	
	public boolean isSc_deleted() {
		return sc_deleted;
	}
	
	public void setSc_deleted(boolean sc_deleted) {
		this.sc_deleted = sc_deleted;
	}
	
	public int getSc_like() {
		return sc_like;
	}
	
	public void setSc_like(int sc_like) {
		this.sc_like = sc_like;
	}
	
	public Date getSc_date() {
		return sc_date;
	}
	
	public void setSc_date(Date sc_date) {
		this.sc_date = sc_date;
	}

	@Override
	public String toString() {
		return "StudyCommentDTO [sc_id=" + sc_id + ", sc_wId=" + sc_wId + ", sc_wName=" + sc_wName + ", sc_bId="
				+ sc_bId + ", sc_gId=" + sc_gId + ", sc_sort=" + sc_sort + ", sc_depth=" + sc_depth + ", sc_child="
				+ sc_child + ", sc_parents=" + sc_parents + ", sc_parentsName=" + sc_parentsName + ", sc_content="
				+ sc_content + ", sc_deleted=" + sc_deleted + ", sc_like=" + sc_like + ", sc_date=" + sc_date + "]";
	}

}
