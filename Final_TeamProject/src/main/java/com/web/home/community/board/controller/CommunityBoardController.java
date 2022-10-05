package com.web.home.community.board.controller;

import java.io.File;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.aspectj.apache.bcel.classfile.Module.Require;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.multipart.MultipartFile;

import com.web.home.account.model.AccountDTO;
import com.web.home.common.util.Paging;
import com.web.home.community.board.model.CommunityBoardDTO;
import com.web.home.community.board.model.CommunityBoardStaticsDTO;
import com.web.home.community.board.model.CommunityLoadBoardVO;
import com.web.home.community.board.service.CommunityBoardService;
import com.web.home.community.comment.model.CommunityCommentDTO;
import com.web.home.community.comment.service.CommunityCommentService;

@Controller
@RequestMapping(value = "/community")
public class CommunityBoardController {
			
	// 게시판 카테고리 : QA 1, 자유 2, 팁 3
	private static int QA_CAT_ID = 1;
	private static int FORUM_CAT_ID = 2;
	private static int TIP_CAT_ID = 3;
	
	@Autowired 
	private CommunityBoardService commBoardservice;
	
	@Autowired 
	private CommunityCommentService commCommentService;

	// 전체화면(메인) 목록 
	@GetMapping(value = "/main")
	public String commBoardMain(Model model, HttpSession session
			, @RequestParam(defaultValue="1", required=false) int page
			, @RequestParam(defaultValue="0", required=false) int pageCount
			, @RequestParam(defaultValue="", required=false) String sort
			, @RequestParam(defaultValue="", required=false) String search) {		

		List commTotal = commBoardservice.findBoardAll();
		
		// 페이징
		if(session.getAttribute("pageCount") == null) {
			session.setAttribute("pageCount", 5);
			
		}
		if(pageCount > 0) {
			session.setAttribute("pageCount", pageCount);
		}
		
		pageCount = Integer.parseInt(session.getAttribute("pageCount").toString());
		
		// 정렬
		if(!sort.equals("main")) {
			session.setAttribute("sort", sort);
		}
		
		sort = session.getAttribute("sort").toString();
		
		// 검색		
		if(!search.isEmpty()) {
			String searchSort = "";
			// 검색 후 정렬이 있을 경우
			if(sort.equals("latest") || sort.equals("")) {
				searchSort = "latest";
			}else if(sort.equals("comment")) {
				searchSort = "comment";
			}else if(sort.equals("like")) {
				searchSort = "like";
			}
			commTotal = commBoardservice.findSearchAll(search.toString(), searchSort);
			
			model.addAttribute("searchValue", search);
		}else {
			if(sort.equals("latest")) {
				commTotal = commBoardservice.findBoardAll();
			}else if(sort.equals("comment")) {
				commTotal = commBoardservice.findBoardOrderByCommentAll();
			}else if(sort.equals("like")) {
				commTotal = commBoardservice.findBoardOrderByLikeAll();
			}
		}

		Paging paging = new Paging(commTotal, page, pageCount);
		
		model.addAttribute("totalBoardList", paging.getPageData());
		model.addAttribute("pageData", paging);
		model.addAttribute("sortValue", sort);
		
		
		return "/community/main";
	}

