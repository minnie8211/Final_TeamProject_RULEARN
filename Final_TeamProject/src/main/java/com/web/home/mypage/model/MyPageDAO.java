package com.web.home.mypage.model;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.web.home.account.model.AccountDTO;

@Repository
public class MyPageDAO {
	
	@Autowired
	private SqlSession session;
	
	private String mapper = "myPageMapper.%s";
	
	// 회원 정보 수정
	public boolean updateAccount(AccountDTO data) {
		String mapperId = String.format(mapper, "updateAccount");
		int res = session.update(mapperId, data);
		return res == 1 ? true : false;
	}
	
	// 회원탈퇴
	public boolean deleteAccount(AccountDTO data) {
		String mapperId = String.format(mapper, "deleteAccount");
		int res = session.delete(mapperId, data);
		return res == 1 ? true : false;
	}
	
	// 패스워드 체크
	public int passChk(AccountDTO data) throws Exception {
		String mapperId = String.format(mapper, "passChk");
		int res = session.selectOne(mapperId, data);
		return res;
	}
	
}
