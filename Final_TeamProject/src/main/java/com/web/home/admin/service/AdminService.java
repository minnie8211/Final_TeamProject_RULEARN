package com.web.home.admin.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.web.home.account.model.AccountDTO;
import com.web.home.account.model.RolesDTO;
import com.web.home.admin.model.AdminDAO;
import com.web.home.payment.model.PaymentDTO;

@Service
public class AdminService {
	
	@Autowired
	private AdminDAO dao;

	// 전체 회원 조회 (최근 가입순 정렬)
	public List<AccountDTO> getAll() {
		List<AccountDTO> datas = dao.selectAll();
		return datas;
	}
	
	// 아이디로 회원정보 조회
	public AccountDTO getData(String id) {
		AccountDTO data = dao.selectData(id);
		return data;
	}

	// 회원 조회(로그인 방법에 따른 분류)
	public List<AccountDTO> getAcgSort(int acgId) {
		List<AccountDTO> datas = dao.selectAcgSort(acgId);
		return datas;
	}
	
	// 회원 조회(권한에 따른 분류)
	public List<AccountDTO> getRoSort(int roId) {
		List<AccountDTO> datas = dao.selectRoSort(roId);
		return datas;
	}
	
	// 회원 검색(아이디/이름/닉네임/전화번호/이메일주소)
	public List<AccountDTO> getSearch(String search) {
		List<AccountDTO> datas = dao.selectSearch(search);
		return datas;
	}

	// 권한 카테고리 검색
	public List<RolesDTO> getAllRoleData() {
		List<RolesDTO> datas = dao.selectAllRole();
		return datas;
	}
	
	// 회원정보수정(권한수정)
	public boolean modifyMemberInfo(AccountDTO data) {
		boolean result = dao.updateMemberData(data);
		return result;
	}
	
	// 회원 삭제
	public boolean removeMemberInfo(AccountDTO data) {
		boolean result = dao.deleteMemberData(data);
		return result;
	}
	
	// 전체 수강 결제 정보 조회
	public List<PaymentDTO> getAllPayment() {
		List<PaymentDTO> datas = dao.selectPaymentAll();
		return datas;
	}

	// 수강 결제 정보 검색(주문번호/아이디/이름/수강과목명)
	public List<PaymentDTO> getSearchPayment(String search) {
		List<PaymentDTO> datas = dao.selectPaymentSearch(search);
		return datas;
	}
}