	// QA 
	@GetMapping(value = "/qa")
	public String commBoardQA(Model model, HttpSession session
			, @RequestParam(defaultValue="1", required=false) int page
			, @RequestParam(defaultValue="0", required=false) int pageCount
			, @RequestParam(defaultValue="", required=false) String sort
			, @RequestParam(defaultValue="", required=false) String search) {
		
		List commQA = commBoardservice.findBoardCategory(QA_CAT_ID);
		
		// 페이징
		if(session.getAttribute("pageCount") == null) {
			session.setAttribute("pageCount", 5);
		}
		
		if(pageCount > 0) {
			session.setAttribute("pageCount", pageCount);
		}
		
		pageCount = Integer.parseInt(session.getAttribute("pageCount").toString());
		
		if(!sort.equals("qa")) {
			session.setAttribute("sort", sort);
		}
		
		sort = session.getAttribute("sort").toString();
		
		// 검색		
		if(!search.isEmpty()) {
			String searchSort = "";
			// 검색 후 정렬이 있을 경우
			if(sort.equals("latest") || sort.equals("")) {
				searchSort = "latest";
			}else if(sort.equals("comment")) {
				searchSort = "comment";
			}else if(sort.equals("like")) {
				searchSort = "like";
			}
			commQA = commBoardservice.findSearchCategory(search.toString(), searchSort, QA_CAT_ID);
			
			model.addAttribute("searchValue", search);
		}else {
			if(sort.equals("latest")) {
				commQA = commBoardservice.findBoardCategory(QA_CAT_ID);
			}else if(sort.equals("comment")) {
				commQA = commBoardservice.findBoardOrderByComment(QA_CAT_ID);
			}else if(sort.equals("like")) {
				commQA = commBoardservice.findBoardOrderByLike(QA_CAT_ID);
			}
		}
		
		
		Paging paging = new Paging(commQA, page, pageCount);
		
		model.addAttribute("qaBoardList", paging.getPageData());
		model.addAttribute("pageData", paging);
		model.addAttribute("sortValue", sort);
		
		return "/community/qa";
	}
	
	// 고민/자유
	@GetMapping(value = "/forum")
	public String commBoardForum(Model model, HttpSession session
			, @RequestParam(defaultValue="1", required=false) int page
			, @RequestParam(defaultValue="0", required=false) int pageCount
			, @RequestParam(defaultValue="", required=false) String sort
			, @RequestParam(defaultValue="", required=false) String search) {
		
		List commForum = commBoardservice.findBoardCategory(FORUM_CAT_ID);
		
		// 페이징
		if(session.getAttribute("pageCount") == null) {
			session.setAttribute("pageCount", 5);
		}
		
		if(pageCount > 0) {
			session.setAttribute("pageCount", pageCount);
		}
		
		pageCount = Integer.parseInt(session.getAttribute("pageCount").toString());
		
		if(!sort.equals("forum")) {
			session.setAttribute("sort", sort);
		}
		
		sort = session.getAttribute("sort").toString();
		
		// 검색		
		if(!search.isEmpty()) {
			String searchSort = "";
			if(sort.equals("latest") || sort.equals("")) {
				searchSort = "latest";
			}else if(sort.equals("comment")) {
				searchSort = "comment";
			}else if(sort.equals("like")) {
				searchSort = "like";
			}
			commForum = commBoardservice.findSearchCategory(search.toString(), searchSort, FORUM_CAT_ID);
			
			model.addAttribute("searchValue", search);
		}else {
			if(sort.equals("latest")) {
				commForum = commBoardservice.findBoardCategory(FORUM_CAT_ID);
			}else if(sort.equals("comment")) {
				commForum = commBoardservice.findBoardOrderByComment(FORUM_CAT_ID);
			}else if(sort.equals("like")) {
				commForum = commBoardservice.findBoardOrderByLike(FORUM_CAT_ID);
			}
		}
		
		Paging paging = new Paging(commForum, page, pageCount);
		
		model.addAttribute("forumBoardList", paging.getPageData());
		model.addAttribute("pageData", paging);
		model.addAttribute("sortValue", sort);
		
		return "/community/forum";
	}
	
