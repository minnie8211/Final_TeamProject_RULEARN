package com.web.home.community.board.model;

public class CommunityLoadBoardVO {
	// 추가되거나 수정된 커뮤니티 게시글을 불러올 때 사용할 VO 객체입니다.
	// CKEDITOR 로 작성된 내용은 아래 변수명을 사용해야 에러가 없음
	private int id;			// 게시판 id(식별자)
	private int catid;		// 게시판 카테고리
	private String title;	// 게시판 제목
	private String content;	// 게시판 내용
							// 게시판 작성자는 따로 로그인 정보로 다룰 것
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getCatid() {
		return catid;
	}
	public void setCatid(int catid) {
		this.catid = catid;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	@Override
	public String toString() {
		return "CommunityAddBoardVO [id=" + id + ", catid=" + catid + ", title=" + title + ", content=" + content + "]";
	}
	
	
	

}
