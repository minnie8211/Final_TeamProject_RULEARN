package com.web.home.account.model;

public class RolesDTO {
	
	private int ro_id;
	private String ro_name;
	
	public int getRo_id() {
		return ro_id;
	}
	public void setRo_id(int ro_id) {
		this.ro_id = ro_id;
	}
	public String getRo_name() {
		return ro_name;
	}
	public void setRo_name(String ro_name) {
		this.ro_name = ro_name;
	}
	
	@Override
	public String toString() {
		return "RolesDTO [ro_id=" + ro_id + ", ro_name=" + ro_name + "]";
	}
}
