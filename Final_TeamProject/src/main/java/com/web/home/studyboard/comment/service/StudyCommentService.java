package com.web.home.studyboard.comment.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.web.home.account.model.AccountDTO;
import com.web.home.studyboard.comment.model.StudyCommentDAO;
import com.web.home.studyboard.comment.model.StudyCommentDTO;
import com.web.home.studyboard.comment.model.StudyCommentStaticsDTO;
import com.web.home.studyboard.model.StudyBoardDTO;

@Service
public class StudyCommentService {

	@Autowired
	private StudyCommentDAO dao;

	public List<StudyCommentDTO> getDatas(int sb_bId) {
		// 게시물 번호로 댓글 데이터 가져오기
		List<StudyCommentDTO> datas = dao.selectDatas(sb_bId);
		return datas;
	}
	
	public int getNextSeq() {
		int seq = dao.getNextSeq();
		return seq;
	}
	
	@Transactional
	public boolean add(StudyCommentDTO data) {
		// 댓글 추가

		if(data.getSc_id() == 0) {
			int seq = this.getNextSeq();
			data.setSc_id(seq);
			data.setSc_gId(seq);	
		}
		
		boolean result = dao.insertData(data);
		
		if(!result) {
			throw new RuntimeException("코멘트 추가 처리에 문제가 발생 하였습니다.");
		}
		
		return result;
	}

	public StudyCommentDTO getData(int sc_id) {
		// 댓글 데이터 가져오기
		StudyCommentDTO data = dao.selectData(sc_id);
		return data;
	}

	public int maxSort(int sc_gId) {
		// 댓글 sort 최댓값
		int result = dao.maxSort(sc_gId);
		return result;
	}

	public boolean updateSort(StudyCommentDTO data) {
		// 댓글 sort 업데이트
		boolean result = dao.updateSort(data);
		return result;
	}

	public int maxChildSort(int sc_id) {
		// 자식 댓글 최댓값
		int result = dao.maxChildSort(sc_id);
		return result;
	}
	
	public int selectTotalChild(int id) {
		// 자식 댓글 총합의 수
		int result = dao.totalChild(id);
		return result;
	}

	public boolean updateChild(StudyCommentDTO data) {
		// 부모 댓글의 자식개수 업데이트
		boolean result = dao.updateChild(data);
		return result;
	}

	public boolean removeUp(StudyCommentDTO data) {
		// 댓글 삭제(상태만 업데이트)
		boolean result = dao.deleteUpData(data);
		return result;
	}
	
	public boolean remove(StudyBoardDTO data) {
		// 댓글 삭제(실제로 삭제)
		boolean result = dao.deleteData(data);
		return result;
	}

	public boolean modify(StudyCommentDTO data) {
		// 댓글 수정
		boolean result = dao.updateData(data);
		return result;
	}
	
	// 마이페이지전용 댓글 가져오기(스터디, 프로젝트)
	public List<StudyCommentDTO> myPageGetCommentDatas(Map input) {
		List<StudyCommentDTO> datas = dao.myPageSelectCommentDatas(input);
		return datas;
	}

	@Transactional
	public void CommentLike(AccountDTO accountDto, StudyCommentDTO data) {
		// 학습 게시판 댓글 추천
		StudyCommentStaticsDTO commentStaticsData = new StudyCommentStaticsDTO();
		commentStaticsData.setScs_cId(data.getSc_id());
		commentStaticsData.setScs_wId(accountDto.getAC_ID());
		
		commentStaticsData = dao.selectCommentStatics(commentStaticsData);
		
		if(commentStaticsData == null) {
			//추천 기록이 없음
			commentStaticsData = new StudyCommentStaticsDTO();
			commentStaticsData.setScs_cId(data.getSc_id());
			commentStaticsData.setScs_wId(accountDto.getAC_ID());
			boolean insertResult = dao.insertCommentStatics(commentStaticsData);
			
			if(!insertResult) {
				throw new RuntimeException("댓글 추천 추가 처리에 문제가 발생 하였습니다.");
			}
			
			data.setSc_like(data.getSc_like() + 1);
		} else {
			//추천 기록이 있다면
			if(commentStaticsData.isScs_liked()) {
				commentStaticsData.setScs_liked(false);
				data.setSc_like(data.getSc_like() - 1);
			} else {
				commentStaticsData.setScs_liked(true);
				data.setSc_like(data.getSc_like() + 1);
			}
			boolean updateResult = dao.updateCommentStaticsLike(commentStaticsData);
			
			if(!updateResult) {
				throw new RuntimeException("댓글 추천 업데이트 처리에 문제가 발생 하였습니다.");
			}
		}
		boolean result = dao.updateCommentLike(data);
		
		if(!result) {
			throw new RuntimeException("댓글 추천수 통계 추가 처리에 문제가 발생 하였습니다.");
		}
	}
}
