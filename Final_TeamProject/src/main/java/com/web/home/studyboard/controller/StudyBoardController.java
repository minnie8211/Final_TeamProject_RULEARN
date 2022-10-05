package com.web.home.studyboard.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

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

import com.web.home.studyboard.comment.model.StudyCommentDTO;
import com.web.home.studyboard.comment.service.StudyCommentService;
import com.web.home.studyboard.model.StudyBoardDTO;
import com.web.home.studyboard.service.StudyBoardService;
import com.web.home.studyboard.vo.StudyBoardVO;
import com.web.home.account.model.AccountDTO;
import com.web.home.common.util.Paging;

@Controller
@RequestMapping(value="/studyboard")
public class StudyBoardController {
	
	private static int CAT_ID_STUDY = 4;
	private static int CAT_ID_PROJECT = 5;
	private static boolean IS_DONE_OPEN = false;	//모집중
	private static boolean IS_DONE_CLOSE = true;	//모집완료
	
	@Autowired
	private StudyBoardService service;
	
	@Autowired
	private StudyCommentService commentService;
	
	@GetMapping(value="")
	public String getList(Model model, HttpSession session
			, @RequestParam(required=false) String search
			, @RequestParam(defaultValue="main", required=false) String menu
			, @RequestParam(defaultValue="as_latest", required=false) String sort
			, @RequestParam(defaultValue="1", required=false) int page
			, @RequestParam(defaultValue="0", required=false) int pageCount) {
		//카테고리,모집여부
		//학습 게시판 전체 목록
		
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
		
		
		if(session.getAttribute("sort") == null) {
			session.setAttribute("sort", "as_latest");
		}
		if(sort != null) {
			session.setAttribute("sort", sort);
		}
		sort = session.getAttribute("sort").toString();
		
		if(search == null || search.equals("")) {
			Alldatas = service.getAll();
			if(menu != null) {
				if(menu.equals("main")) {
					Alldatas = service.getAllSort(sort);
				} else if(menu.equals("study")) {
					Alldatas = service.getCatSort(CAT_ID_STUDY, sort);
				} else if(menu.equals("project")) {
					Alldatas = service.getCatSort(CAT_ID_PROJECT, sort);
				} else if(menu.equals("open")) {
					Alldatas = service.getDoneSort(IS_DONE_OPEN, sort);
				} else if(menu.equals("close")) {
					Alldatas = service.getDoneSort(IS_DONE_CLOSE, sort);
				} else {
					model.addAttribute("error", "해당 카테고리가 존재하지 않습니다.");
					return "error/notExists";
				}
			}
		} else {
			Alldatas = service.getSearch(search, sort);
			model.addAttribute("search", search);
		}
		
		Paging paging = new Paging(Alldatas, page, pageCount);
		
		model.addAttribute("menu", menu);
		model.addAttribute("Alldatas", paging.getPageData());
		model.addAttribute("pageData", paging);
		model.addAttribute("sort", sort);
		
		return "studyboard/list";
	}
	
	@GetMapping(value="/detail")
	public String getDetail(Model model
			, @RequestParam int id
			, @RequestParam(defaultValue="1", required=false) int page) {
		
		StudyBoardDTO data = service.getData(id);
		// 게시물 번호로 데이터 가져오기
		
		if(data != null) {
			List commentDatas = commentService.getDatas(data.getSb_bId());
			model.addAttribute("originalData", commentDatas);
			
			Paging commentPage = new Paging(commentDatas, page, 10);
			
			model.addAttribute("data", data);
			model.addAttribute("commentPage", commentPage);
			
			return "studyboard/detail";
		} else {
			model.addAttribute("error", "해당 데이터가 존재하지 않습니다.");
			return "error/notExists";
		}
	}
	
	@GetMapping(value="/add")
	public String add() {
		return "studyboard/add";
	}
	
	@PostMapping(value="/add")
	public String add(@SessionAttribute("loginData") AccountDTO accountDto
			, HttpServletRequest request
			, @ModelAttribute StudyBoardVO sBoardVo) {
		
		StudyBoardDTO data = new StudyBoardDTO();
		data.setSb_wId(accountDto.getAC_ID());
		data.setSb_title(sBoardVo.getSb_title());
		data.setSb_content(sBoardVo.getSb_content());
		data.setSb_catId(sBoardVo.getSb_catId());
		data.setSb_isDone(sBoardVo.isSb_isDone());
		
		int bId = service.add(data);
		
		if(bId != -1) {
			return "redirect:/studyboard/detail?id=" + bId;			
		} else {
			request.setAttribute("error", "게시글 저장 실패!");
			return "studyboard/add";
		}
	}

