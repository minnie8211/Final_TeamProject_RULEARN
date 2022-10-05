package com.web.home.studyboard.comment.model;

public class StudyCommentStaticsDTO {
	
	private int scs_id;			// 식별자 자동생성
	private String scs_wId;		// 추천을 누르는 사용자의 아이디
	private int scs_cId;		// 추천할 학습 댓글 아이디
	private boolean scs_liked;	// 추천 여부
	
	public int getScs_id() {
		return scs_id;
	}
	
	public void setScs_id(int scs_id) {
		this.scs_id = scs_id;
	}
	
	public String getScs_wId() {
		return scs_wId;
	}
	
	public void setScs_wId(String scs_wId) {
		this.scs_wId = scs_wId;
	}
	
	public int getScs_cId() {
		return scs_cId;
	}
	
	public void setScs_cId(int scs_cId) {
		this.scs_cId = scs_cId;
	}
	
	public boolean isScs_liked() {
		return scs_liked;
	}
	
	public void setScs_liked(boolean scs_liked) {
		this.scs_liked = scs_liked;
	}

	@Override
	public String toString() {
		return "StudyCommentStaticsDTO [scs_id=" + scs_id + ", scs_wId=" + scs_wId + ", scs_cId=" + scs_cId
				+ ", scs_liked=" + scs_liked + "]";
	}

}
