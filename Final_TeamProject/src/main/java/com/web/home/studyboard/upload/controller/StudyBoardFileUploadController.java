package com.web.home.studyboard.upload.controller;

import java.io.File;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

@Controller
@RequestMapping(value="/studyupload")
public class StudyBoardFileUploadController {

	@PostMapping(value="/image", produces="application/json; charset=utf-8")
	@ResponseBody
	public String image(HttpServletRequest request
			, @RequestParam("upload") MultipartFile[] files) throws Exception {
		
		String realPath = request.getServletContext().getRealPath("/resources");
		JSONObject json = new JSONObject();
		
		for(MultipartFile file: files) {
			json.put("uploaded", 1);
			json.put("fileName", file.getOriginalFilename());
			json.put("url", request.getContextPath() + "/static/img/studyboard/" + file.getOriginalFilename());
			
			file.transferTo(new File(realPath + "/img/studyboard/" + file.getOriginalFilename()));
		}
		
		return json.toJSONString();
	}
}
