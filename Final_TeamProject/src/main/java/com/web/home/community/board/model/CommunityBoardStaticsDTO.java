package com.web.home.community.board.model;

public class CommunityBoardStaticsDTO {
	private int cbs_id;
	private String cbs_wid;
	private int cbs_bid;
	private boolean cbs_liked;
	
	public int getCbs_id() {
		return cbs_id;
	}
	public void setCbs_id(int cbs_id) {
		this.cbs_id = cbs_id;
	}
	public String getCbs_wid() {
		return cbs_wid;
	}
	public void setCbs_wid(String cbs_wid) {
		this.cbs_wid = cbs_wid;
	}
	public int getCbs_bid() {
		return cbs_bid;
	}
	public void setCbs_bid(int cbs_bid) {
		this.cbs_bid = cbs_bid;
	}
	public boolean isCbs_liked() {
		return cbs_liked;
	}
	public void setCbs_liked(boolean cbs_liked) {
		this.cbs_liked = cbs_liked;
	}
	@Override
	public String toString() {
		return "CommunityBoardStaticsDTO [cbs_id=" + cbs_id + ", cbs_wid=" + cbs_wid + ", cbs_bid=" + cbs_bid
				+ ", cbs_liked=" + cbs_liked + "]";
	}
	
	
	
	

}
