package com.web.home.payment.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.TimeZone;
import java.util.stream.Stream;

import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.web.home.account.model.AccountDTO;
import com.web.home.payment.model.PayDAO;
import com.web.home.payment.model.PaymentDTO;
import com.web.home.payment.service.KaKaoPay;
import com.web.home.payment.service.PayRestService;
import com.web.home.payment.vo.KaKaoApproveVO;
import com.web.home.payment.vo.KaKaoReadyVO;

@Controller
@RequestMapping(value = "/kakaoPay")
public class KaKaoPayController {
	
	@Autowired
	private KaKaoPay kakaoPay;
	@Autowired
	private PayRestService restService;
	
	@Autowired
	private PayDAO dao;
	
//	@GetMapping(value = "")
//	public String kakaoPay(){
//		
//		return "/payment/ready";
//	}
	
	@SuppressWarnings("unchecked")
	@PostMapping(value = "/ready", produces = "application/json; charset=utf-8")
	@ResponseBody
	public String kakaoPayReady(Model model, HttpSession session,
			@RequestParam String order,
			@RequestParam String orderName,
			@RequestParam Long amount,
			@RequestParam int quantity){
		
		JSONObject json = new JSONObject();
		
		// 카카오페이에 파라미터를 설정하려면 모두 String으로 형변환 필요
		String total_amount = Long.toString(amount);
		String item_quantity = Integer.toString(quantity);
		
		System.out.println("주문번호 : " + order);
		System.out.println("amount :" + total_amount);
		System.out.println("orderName : " + orderName);
		System.out.println("수량 : " + item_quantity);
		
		// 상품 정보들을 전달
		KaKaoReadyVO ready = kakaoPay.PayReady(session, order, orderName, total_amount, item_quantity);
		
		json.put("next_redirect_pc_url", ready.getNext_redirect_pc_url());
		
		// "redirect:" + ready.getNext_redirect_pc_url().toString();
		return json.toJSONString();  
	}
	
	@GetMapping(value="/success", produces = "application/json; charset=utf-8")
	public String kakaoPaySuccess(HttpSession session,
			@RequestParam("pg_token") String pg_token, 
			Model model){
		
		System.out.println("pg_token : " + pg_token);
		
		// 결제 승인 데이터 반환받기
		KaKaoApproveVO approve = kakaoPay.PayApprove(pg_token);
		
		// 결제 승인 시각이 한국시간 +9 로 받기 때문에 한국 표준시로 변경
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		df.setTimeZone(TimeZone.getTimeZone("KST"));
		String kst = df.format(approve.getApproved_at());
		
		System.out.println("==============================");
		System.out.println("요청 고유 번호 : " + approve.getAid());
		System.out.println("결제 번호 : " + approve.getTid());
		System.out.println("가맹점 코드(TESTCODE) : " + approve.getCid());
		System.out.println("가맹점 주문번호 : " + approve.getPartner_order_id());
		System.out.println("가맹점 이름 : " + approve.getPartner_user_id());
		System.out.println("결제 수단 : " + approve.getPayment_method_type());
		System.out.println("상품 이름 : " + approve.getItem_name());
		System.out.println("상품 코드 : " + approve.getItem_code());
		System.out.println("상품 수량 : " + approve.getQuantity());
		System.out.println("결제 금액 : " + approve.getAmount().getTotal());
		System.out.println("결제 승인 시각 : " + kst);
		System.out.println("==============================");
		
		// 결제 정보를 DB에 저장
		// P_TID : 고유 결제 번호, P_ACID : 구매자(회원ID), 
		// P_ITEM_NAME : 결제 이름(ex 강의 A 외 2건), P_ITEM_CODE : 상품 식별자들
		// P_TOTAL_AMOUNT : 총 결제 금액, P_APPROVED_AT : 결제 날짜&시각
		AccountDTO loginData = (AccountDTO)session.getAttribute("loginData");
		PaymentDTO payData = new PaymentDTO();
		payData.setP_acid(loginData.getAC_ID());
		payData.setP_tid(approve.getTid());
		payData.setP_item_name(approve.getItem_name());
		payData.setP_item_code(approve.getItem_code());
		payData.setP_total_amount(approve.getAmount().getTotal());
		payData.setP_approved_at(kst); // insert 쿼리문에서 TO_DATE()를 이용하여 문자열을 DATE 형식으로 입력
		
		boolean insertPay = dao.insertPaymentData(payData);
		
		// 장바구니 삭제 DB 처리 필요(결제된 상품들 장바구니에서 삭제하기)
		// 결과가 성공해도 false가 나온다 => W_ID IN (2, 4, 5) 로 삭제처리해서 false가 나올때가 있는듯)
		boolean deleteList = kakaoPay.approveWishList(loginData.getAC_ID());
		
		// System.out.println("영수증 저장 여부 : " + insertPay);
		// System.out.println("장바구니 삭제 여부 : " + deleteList);
		
		//수강 중 강의로 처리
		Integer[] takingLessons = Stream.of(approve.getItem_code().split("/"))
										.mapToInt(Integer::parseInt)
										.boxed()
										.toArray(Integer[]::new);
		restService.insertTakingLesson(takingLessons, loginData.getAC_ID());
		
		// 필요한 페이지에 해당 정보 출력
		model.addAttribute("payResult", "success");
		model.addAttribute("payData", approve);
		
		return "/payment/kakaoPayResult";
		
	}
	
	// 결제 취소 
	@GetMapping(value="/cancel")
	public String kakaoPayCancel(Model model) {
		model.addAttribute("payResult", "cancel");
		
		
		return "/payment/kakaoPayResult"; 
	}
	
	// 결제 실패
	@GetMapping(value="/fail")
	public String kakaoPayfail(Model model) {
		model.addAttribute("payResult", "fail");
		
		return "/payment/kakaoPayResult";
	}
	

}
