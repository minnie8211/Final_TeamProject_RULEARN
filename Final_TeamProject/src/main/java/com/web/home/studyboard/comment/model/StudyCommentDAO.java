package com.web.home.studyboard.comment.model;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.web.home.community.comment.model.CommunityCommentIdDTO;
import com.web.home.studyboard.model.StudyBoardDTO;


@Repository
public class StudyCommentDAO {

	@Autowired
	private SqlSession session;
	private String mapper = "studyCommentMapper.%s";

	public List<StudyCommentDTO> selectDatas(int sb_bId) {
		// 게시물 번호로 댓글들 데이터 가져오기
		String mapperId = String.format(mapper, "selectDatas");
		List<StudyCommentDTO> result = session.selectList(mapperId, sb_bId);
		return result;
	}

	public boolean insertData(StudyCommentDTO data) {
		// 댓글 추가
		String mapperId = String.format(mapper, "insertData");
		int result = session.insert(mapperId, data);
		return result == 1 ? true : false;
	}

	public int getNextSeq() {
		// 댓글 추가시 번호 자동생성
		String mapperId = String.format(mapper, "getNextSeq");
		int seq = session.selectOne(mapperId);
		return seq;
	}

	public StudyCommentDTO selectData(int sc_id) {
		// 댓글 데이터 가져오기
		String mapperId = String.format(mapper, "selectData");
		StudyCommentDTO result = session.selectOne(mapperId, sc_id);
		return result;
	}

	public int maxSort(int sc_gId) {
		// 댓글 sort 최댓값
		String mapperId = String.format(mapper, "maxSort");
		int maxSort = session.selectOne(mapperId, sc_gId);
		return maxSort;
	}

	public boolean updateSort(StudyCommentDTO data) {
		// 댓글 sort 업데이트
		String mapperId = String.format(mapper, "updateSort");
		int result = session.update(mapperId, data);
		return result == 1 ? true : false;
	}

	public int maxChildSort(int sc_id) {
		// 자식 댓글 최댓값
		String mapperId = String.format(mapper, "maxChildSort");
		int maxChildSort = session.selectOne(mapperId, sc_id);
		return maxChildSort;
	}
	
	public int totalChild(int id) {
		// 자식 댓글 총합의 수
		String mapperId = String.format(mapper, "totalChild");
		int totalChild = session.selectOne(mapperId, id);
		return totalChild;
	}

	public boolean updateChild(StudyCommentDTO data) {
		// 부모 댓글의 자식개수 업데이트
		String mapperId = String.format(mapper, "updateChild");
		int result = session.update(mapperId, data);
		return result == 1 ? true : false;
	}

	public boolean deleteUpData(StudyCommentDTO data) {
		// 댓글 삭제(상태만 업데이트)
		String mapperId = String.format(mapper, "deleteUpData");
		int result = session.update(mapperId, data);
		return result == 1 ? true : false;
	}
	
	public boolean deleteData(StudyBoardDTO data) {
		// 댓글 삭제(실제로 삭제)
		String mapperId = String.format(mapper, "deleteData");
		int result = session.update(mapperId, data);
		return result == 1 ? true : false;
	}

	public boolean updateData(StudyCommentDTO data) {
		// 댓글 수정
		String mapperId = String.format(mapper, "updateData");
		int result = session.update(mapperId, data);
		return result == 1 ? true : false;
	}
	
	public List<StudyCommentDTO> myPageSelectCommentDatas(Map input){
		// 마이페이지용 댓글 가져오기
		String mapperId = String.format(mapper, "myPageSelectCommentData");
		List<StudyCommentDTO> result = session.selectList(mapperId, input);
		return result;
	}

	public StudyCommentStaticsDTO selectCommentStatics(StudyCommentStaticsDTO commentStaticsData) {
		// 댓글 추천 정보 조회
		String mapperId = String.format(mapper, "selectCommentStatics");
		StudyCommentStaticsDTO data = session.selectOne(mapperId, commentStaticsData);
		return data;
	}

	public boolean insertCommentStatics(StudyCommentStaticsDTO commentStaticsData) {
		// 댓글 추천 정보 추가
		String mapperId = String.format(mapper, "insertCommentStatics");
		int result = session.insert(mapperId, commentStaticsData);
		return result == 1 ? true : false;
	}

	public boolean updateCommentStaticsLike(StudyCommentStaticsDTO commentStaticsData) {
		// 댓글 추천 정보 수정
		String mapperId = String.format(mapper, "updateCommentStaticsLike");
		int result = session.update(mapperId, commentStaticsData);
		return result == 1 ? true : false;
	}

	public boolean updateCommentLike(StudyCommentDTO data) {
		// 댓글 추천수 수정
		String mapperId = String.format(mapper, "updateCommentLike");
		int result = session.update(mapperId, data);
		return result == 1 ? true : false;
	}

	public List<StudyCommentIdDTO> selectBoardID(String wId) {
		// 스터디 댓글 조회
		String mapperId = String.format(mapper, "selectBoardID");
		List<StudyCommentIdDTO> datas = session.selectList(mapperId, wId);
		return datas;
	}
	
}
