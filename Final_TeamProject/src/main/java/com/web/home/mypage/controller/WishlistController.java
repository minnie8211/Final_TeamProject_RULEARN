package com.web.home.mypage.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.web.home.account.model.AccountDTO;
import com.web.home.common.util.Paging;
import com.web.home.mypage.model.WishlistDTO;
import com.web.home.mypage.service.WishlistService;

@Controller
@RequestMapping("/mypage")
public class WishlistController {
	
	@Autowired
	private WishlistService wishlistService;

	
	/* 장바구니 추가 */
	/**
	 * 0: 등록 실패
	 * 1: 등록 성공
	 * 2: 등록된 데이터 존재
	 */
	@PostMapping("/wishlist/add")
	@ResponseBody
	public String addCartPOST(@RequestParam int l_id,
							  @SessionAttribute("loginData")AccountDTO accounDto,
							  @RequestParam(defaultValue="0", required = false) int direct) {
		// 카트 등록
		int result = wishlistService.addWish(l_id, accounDto.getAC_ID());
		
		//수강바구니로 바로 이동하기
		if(direct == 3) {
			result = 3;
		}
		JSONObject json = new JSONObject();
		if(result == 1) {
			json.put("result", "success");
			json.put("msg", "장바구니 등록에 되었습니다.");
		}else if(result == 2){
			json.put("result", "alreadyExist");
			json.put("msg", "장바구니 등록에 실패하였습니다. 다시 시도해 주세요.");
		}else if(result == 3){
			json.put("result", "goToCart");
		}else{
			json.put("result", "fail");
			json.put("msg", "장바구니 등록에 실패하였습니다. 다시 시도해 주세요.");
		}
		
		return json.toJSONString();
	}	
	
	/* 장바구니 페이지 이동 */   
   @GetMapping("/wishlist/{W_ACID}")
   public String cartPageGET(@PathVariable("W_ACID") String W_ACID
         , Model model
         , @RequestParam(defaultValue="1", required=false) int page
         , @RequestParam(defaultValue="5", required=false) int pageCount) {
      
      List data = wishlistService.getWishList(W_ACID);
      
      Paging paging = new Paging(data, page, pageCount);
      
      System.out.println("paging data: " + paging);
      
      model.addAttribute("wishInfoList", paging.getPageData());
      model.addAttribute("pageData", paging);
      
      System.out.println(model);
      return "mypage/myPageWishList";
   }   
	
	/* 장바구니 삭제 */
	@PostMapping("/wishlist/delete")
	public String deleteCartPOST(WishlistDTO wishlist) {
		wishlistService.deleteWishlist(wishlist.getW_ID());
		return "redirect:/wishlist/" + wishlist.getW_ACID();
	}		
	
	// 장바구니 전체 삭제
	@PostMapping(value = "/wishlist/totalDelete", produces = "application/json; charset=utf-8")
	@ResponseBody
	public String deleteTotalCart(HttpSession session) {
		JSONObject json = new JSONObject();
		AccountDTO loginData = (AccountDTO)session.getAttribute("loginData");
		
		boolean deleteResult = wishlistService.deleteTotalWishList(loginData.getAC_ID());
		
		// 삭제 성공
		if(deleteResult == true) {
			json.put("code", "success");
			json.put("message", "수강 바구니를 모두 삭제했습니다.");
		}else {
			// 삭제 실패
			json.put("code", "fail");
			json.put("message", "삭제 작업 중 문제가 발생하였습니다.");
		}
		
		return json.toJSONString();  
	}
	
	@PostMapping(value = "/wishlist/listDelete", produces = "application/json; charset=utf-8")
	@ResponseBody
	public String deleteListCart(@RequestParam int w_id) {
		JSONObject json = new JSONObject();
		
		System.out.println("삭제할 장바구니 id : " + w_id);
		
		boolean deleteResult = wishlistService.delteWishOne(w_id);
		
		// 삭제 성공
		if(deleteResult == true) {
			json.put("code", "success");
			json.put("message", "강의를 삭제했습니다.");
		}else {
			// 삭제 실패
			json.put("code", "fail");
			json.put("message", "삭제 작업 중 문제가 발생하였습니다.");
		}
		
		return json.toJSONString();  
	}
	
	
	
	
	
	
}