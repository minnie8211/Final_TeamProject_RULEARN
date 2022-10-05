package com.web.home;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.web.home.common.util.Paging;
import com.web.home.community.board.service.CommunityBoardService;
import com.web.home.course.service.CourseService;
import com.web.home.studyboard.service.StudyBoardService;

@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@Autowired 
	private CommunityBoardService commBoardService;
	
	@Autowired
	private StudyBoardService studyService;
	
	@Autowired
	private CourseService courseService;
	
	@GetMapping(value = "/")
	public String home(Model model, HttpSession session) {
		
		List commTotal = commBoardService.findBoardAll();
		List studyTotal = studyService.getAll();
		List courseTotal = courseService.getAll("");
		
		Paging commPaging = new Paging(commTotal, 1, 5);
		Paging studyPaging = new Paging(studyTotal, 1, 5);
		Paging coursePaging = new Paging(courseTotal, 1, 10);
		
		
		model.addAttribute("commBoardList", commPaging.getPageData());
		model.addAttribute("studyBoardList", studyPaging.getPageData());
		model.addAttribute("courseBoardList", coursePaging.getPageData());
		return "index";
	}
	
	@GetMapping(value = "/allsearch")
	public String allSearch(Model model, HttpSession session
			, @RequestParam(required=false) String search) {
		
		if(search == null || search.equals("")) {
			return "common/search";
		} else {
			List commBoardDatas = commBoardService.findSearchAll(search, "");
			List studyBoardDatas = studyService.getSearch(search, "");
			List courseDatas = courseService.getSearchAll(search);
			
			Paging commPaging = new Paging(commBoardDatas, 1, 3);
			Paging studyPaging = new Paging(studyBoardDatas, 1, 3);
			Paging coursePaging = new Paging(courseDatas, 1, 3);
			
			model.addAttribute("commSearch", commPaging.getPageData());
			model.addAttribute("studySearch", studyPaging.getPageData());
			model.addAttribute("courseSearch", coursePaging.getPageData());
			model.addAttribute("search", search);
			return "common/search";
		}
		
	}
	
}