	// 팁&노하우 
	@GetMapping(value = "/tip")
	public String commBoardTip(Model model, HttpSession session
			, @RequestParam(defaultValue="1", required=false) int page
			, @RequestParam(defaultValue="0", required=false) int pageCount
			, @RequestParam(defaultValue="", required=false) String sort
			, @RequestParam(defaultValue="", required=false) String search) {
		
		List commTip = commBoardservice.findBoardCategory(TIP_CAT_ID);
		
		// 페이징
		if(session.getAttribute("pageCount") == null) {
			session.setAttribute("pageCount", 5);
		}
		
		if(pageCount > 0) {
			session.setAttribute("pageCount", pageCount);
		}
		
		pageCount = Integer.parseInt(session.getAttribute("pageCount").toString());
		
		if(!sort.equals("tip")) {
			session.setAttribute("sort", sort);
		}
		
		sort = session.getAttribute("sort").toString();
		
		// 검색		
		if(!search.isEmpty()) {
			String searchSort = "";
			if(sort.equals("latest") || sort.equals("")) {
				searchSort = "latest";
			}else if(sort.equals("comment")) {
				searchSort = "comment";
			}else if(sort.equals("like")) {
				searchSort = "like";
			}
			commTip = commBoardservice.findSearchCategory(search.toString(), searchSort, TIP_CAT_ID);
			
			model.addAttribute("searchValue", search);
		}else {
			if(sort.equals("latest")) {
				commTip = commBoardservice.findBoardCategory(TIP_CAT_ID);
			}else if(sort.equals("comment")) {
				commTip = commBoardservice.findBoardOrderByComment(TIP_CAT_ID);
			}else if(sort.equals("like")) {
				commTip = commBoardservice.findBoardOrderByLike(TIP_CAT_ID);
			}
		}
		
		Paging paging = new Paging(commTip, page, pageCount);
		
		model.addAttribute("tipBoardList", paging.getPageData());
		model.addAttribute("pageData", paging);
		model.addAttribute("sortValue", sort);
		
		return "/community/tip";
	}
	
	// 게시판 상세내용 + 댓글 -> 게시판 추천 제한정보 insert
	@GetMapping(value="/detail")
	public String commBoardDetail(Model model, HttpSession session,
			@RequestParam int cb_bid,
			@RequestParam(defaultValue="1", required=false) int page) {
		
		// 접속된 게시판의 id로 데이터 조회
		CommunityBoardDTO data = commBoardservice.findBoard(cb_bid);
		
		CommunityBoardStaticsDTO staticData = new CommunityBoardStaticsDTO();
		
		// 로그인 유저 확인
		if(session.getAttribute("loginData") != null) {
			AccountDTO loginData = (AccountDTO)session.getAttribute("loginData");
			
			// 게시판 추천 제한 정보 조회
			staticData.setCbs_bid(cb_bid); 
			staticData.setCbs_wid(loginData.getAC_ID());
			
			staticData = commBoardservice.findBoardStatic(staticData);
		}
		
		if(data != null) {
			if(session.getAttribute("loginData") != null) {
				// 게시판 추천 제한 정보가 있는지 확인(추천 제한 정보가 없으면 생성 및 추가)
				commBoardservice.checkBoardStatics(session, data);   
			}
			
			// 댓글 목록 조회
			List commentDatas = commCommentService.findBoardComment(cb_bid);
			
			Paging commentPage = new Paging(commentDatas, page, 10);
			
			model.addAttribute("boardData", data);
			model.addAttribute("boardStaticData", staticData);
			model.addAttribute("commentPage", commentPage);
			
			return "community/detail";
		}else {
			// 게시판 정보 없음
			model.addAttribute("error", "해당 게시판이 존재하지 않습니다.");
			return "error/notExists";
		}
		
	}
	
	// 게시판 등록(추가) 추가하는 페이지 띄우기 - Get
	@GetMapping(value = "/add")
	public String add() {
		return "community/add";
	}
	
	// 게시판 등록(데이터 처리) - Post
	@PostMapping(value = "/add")
	public String add(HttpServletRequest request,
			@ModelAttribute CommunityLoadBoardVO boardVO,
			@SessionAttribute("loginData") AccountDTO acDto) {
		
		CommunityBoardDTO data = new CommunityBoardDTO();
		data.setCb_catid(boardVO.getCatid());
		data.setCb_title(boardVO.getTitle());
		data.setCb_content(boardVO.getContent());
		data.setCb_wid(acDto.getAC_ID());
		
		int cb_bid = commBoardservice.addBoard(data);
		
		if(cb_bid != -1) {
			// 정상적으로 게시판 추가
			return "redirect:/community/detail?cb_bid=" + cb_bid;
		}else {
			
			return "community/add";
		}
	}
	
