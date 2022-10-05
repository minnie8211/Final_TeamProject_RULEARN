package com.web.home.course.controller;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.web.home.account.model.AccountDTO;
import com.web.home.course.model.ReviewDTO;
import com.web.home.course.service.CourseService;
import com.web.home.course.vo.ReviewVO;

@Controller @SuppressWarnings("unchecked")
@RequestMapping(value="/course/review")
public class ReviewController {

	@Autowired
	private CourseService service;
	
	@PostMapping(value = "/delete", produces="application/json; charset=utf-8")
	@ResponseBody
	public String deleteReview(@SessionAttribute("loginData") AccountDTO accountDto,
							   @RequestParam int rb_id) {
		JSONObject json = new JSONObject();
		ReviewDTO reviewData = service.getReview(rb_id);
		
		if(reviewData == null) {
			json.put("type", "notExist");
			json.put("message", "삭제할 리뷰가 없습니다.");
		}else {
			if(accountDto.getAC_ID().equals(reviewData.getRb_wid())) {
				boolean result = service.deleteReview(reviewData);
				if(!result) {
					json.put("type", "fail");
					json.put("message", "삭제에 실패하였습니다");
				}else {
					json.put("type", "success");
					json.put("message", "리뷰가 삭제되었습니다.");
				}
			}
	
		}
		
		return json.toJSONString();
	}
}
