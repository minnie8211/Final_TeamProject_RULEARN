package com.web.home.account.model;

public class AgreementDTO {
	private int ag_id;
	private String ag_acid;
	private int ag_tid;
	private boolean isagree;
	
	public int getAg_id() {
		return ag_id;
	}
	
	public void setAg_id(int ag_id) {
		this.ag_id = ag_id;
	}
	
	public String getAg_acid() {
		return ag_acid;
	}
	
	public void setAg_acid(String ag_acid) {
		this.ag_acid = ag_acid;
	}
	
	public int getAg_tid() {
		return ag_tid;
	}
	
	public void setAg_tid(int ag_tid) {
		this.ag_tid = ag_tid;
	}
	
	public boolean isIsagree() {
		return isagree;
	}
	
	public void setIsagree(boolean isagree) {
		this.isagree = isagree;
	}

	@Override
	public String toString() {
		return "AgreementDTO [ag_id=" + ag_id + ", ag_acid=" + ag_acid + ", ag_tid=" + ag_tid + ", isagree=" + isagree
				+ "]";
	}
}
