package com.web.home.mypage.model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class WishlistDAO {
	
	@Autowired
	private SqlSession session;
	
	private String mapper = "wishlistMapper.%s";
	
	// 장바구니 추가
	public int addWishlist(Map<String, Object> check){
		String mapperId = String.format(mapper, "addWishlist");
		int res = session.insert(mapperId, check);
		return res;
	}
	
	// 장바구니 삭제(여러개)
	public boolean deleteWishlist(List<Integer> lesssonID) {
		String mapperId = String.format(mapper, "deleteWishlist");
		int res = session.delete(mapperId, lesssonID);
		return res == 1 ? true : false;
	}
	
	// 장바구니 삭제(한개)
	public int deleteWishlist(int W_LID) {
		String mapperId = String.format(mapper, "deleteWishlist");
		int res = session.delete(mapperId, W_LID);
		return res;
	}
	
	// 장바구니 확인
	public WishlistDTO checkWishlist(Map<String, Object> check) {
		
		String mapperId = String.format(mapper, "checkWishlist");
		WishlistDTO res = session.selectOne(mapperId, check);
		return res;
	}

	// 장바구니 목록
	public List<WishlistDTO> getWishlist(String W_AC_ID) {
		String mapperId = String.format(mapper, "getWishlist");
		List<WishlistDTO> res = session.selectList(mapperId, W_AC_ID);
		return res;
	}

	public boolean deleteTotalList(String W_ACID) {
		String mapperId = String.format(mapper, "deleteTotalList");
		int res = session.delete(mapperId, W_ACID);
		return res >= 1 ? true : false;
	}

	public boolean deleteWishOne(int w_id) {
		String mapperId = String.format(mapper, "deleteWishOne");
		int res = session.delete(mapperId, w_id);
		return res == 1 ? true : false;
	}

}