	// 게시판 수정(기존 내용 불러와서 페이지에 출력) - Get
	@GetMapping(value = "/modify")
	public String modify(Model model, 
			@RequestParam int cb_bid,
			@SessionAttribute("loginData") AccountDTO acDto) {
		CommunityBoardDTO data = commBoardservice.findBoard(cb_bid);
				
		if(data != null) {
			// 게시판 등록자인지 확인
			if(data.getCb_wid().equals(acDto.getAC_ID())) {
				model.addAttribute("boardData", data);
				return "community/modify";
			}else {
				// 게시판 등록자가 아니니 에러 페이지로
				model.addAttribute("error", "해당 작업을 수행할 권힌이 없습니다.");
				return "error/permission";
			}
		}else {
			model.addAttribute("error", "해당 데이터가 존재하지 않습니다.");
			return "error/notExists";
		}
		
	}
	
	// 게시판 수정(데이터 처리) - Post
	@PostMapping(value = "/modify")
	public String modify(Model model,
			@RequestParam int cb_bid,
			@ModelAttribute CommunityLoadBoardVO boardVO,
			@SessionAttribute("loginData") AccountDTO acDto) {

		CommunityBoardDTO data = commBoardservice.findBoard(cb_bid);
		
		if(data != null) {			
			if(data.getCb_wid().equals(acDto.getAC_ID())) {
				// 수정된 게시판 정보 설정
				data.setCb_catid(boardVO.getCatid());
				data.setCb_title(boardVO.getTitle());
				data.setCb_content(boardVO.getContent());
				
				boolean result = commBoardservice.modifyBoard(data);
				
				if(result) {
					// 데이터 수정 성공
					return "redirect:/community/detail?cb_bid=" + data.getCb_bid();
				}else {
					// 데이터 수정 실패
					return "community/modify";
				}
				
			}else {
				model.addAttribute("error", "해당 작업을 수행할 권힌이 없습니다.");
				return "error/permission";
			}
			
		}else {
			model.addAttribute("error", "해당 데이터가 존재하지 않습니다.");
			return "error/notExists";
		}
	}
	
	// 게시판 삭제(ajax 사용)
	@SuppressWarnings("unchecked") 
	@PostMapping(value = "/delete", produces = "application/json; charset=utf-8") // produces는 ajax를 쓰기 위한 설정
	@ResponseBody
	public String delete(@RequestParam int cb_bid,
						 @SessionAttribute("loginData") AccountDTO acDto) {
		// 삭제할 게시판 정보 조회
		CommunityBoardDTO data = commBoardservice.findBoard(cb_bid);
		JSONObject json = new JSONObject();
		
		if(data == null) {
			// 삭제할 데이터 없음
			json.put("code", "notExists");
			json.put("message", "이미 삭제 된 데이터 입니다.");
		} else {
			// 샘플 데이터로 로그인 정보 처리(로그인 정보로 수정)
			if(data.getCb_wid().equals(acDto.getAC_ID())) {
				// 작성자, 수정자 동일인
				boolean result = commBoardservice.removeBoard(data);
				if(result) {
					json.put("code", "success");
					json.put("message", "삭제가 완료되었습니다.");
				} else {
					// 삭제 실패
					json.put("code", "fail");
					json.put("message", "삭제 작업 중 문제가 발생하였습니다.");
				}
			} else {
				// 작성자, 수정자 동일인 아님 - 권한 없음
				json.put("code", "permissionError");
				json.put("message", "삭제 할 권한이 없습니다.");
			}
		}
		
		return json.toJSONString();
	}
	
