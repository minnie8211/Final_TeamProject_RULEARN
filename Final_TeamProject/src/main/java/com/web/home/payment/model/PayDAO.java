package com.web.home.payment.model;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class PayDAO {
	@Autowired
	private SqlSession session;
	
	private String mapper = "paymentMapper.%s";
	
	// 결제 정보 조회
	public List<PaymentDTO> selectPaymentData(String p_acid){
		String mapperId = String.format(mapper, "selectPaymentData");
		List<PaymentDTO> res = session.selectList(mapperId, p_acid);
		
		return res;
	}
	// 결제 정보 추가(카카오페이)
	public boolean insertPaymentData(PaymentDTO data) {
		String mapperId = String.format(mapper, "insertPaymentKaKaoPay");
		int res = session.insert(mapperId, data);

		return res == 1 ? true : false;
	}
	
	// 결제 정보 추가(토스)
	public boolean insertPaymentToss(PaymentDTO data) {
		String mapperId = String.format(mapper, "insertPaymentTossPay");
		int res = session.insert(mapperId, data);

		return res == 1 ? true : false;
	}
	
	
	// 결제 정보 삭제
	public boolean deletePaymentData(PaymentDTO data) {
		String mapperId = String.format(mapper, "deletePaymentData");
		int res = session.insert(mapperId, data);

		return res == 1 ? true : false;
	}
	
	//결제 후 수강 중 강의로 등록
	public boolean insertTakingLesson(Map<String, Object> registerTakingLesson) {
		int res = session.insert("courseMapper.insertTakingLesson", registerTakingLesson);
		return res == 1 ? true : false;
	}
	
	
}
