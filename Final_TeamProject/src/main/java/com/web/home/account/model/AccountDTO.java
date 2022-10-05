package com.web.home.account.model;

import java.sql.Date;

public class AccountDTO {

	private String AC_ID;
	private int AC_ROLE;
	private String AC_PW;
	private String AC_PW_ORIGIN;
	private String AC_NAME;
	private String AC_NICKNAME;
	private String AC_PHONE;
	private String AC_EMAIL;
	private Date AC_DATE;
	private int AC_GROUP;
	private int AC_MAIL_AUTH;
	private String AC_MAIL_KEY;
	private int RO_ID;
	private String RO_NAME;
	private int ACG_ID;
	private String ACG_NAME;

	public String getAC_ID() {
		return AC_ID;
	}
	public void setAC_ID(String aC_ID) {
		AC_ID = aC_ID;
	}
	public int getAC_ROLE() {
		return AC_ROLE;
	}
	public void setAC_ROLE(int aC_ROLE) {
		AC_ROLE = aC_ROLE;
	}
	public String getAC_PW() {
		return AC_PW;
	}
	public void setAC_PW(String aC_PW) {
		AC_PW = aC_PW;
	}
	public String getAC_PW_ORIGIN() {
		return AC_PW_ORIGIN;
	}
	public void setAC_PW_ORIGIN(String aC_PW_ORIGIN) {
		AC_PW_ORIGIN = aC_PW_ORIGIN;
	}
	public String getAC_NAME() {
		return AC_NAME;
	}
	public void setAC_NAME(String aC_NAME) {
		AC_NAME = aC_NAME;
	}
	public String getAC_NICKNAME() {
		return AC_NICKNAME;
	}
	public void setAC_NICKNAME(String aC_NICKNAME) {
		AC_NICKNAME = aC_NICKNAME;
	}
	public String getAC_PHONE() {
		return AC_PHONE;
	}
	public void setAC_PHONE(String aC_PHONE) {
		AC_PHONE = aC_PHONE;
	}
	public String getAC_EMAIL() {
		return AC_EMAIL;
	}
	public void setAC_EMAIL(String aC_EMAIL) {
		AC_EMAIL = aC_EMAIL;
	}
	public Date getAC_DATE() {
		return AC_DATE;
	}
	public void setAC_DATE(Date aC_DATE) {
		AC_DATE = aC_DATE;
	}
	
	public int getAC_GROUP() {
		return AC_GROUP;
	}
	public void setAC_GROUP(int aC_GROUP) {
		AC_GROUP = aC_GROUP;
	}
	
	public int getAC_MAIL_AUTH() {
		return AC_MAIL_AUTH;
	}

	public void setAC_MAIL_AUTH(int aC_MAIL_AUTH) {
		AC_MAIL_AUTH = aC_MAIL_AUTH;
	}

	public String getAC_MAIL_KEY() {
		return AC_MAIL_KEY;
	}

	public void setAC_MAIL_KEY(String aC_MAIL_KEY) {
		AC_MAIL_KEY = aC_MAIL_KEY;
	}
	
	public int getRO_ID() {
		return RO_ID;
	}
	public void setRO_ID(int rO_ID) {
		RO_ID = rO_ID;
	}
	public String getRO_NAME() {
		return RO_NAME;
	}
	public void setRO_NAME(String rO_NAME) {
		RO_NAME = rO_NAME;
	}
	public int getACG_ID() {
		return ACG_ID;
	}
	public void setACG_ID(int aCG_ID) {
		ACG_ID = aCG_ID;
	}
	public String getACG_NAME() {
		return ACG_NAME;
	}
	public void setACG_NAME(String aCG_NAME) {
		ACG_NAME = aCG_NAME;
	}
	
	@Override
	public String toString() {
		return "AccountDTO [AC_ID=" + AC_ID + ", AC_ROLE=" + AC_ROLE + ", AC_PW=" + AC_PW + ", AC_PW_ORIGIN="
				+ AC_PW_ORIGIN + ", AC_NAME=" + AC_NAME + ", AC_NICKNAME=" + AC_NICKNAME + ", AC_PHONE=" + AC_PHONE
				+ ", AC_EMAIL=" + AC_EMAIL + ", AC_DATE=" + AC_DATE + ", AC_GROUP=" + AC_GROUP + ", AC_MAIL_AUTH="
				+ AC_MAIL_AUTH + ", AC_MAIL_KEY=" + AC_MAIL_KEY + ", RO_ID=" + RO_ID + ", RO_NAME=" + RO_NAME
				+ ", ACG_ID=" + ACG_ID + ", ACG_NAME=" + ACG_NAME + "]";
	}
	
}