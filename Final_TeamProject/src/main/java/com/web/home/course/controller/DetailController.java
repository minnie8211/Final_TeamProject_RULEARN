package com.web.home.course.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.web.home.account.model.AccountDTO;
import com.web.home.course.model.CourseDTO;
import com.web.home.course.model.Curriculum_bigDTO;
import com.web.home.course.model.Curriculum_smallDTO;
import com.web.home.course.model.QA_answerDTO;
import com.web.home.course.model.QA_boardDTO;
import com.web.home.course.model.ReviewDTO;
import com.web.home.course.model.ReviewInfoDTO;
import com.web.home.course.service.CourseService;
import com.web.home.course.vo.QnAVO;
import com.web.home.course.vo.ReviewVO;

@Controller
@RequestMapping(value = "/course/detail")
public class DetailController {
	@Autowired
	private CourseService service;
	
	@GetMapping(value="")
	public String courseDetail(Model model, HttpSession session, @RequestParam int id,
			 	@RequestParam(defaultValue = "latest", required = false)String sort) {
		
		CourseDTO lessonData = service.getLessonDetail(id);
		if (lessonData != null) {
			List<Curriculum_bigDTO> curriBigTitle = service.getCurriBigTitle(id);
			List<Curriculum_smallDTO> curriData = service.getCurriData(id);
			List<ReviewDTO> reviewData = service.getReviewDatas(id, sort);
			ReviewInfoDTO reviewStatics = service.getReviewStatics(id);
			
			if(session.getAttribute("loginData") != null) {
				boolean hasReviewHistory = service.getReviewHistory(session, id);
				if(hasReviewHistory) {
					model.addAttribute("hasReviewHistory", hasReviewHistory);
				}
			}
			
			//수강 여부, 카트 정보(사이드 섹션용)
			getHistory_CartInfo(model, session, id);
			
			model.addAttribute("reviewStatics", reviewStatics);
			model.addAttribute("lessonData", lessonData);
			model.addAttribute("bigTitle", curriBigTitle);
			model.addAttribute("curriData", curriData);
			model.addAttribute("reviewData", reviewData);
			model.addAttribute("sort", sort);
				return "course/detail";
		}else {
			
			model.addAttribute("error", "해당 강의가 존재하지 않습니다.");
			return "error/notExists";
		}
	}
	
	@PostMapping(value = "/review/add")
	public String addReview(Model model, @ModelAttribute ReviewVO reviewVO) {
		System.out.println("리뷰 내용: " + reviewVO);
		boolean result = service.addReview(reviewVO);
		
		if(result) {
			return "redirect:/course/detail?id=" + reviewVO.getRb_lid() + "#review";
		}else {
			model.addAttribute("error", "리뷰 등록에 실패하였습니다. 다시 시도해주세요.");
			return "error/notExists";
		}
	}
	@PostMapping(value = "/review/modify")
	public String modifyReview(Model model, 
							@ModelAttribute ReviewVO reviewVO,
							@SessionAttribute("loginData") AccountDTO accountDto) {
		System.out.println("강의 번호: " + reviewVO.getRb_id());
		ReviewDTO reviewData = service.getReview(reviewVO.getRb_id());
		System.out.println(reviewData);
		
		if(accountDto.getAC_ID().equals(reviewData.getRb_wid())) {
			System.out.println("vo 정보: " + reviewVO);
			reviewData.setRb_content(reviewVO.getRb_content());
			reviewData.setRb_score(reviewVO.getRb_score());
			
			boolean result = service.modifyReview(reviewData);
			if(result) {
				return "redirect:/course/detail?id=" + reviewData.getRb_lid() + "#review";
			}else {
				model.addAttribute("error", "리뷰 등록에 실패하였습니다. 다시 시도해주세요.");
				return "error/notExists";
			}
		}else {
			model.addAttribute("error", "리뷰 등록에 실패하였습니다. 다시 시도해주세요.");
			return "error/notExists";
		}
		
	}
	
	@GetMapping(value="/QnA")
	public String courseQnA(Model model, @RequestParam int id, HttpSession session) {
		CourseDTO lessonData = service.getLessonDetail(id);
		if(lessonData != null) {
			//리뷰 정보(배너용)
			ReviewInfoDTO reviewInfo = service.getReviewAmount_AVG(id);
			
			//QnA 정보
			List<QnAVO> QnA_boardDatas = service.getQnA_answersInLesson(id);
			if(QnA_boardDatas.size() != 0) {
				model.addAttribute("QnA", QnA_boardDatas);
			}else {
				model.addAttribute("foundNothing", 0);
			}
			
			//수강 여부, 카트 정보(사이드 섹션용)
			getHistory_CartInfo(model, session, id);
		
			model.addAttribute("lessonData", lessonData);
			model.addAttribute("reviewInfo", reviewInfo);
			return "course/QnA";
		}else{
			model.addAttribute("error", "해당 강의가 존재하지 않습니다.");
			return "error/notExists";
		}
	}
	

	@PostMapping(value = "/QnA/add")
	public String addQnA(Model model, @ModelAttribute QnAVO QnAVO) {
		boolean result = service.addQnA(QnAVO);
		if(result) {
			return "redirect:/course/detail/QnA?id=" + QnAVO.getQb_lid() + "#QnA";
		}else {
			model.addAttribute("error", "QnA 등록에 실패하였습니다. 다시 시도해주세요.");
			return "error/notExists";
		}
	}
	
	@PostMapping(value = "/QnA/answer/add")
	public String addQnAanswer(Model model,
							   @ModelAttribute QA_answerDTO answer) {
		boolean result = service.addQA_answer(answer);
		if(result) {
			return "redirect:/course/detail/QnA?id=" + answer.getQaa_lid();
		}else {
			model.addAttribute("error", "QnA 답변 등록에 실패하였습니다.");
			return "error/notExists";
		}
	}
	
	private void getHistory_CartInfo(Model model, HttpSession session, int id) {
		boolean isExistLessonHistory = false;
		boolean isExistInCart = false;
		if(session.getAttribute("loginData") != null) {
			isExistLessonHistory = service.getHistoryDatas(session, id);
			isExistInCart = service.getCartInfo(session, id);
			
			if(isExistLessonHistory) {
				model.addAttribute("historyExist", isExistLessonHistory);
			}
			if(isExistInCart) {
				model.addAttribute("isExistInCart", isExistInCart);
			}
		}
	}
	
}
