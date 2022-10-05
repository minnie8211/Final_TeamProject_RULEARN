package com.web.home.studyboard.comment.model;

public class StudyCommentIdDTO {
	private int sc_bId;				// 학습 게시글 아이디(자동생성)

	public int getSc_bId() {
		return sc_bId;
	}

	public void setSc_bId(int sc_bId) {
		this.sc_bId = sc_bId;
	}

	@Override
	public String toString() {
		return "StudyCommentIdDTO [sc_bId=" + sc_bId + "]";
	}
	
}
