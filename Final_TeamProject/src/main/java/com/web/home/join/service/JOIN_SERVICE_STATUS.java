package com.web.home.join.service;

public enum JOIN_SERVICE_STATUS {
	SUCCESS(1, "성공"), FAILED(0, "실패"),
	ID_DUPLICATED(-1, "ID 중복 오류"),
	NICKNAME_DUPLICATED(-2, "닉네임 중복 오류"),
	EMAIL_DUPLICATED(-3, "이메일 중복 오류");
	
	public final int value;
	public final String msg;
	
	JOIN_SERVICE_STATUS(int value, String msg) {
		this.value = value;
		this.msg = msg;
	}

}
