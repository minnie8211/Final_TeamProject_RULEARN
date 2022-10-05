package com.web.home.community.comment.model;

import java.sql.Date;

public class CommunityCommentDTO {
	private int cc_id;		// 댓글 식별자(자동생성)
	private String cc_wid;	// 댓글 작성자(로그인 유저)
	private int cc_bid;		// 게시판 식별자(자동생성) - 외래키
	private int cc_gid;		// 댓글 그룹 id
	private int cc_sort;	// 댓글 순서(같은 그룹일때)
	private int cc_depth;	// 댓글 깊이
	private String cc_content;
	private boolean cc_deleted;
	private int cc_like;
	private Date cc_date;
	private int cc_child;	// 대댓글(자식 댓글 개수)
	private int cc_parents;	// 부모댓글의 id
	private String cc_nickName;
	
	
	public String getCc_nickName() {
		return cc_nickName;
	}
	public void setCc_nickName(String cc_nickName) {
		this.cc_nickName = cc_nickName;
	}
	public int getCc_child() {
		return cc_child;
	}
	public void setCc_child(int cc_child) {
		this.cc_child = cc_child;
	}
	public int getCc_parents() {
		return cc_parents;
	}
	public void setCc_parents(int cc_parents) {
		this.cc_parents = cc_parents;
	}
	public int getCc_id() {
		return cc_id;
	}
	public void setCc_id(int cc_id) {
		this.cc_id = cc_id;
	}
	public String getCc_wid() {
		return cc_wid;
	}
	public void setCc_wid(String cc_wid) {
		this.cc_wid = cc_wid;
	}
	public int getCc_bid() {
		return cc_bid;
	}
	public void setCc_bid(int cc_bid) {
		this.cc_bid = cc_bid;
	}
	public int getCc_gid() {
		return cc_gid;
	}
	public void setCc_gid(int cc_gid) {
		this.cc_gid = cc_gid;
	}
	public int getCc_sort() {
		return cc_sort;
	}
	public void setCc_sort(int cc_sort) {
		this.cc_sort = cc_sort;
	}
	public int getCc_depth() {
		return cc_depth;
	}
	public void setCc_depth(int cc_depth) {
		this.cc_depth = cc_depth;
	}
	public String getCc_content() {
		return cc_content;
	}
	public void setCc_content(String cc_content) {
		this.cc_content = cc_content;
	}
	public boolean isCc_deleted() {
		return cc_deleted;
	}
	public void setCc_deleted(boolean cc_deleted) {
		this.cc_deleted = cc_deleted;
	}
	public int getCc_like() {
		return cc_like;
	}
	public void setCc_like(int cc_like) {
		this.cc_like = cc_like;
	}
	public Date getCc_date() {
		return cc_date;
	}
	public void setCc_date(Date cc_date) {
		this.cc_date = cc_date;
	}
	@Override
	public String toString() {
		return "CommunityCommentDTO [cc_id=" + cc_id + ", cc_wid=" + cc_wid + ", cc_bid=" + cc_bid + ", cc_gid="
				+ cc_gid + ", cc_sort=" + cc_sort + ", cc_depth=" + cc_depth + ", cc_content=" + cc_content
				+ ", cc_deleted=" + cc_deleted + ", cc_like=" + cc_like + ", cc_date=" + cc_date + ", cc_child="
				+ cc_child + ", cc_parent=" + cc_parents + "]";
	}
	
	
}
