package com.web.home.common.util;

import java.util.regex.Pattern;

public class MatchPattern {

	// ID체크(영어,숫자 4 ~ 16자리)
	public boolean isAlphaNumber(String str) {
		return Pattern.matches("^[A-Za-z0-9]{4,16}$", str);
	}
	
	// 비밀번호체크(영어,숫자,특수문자 포함 최소8자)
	public boolean isAlphaNumberSpchar(String str) {
		return Pattern.matches("^(?=.*[A-Za-z])(?=.*[0-9])(?=.*[@$!%*#?&]).{8,}$", str);
	}
	
	// 핸드폰번호체크
	public boolean isMobile(String str) {
		return Pattern.matches("^010([0-9]{4})([0-9]{4})$", str);
	}
	
	// 이메일주소체크
	public boolean isEmail(String str) {
		return Pattern.matches("^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$", str);
	}
}
