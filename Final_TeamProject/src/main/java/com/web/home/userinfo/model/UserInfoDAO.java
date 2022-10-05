package com.web.home.userinfo.model;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.web.home.account.model.AccountDTO;

@Repository
public class UserInfoDAO {

	@Autowired
	private SqlSession session;
	private String mapper = "userInfoMapper.%s";
	
	public AccountDTO selectUserData(String wId) {
		// 회원 정보 조회
		String mapperId = String.format(mapper, "selectUserData");
		AccountDTO result = session.selectOne(mapperId, wId);
		return result;
	}
}
