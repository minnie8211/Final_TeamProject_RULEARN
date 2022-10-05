package com.web.home.login.vo;

public class KakaoUserInfoVO {

	private String id;
	private String email;
	private String nickname;
	
	public String getId() {
		return id;
	}
	
	public void setId(String id) {
		this.id = id;
	}
	
	public String getEmail() {
		return email;
	}
	
	public void setEmail(String email) {
		this.email = email;
	}
	
	public String getNickname() {
		return nickname;
	}
	
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	@Override
	public String toString() {
		return "KakaoUserInfoVO [id=" + id + ", email=" + email + ", nickname=" + nickname + "]";
	}
}
