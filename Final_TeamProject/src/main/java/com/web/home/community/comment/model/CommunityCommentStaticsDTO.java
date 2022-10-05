package com.web.home.community.comment.model;

public class CommunityCommentStaticsDTO {
	
	private int ccs_id;		// 댓글 추천 제한정보 식별자
	private String ccs_wid;	// 해당 제한정보의 회원
	private int ccs_cid;	// 해당하는 댓글의 id
	private boolean ccs_liked;	// 해당 댓글을 추천했는지
	
	public int getCcs_id() {
		return ccs_id;
	}
	public void setCcs_id(int ccs_id) {
		this.ccs_id = ccs_id;
	}
	public String getCcs_wid() {
		return ccs_wid;
	}
	public void setCcs_wid(String ccs_wid) {
		this.ccs_wid = ccs_wid;
	}
	public int getCcs_cid() {
		return ccs_cid;
	}
	public void setCcs_cid(int ccs_cid) {
		this.ccs_cid = ccs_cid;
	}
	public boolean isCcs_liked() {
		return ccs_liked;
	}
	public void setCcs_liked(boolean ccs_liked) {
		this.ccs_liked = ccs_liked;
	}
	
	@Override
	public String toString() {
		return "CommunityCommentStaticsDTO [ccs_id=" + ccs_id + ", ccs_wid=" + ccs_wid + ", ccs_cid=" + ccs_cid
				+ ", ccs_liked=" + ccs_liked + "]";
	}
	
}
