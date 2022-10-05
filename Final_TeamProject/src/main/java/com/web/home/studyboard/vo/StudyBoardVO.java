package com.web.home.studyboard.vo;

public class StudyBoardVO {
	private int sb_bId;			//게시글 아이디(자동생성)
	private String sb_title;	//게시글 제목
	private String sb_content;	//게시글 내용
	private int sb_catId;		//카테고리 분류
	private boolean sb_isDone;	//모집중 or 모집완료
	
	public int getSb_bId() {
		return sb_bId;
	}
	
	public void setSb_bId(int sb_bId) {
		this.sb_bId = sb_bId;
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

	public int getSb_catId() {
		return sb_catId;
	}

	public void setSb_catId(int sb_catId) {
		this.sb_catId = sb_catId;
	}

	public boolean isSb_isDone() {
		return sb_isDone;
	}

	public void setSb_isDone(boolean sb_isDone) {
		this.sb_isDone = sb_isDone;
	}

	@Override
	public String toString() {
		return "StudyBoardVO [sb_bId=" + sb_bId + ", sb_title=" + sb_title + ", sb_content=" + sb_content
				+ ", sb_catId=" + sb_catId + ", sb_isDone=" + sb_isDone + "]";
	}

}
