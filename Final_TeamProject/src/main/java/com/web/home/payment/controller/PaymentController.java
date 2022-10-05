package com.web.home.payment.controller;

import java.io.IOException;
import java.sql.Date;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.fasterxml.jackson.databind.JsonNode;
import com.web.home.account.model.AccountDTO;
import com.web.home.mypage.model.VirtualAccountInfoVO;
import com.web.home.mypage.model.WishlistDTO;
import com.web.home.mypage.service.WishlistService;
import com.web.home.payment.model.PayDAO;
import com.web.home.payment.model.PaymentDTO;
import com.web.home.payment.service.PayRestService;

@Controller
@RequestMapping(value = "")
public class PaymentController {
	@Autowired
	private PayRestService restService;
	@Autowired
	private WishlistService wishListService;
	
	private String secret = new String();
	private JsonNode successNode;

	@RequestMapping(value = "/success")
	public String requestPay_Auth(Model model,
								  @SessionAttribute("loginData")AccountDTO user,
								  @RequestParam String orderId,
								  @RequestParam String paymentKey,
								  @RequestParam Long amount) 
								  throws IllegalArgumentException, IOException, Exception{
		ResponseEntity<JsonNode> response = new ResponseEntity<JsonNode>(HttpStatus.OK);
		response = restService.requestPay_Confirm(orderId, amount, paymentKey);

		if (response.getStatusCode() == HttpStatus.OK) {
            successNode = response.getBody();
            String status = successNode.get("status").asText();
            
            //가상 계좌 결제일 떄
            if(status.equals("WAITING_FOR_DEPOSIT")) {
            	VirtualAccountInfoVO payload = restService.setTempVirtualAccountInfo(successNode);
          
            	// 가상계좌의 경우 입금 확인을 위해서 secret 항목 저장
            	secret = successNode.get("secret").asText();
            	
            	// 장바구니 삭제 처리 - 결제 완료 정보를 받지 못하므로 사용불가
        		//this.approveWishList(user.getAC_ID());
        		
        		//수강 중 강의로 처리 - 결제 완료 정보를 받지 못하므로 사용불가
        		//Integer[] itemArr = getItemArr(user.getAC_ID());
        		//restService.insertTakingLesson(itemArr, user.getAC_ID());
            	
            	model.addAttribute("result", "WAITING_FOR_DEPOSIT");
            	model.addAttribute("payload", payload);
            	
        	//카드 결제 일떄
            }else {
            	List<WishlistDTO> wish = wishListService.getWishList(user.getAC_ID());

            	//결제 정보 DB에 저장
            	String itemCode = this.inquireWishlist(wish);
            	boolean insertPay = restService.insertPaymentToss(successNode, user.getAC_ID(), itemCode);
            	if(!insertPay) {
            		System.out.println("결제 정보 DB 업로드가 개별적으로 필요합니다. ");
            	}

            	//수강 중 강의로 처리 itemArr-> int[]
            	Integer[] itemArr = getItemArr(wish);
            	restService.insertTakingLesson(itemArr, user.getAC_ID());
            	
        		// 장바구니 삭제 처리
        		this.approveWishList(wish);
        		
            	model.addAttribute("result", "DONE");
            	model.addAttribute("orderName", successNode.get("orderName").asText());
            }
            return "payment/tossPayResult";
        } else {
            _fail(response, model);
            model.addAttribute("error", "결제 요청 에러");
            return "error/payment_error";
        }
	}
	
	@RequestMapping(value = "/fail")
	public String request_Pay_Fail(@RequestParam String message, 
								   @RequestParam String code, 
								   Model model) {
		model.addAttribute("message", message);
		model.addAttribute("code", code);
		
		return "error/payment_error";
	}
	
	/*
	 * 이 callback 메서드는 외부에서 접근 가능한 ip주소일 때만 실행됨
	 * 따라서 배포 후에 확인 필요
	 */
	@RequestMapping("/virtual-account/callback")
    @ResponseStatus(HttpStatus.OK)
    public String handleVirtualAccountCallback(Model model,
    								@SessionAttribute("loginData")AccountDTO user,
    								@RequestBody VirtualAccountInfoVO payload) {
		//외부의 부적절한 요청/접근 제재
		if(secret.equals(payload.getSecret())) {
			//가상 계좌 입금 완료
	        if (payload.getStatus().equals("DONE")) {
            	wishListService.removeWishlist();
            	
            	//결제 정보 DB 올리기
            	List<WishlistDTO> wish = wishListService.getWishList(user.getAC_ID());
            	String itemCode = this.inquireWishlist(wish);
            	boolean insertPay = restService.insertPaymentToss(successNode, user.getAC_ID(), itemCode);
            	if(!insertPay) {
            		System.out.println("결제 정보 DB 업로드가 개별적으로 필요합니다. ");
            	}
	        	
	        	model.addAttribute("result", "DONE");
	        
	    	//가상 계좌 입금 취소
	        }else if(payload.getStatus().equals("CANCELED")) {
	        	// 입금 취소하면 위시리스트를 돌려놓을 것인지 물어보기
	        	
	        	model.addAttribute("result", "CANCELED");
	        }
	        return "mypage/myPageWishList" ;
	        
		}else {
			
			model.addAttribute("error", "결제 실패");
			model.addAttribute("message", "잘못된 접근 입니다.");
			model.addAttribute("code", HttpStatus.FORBIDDEN);
			return "error/payment_error";
		}
    }
	
	private void _fail(ResponseEntity<JsonNode> response, Model model) {
		JsonNode failNode = response.getBody();
        model.addAttribute("message", failNode.get("message").asText());
        model.addAttribute("code", failNode.get("code").asText());
	}
	
	// 장바구니 삭제 -> 삭제할 상품 id 준비
	private void approveWishList(List<WishlistDTO> wish) {
		// 기존의 장바구니 조회
		Integer[] itemArr = this.getItemArr(wish);
	    List<Integer> wishlist = Arrays.asList(itemArr);
	    
	    boolean res = wishListService.deleteWishList(wishlist);
	}
	
	private String inquireWishlist(List<WishlistDTO> wish) {
 	    String[] itemArr = new String[wish.size()];
 	    for(int i = 0; i < wish.size(); i++) {
 	    	itemArr[i] = Integer.toString(wish.get(i).getW_LID()); 
 	    }
 	    String itemCode = String.join("/", itemArr);
		return itemCode;
	}
	
	private Integer[] getItemArr(List<WishlistDTO> wish) {
		Integer[] itemArr = new Integer[wish.size()];
	    for(int i = 0; i < wish.size(); i++) {
	    	itemArr[i] = wish.get(i).getW_LID(); 
	    }
	    return itemArr;
	}
}
