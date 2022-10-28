package com.web.home.course.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.web.home.common.util.Paging;
import com.web.home.course.service.CourseService;

@Controller
@RequestMapping(value="/course")
public class CourseController {
	@Autowired
	private CourseService service;

	@GetMapping(value="")
	public String courseMain(Model model, HttpSession session,
				@RequestParam(defaultValue = "1", required = false) int page,
				@RequestParam(defaultValue = "allCourse", required = false)String sort,
				@RequestParam(required = false)String lessonSearch) {
		System.out.println("검색어 : " + lessonSearch);
		List courseDatas;
		if(lessonSearch != null) {
			courseDatas = service.getSearchAll(lessonSearch);
			model.addAttribute("search", lessonSearch);
			if(courseDatas.size() == 0) {
				model.addAttribute("foundNothing", 0);
			}
		}else {
			courseDatas = service.getAll(sort);
		}

		Paging paging = new Paging(courseDatas, page, 9);

		model.addAttribute("courseDatas", paging.getPageData());
		model.addAttribute("pageData", paging);
		model.addAttribute("sort", sort);
		
		return "course/main";
	}
	
}