	@GetMapping(value="/modify")
	public String modify(Model model
			, @RequestParam int id
			, @SessionAttribute("loginData") AccountDTO accountDto) {
		
		StudyBoardDTO data = service.getData(id);
		// 게시물 번호로 게시글 데이터 가져오기
		
		if(data != null) {
			if(data.getSb_wId().equals(accountDto.getAC_ID())) {
				//작성자와 로그인 사용자의 아이디가 같을 때 수정 가능
				model.addAttribute("data", data);
				return "studyboard/modify";
			} else {
				model.addAttribute("error", "해당 작업을 수행할 권한이 없습니다.");
				return "error/permission";
			}
		}  else {
			model.addAttribute("error", "해당 데이터가 존재하지 않습니다.");
			return "error/notExists";
		}
	}
	
	@PostMapping(value="/modify")
	public String modify(Model model
			, @ModelAttribute StudyBoardVO sBoardVo
			, @SessionAttribute("loginData") AccountDTO accountDto) {
		
		StudyBoardDTO data = service.getData(sBoardVo.getSb_bId());	//수정할 게시글의 기존 데이터 가져오기
		
		if(data != null) {
			if(data.getSb_wId().equals(accountDto.getAC_ID())) {
				//작성자와 로그인 사용자가 같을 때 수정 가능
				data.setSb_title(sBoardVo.getSb_title());
				data.setSb_content(sBoardVo.getSb_content());
				data.setSb_catId(sBoardVo.getSb_catId());
				data.setSb_isDone(sBoardVo.isSb_isDone());
				
				boolean result = service.modify(data);
				if(result) {
					return "redirect:/studyboard/detail?id=" + data.getSb_bId();	
				} else {
					return modify(model, data.getSb_bId(), accountDto);
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
	
	@PostMapping(value="/delete", produces="application/json; charset=utf-8")
	@ResponseBody
	public String delete(@RequestParam int id
			, @SessionAttribute("loginData") AccountDTO accountDto) {
		StudyBoardDTO data = service.getData(id);
		//삭제할 게시글 데이터 가져오기
		
		JSONObject json = new JSONObject();
		
		if(data == null) {
			//삭제할 데이터 없음
			json.put("code", "notExists");
			json.put("message", "이미 삭제된 데이터 입니다.");
		} else {
			if(data.getSb_wId().equals(accountDto.getAC_ID())) {
				try {
					//삭제 완료
					boolean result = commentService.remove(data);
					result = service.remove(data);
					json.put("code", "success");
					json.put("message", "삭제가 완료되었습니다.");
				} catch(Exception e) {
					//삭제 실패
					json.put("code", "fail");
					json.put("message", "삭제 작업 중 문제가 발생하였습니다.");
					e.printStackTrace();
				}
			} else {
				//작성자, 수정자 동일인 아님 - 권한 없음
				json.put("code", "permissionError");
				json.put("message", "삭제 할 권한이 없습니다.");
			}
		}
		return json.toJSONString();
	}
	
	@PostMapping(value="/like", produces="application/json; charset=utf-8")
	@ResponseBody
	public String like(@RequestParam int id
			, @SessionAttribute("loginData") AccountDTO accountDto) {
		
		StudyBoardDTO data = service.getData(id);
		//게시글 데이터 가져오기
		
		JSONObject json = new JSONObject();

		if(data == null) {
			json.put("code", "noData");
			json.put("message", "해당 데이터가 존재하지 않습니다.");
		} else {
			service.incLike(accountDto, data);
			json.put("code", "success");
			json.put("sb_like", data.getSb_like());
		}
		
		return json.toJSONString();
	}
	
	@PostMapping(value="/comment/add")
	public String commentAdd(@ModelAttribute StudyCommentDTO scData
			, @SessionAttribute("loginData") AccountDTO accountDto) {
		
		int sc_sort = 0 , sc_depth = 0, child = 0, parents = 0;
		
		StudyCommentDTO data = new StudyCommentDTO();
		data.setSc_bId(scData.getSc_bId());
		data.setSc_content(scData.getSc_content());
		data.setSc_id(scData.getSc_id());
		data.setSc_wId(accountDto.getAC_ID());
		
		boolean result  = false;
		if(data.getSc_id() != 0) {
			StudyCommentDTO parentData = commentService.getData(data.getSc_id());
			if(parentData.getSc_sort() == 0 && parentData.getSc_depth() == 0) {
				//기본 댓글에 댓글을 달 때
				data.setSc_gId(parentData.getSc_gId());
				int maxSort = commentService.maxSort(parentData.getSc_gId());
				data.setSc_sort(maxSort);
				data.setSc_id(commentService.getNextSeq());
				data.setSc_depth(parentData.getSc_depth() + 1);
				data.setSc_parents(parentData.getSc_id());
				boolean res = commentService.add(data);
				if(res) {
					result = true;
				}
			} else {
				// 댓글의 댓글을 달 때
				data.setSc_gId(parentData.getSc_gId());
				int maxChildSort = commentService.maxChildSort(parentData.getSc_id());
				data.setSc_sort(maxChildSort);
				commentService.updateSort(data);
				data.setSc_sort(data.getSc_sort() + 1);
				data.setSc_id(commentService.getNextSeq());
				data.setSc_depth(parentData.getSc_depth() + 1);
				data.setSc_parents(parentData.getSc_id());
				boolean res = commentService.add(data);
				if(res) {
					result = true;
				}
			}
			
			if(result) {
				//자식,자손 댓글이 정상적으로 추가되면 부모의 자식개수를 증가시킴
				int totalChild = commentService.selectTotalChild(parentData.getSc_id());
				parentData.setSc_child(totalChild);
				commentService.updateChild(parentData);
			}
		} else {
			// 기본 댓글
			data.setSc_sort(sc_sort);
			data.setSc_depth(sc_depth);
			data.setSc_child(child);
			data.setSc_parents(parents);
			result = commentService.add(data);
		}
		
		if(result) {
			return "redirect:/studyboard/detail?id=" + scData.getSc_bId();
		} else {
			return "redirect:/studyboard/detail?id=" + scData.getSc_bId();
		}
		
	}
	
	@PostMapping(value="/comment/delete", produces="application/json; charset=utf-8")
	@ResponseBody
	public String commentDelete(@RequestParam int id
			, @SessionAttribute("loginData") AccountDTO accountDto) {
		StudyCommentDTO data = commentService.getData(id);
		
		JSONObject json = new JSONObject();
		
		if (data == null) {
			// 삭제할 데이터 없음
			json.put("code", "notExists");
			json.put("message", "이미 삭제된 데이터 입니다.");
		} else {
			if(data.getSc_wId().equals(accountDto.getAC_ID())) {
				boolean result = commentService.removeUp(data);
				if(result) {
					json.put("code", "success");
					json.put("message", "댓글 삭제 완료");
					json.put("value", "삭제된 댓글입니다.");
				} else {
					json.put("code", "fail");
					json.put("message", "삭제 실패");
				}
			} else {
				json.put("code", "poermissionError");
				json.put("message", "삭제 권한이 없습니다.");
			}
		}
		
		return json.toJSONString();
	}
	
	@PostMapping(value="/comment/modify", produces="application/json; charset=utf-8")
	@ResponseBody
	public String commentModify(@RequestParam int id
			, @RequestParam String content
			, @SessionAttribute("loginData") AccountDTO accountDto) {
		
		StudyCommentDTO data = commentService.getData(id);
		
		JSONObject json = new JSONObject();
		
		if(data.getSc_wId().equals(accountDto.getAC_ID())) {
			//댓글 작성자 아이디와 로그인 사용자 아이디가 같을 때 수정가능
			data.setSc_content(content);
			boolean result = commentService.modify(data);
			if(result) {
				json.put("code", "success");
				json.put("value", data.getSc_content());
			}
		} 
		return json.toJSONString();
	}
	
	@PostMapping(value = "/comment/like", produces = "application/json; charset=utf-8")
	@ResponseBody
	public String commentLike(@RequestParam int id
			, @SessionAttribute("loginData") AccountDTO accountDto) {
		
		JSONObject json = new JSONObject();
		
		StudyCommentDTO data = commentService.getData(id);	//댓글 데이터 조회
		
		if(data == null) {
			json.put("code", "noData");
			json.put("message", "해당 데이터가 존재하지 않습니다.");
		} else {
			//세선 로그인으로 추후 수정 필요
			commentService.CommentLike(accountDto, data);
			json.put("code", "success");
			json.put("like", data.getSc_like());
		}
		
		return json.toJSONString();
	}
}