	// 게시판 추천 처리
	@SuppressWarnings({ "unchecked", "unused" }) 
	@PostMapping(value = "/like", produces = "application/json; charset=utf-8")
	@ResponseBody
	public String like(HttpSession session, @RequestParam int cb_bid,
						@SessionAttribute("loginData") AccountDTO acDto) {
		CommunityBoardDTO data = commBoardservice.findBoard(cb_bid);
		// 로그인한 회원 id로 댓글 추천 제한 정보 조회
		CommunityBoardStaticsDTO bs = new CommunityBoardStaticsDTO();
		bs.setCbs_bid(cb_bid);
		bs.setCbs_wid(acDto.getAC_ID());
		
		JSONObject json = new JSONObject();
		
		if(data == null) {
			// 존재하지 않음.
			json.put("code", "noData");
			json.put("message", "해당 데이터가 존재하지 않습니다.");
		} else {
			// 게시판 정보 수정할 때 BoardStaticsDTO 정보도 같이 수정된다
			commBoardservice.modifyBoardLike(session, data);
			
			// 게시판 추천 제한 정보의 추천여부도 ajax로 전달
			bs = commBoardservice.findBoardStatic(bs);
			
			json.put("code", "success");
			json.put("like", data.getCb_like());
			json.put("isLiked", bs.isCbs_liked());
		}
		
		return json.toJSONString();
	}
	
	// 게시판 댓글 추가
	@PostMapping(value="/comment/add")
	public String commentAdd(@ModelAttribute CommunityCommentDTO commentData,
							@RequestParam int cb_bid,
							@SessionAttribute("loginData") AccountDTO acDto) {
		
		int sort = 0, depth = 0, child = 0, parent = 0; // 대댓글 정렬 순서, 대댓글 깊이, 자식댓글 수, 부모 댓글id
		
		CommunityCommentDTO comment = new CommunityCommentDTO();
		comment.setCc_bid(cb_bid);
		comment.setCc_content(commentData.getCc_content());
		comment.setCc_id(commentData.getCc_id());
		comment.setCc_wid(acDto.getAC_ID());	
		
		boolean result = false;
		
		//System.out.println(commentData.getCc_id());
		// 일반 댓글의 경우(cc_id == 0)
		if(comment.getCc_id() == 0) {
			comment.setCc_sort(sort); // 일반댓글의 경우 정렬, 깊이 = 0, 부모, 자식 0
			comment.setCc_depth(depth);
			comment.setCc_child(child);
			comment.setCc_parents(parent);
			result = commCommentService.addCommComment(comment);
		}else {
			
			CommunityCommentDTO parentComment = commCommentService.findComment(comment.getCc_id());
			// 기본 댓글에 댓글
			if(parentComment.getCc_sort() == 0 && parentComment.getCc_depth() == 0) {
				comment.setCc_gid(parentComment.getCc_gid());
				int maxSort = commCommentService.maxSort(parentComment.getCc_gid());
				comment.setCc_sort(maxSort);
				comment.setCc_id(commCommentService.getNextSeq());
				comment.setCc_depth(parentComment.getCc_depth() + 1);
				comment.setCc_parents(parentComment.getCc_id());
				boolean check = commCommentService.addCommComment(comment);
				if(check) {
					result = true;
				}
			}else {
				// 댓글의 댓글
				comment.setCc_gid(parentComment.getCc_gid());
				int maxChildSort = commCommentService.maxChildSort(parentComment.getCc_id());
				comment.setCc_sort(maxChildSort);
				commCommentService.updateSort(comment);
				comment.setCc_sort(comment.getCc_sort() + 1);
				comment.setCc_id(commCommentService.getNextSeq());
				comment.setCc_depth(parentComment.getCc_depth() + 1);
				comment.setCc_parents(parentComment.getCc_id());
				boolean check = commCommentService.addCommComment(comment);
				if(check) {
					result = true;
				}
				
			}
			
			if(result) {
				int totalChild = commCommentService.findTotalChild(parentComment.getCc_id());
				parentComment.setCc_child(totalChild);
				commCommentService.updateChild(parentComment);
			}
			
		}
		
		if(result) {
			// 댓글 추가 성공
			return "redirect:/community/detail?cb_bid=" + cb_bid;
		}else {
			// 댓글 추가 실패
			return "redirect:/community/detail?cb_bid=" + cb_bid;
		}

	}
	
