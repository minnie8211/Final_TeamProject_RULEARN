package com.web.home.community.comment.model;

public class CommunityCommentIdDTO {
	private int cc_bid;		// 게시판 식별자(자동생성) - 외래키

	public int getCc_bid() {
		return cc_bid;
	}

	public void setCc_bid(int cc_bid) {
		this.cc_bid = cc_bid;
	}

	@Override
	public String toString() {
		return "CommunityCommentIdVO [cc_bid=" + cc_bid + "]";
	}
	
}
