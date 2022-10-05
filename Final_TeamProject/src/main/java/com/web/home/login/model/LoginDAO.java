package com.web.home.login.model;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.web.home.account.model.AccountDTO;

@Repository
public class LoginDAO {

	@Autowired
	private SqlSession session;
	
	private String mapper = "loginMapper.%s";
	
	public AccountDTO selectLogin(AccountDTO data) {
		String mapperId = String.format(mapper, "selectLogin");
		AccountDTO result = session.selectOne(mapperId, data);
		return result;
	}
	
	public boolean getAccountGroup(String id) {
		String mapperId = String.format(mapper, "getAccountGroup");
		int result = session.selectOne(mapperId, id);
		return result == 1 ? true : false;
	}
	
	public boolean emailAuthFail(String id) {
		String mapperId = String.format(mapper, "emailAuthFail");
		int result = session.selectOne(mapperId, id);
		return result == 1 ? true : false;
	}

	public AccountDTO selectId(AccountDTO data) {
		String mapperId = String.format(mapper, "selectId");
		AccountDTO result = session.selectOne(mapperId, data);
		return result;
	}

	public boolean updatePassword(AccountDTO data) {
		String mapperId = String.format(mapper, "updatePassword");
		int result = session.update(mapperId, data);
		return result == 1 ? true : false;
	}

	public AccountDTO selectLoginInfo(AccountDTO data) {
		String mapperId = String.format(mapper, "selectLoginInfo");
		AccountDTO result = session.selectOne(mapperId, data);
		return result;
	}

}
