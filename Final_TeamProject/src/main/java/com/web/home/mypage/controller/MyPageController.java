package com.web.home.mypage.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.web.home.account.model.AccountDTO;
import com.web.home.common.util.Paging;
import com.web.home.community.board.service.CommunityBoardService;
import com.web.home.community.comment.service.CommunityCommentService;
import com.web.home.course.service.CourseService;
import com.web.home.mypage.model.VirtualAccountInfoVO;
import com.web.home.mypage.service.MyPageService;
import com.web.home.studyboard.comment.service.StudyCommentService;
import com.web.home.studyboard.service.StudyBoardService;

@Controller
@RequestMapping("/mypage")
public class MyPageController {
	
	// 게시판 카테고리 : QA 1, 자유 2, 팁 3, 스터디 4, 프로젝트 5
	private final static int QA_CAT_ID = 1;
	private final static int FORUM_CAT_ID = 2;
	private final static int TIP_CAT_ID = 3;
	private final static int STUDY_CAT_ID = 4;
	private final static int PROJECT_CAT_ID = 5;
	
	@Autowired
	private MyPageService service;
	
	@Autowired 
	private CommunityBoardService commBoardService;
 
	@Autowired
	private StudyBoardService studyBoardService;
	
	@Autowired
	private CommunityCommentService commCommentService;
	
	@Autowired
	private StudyCommentService studyCommentService;
	
	@Autowired
	private CourseService courseService;
	
	// 내가 쓴 게시글
	@GetMapping("/board/QnA")
	public String getMyBoardQnA(Model model, HttpSession session
			, @RequestParam(defaultValue="1", required=false) int page
			, @RequestParam(defaultValue="0", required=false) int pageCount) {
		
		AccountDTO account = (AccountDTO) session.getAttribute("loginData");
		String AC_ID = account.getAC_ID();
		
		Map input = new HashMap();
		input.put("ID", AC_ID);
		input.put("CATEGORY", QA_CAT_ID);
		
		List datas = commBoardService.myPagefindBoardCategory(input);
		
		if(session.getAttribute("pageCount") == null) {
			session.setAttribute("pageCount", 5);
		}
		
		if(pageCount > 0) {
			session.setAttribute("pageCount", pageCount);
		}
		
		pageCount = Integer.parseInt(session.getAttribute("pageCount").toString());
		Paging paging = new Paging(datas, page, pageCount);
		
		model.addAttribute("qaBoardList", paging.getPageData());
		model.addAttribute("pageData", paging);
		
		return "mypage/myPageBoardQnA";
	}
	
	@GetMapping("/board/free")
	public String getMyBoardtroubleAndFree(Model model, HttpSession session
			, @RequestParam(defaultValue="1", required=false) int page
			, @RequestParam(defaultValue="0", required=false) int pageCount) {
		
		AccountDTO account = (AccountDTO) session.getAttribute("loginData");
		String AC_ID = account.getAC_ID();
		
		Map input = new HashMap();
		input.put("ID", AC_ID);
		input.put("CATEGORY", FORUM_CAT_ID);
		
		List datas = commBoardService.myPagefindBoardCategory(input);
		
		if(session.getAttribute("pageCount") == null) {
			session.setAttribute("pageCount", 5);
		}
		
		if(pageCount > 0) {
			session.setAttribute("pageCount", pageCount);
		}
		
		pageCount = Integer.parseInt(session.getAttribute("pageCount").toString());
		Paging paging = new Paging(datas, page, pageCount);
		
		model.addAttribute("forumBoardList", paging.getPageData());
		model.addAttribute("pageData", paging);
		
		return "mypage/myPageBoardFree";
	}
	
	@GetMapping("/board/knowhow")
	public String getMyBoardknowhowAndTip(Model model, HttpSession session
			, @RequestParam(defaultValue="1", required=false) int page
			, @RequestParam(defaultValue="0", required=false) int pageCount) {
		
		AccountDTO account = (AccountDTO) session.getAttribute("loginData");
		String AC_ID = account.getAC_ID();
		
		Map input = new HashMap();
		input.put("ID", AC_ID);
		input.put("CATEGORY", TIP_CAT_ID);
		
		List datas = commBoardService.myPagefindBoardCategory(input);
		
		if(session.getAttribute("pageCount") == null) {
			session.setAttribute("pageCount", 5);
		}
		
		if(pageCount > 0) {
			session.setAttribute("pageCount", pageCount);
		}
		
		pageCount = Integer.parseInt(session.getAttribute("pageCount").toString());
		Paging paging = new Paging(datas, page, pageCount);
		
		model.addAttribute("tipBoardList", paging.getPageData());
		model.addAttribute("pageData", paging);
		
		return "mypage/myPageBoardKnowhow";
	}
	
