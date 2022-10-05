package com.web.home.admin.model;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.web.home.account.model.AccountDTO;
import com.web.home.account.model.RolesDTO;
import com.web.home.payment.model.PaymentDTO;

@Repository
public class AdminDAO {

	@Autowired
	private SqlSession session;
	
	private String mapper = "adminMapper.%s";
	
	public List<AccountDTO> selectAll() {
		String mapperId = String.format(mapper, "selectAll");
		List<AccountDTO> result = session.selectList(mapperId);
		return result;
	}
	
	public AccountDTO selectData(String id) {
		String mapperId = String.format(mapper, "selectData");
		AccountDTO result = session.selectOne(mapperId,id);
		return result;
	}

	public List<AccountDTO> selectAcgSort(int acgId) {
		String mapperId = String.format(mapper, "selectAcgSort");
		List<AccountDTO> result = session.selectList(mapperId, acgId) ;
		return result;
	}
	
	public List<AccountDTO> selectRoSort(int roId) {
		String mapperId = String.format(mapper, "selectRoSort");
		List<AccountDTO> result = session.selectList(mapperId, roId) ;
		return result;
	}

	public List<AccountDTO> selectSearch(String search) {
		String mapperId = String.format(mapper, "selectSearch");
		List<AccountDTO> result = session.selectList(mapperId, search) ;
		return result;
	}

	public List<RolesDTO> selectAllRole() {
		String mapperId = String.format(mapper, "selectAllRole");
		List<RolesDTO> result = session.selectList(mapperId) ;
		return result;
	}

	public boolean updateMemberData(AccountDTO data) {
		String mapperId = String.format(mapper, "updateMemberData");
		int result = session.update(mapperId, data);
		return result == 1 ? true : false;
	}

	public List<PaymentDTO> selectPaymentAll() {
		String mapperId = String.format(mapper, "selectPaymentAll");
		List<PaymentDTO> result = session.selectList(mapperId);
		return result;
	}

	public List<PaymentDTO> selectPaymentSearch(String search) {
		String mapperId = String.format(mapper, "selectPaymentSearch");
		List<PaymentDTO> result = session.selectList(mapperId, search);
		return result;
	}

	public boolean deleteMemberData(AccountDTO data) {
		String mapperId = String.format(mapper, "deleteMemberData");
		int result = session.delete(mapperId, data);
		return result == 1 ? true : false;
	}

}
