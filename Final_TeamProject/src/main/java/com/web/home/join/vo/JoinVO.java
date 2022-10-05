package com.web.home.join.vo;

import java.sql.Date;

public class JoinVO {

	private String id;
	private String password;
	private String passwordChk;
	private String name;
	private String nickname;
	private String phone;
	private String email;
	private int acgroup;
	private int role;
	private Date createDate;
	
	public String getId() {
		return id;
	}
	
	public void setId(String id) {
		this.id = id;
	}
	
	public String getPassword() {
		return password;
	}
	
	public void setPassword(String password) {
		this.password = password;
	}
	
	public String getPasswordChk() {
		return passwordChk;
	}

	public void setPasswordChk(String passwordChk) {
		this.passwordChk = passwordChk;
	}

	public String getName() {
		return name;
	}
	
	public void setName(String name) {
		this.name = name;
	}
	
	public String getNickname() {
		return nickname;
	}
	
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	
	public String getPhone() {
		return phone;
	}
	
	public void setPhone(String phone) {
		this.phone = phone;
	}
	
	public String getEmail() {
		return email;
	}
	
	public void setEmail(String email) {
		this.email = email;
	}
	
	public int getAcgroup() {
		return acgroup;
	}

	public void setAcgroup(int acgroup) {
		this.acgroup = acgroup;
	}

	public int getRole() {
		return role;
	}

	public void setRole(int role) {
		this.role = role;
	}

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	@Override
	public String toString() {
		return "JoinVO [id=" + id + ", password=" + password + ", passwordChk=" + passwordChk + ", name=" + name
				+ ", nickname=" + nickname + ", phone=" + phone + ", email=" + email + ", acgroup=" + acgroup
				+ ", role=" + role + ", createDate=" + createDate + "]";
	}
}