	@GetMapping("/board/study")
	public String getMyBoardStudy(Model model, HttpSession session
			, @RequestParam(defaultValue="1", required=false) int page
			, @RequestParam(defaultValue="0", required=false) int pageCount) {
		
		AccountDTO account = (AccountDTO) session.getAttribute("loginData");
		String AC_ID = account.getAC_ID();
		
		Map input = new HashMap();
		input.put("ID", AC_ID);
		input.put("CATEGORY", STUDY_CAT_ID);
		
		List datas = studyBoardService.myPagegetCatData(input);
		
		if(session.getAttribute("pageCount") == null) {
			session.setAttribute("pageCount", 5);
		}
		
		if(pageCount > 0) {
			session.setAttribute("pageCount", pageCount);
		}
		
		pageCount = Integer.parseInt(session.getAttribute("pageCount").toString());
		Paging paging = new Paging(datas, page, pageCount);
		
		model.addAttribute("studyBoardList", paging.getPageData());
		model.addAttribute("pageData", paging);
		
		return "mypage/myPageBoardStudy";
	}
	
	@GetMapping("/board/project")
	public String getMyBoardProject(Model model, HttpSession session
			, @RequestParam(defaultValue="1", required=false) int page
			, @RequestParam(defaultValue="0", required=false) int pageCount) {
		
		AccountDTO account = (AccountDTO) session.getAttribute("loginData");
		String AC_ID = account.getAC_ID();
		
		Map input = new HashMap();
		input.put("ID", AC_ID);
		input.put("CATEGORY", PROJECT_CAT_ID);
		
		List datas = studyBoardService.myPagegetCatData(input);
		
		if(session.getAttribute("pageCount") == null) {
			session.setAttribute("pageCount", 5);
		}
		
		if(pageCount > 0) {
			session.setAttribute("pageCount", pageCount);
		}
		
		pageCount = Integer.parseInt(session.getAttribute("pageCount").toString());
		Paging paging = new Paging(datas, page, pageCount);
		
		model.addAttribute("projectBoardList", paging.getPageData());
		model.addAttribute("pageData", paging);
		
		return "mypage/myPageBoardProject";
	}
	
	// 내가 쓴 댓글
	@GetMapping("/comment/QnA")
	public String getMyCommentQnA(Model model, HttpSession session
	, @RequestParam(defaultValue="1", required=false) int page
	, @RequestParam(defaultValue="5", required=false) int pageCount) {
		
		AccountDTO account = (AccountDTO) session.getAttribute("loginData");
		String AC_ID = account.getAC_ID();
		
		Map input = new HashMap();
		input.put("ID", AC_ID);
		input.put("CATEGORY", QA_CAT_ID);
		
		List commentDatas = commCommentService.myPageGetCommentDatas(input);
		
		Paging paging = new Paging(commentDatas, page, pageCount);
		
		model.addAttribute("qaCommentList", paging.getPageData());
		model.addAttribute("pageData", paging);
		
		return "mypage/myPageCommentQnA";
	}
	
	@GetMapping("/comment/free")
	public String getMyCommentTroubleAndFree(Model model, HttpSession session
	, @RequestParam(defaultValue="1", required=false) int page
	, @RequestParam(defaultValue="5", required=false) int pageCount) {
		
		AccountDTO account = (AccountDTO) session.getAttribute("loginData");
		String AC_ID = account.getAC_ID();
		
		Map input = new HashMap();
		input.put("ID", AC_ID);
		input.put("CATEGORY", FORUM_CAT_ID);
		
		List commentDatas = commCommentService.myPageGetCommentDatas(input);
		
		Paging paging = new Paging(commentDatas, page, pageCount);
		
		model.addAttribute("freeCommentList", paging.getPageData());
		model.addAttribute("pageData", paging);
		
		return "mypage/myPageCommentFree";
	}
	
	@GetMapping("/comment/knowhow")
	public String getMyCommentknowhowAndTip(Model model, HttpSession session
	, @RequestParam(defaultValue="1", required=false) int page
	, @RequestParam(defaultValue="5", required=false) int pageCount) {
		
		AccountDTO account = (AccountDTO) session.getAttribute("loginData");
		String AC_ID = account.getAC_ID();
		
		Map input = new HashMap();
		input.put("ID", AC_ID);
		input.put("CATEGORY", TIP_CAT_ID);
		
		List commentDatas = commCommentService.myPageGetCommentDatas(input);
		
		Paging paging = new Paging(commentDatas, page, pageCount);
		
		model.addAttribute("knowhowCommentList", paging.getPageData());
		model.addAttribute("pageData", paging);
		
		return "mypage/myPageCommentKnowhow";
	}
	
