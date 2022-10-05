package com.web.home.payment.service;

import java.io.IOException;
import java.net.URI;
import java.util.Arrays;
import java.util.Base64;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.http.client.ClientHttpResponse;
import org.springframework.stereotype.Service;
import org.springframework.web.client.ResponseErrorHandler;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.web.home.mypage.model.VirtualAccountInfoVO;
import com.web.home.mypage.model.WishlistDTO;
import com.web.home.payment.model.PayDAO;
import com.web.home.payment.model.PaymentDTO;


@Service
public class PayRestService {
	@Autowired
	private PayDAO dao;
	
	private final RestTemplate rest = new RestTemplate();
	private final ObjectMapper objectMapper = new ObjectMapper();
	private final String SECRET_KEY = "test_sk_N5OWRapdA8d5zyYLmEP3o1zEqZKL";
	
	private HttpHeaders fixHeader() {
		HttpHeaders headers = new HttpHeaders();
		headers.set("Authorization", 
					"Basic " + Base64.getEncoder().encodeToString((SECRET_KEY + ":").getBytes()));
		headers.setContentType(MediaType.APPLICATION_JSON);
		return headers;
	}
	
	@PostConstruct
	private void init() {
	    rest.setErrorHandler(new ResponseErrorHandler() {
			
			@Override
			public boolean hasError(ClientHttpResponse response) throws IOException {
				return false;
			}
			
			@Override
			public void handleError(ClientHttpResponse response) throws IOException {
			}
		});
	}
	
	public ResponseEntity<JsonNode> requestPay_Confirm(String orderId, 
													   Long amount, 
													   String paymentKey) 
												throws JsonProcessingException{
		URI uri = UriComponentsBuilder
					.fromUriString("https://api.tosspayments.com")
					.path("/v1/payments/confirm")
					.build()
					.toUri();
		Map<String, String> payloadMap = new HashMap<>();
		payloadMap.put("orderId", orderId);
		payloadMap.put("paymentKey", paymentKey);
		payloadMap.put("amount", String.valueOf(amount));
		
		HttpEntity<String> request 
					= new HttpEntity<>(objectMapper.writeValueAsString(payloadMap), fixHeader());
		
		return rest.postForEntity(uri, request, JsonNode.class);
	}

	public VirtualAccountInfoVO setTempVirtualAccountInfo(JsonNode jsonNode) 
													throws IllegalArgumentException, IOException{
		VirtualAccountInfoVO payload = new VirtualAccountInfoVO();
		
		payload.setmId(jsonNode.get("mId").asText());
		payload.setOrderName(jsonNode.get("orderName").asText());
		payload.setTotalAmount(jsonNode.get("totalAmount").asText());
		payload.setMethod(jsonNode.get("method").asText());
		payload.setRequestedAt(jsonNode.get("requestedAt").asText());
		payload.setOrderId(jsonNode.get("orderId").asText());
		payload.setVirtualAccount(jsonNode.get("virtualAccount"));
		
		return payload;
	}

	public boolean insertPaymentToss(JsonNode successNode, 
									 String userID, 
									 String itemCode) {
 	    
		PaymentDTO payData = new PaymentDTO();
		payData.setP_acid(userID);
		payData.setP_tid(successNode.get("orderId").asText());
		payData.setP_item_name(successNode.get("orderName").asText());
		payData.setP_item_code(itemCode);
		payData.setP_total_amount(successNode.get("totalAmount").asInt());
		payData.setP_approved_at(successNode.get("approvedAt").asText());
		
		System.out.println("=======================");
    	System.out.println(successNode.get("status").asText());
    	System.out.println("주문번호 : " + payData.getP_tid());
    	System.out.println("상품 이름 : " + payData.getP_item_name());
    	System.out.println("상품 코드 : " + itemCode);
    	System.out.println("결제 금액 : " + payData.getP_total_amount());
    	System.out.println("결제 승인 시각 : " + payData.getP_approved_at());
    	System.out.println("=======================");
		
		boolean insertPay = dao.insertPaymentToss(payData);
		
		return insertPay;
	}

	public void insertTakingLesson(Integer[] itemArr, String userID) {
		System.out.println(Arrays.toString(itemArr));
		int[] notProcessed = new int[itemArr.length];
		for(int i = 0; i < itemArr.length; i++) {
			Map<String, Object> registerTakingLesson = new HashMap<String, Object>();
			registerTakingLesson.put("lm_lid", itemArr[i]);
			registerTakingLesson.put("lm_wid", userID);

			boolean result = dao.insertTakingLesson(registerTakingLesson);
			notProcessed[i] = result == true ? 0 : itemArr[i];
			System.out.println("notProcessed[i] :" + notProcessed[i]);
		}
		
		System.out.println("0이 아닌 것은 수강 중인 강의로 등록 안된 강의 번호입니다.");
		System.out.println("=========================");
		System.out.println("회원 id: " + userID);
		System.out.println("수강 중 강의 등록 결과: " + Arrays.toString(notProcessed));
		System.out.println("=========================");
	}

}