	// 게시판 댓글 수정
	@SuppressWarnings("unchecked") 
	@PostMapping(value="comment/modify", produces = "application/json; charset=utf-8")
	@ResponseBody
	public String commentModify(@RequestParam int cc_id,
								@RequestParam String cc_content,
								@SessionAttribute("loginData") AccountDTO acDto) {
		JSONObject json = new JSONObject();
		
		CommunityCommentDTO comment = commCommentService.findComment(cc_id);
		
		if(comment.getCc_wid().equals(acDto.getAC_ID())) {
			comment.setCc_content(cc_content);
			boolean result = commCommentService.modifyCommComment(comment);
			if(result) {
				json.put("code", "success");
				json.put("value", comment.getCc_content());
			}
		}
		
		return json.toJSONString();		
	}
	
	// 게시판 댓글 삭제
	@SuppressWarnings("unchecked") // 아래 코드의 json.put의 주의를 체크 해제
	@PostMapping(value = "/comment/delete", produces = "application/json; charset=utf-8")
	@ResponseBody
	public String commentDelete(@RequestParam int cc_id, 
								@SessionAttribute("loginData") AccountDTO acDto) {
		
		JSONObject json = new JSONObject();
		CommunityCommentDTO comment = commCommentService.findComment(cc_id);
		
		if (comment == null) {
			// 삭제할 데이터 없음
			json.put("code", "notExists"); // 주의가 떳지만 문제가 아님
			json.put("message", "이미 삭제된 데이터 입니다.");
		} else {
			
			if (comment.getCc_wid().equals(acDto.getAC_ID())) {
				boolean result = commCommentService.removeCommComment(comment);
				if (result) {
					// 삭제 완료
					json.put("code", "success");
					json.put("message", "댓글 삭제 완료");
				} else {
					// 삭제 실패
					json.put("code", "fail");
					json.put("message", "삭제 실패.");
				}

			} else {
				// 동일인 아님 = 권한 없음
				json.put("code", "poermissionError");
				json.put("message", "삭제 권한이 없습니다.");
			}
		}
		
		return json.toJSONString();
	}
	
	// 게시판 댓글 추천 처리
	@SuppressWarnings({ "unchecked"}) 
	@PostMapping(value = "/comment/like", produces = "application/json; charset=utf-8")
	@ResponseBody
	public String commentLike(HttpSession session, @RequestParam int cc_id) {
		JSONObject json = new JSONObject();
		
		CommunityCommentDTO data = commCommentService.findComment(cc_id);
		
		if(data == null) {
			// 존재하지 않음.
			json.put("code", "noData");
			json.put("message", "해당 데이터가 존재하지 않습니다.");
		} else {
			commCommentService.checkCommentLike(session, data);
			json.put("code", "success");
			json.put("like", data.getCc_like());
		}
		
		return json.toJSONString();
	}
		
	// 이미지 업로드
	@SuppressWarnings("unchecked") // 아래 코드의 json.put의 주의를 체크 해제
	@PostMapping(value = "/image", produces = "application/json; charset=utf-8")
	@ResponseBody
	public String commImageUpload(
			HttpServletRequest request
			, @RequestParam("upload") MultipartFile[] files) throws Exception {
		
		String realPath = request.getServletContext().getRealPath("/resources");
		JSONObject json = new JSONObject();
		
		for(MultipartFile file: files) {
			// 파일 출력은 생략
			// 서버에 업로드한 파일(이미지, 문서등)을 ckeditor가 요청 -> 서버는 url 주소로 파일 주소를 보내줌
			json.put("uploaded", 1);
			json.put("fileName", file.getOriginalFilename());
			json.put("url", request.getContextPath() + "/static/community/img/" + file.getOriginalFilename());
			
			file.transferTo(new File(realPath + "/community/img/" + file.getOriginalFilename()));
		}
		
		return json.toJSONString();
	}
	
}
