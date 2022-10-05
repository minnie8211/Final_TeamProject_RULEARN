package com.web.home.admin.controller;

import java.util.List;

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
import org.springframework.web.bind.annotation.SessionAttribute;

import com.web.home.account.model.AccountDTO;
import com.web.home.account.model.RolesDTO;
import com.web.home.admin.service.AdminService;
import com.web.home.common.util.Paging;
import com.web.home.join.vo.JoinVO;

@Controller
@RequestMapping("/admin")
public class AdminController {

	private static int ACG_ID_SITELOGIN = 1;	// 일반로그인
	private static int ACG_ID_KAKAOLOGIN = 2;	// 카카오로그인
	private static int RO_ID_PMEMBER = 1;		// 일반 사용자
	private static int RO_ID_INSTRUCTOR = 2;	// 강사
	private static int RO_ID_ADMIN = 3;			// 관리자
	
	
	@Autowired
	private AdminService service;
	
	@GetMapping("/memberInfo")
	public String getMerberInfo(Model model, HttpSession session
			, @RequestParam(required=false) String search
			, @RequestParam(defaultValue="main", required=false) String menu
			, @RequestParam(defaultValue="1", required=false) int page
			, @RequestParam(defaultValue="0", required=false) int pageCount) {
		// 전체 회원정보 조회
		List Alldatas = service.getAll();
		
		if(session.getAttribute("pageCount") == null) {
			session.setAttribute("pageCount", 10);
		}
		if(pageCount > 0) {
			session.setAttribute("pageCount", pageCount);
		}
		pageCount = Integer.parseInt(session.getAttribute("pageCount").toString());
		
		if(session.getAttribute("menu") == null) {
			session.setAttribute("menu", "main");
		}
		if(menu != null) {
			session.setAttribute("menu", menu);
		}
		menu = session.getAttribute("menu").toString();
		
		
		if(search == null || search.equals("")) {
			if(menu != null) {
				if(menu.equals("main")) {
					Alldatas = service.getAll();
				} else if(menu.equals("sitelogin")) {
					Alldatas = service.getAcgSort(ACG_ID_SITELOGIN);
				} else if(menu.equals("kakaologin")) {
					Alldatas = service.getAcgSort(ACG_ID_KAKAOLOGIN);
				} else if(menu.equals("pmember")) {
					Alldatas = service.getRoSort(RO_ID_PMEMBER);
				} else if(menu.equals("instructor")) {
					Alldatas = service.getRoSort(RO_ID_INSTRUCTOR);
				} else if(menu.equals("admin")) {
					Alldatas = service.getRoSort(RO_ID_ADMIN);
				} else {
					model.addAttribute("error", "해당 카테고리가 존재하지 않습니다.");
					return "error/notExists";
				}
			}
		} else {
			// 회원정보검색(아이디/이름/닉네임/전화번호/이메일주소)
			Alldatas = service.getSearch(search);
			model.addAttribute("search", search);
		}
		
		Paging paging = new Paging(Alldatas, page, pageCount);
		
		model.addAttribute("menu", menu);
		model.addAttribute("Alldatas", paging.getPageData());
		model.addAttribute("pageData", paging);
		
		return "/admin/memberInfoList";
	}
	
	@GetMapping("/memberInfo/detail")
	public String getMerberInfoDetail(Model model
			, @RequestParam String id
			, @RequestParam(defaultValue="1", required=false) int page) {
		// 아이디로 회원정보 가져오기
		AccountDTO data = service.getData(id);
		
		if(data != null) {
			model.addAttribute("data", data);
			return "/admin/memberInfoDetail";
		} else {
			model.addAttribute("error", "해당 데이터가 존재하지 않습니다.");
			return "error/notExists";
		}
	}
	
