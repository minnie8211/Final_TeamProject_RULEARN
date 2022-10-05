package com.web.home.mypage.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.web.home.mypage.model.AttachImageDAO;
import com.web.home.mypage.model.AttachImageDTO;
import com.web.home.mypage.model.WishlistDAO;
import com.web.home.mypage.model.WishlistDTO;

@Service
public class WishlistService {
	
	@Autowired
	private WishlistDAO wishlistDAO;
	
	@Autowired
	private AttachImageDAO attachDAO;
	
	
	// 장바구니 추가
	public int addWish(int l_id, String ac_id) {
		Map<String, Object> check = new HashMap<String, Object>();
		check.put("W_ACID", ac_id);
		check.put("W_LID", l_id);
		
		// 장바구니 데이터 체크, 있나 없나?
		WishlistDTO checkWishlist = wishlistDAO.checkWishlist(check);
		
		if(checkWishlist != null) {
			return 2;
		}else {
			// 장바구니 등록 & 에러발생시 0반환
			try {
				return wishlistDAO.addWishlist(check); // 1
			} catch (Exception e) {
				return 0;
			}
		}
	}
	
	public List<WishlistDTO> getWishList(String W_ACID) {
		List<WishlistDTO> wishlist = wishlistDAO.getWishlist(W_ACID);
		return wishlist;
	}
	
	public int deleteWishlist(int W_ID) {

		return wishlistDAO.deleteWishlist(W_ID);
	}

	//위시리스트 삭제
	public void removeWishlist() {
		//인자로 리스트 객체 받기
		List<Integer> lesssonID = new ArrayList<Integer>();
		boolean result = wishlistDAO.deleteWishlist(lesssonID);
		
	}
	
	// 결제 완료 후 장바구니 삭제(1개 이상)
	public boolean deleteWishList(List<Integer> list) {
		boolean res = wishlistDAO.deleteWishlist(list);
		
		return res;
	}
	
	public boolean deleteTotalWishList(String ac_id) {
		boolean res = wishlistDAO.deleteTotalList(ac_id);
		
		return res;
	}
	
	public boolean delteWishOne(int w_id) {
		boolean res = wishlistDAO.deleteWishOne(w_id);
		
		return res;
	}

}
