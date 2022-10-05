package com.web.home.join.model;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.web.home.account.model.AccountDTO;
import com.web.home.account.model.AgreementDTO;
import com.web.home.account.model.AgreementDTO;
import com.web.home.account.model.AgreementDTO;

@Repository
public class JoinDAO {

	@Autowired
	private SqlSession session;
	
	private String mapper = "joinMapper.%s";
	
	public int checkId(String id) {
		String mapperId = String.format(mapper, "checkId");
		int result = session.selectOne(mapperId, id);
		return result;
		
	}

	public int selectNickname(String nickname) {
		String mapperId = String.format(mapper, "selectNickname");
		int result = session.selectOne(mapperId, nickname);
		return result;
	}

	public int selectEmail(String email) {
		String mapperId = String.format(mapper, "selectEmail");
		int result = session.selectOne(mapperId, email);
		return result;
	}

	public boolean insertData(AccountDTO data) {
		String mapperId = String.format(mapper, "insertData");
		int result = session.insert(mapperId, data);
		return result == 1 ? true : false;
	}
	
	public int updateMailKey(AccountDTO data) {
		String mapperId = String.format(mapper, "updateMailkey");
		int result = session.update(mapperId, data);
		return result;
	}

	public boolean updateMailAuth(AccountDTO data) {
		String mapperId = String.format(mapper, "updateMailAuth");
		int result = session.update(mapperId, data);
		return result == 1 ? true : false;
	}
	
	public void updateKakaoMailAuth(AccountDTO data) {
		String mapperId = String.format(mapper, "updateKakaoMailAuth");
		session.update(mapperId, data);
	}

	public void insertAgree(AgreementDTO data) {
		String mapperId = String.format(mapper, "insertAgree");
		int result = session.insert(mapperId, data);
		
	}
}
