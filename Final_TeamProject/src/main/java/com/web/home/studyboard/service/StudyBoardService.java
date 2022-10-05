package com.web.home.studyboard.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.web.home.account.model.AccountDTO;
import com.web.home.studyboard.model.StudyBoardDAO;
import com.web.home.studyboard.model.StudyBoardDTO;
import com.web.home.studyboard.model.StudyBoardStaticsDTO;

@Service
public class StudyBoardService {

	@Autowired
	private StudyBoardDAO dao;

	public List<StudyBoardDTO> getAll() {
		// 학습 게시판 전체 글 조회
		List<StudyBoardDTO> datas = dao.selectAll();
		return datas;
	}

	public StudyBoardDTO getData(int id) {
		// 학습 게시판 한개의 글 조회
		StudyBoardDTO data = dao.selectData(id);
		return data;
	}

	public int add(StudyBoardDTO data) {
		// 학습 게시판 글 추가
		int seq = dao.getNextSeq();
		data.setSb_bId(seq);
		
		boolean result = dao.insertData(data);
		
		if(result) {
			return data.getSb_bId();
		}
		return -1;
	}
	
	public List<StudyBoardDTO> getSearch(String search, String sort) {
		// 학습 전체 게시판 검색어(제목, 내용, 작성자) 조회 - 통합검색/게시판 내 검색
		Map<String,String> map = new HashMap<String,String>();
		map.put("search", search);
		map.put("sort", sort);

		List<StudyBoardDTO> datas = dao.selectSearch(map);
		return datas;
	}

	public boolean modify(StudyBoardDTO data) {
		// 학습 게시판 게시글 수정
		boolean result = dao.updateData(data);
		return result;
	}

	public boolean remove(StudyBoardDTO data) {
		// 학습 게시판 게시글 삭제
		StudyBoardStaticsDTO staticsData = new StudyBoardStaticsDTO();
		staticsData.setSbs_bId(data.getSb_bId());
		
		dao.deleteStaticsData(staticsData);
		boolean result = dao.deleteData(data);
		return result;
	}

	@Transactional
	public void incLike(AccountDTO accountDto, StudyBoardDTO data) {
		// 학습 게시판 게시글 추천
		StudyBoardStaticsDTO staticsData = new StudyBoardStaticsDTO();
		staticsData.setSbs_bId(data.getSb_bId());
		staticsData.setSbs_wId(accountDto.getAC_ID());
		
		staticsData = dao.selectStatics(staticsData);	//추천 데이터 조회
		
		if(staticsData == null) {
			//추천 기록이 없음
			staticsData = new StudyBoardStaticsDTO();
			staticsData.setSbs_bId(data.getSb_bId());
			staticsData.setSbs_wId(accountDto.getAC_ID());
			boolean insertResult = dao.insertStatics(staticsData);
			
			if(!insertResult) {
				throw new RuntimeException("추천수 통계 추가 처리에 문제가 발생 하였습니다.");
			}
			
			data.setSb_like(data.getSb_like() + 1);
		} else {
			//추천 기록이 있다면
			if(staticsData.isSbs_liked()) {
				staticsData.setSbs_liked(false);
				data.setSb_like(data.getSb_like() - 1);
			} else {
				staticsData.setSbs_liked(true);
				data.setSb_like(data.getSb_like() + 1);
			}
			boolean updateResult = dao.updateStaticsLike(staticsData);
			
			if(!updateResult) {
				throw new RuntimeException("추천 여부 업데이트 처리에 문제가 발생 하였습니다.");
			}
		}
		boolean result = dao.updateLike(data);
		if(!result) {
			throw new RuntimeException("추천수 업데이트 처리에 문제가 발생 하였습니다.");
		}
		
	}
	
	public List<StudyBoardDTO> getAllSort(String sort) {
		// 전체 게시판 정렬에 따른 데이터 조회
		List<StudyBoardDTO> datas = this.getAll();	//기본 데이터
		
		switch(sort) {
			case "as_reply":
				datas = dao.selectAllSort(sort);
				break;
			case "as_likes":
				datas = dao.selectAllSort(sort);
				break;
		}
		return datas;
	}

	public List<StudyBoardDTO> getCatSort(int catId, String sort) {
		// 카테고리별 게시판 정렬에 따른 데이터 조회
		Map<String,Integer> map = new HashMap<String,Integer>();
		map.put("catId", catId);
		
		switch(sort) {
			case "as_reply":
				map.put("sort", 1); break;
			case "as_likes":
				map.put("sort", 2); break;
		}
		
		List<StudyBoardDTO> datas = dao.selectCatSort(map);
		return datas;
	}

	public List<StudyBoardDTO> getDoneSort(boolean sb_isDone, String sort) {
		// 모집여부 게시판 정렬에 따른 데이터 조회
		Map<String,Integer> map = new HashMap<String,Integer>();
		
		if(sb_isDone) {
			//모집완료
			map.put("isDone", 1);
		} else {
			//모집중
			map.put("isDone", 2);
		}
		
		switch(sort) {
			case "as_reply":
				map.put("sort", 1); break;
			case "as_likes":
				map.put("sort", 2); break;
		}
		
		List<StudyBoardDTO> datas = dao.selectDoneSort(map);
		return datas;
	}
	
	public List<StudyBoardDTO> myPagegetCatData(Map input) {
		// 카테고리 데이터 가져오기
		List<StudyBoardDTO> datas = dao.myPageselectCatData(input);
		return datas;
	}
	
}
