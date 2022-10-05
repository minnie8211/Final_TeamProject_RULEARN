package com.web.home.course.model;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.web.home.account.model.AccountDTO;
import com.web.home.course.vo.QnAVO;
import com.web.home.course.vo.ReviewVO;
import com.web.home.mypage.model.WishlistDTO;

@Repository
public class CourseDAO {

	@Autowired
	private SqlSession session;

	public List<CourseDTO> selectAll(String sort) {
		List<CourseDTO> result = session.selectList("courseMapper.selectAll", sort);
		return result;
	}

	public List<CourseDTO> selectSearchAll(String keyword) {
		List<CourseDTO> result = session.selectList("courseMapper.selectSearchAll", keyword);
		return result;
	}
	
	public CourseDTO selectLessonData(int id) {
		CourseDTO result = session.selectOne("courseMapper.selectLessonData", id);
		return result;
	}

	public List<ReviewInfoDTO> selectCourseAmount_LID(String sort) {
		List<ReviewInfoDTO> result = session.selectList("courseMapper.selectEachCourseSort_LID", sort);
		return result;
	}
	
	public List<Curriculum_bigDTO> selectCurriBigTitle(int id) {
		List<Curriculum_bigDTO> result = session.selectList("courseMapper.selectCurriBigTitle", id);
		return result;
	}

	public List<Curriculum_smallDTO> selectCurriData(int id) {
		List<Curriculum_smallDTO> result = session.selectList("courseMapper.selectCurriData", id);
		return result;
	}

	public List<ReviewDTO> selectReviewDatas(Map<String, Object> reviewMap) {
		List<ReviewDTO> result = session.selectList("courseMapper.selectReviewDatas", reviewMap);
		return result;
	}
	
	public ReviewDTO selectReview(int rb_id) {
		ReviewDTO result = session.selectOne("courseMapper.selectReview", rb_id);
		return result;
	}
	
	public Map<String, BigDecimal> selectReviewAmount_AVG(int id) {
		Map<String, BigDecimal> result = session.selectOne("courseMapper.selectReviewAmount_AVG", id);
		return result;
	}

	public boolean updateReview(ReviewDTO reviewData) {
		int result = session.update("courseMapper.updateReview", reviewData);
		return result == 1 ? true : false;
	}
	
	public boolean deleteReview(ReviewDTO reviewData) {
		int result = session.delete("courseMapper.deleteReview", reviewData);
		return result == 1 ? true : false;
	}
	
	public int selectEachScoreAmount(Map<String, Integer> eachScoreAmount) {
		int result = session.selectOne("courseMapper.selectEachScoreAmount", eachScoreAmount);
		return result;
	}
	
	public List<QnAVO> selectQnA_answersInLesson(int lid) {
		 List<QnAVO> result = session.selectList("courseMapper.selectQnA_answersInLesson", lid);
		return result;
	}
	
	public QA_boardDTO selectQnA(int id) {
		QA_boardDTO result = session.selectOne("courseMapper.selectQnA", id);
		return result;
	}
	
	public boolean updateQnA(QA_boardDTO qa_boardData) {
		int result = session.update("courseMapper.updateQnA", qa_boardData);
		return result == 1 ? true : false;
	}

	public boolean selectHistoryData(LessonManagerDTO historyDTO) {
		int result = session.selectOne("courseMapper.selectHistoryData", historyDTO);
		return result == 1 ? true : false;
	}
	
	public boolean deleteQnA(int bid) {
		int result = session.delete("courseMapper.deleteQnA", bid);
		return result == 1 ? true : false;
	}

	public QA_answerDTO selectQA_answerData(int bid) {
		QA_answerDTO result = session.selectOne("courseMapper.selectQA_answerData", bid);
		return result;
	}

	public boolean updateQA_answer(QA_answerDTO qa_answerData) {
		int result = session.update("courseMapper.updateQA_answer", qa_answerData);
		return result == 1 ? true : false;
	}

	public boolean deleteQA_answer(int bid) {
		int result = session.delete("courseMapper.deleteQA_answer", bid);
		return result == 1 ? true : false;
	}

	public boolean insertReview(ReviewVO reviewVO) {
		int result = session.insert("courseMapper.insertReview", reviewVO);
		return result == 1 ? true : false;
	}

	public boolean insertQnA(QnAVO QnAVO) {
		int result = session.insert("courseMapper.insertQnA", QnAVO);
		return result == 1 ? true : false;
	}
	
	public int selectLidCount(String title) {
		int result = session.selectOne("courseMapper.selectLidCount", title);
		return result;
	}

	public boolean insertLesson(CourseDTO courseDto) {
		int result = session.insert("courseMapper.insertLesson", courseDto);
		return result == 1 ? true : false;
	}

	public boolean insertBigCurri(List<Curriculum_bigDTO> curri_big_list) {
		// TODO Auto-generated method stub
		return false;
	}

	public boolean insertSmallCurri(List<Curriculum_bigDTO> curri_big_list) {
		// TODO Auto-generated method stub
		return false;
	}

	public boolean insertFileInfo(FileInfoDTO files) {
		// TODO Auto-generated method stub
		return false;
	}

	
	public List<CourseDTO> selectLessonList(String lm_wid) {
		List<CourseDTO> result = session.selectList("courseMapper.selectLessonList", lm_wid);
		return result;
	}

	public boolean selectCartInfo(Map<String, Object> check) {
		WishlistDTO result = session.selectOne("wishlistMapper.checkWishlist", check);
		return result != null ? true : false;
	}

	public boolean insertQA_answer(QA_answerDTO answer) {
		int result = session.insert("courseMapper.insertQA_answer", answer);
		return result == 1 ? true : false;
	}

	public boolean selectReviewHistory(Map<String, Object> check) {
		int result = session.selectOne("courseMapper.selectReviewHistory", check);
		return result == 1 ? true : false;
	}

	
	public List<CourseDTO> selectTakenLessons(String lm_wid) {
		List<CourseDTO> result = session.selectList("courseMapper.selectTakenLessons", lm_wid);
		return result;
	}
	
}
