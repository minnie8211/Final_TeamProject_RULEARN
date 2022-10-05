package com.web.home.payment.service;

import java.net.InetAddress;
import java.net.UnknownHostException;
import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.web.home.account.model.AccountDTO;
import com.web.home.mypage.model.WishlistDAO;
import com.web.home.mypage.model.WishlistDTO;
import com.web.home.payment.vo.KaKaoApproveVO;
import com.web.home.payment.vo.KaKaoReadyVO;

@Service
public class KaKaoPay {
	
	/*
	https://developers.kakao.com/docs/latest/ko/kakaopay/single-payment#prepare
	 
	POST /v1/payment/ready HTTP/1.1
	Host: kapi.kakao.com
	Authorization: KakaoAK ${APP_ADMIN_KEY}
	Content-type: application/x-www-form-urlencoded;charset=utf-8
	 */
	
	// 고정 정보들
	private static String TEST_CID =  "TC0ONETIME";
	private static String KAKAOPAY_HOST = "https://kapi.kakao.com";
	private static String MY_HOST = "http://localhost/home";
	private static String ADMIN_KEY = "ae4920a634b9d61e61a0980488c1d65e";
	private static String PARTNER_ID = "RULearn";
	
	// 장바구니 조회
	@Autowired
	private WishlistDAO w_dao;
	
	// 요청자 쪽에서 저장할 변수(tid, partner_order_id를 따로 저장해야 한다)
	private String tid;
	private String partner_orderId;
	
	public String getTid() {
		return tid;
	}

	public void setTid(String tid) {
		this.tid = tid;
	}

	public String getPartner_orderId() {
		return partner_orderId;
	}

	public void setPartner_orderId(String partner_orderId) {
		this.partner_orderId = partner_orderId;
	}

	// header() 셋팅
	private HttpHeaders getHeaders() {
		HttpHeaders headers = new HttpHeaders();
		headers.set("Authorization", "KakaoAK " + ADMIN_KEY);
		headers.set("Content-type", MediaType.APPLICATION_FORM_URLENCODED_VALUE + ";charset=utf-8");
		
		return headers;
	}
	
	// 결제 요청
	public KaKaoReadyVO PayReady(HttpSession session, String orderId, String itemName, String amount, String quantity) {
	    
	    // 주문번호 저장 -> 결제 승인 후 해당 주문번호와 같아야 한다
	    this.setPartner_orderId(orderId);
	    
	    RestTemplate restTemplate = new RestTemplate();
	 	
	 	// item_code 만들기 장바구니를 조회해서 W_LID 이어 붙이기
	    AccountDTO user = (AccountDTO)session.getAttribute("loginData");
	    
	    List<WishlistDTO> wish = w_dao.getWishlist(user.getAC_ID());
	    String[] itemArr = new String[wish.size()];
	    for(int i = 0; i < wish.size(); i++) {
	    	itemArr[i] = Integer.toString(wish.get(i).getW_LID()); 
	    }
	    String itemCode = String.join("/", itemArr);
        
        // 서버로 요청할 Body
        MultiValueMap<String, String> params = new LinkedMultiValueMap<String, String>();
        params.add("cid", TEST_CID);			// 가맹점 코드(테스트 코드)
        params.add("partner_order_id", this.getPartner_orderId());	// 주문번호
        params.add("partner_user_id", PARTNER_ID); // 가맹점 회원 id
        params.add("item_name", itemName);	// 상품 이름
        params.add("item_code", itemCode);		// 상품 코드들
        params.add("quantity", quantity);			// 상품 수량
        params.add("total_amount", amount);	// 상품 금액
        params.add("tax_free_amount", "0");	// 비과세 금액
        params.add("approval_url", "http://localhost/home/kakaoPay/success"); // 결제 성공시 url "http://localhost:8080/home/kakaoPay/success"
        params.add("cancel_url", "http://localhost/home/kakaoPay/cancel"); // 
        params.add("fail_url", "http://localhost/home/kakaoPay/fail"); // 
        
 
        HttpEntity<MultiValueMap<String, String>> requestEntity = new HttpEntity<MultiValueMap<String, String>>(params, this.getHeaders());
	
        RestTemplate template = new RestTemplate();
		String url = "https://kapi.kakao.com/v1/payment/ready";
		
        // template으로 값을 보내고 받아온 ReadyResponse값 readyResponse에 저장.
		KaKaoReadyVO readyResponse = template.postForObject(url, requestEntity, KaKaoReadyVO.class);
		
		// 통신 후 받아온 tid는 결제 승인에 사용되기 때문에 따로 저장해둔다(pg_token은 api가 반환해준다)
		this.setTid(readyResponse.getTid());
		
		return readyResponse;
	}
	
	// 결제 승인
	public KaKaoApproveVO PayApprove(String pgToken) {
		
		RestTemplate restTemplate = new RestTemplate();
		
		MultiValueMap<String, String> params = new LinkedMultiValueMap<String, String>();
		params.add("cid", TEST_CID);
		params.add("tid", this.getTid());
		params.add("partner_order_id", this.getPartner_orderId());
		params.add("partner_user_id", PARTNER_ID);
		params.add("pg_token", pgToken);
		
		HttpEntity<MultiValueMap<String, String>> requestEntity = new HttpEntity<MultiValueMap<String, String>>(params, this.getHeaders());
		
        RestTemplate template = new RestTemplate();
		String url = "https://kapi.kakao.com/v1/payment/approve";
		
        // template으로 값을 보내고 받아온 ReadyResponse값 readyResponse에 저장.
		KaKaoApproveVO approveResponse = template.postForObject(url, requestEntity, KaKaoApproveVO.class);
		return approveResponse;
	}
	
	// 결제 승인 후 장바구니 삭제
	public boolean approveWishList(String ac_id) {
		// 기존의 장바구니 조회
		List<WishlistDTO> wish = w_dao.getWishlist(ac_id);
	    Integer[] itemArr = new Integer[wish.size()];
	    for(int i = 0; i < wish.size(); i++) {
	    	itemArr[i] = wish.get(i).getW_ID(); 
	    }
	    
	    List<Integer> wishlist = Arrays.asList(itemArr);
	    boolean res = w_dao.deleteWishlist(wishlist);
	    
	    return res;
	}

	

}
