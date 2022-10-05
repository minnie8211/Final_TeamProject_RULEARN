package com.web.home.course.controller;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.web.home.account.model.AccountDTO;
import com.web.home.course.model.QA_answerDTO;
import com.web.home.course.model.QA_boardDTO;
import com.web.home.course.service.CourseService;
import com.web.home.course.vo.QnAVO;

@Controller
@SuppressWarnings("unchecked")
@RequestMapping(value = "/course/QnA")
public class QnAController {

	@Autowired
	private CourseService service;

	@PostMapping(value = "/modify", produces = "application/json; charset=utf-8")
	@ResponseBody
	public String modifyQnA(@SessionAttribute("loginData") AccountDTO accountDto, @RequestParam("bid") int bid,
			@RequestParam("content") String content) {

		JSONObject json = new JSONObject();
		QA_boardDTO qa_boardData = service.getQnA(bid);

		if (accountDto.getAC_ID().equals(qa_boardData.getQb_wid())) {
			qa_boardData.setQb_content(content);
			boolean result = service.modifyQnA(qa_boardData);

			if (result) {
				json.put("value", qa_boardData.getQb_content().replace("\r", "\\r").replace("\n", "\\n"));
			}
		}
		return json.toJSONString();
	}

	@PostMapping(value = "/delete", produces = "application/json; charset=utf-8")
	@ResponseBody
	public String deleteQnA(@SessionAttribute("loginData") AccountDTO accountDto, @RequestParam("bid") int bid) {
		JSONObject json = new JSONObject();
		QA_boardDTO qaData = service.getQnA(bid);
		if (qaData == null) {
			json.put("type", "notExist");
			json.put("message", "삭제할 QnA가 없습니다.");
		} else {
			if (accountDto.getAC_ID().equals(qaData.getQb_wid())) {
				boolean result = service.deleteQnA(qaData.getQb_bid());
				if (!result) {
					json.put("type", "fail");
					json.put("message", "삭제에 실패하였습니다");
				} else {
					json.put("type", "success");
					json.put("message", "QnA가 삭제되었습니다.");
				}
			}
		}

		return json.toJSONString();
	}

	@PostMapping(value = "/answer/modify", produces = "application/json; charset=utf-8")
	@ResponseBody
	public String modifyQnA_answer(@SessionAttribute("loginData") AccountDTO accountDto, @RequestParam("bid") int bid,
			@RequestParam("content") String content) {

		JSONObject json = new JSONObject();
		QA_answerDTO qa_answerData = service.getQA_answer(bid);

		if (accountDto.getAC_ID().equals(qa_answerData.getQaa_wid())) {
			qa_answerData.setQaa_content(content);
			boolean result = service.modifyQA_answer(qa_answerData);

			if (result) {
				json.put("value", qa_answerData.getQaa_content().replace("\r", "\\r").replace("\n", "\\n"));
			}
		}
		return json.toJSONString();
	}

	@PostMapping(value = "/answer/delete", produces = "application/json; charset=utf-8")
	@ResponseBody
	public String deleteQnA_answer(@SessionAttribute("loginData") AccountDTO accountDto, @RequestParam("bid") int bid) {
		JSONObject json = new JSONObject();
		QA_answerDTO qa_answerData = service.getQA_answer(bid);
		if (qa_answerData == null) {
			json.put("type", "notExist");
			json.put("message", "삭제할 QnA 답변이 없습니다.");
		} else {
			if (accountDto.getAC_ID().equals(qa_answerData.getQaa_wid())) {
				boolean result = service.deleteQA_answer(qa_answerData.getQaa_bid());
				if (!result) {
					json.put("type", "fail");
					json.put("message", "삭제에 실패하였습니다");
				} else {
					json.put("type", "success");
					json.put("message", "QnA 답변이 삭제되었습니다.");
				}
			}
		}

		return json.toJSONString();
	}


}
