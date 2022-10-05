package com.web.home.studyboard.model;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class StudyBoardDAO {

	@Autowired
	private SqlSession session;
	private String mapper = "studyBoardMapper.%s";
	
	public List<StudyBoardDTO> selectAll() {
		// 학습 게시판 전체 글 조회
		String mapperId = String.format(mapper, "selectAll");
		List<StudyBoardDTO> result = session.selectList(mapperId);
		return result;
	}

	public StudyBoardDTO selectData(int id) {
		// 학습 게시판 하나의 글 조회
		String mapperId = String.format(mapper, "selectData");
		StudyBoardDTO result = session.selectOne(mapperId, id);
		return result;
	}

	public int getNextSeq() {
		// 학습 게시판 게시글 추가시 글번호 자동생성
		String mapperId = String.format(mapper, "getNextSeq");
		int seq = session.selectOne(mapperId);
		return seq;
	}

	public boolean insertData(StudyBoardDTO data) {
		// 학습 게시판 게시글 추가
		String mapperId = String.format(mapper, "insertData");
		int result = session.insert(mapperId, data);
		return result == 1 ? true : false;
	}
	
	public List<StudyBoardDTO> selectSearch(Map<String, String> map) {
		// 학습 게시판 통합 검색
		String mapperId = String.format(mapper, "selectSearch");
		List<StudyBoardDTO> result = session.selectList(mapperId, map);
		return result;
	}

	public boolean updateData(StudyBoardDTO data) {
		// 학습 게시판 게시글 수정
		String mapperId = String.format(mapper, "updateData");
		int result = session.update(mapperId, data);
		return result == 1 ? true : false;
	}

	public boolean deleteData(StudyBoardDTO data) {
		// 학습 게시판 게시글 삭제
		String mapperId = String.format(mapper, "deleteData");
		int result = session.delete(mapperId, data);
		return result == 1 ? true : false;
	}

	public StudyBoardStaticsDTO selectStatics(StudyBoardStaticsDTO staticsData) {
		// 추천 데이터 조회
		String mapperId = String.format(mapper, "selectStatics");
		StudyBoardStaticsDTO result = session.selectOne(mapperId, staticsData);
		return result;
	}
	
	public boolean insertStatics(StudyBoardStaticsDTO staticsData) {
		// 추천 기록 추가
		String mapperId = String.format(mapper, "insertStatics");
		int result = session.insert(mapperId, staticsData);
		return result == 1 ? true : false;
	}

	public boolean updateStaticsLike(StudyBoardStaticsDTO staticsData) {
		// 추천 여부 수정
		String mapperId = String.format(mapper, "updateStaticsLike");
		int result = session.update(mapperId, staticsData);
		return result == 1 ? true : false;
	}

	public boolean updateLike(StudyBoardDTO data) {
		// 학습 게시판 게시글 추천수 수정
		String mapperId = String.format(mapper, "updateLike");
		int result = session.update(mapperId, data);
		return result == 1 ? true : false;
	}

	public boolean deleteStaticsData(StudyBoardStaticsDTO staticsData) {
		// 학습 게시판 게시글 추천 기록 삭제
		String mapperId = String.format(mapper, "deleteStaticsData");
		int result = session.delete(mapperId, staticsData);
		return result >= 0 ? true : false;
	}

	public List<StudyBoardDTO> selectAllSort(String sort) {
		// 전체 게시판 정렬에 따른 데이터 조회
		String mapperId = String.format(mapper, "selectAllSort");
		List<StudyBoardDTO> result = session.selectList(mapperId, sort);
		return result;
	}

	public List<StudyBoardDTO> selectCatSort(Map<String, Integer> map) {
		// 카테고리별 게시판 정렬에 따른 데이터 조회
		String mapperId = String.format(mapper, "selectCatSort");
		List<StudyBoardDTO> result = session.selectList(mapperId, map);
		return result;
	}

	public List<StudyBoardDTO> selectDoneSort(Map<String, Integer> map) {
		// 모집여부 게시판 정렬에 따른 데이터 조회
		String mapperId = String.format(mapper, "selectDoneSort");
		List<StudyBoardDTO> result = session.selectList(mapperId, map);
		return result;
	}
	
	public List<StudyBoardDTO> myPageselectCatData(Map input) {
		// 카테고리별 데이터 가져오기
		String mapperId = String.format(mapper, "myPageselectCatData");
		List<StudyBoardDTO> result = session.selectList(mapperId, input);
		return result;
	}
	
	public List<StudyBoardDTO> selectUserStudyData(String wId) {
		// 학습 게시판 사용자 글 조회
		String mapperId = String.format(mapper, "selectUserStudyData");
		List<StudyBoardDTO> result = session.selectList(mapperId, wId);
		return result;
	}

	public List<StudyBoardDTO> selectBoardList(List boardIdDatas) {
		// 스터디 댓글 단 글 조회
		String mapperId = String.format(mapper, "selectBoardList");
		List<StudyBoardDTO> result = session.selectList(mapperId, boardIdDatas);
		return result;
	}

}
