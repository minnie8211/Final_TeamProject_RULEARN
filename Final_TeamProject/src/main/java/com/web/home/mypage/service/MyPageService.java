package com.web.home.mypage.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.web.home.account.model.AccountDTO;
import com.web.home.mypage.model.MyPageDAO;

@Service
public class MyPageService {
	
	@Autowired
	private MyPageDAO dao;
	
	// 회원 정보 수정
	public boolean modify(AccountDTO data) {
		return dao.updateAccount(data);
		
	}
	
	// 회원 탈퇴
	public boolean AccountRemove(AccountDTO data) {
		return dao.deleteAccount(data);
	}
	
	// 패스워드 체크
	public int passChk(AccountDTO data) throws Exception {
		return dao.passChk(data);
	}
	
}