	@GetMapping("/comment/study")
	public String getMyCommentStudy(Model model, HttpSession session
			, @RequestParam(defaultValue="1", required=false) int page
			, @RequestParam(defaultValue="5", required=false) int pageCount) {
		
		AccountDTO account = (AccountDTO) session.getAttribute("loginData");
		String AC_ID = account.getAC_ID();
		
		Map input = new HashMap();
		input.put("ID", AC_ID);
		input.put("CATEGORY", STUDY_CAT_ID);
		
		List commentDatas = studyCommentService.myPageGetCommentDatas(input);
		
		Paging paging = new Paging(commentDatas, page, pageCount);
		
		model.addAttribute("studyCommentList", paging.getPageData());
		model.addAttribute("pageData", paging);
		
		return "mypage/myPageCommentStudy";
	}
	
	@GetMapping("/comment/project")
	public String getMyCommentProject(Model model, HttpSession session
			, @RequestParam(defaultValue="1", required=false) int page
			, @RequestParam(defaultValue="5", required=false) int pageCount) {
		
		AccountDTO account = (AccountDTO) session.getAttribute("loginData");
		String AC_ID = account.getAC_ID();
		
		Map input = new HashMap();
		input.put("ID", AC_ID);
		input.put("CATEGORY", PROJECT_CAT_ID);
		
		List commentDatas = studyCommentService.myPageGetCommentDatas(input);
		
		Paging paging = new Paging(commentDatas, page, pageCount);
		
		model.addAttribute("projectCommentList", paging.getPageData());
		model.addAttribute("pageData", paging);
		
		return "mypage/myPageCommentProject";
	}
	
	// 수강 중 강의
	@GetMapping("/lesson")
	public String getMyLesson(Model model, HttpSession session,
			@RequestParam(defaultValue = "1", required = false) int page,
			@RequestParam(defaultValue = "allCourse", required = false)String sort) {
		
		AccountDTO account = (AccountDTO) session.getAttribute("loginData");
		String lm_wid = account.getAC_ID();
		
		List courseDatas = courseService.getTakenLessons(lm_wid);
		
		Paging paging = new Paging(courseDatas, page, 9);

		model.addAttribute("courseDatas", paging.getPageData());
		model.addAttribute("pageData", paging);
		model.addAttribute("sort", sort);
		
		return "mypage/myPageLesson";
	}
	
	// 개인정보 수정 탭 실행시
	@GetMapping("/certifyformView")
	public String getMycertifyForm() {
		return "mypage/myPageCertifyForm";
	}
	
	// 개인정보 수정 버튼 클릭시
	@PostMapping("/certifyform")
	public String postMycertifyForm(@ModelAttribute AccountDTO Dto, HttpSession session) throws Exception {
		
		// 폼에 정보를 바꾸든 안바꾸든 update는 이루어진다.
		// 내가 원하는 정보만 수정 할 수 있도록 기본값들도 들어가 있어야 한다.(비밀번호 제외 전부)
		if(service.passChk(Dto) == 1) {
			service.modify(Dto);
			session.invalidate();
			
			return "redirect:/";
		} else {
			return "redirect:/mypage/certifyform";
		}
		
	}
	
	// 회원 탈퇴 탭 실행시
	@GetMapping("/withdrawView")
	public String getMywithdrawView() {
		return "mypage/myPageWithdraw";
	}
	
	// 회원 탈퇴 버튼 실행시
	@PostMapping("/withdraw")
	public String postMywithdraw(@ModelAttribute AccountDTO Dto, HttpSession session, RedirectAttributes rttr) {
		
		// 세션에 있는 회원정보를(임시로 "member") 가져온다. ( 현재비밀번호 가져오기 위해서 ) 
		AccountDTO member = (AccountDTO) session.getAttribute("loginData");
		
		String sessionPass = member.getAC_PW(); // 세션에 있는 비밀번호 ( 현재비밀번호 ) 
		
		String DtoPass = Dto.getAC_PW();
		
		if(sessionPass.equals(DtoPass)) {
			// 입력한 비밀번호와 현재 비밀번호가 동일할 때
			service.AccountRemove(member);
			session.invalidate();
			return "redirect:/";
		} else {
			// 동일하지 않을때
			rttr.addFlashAttribute("msg", false);
			return "redirect:/mypage/withdrawView";
		}
	}
	
	@ResponseBody
	@PostMapping("/passChk")
	public int passChk(AccountDTO data) throws Exception {
		return service.passChk(data);
	}
	
}
