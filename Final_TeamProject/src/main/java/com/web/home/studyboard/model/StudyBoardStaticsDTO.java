package com.web.home.studyboard.model;

public class StudyBoardStaticsDTO {
	private int sbs_id;			//식별자 자동생성
	private String sbs_wId;		//추천을 누르는 사용자의 아이디
	private int sbs_bId;		//학습 게시물 아이디
	private boolean sbs_liked;	//추천 여부
	
	public int getSbs_id() {
		return sbs_id;
	}
	
	public void setSbs_id(int sbs_id) {
		this.sbs_id = sbs_id;
	}
	
	public String getSbs_wId() {
		return sbs_wId;
	}
	
	public void setSbs_wId(String sbs_wId) {
		this.sbs_wId = sbs_wId;
	}
	
	public int getSbs_bId() {
		return sbs_bId;
	}
	
	public void setSbs_bId(int sbs_bId) {
		this.sbs_bId = sbs_bId;
	}
	
	public boolean isSbs_liked() {
		return sbs_liked;
	}
	
	public void setSbs_liked(boolean sbs_liked) {
		this.sbs_liked = sbs_liked;
	}

	@Override
	public String toString() {
		return "StudyBoardStaticsDTO [sbs_id=" + sbs_id + ", sbs_wId=" + sbs_wId + ", sbs_bId=" + sbs_bId
				+ ", sbs_liked=" + sbs_liked + "]";
	}

}
