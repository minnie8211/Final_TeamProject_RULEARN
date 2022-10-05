package com.web.home.course.service;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.web.home.account.model.AccountDTO;
import com.web.home.course.model.CourseDAO;
import com.web.home.course.model.CourseDTO;
import com.web.home.course.model.Curriculum_bigDTO;
import com.web.home.course.model.Curriculum_smallDTO;
import com.web.home.course.model.LessonManagerDTO;
import com.web.home.course.model.QA_answerDTO;
import com.web.home.course.model.QA_boardDTO;
import com.web.home.course.model.ReviewDTO;
import com.web.home.course.model.ReviewInfoDTO;
import com.web.home.course.vo.QnAVO;
import com.web.home.course.vo.ReviewVO;

@Service
public class CourseService {
	@Autowired
	CourseDAO dao;

	public List<CourseDTO> getAll(String sort) {
		List<CourseDTO> datas = dao.selectAll(sort);
		//리뷰 및 평균
		getReviewAmount_avg(datas);
		
		return datas;
	}
	public List<CourseDTO> getSearchAll(String keyword){
		List<CourseDTO> datas = dao.selectSearchAll(keyword);
		getReviewAmount_avg(datas);
		return datas;
	}

	//리뷰 갯수와 평균 가져오기
	private void getReviewAmount_avg(List<CourseDTO> datas) {
		for(int i = 0; i < datas.size(); i++) {
			ReviewInfoDTO reviewInfo =  getReviewAmount_AVG(datas.get(i).getL_id());
			datas.get(i).setAmount(reviewInfo.getAMOUNT());
			datas.get(i).setAvg(reviewInfo.getAVG());
		}
	}
	public CourseDTO getLessonDetail(int id) {
		CourseDTO data = dao.selectLessonData(id);
		return data;
	}

	public List<Curriculum_bigDTO> getCurriBigTitle(int id) {
		List<Curriculum_bigDTO> data = dao.selectCurriBigTitle(id);
		return data;
	}

	public List<Curriculum_smallDTO> getCurriData(int id) {
		List<Curriculum_smallDTO> data = dao.selectCurriData(id);
		return data;
	}

	public List<ReviewDTO> getReviewDatas(int id, String sort) {
		Map<String, Object> reviewMap = new HashMap<String, Object>();
		reviewMap.put("id", id);
		reviewMap.put("sort", sort);
		
		List<ReviewDTO> data = dao.selectReviewDatas(reviewMap);
		return data;
	}
	//리뷰 수정, 삭제시 사용
	public ReviewDTO getReview(int rb_id) {
		ReviewDTO data = dao.selectReview(rb_id);
		return data;
	}

	public ReviewInfoDTO getReviewStatics(int id) {
		ReviewInfoDTO info = getReviewAmount_AVG(id);
		
		if(info.getAMOUNT() > 0) {
			Map<String, Integer> eachScoreAmount = new HashMap<String, Integer>();
			int[] score = new int[5];
			int[] scorePercent = new int[5];
			
			for(int i = 0; i < 5; i++) {
				eachScoreAmount.put("score", i + 1);
				eachScoreAmount.put("id", id);
				score[i] = dao.selectEachScoreAmount(eachScoreAmount);
				scorePercent[i] = 0;
				if(score[i] != 0) {
					scorePercent[i] = (int)(((double)score[i] / info.getAMOUNT()) * 100);
				}
			}
			info.setScore(score);
			info.setScorePercent(scorePercent);
		}
		return info;
	}

	public ReviewInfoDTO getReviewAmount_AVG(int id) {
		ReviewInfoDTO info = new ReviewInfoDTO();
		
		Map<String, BigDecimal> amount_avg = dao.selectReviewAmount_AVG(id);
		info.setAMOUNT((amount_avg.get("AMOUNT")).intValue());
		
		if(amount_avg.get("AMOUNT").intValue() > 0) {
			info.setAVG(amount_avg.get("AVG").floatValue());
		}
		return info;
	}

	public boolean modifyReview(ReviewDTO reviewData) {
		boolean result = dao.updateReview(reviewData);
		return result;
	}
	
	public boolean deleteReview(ReviewDTO reviewData) {
		boolean result = dao.deleteReview(reviewData);
		return result;
	}
	
	public List<QnAVO> getQnA_answersInLesson(int lid) {
		List<QnAVO> datas = dao.selectQnA_answersInLesson(lid);
		return datas;
	}

	public QA_boardDTO getQnA(int id) {
		QA_boardDTO data = dao.selectQnA(id);
		return data;
	}
	
	public boolean modifyQnA(QA_boardDTO qa_boardData) {
		boolean result = dao.updateQnA(qa_boardData);
		return result;
	}

	public boolean getHistoryDatas(HttpSession session, int id) {
		AccountDTO accountDto = (AccountDTO) session.getAttribute("loginData");
		LessonManagerDTO historyDTO = new LessonManagerDTO(accountDto.getAC_ID(), id);
		
		boolean result = dao.selectHistoryData(historyDTO);
		return result;
	}

	public boolean deleteQnA(int bid) {
		boolean result = dao.deleteQnA(bid);
		return result;
	}

	public QA_answerDTO getQA_answer(int bid) {
		QA_answerDTO data = dao.selectQA_answerData(bid);
		return data;
	}

	public boolean modifyQA_answer(QA_answerDTO qa_answerData) {
		boolean result = dao.updateQA_answer(qa_answerData);
		return result;
	}

	public boolean deleteQA_answer(int bid) {
		boolean result = dao.deleteQA_answer(bid);
		return result;
	}
	public boolean addQA_answer(QA_answerDTO answer) {
		boolean result = dao.insertQA_answer(answer);
		return result;
	}

	public boolean addReview(ReviewVO reviewVO) {
		boolean result = dao.insertReview(reviewVO);
		return result;
	}

	public boolean addQnA(QnAVO QnAVO) {
		boolean result = dao.insertQnA(QnAVO);
		return result;
	}
	
	public List<CourseDTO> selectLessonList(String lm_wid) {
		List<CourseDTO> datas = dao.selectLessonList(lm_wid);
		return datas;
	}

	public boolean getCartInfo(HttpSession session, int id) {
		AccountDTO accountDto = (AccountDTO) session.getAttribute("loginData");
		
		Map<String, Object> check = new HashMap<String, Object>();
		check.put("W_ACID", accountDto.getAC_ID());
		check.put("W_LID", id);
		
		boolean result = dao.selectCartInfo(check);
		return result;
	}
	
	public boolean getReviewHistory(HttpSession session, int id) {
		AccountDTO accountDto = (AccountDTO) session.getAttribute("loginData");
		
		Map<String, Object> check = new HashMap<String, Object>();
		check.put("rb_wid", accountDto.getAC_ID());
		check.put("rb_lid", id);
		
		boolean result = dao.selectReviewHistory(check);
		return result;
	}
	public List getTakenLessons(String lm_wid) {
		List<CourseDTO> datas = dao.selectTakenLessons(lm_wid);
		return datas;
	}

}