	@GetMapping("/memberInfo/modify")
	public String modifyMemberInfo(Model model
			, @SessionAttribute("loginData") AccountDTO accountDto
			, @RequestParam String id) {
		AccountDTO data = service.getData(id);
		List<RolesDTO> roleDatas = service.getAllRoleData();
		
		if(data != null) {
			if(accountDto.getAC_ROLE() == 3) {
				model.addAttribute("data", data);
				model.addAttribute("roleDatas", roleDatas);
				return "/admin/memberInfoModify";
			}else {
				model.addAttribute("error", "해당 작업을 수행할 권한이 없습니다.");
				return "error/permission";
			}
		} else {
			model.addAttribute("error", "해당 데이터가 존재하지 않습니다.");
			return "error/notExists";
		}
	}
	
	@PostMapping("/memberInfo/modify")
	public String modifyMemberInfo(Model model
			, @SessionAttribute("loginData") AccountDTO accountDto
			, JoinVO joinVo) {
		
		AccountDTO data = new AccountDTO();
		data.setAC_ID(joinVo.getId());
		data.setAC_EMAIL(joinVo.getEmail());
		
		data = service.getData(data.getAC_ID());
		if(data != null) {
			if(accountDto.getAC_ROLE() == 3) {
				data.setAC_ROLE(joinVo.getRole());
				
				if(data.getAC_MAIL_AUTH() == 1) {
					boolean result = service.modifyMemberInfo(data);
					if(result) {
						return "redirect:/admin/memberInfo/detail?id=" + data.getAC_ID();
					} else {
						return modifyMemberInfo(model, accountDto, data.getAC_ID());
					}
				} else {
					model.addAttribute("error", "메일 인증을 받지 않은 회원은\\n권한을 수정할 수 없습니다.");
					return modifyMemberInfo(model, accountDto, data.getAC_ID());
				}
			} else {
				model.addAttribute("error", "해당 작업을 수행할 권한이 없습니다.");
				return "error/permission";
			}
		} else {
			model.addAttribute("error", "해당 데이터가 존재하지 않습니다.");
			return "error/notExists";
		}
	}
	
	@GetMapping("/lessonRegList")
	public String getlessonRegList(Model model, HttpSession session
			, @RequestParam(required=false) String search
			, @RequestParam(defaultValue="1", required=false) int page
			, @RequestParam(defaultValue="0", required=false) int pageCount) {
		// 전체 수강결제정보 조회
		
		if(session.getAttribute("pageCount") == null) {
			session.setAttribute("pageCount", 10);
		}
		if(pageCount > 0) {
			session.setAttribute("pageCount", pageCount);
		}
		pageCount = Integer.parseInt(session.getAttribute("pageCount").toString());
		
		List Alldatas;
		if(search == null || search.equals("")) {
			Alldatas = service.getAllPayment();
			
		} else {
			// 수강정보검색
			Alldatas = service.getSearchPayment(search);
			model.addAttribute("search", search);
		}
		
		Paging paging = new Paging(Alldatas, page, pageCount);
		
		model.addAttribute("Alldatas", paging.getPageData());
		model.addAttribute("pageData", paging);
		
		return "/admin/LessonRegList";
	}
	
	@PostMapping(value="/memberDelete", produces="application/json; charset=utf-8")
	@ResponseBody
	public String deleteMemberInfo(@RequestParam String id
			, @SessionAttribute("loginData") AccountDTO accountDto) {
		AccountDTO data = service.getData(id);
		JSONObject json = new JSONObject();
		System.out.println("getid: " + id);
		if(data != null) {
			if(accountDto.getAC_ROLE() == 3) {
				boolean result = service.removeMemberInfo(data);
				if(result) {
					json.put("code", "success");
					json.put("message", "회원 정보가 삭제되었습니다.");
				} else {
					json.put("code", "fail");
					json.put("message", "회원 정보 삭제 중 문제가 발생하였습니다.");
				} 
			} else {
				json.put("code", "permissionError");
				json.put("message", "삭제 권한이 없습니다.");
			}
		} else {
			json.put("code", "notExists");
			json.put("message", "이미 삭제된 데이터 입니다.");
		}
		
		return json.toJSONString();
	}
	
}
