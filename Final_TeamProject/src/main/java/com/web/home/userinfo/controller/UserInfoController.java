package com.web.home.userinfo.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.web.home.account.model.AccountDTO;
import com.web.home.common.util.Paging;
import com.web.home.userinfo.service.UserInfoService;

@Controller
@RequestMapping(value="/userinfo")
public class UserInfoController {
	
	@Autowired
	private UserInfoService service;
	
	@GetMapping(value="post")
	public String getList(Model model, HttpSession session
			, @RequestParam(required=false) String id
			, @RequestParam(defaultValue="community", required=false) String menu
			, @RequestParam(defaultValue="1", required=false) int page
			, @RequestParam(defaultValue="10", required=false) int pageCount) {
		
		if(session.getAttribute("menu") == null) {
			session.setAttribute("menu", "community");
		}
		if(menu != null) {
			session.setAttribute("menu", menu);
		}
		menu = session.getAttribute("menu").toString();
		
		//회원 정보 조회
		AccountDTO userData = service.getUserData(id);
		if(userData == null) {
			return "error/notExists";
		}
		
		Paging paging;
		List Alldatas;
		
		if(menu.equals("community")) {
			//커뮤니티 게시글 조회
			Alldatas = service.getUserCommuData(id);
		} else if(menu.equals("study")) {
			//스터디,프로젝트 게시글 조회
			Alldatas = service.getUserStudyData(id);
		} else {
			model.addAttribute("error", "해당 카테고리가 존재하지 않습니다.");
			return "error/notExists";
		}
		paging = new Paging(Alldatas, page, pageCount);
		
		model.addAttribute("menu", menu);
		model.addAttribute("originalDatas", Alldatas);
		model.addAttribute("Alldatas", paging.getPageData());
		model.addAttribute("pageData", paging);
		model.addAttribute("userData", userData);
		
		return "userInfo/post";
	}
	
	@GetMapping(value="reply")
	public String getCommentLsit(Model model, HttpSession session
			, @RequestParam(required=false) String id
			, @RequestParam(defaultValue="community", required=false) String menu
			, @RequestParam(defaultValue="1", required=false) int page
			, @RequestParam(defaultValue="10", required=false) int pageCount) {
		
		if(session.getAttribute("menu") == null) {
			session.setAttribute("menu", "community");
		}
		if(menu != null) {
			session.setAttribute("menu", menu);
		}
		menu = session.getAttribute("menu").toString();
		
		//회원 정보 조회
		AccountDTO userData = service.getUserData(id);
		if(userData == null) {
			return "error/notExists";
		}
		
		Paging paging = null;
		List Alldatas = null;
		List boardIdDatas = null;
		
		if(menu.equals("community")) {
			//커뮤니티 게시글 조회
			boardIdDatas = service.getCommuBoardId(id);
			
			if(!boardIdDatas.isEmpty()) {
				Alldatas = service.getCommuBoradList(boardIdDatas);
				paging = new Paging(Alldatas, page, pageCount);
				model.addAttribute("Alldatas", paging.getPageData());
			}
		} else if(menu.equals("study")) {
			//스터디 게시글 조회
			boardIdDatas = service.getStudyBoardId(id);
			
			if(!boardIdDatas.isEmpty()) {
				Alldatas = service.getStudyBoradList(boardIdDatas);
				paging = new Paging(Alldatas, page, pageCount);
				model.addAttribute("Alldatas", paging.getPageData());
			}
		} else {
			model.addAttribute("error", "해당 카테고리가 존재하지 않습니다.");
			return "error/notExists";
		}
		
		model.addAttribute("menu", menu);
		model.addAttribute("originalDatas", Alldatas);
		model.addAttribute("pageData", paging);
		model.addAttribute("userData", userData);
		
		return "userInfo/reply";
	}
}

