package com.web.home.community.comment.model;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class CommunityCommentDAO {

	@Autowired
	private SqlSession session = null;

	private String mapper = "commCommentMapper.%s";

	// 식별자도 댓글 데이터 조회
	public CommunityCommentDTO selectCommentData(int cc_id) {
		String mapperId = String.format(mapper, "selectCommentData");
		CommunityCommentDTO res = session.selectOne(mapperId, cc_id);

		return res;
	}

	// 게시판 id로 해당 게시판의 댓글들 조회
	public List<CommunityCommentDTO> selectBoardComment(int cc_bid) {
		String mapperId = String.format(mapper, "selectBoardComment");
		List<CommunityCommentDTO> res = session.selectList(mapperId, cc_bid);

		return res;
	}

	// 사용자 id로 해당 유저가 등록한 모든 댓글 조회
	public List<CommunityCommentDTO> selectUserComment(String cc_wid) {
		String mapperId = String.format(mapper, "selectUserComment");
		List<CommunityCommentDTO> res = session.selectList(mapperId, cc_wid);

		return res;
	}

	// 댓글 추가(생성) 시퀀스로 식별자 자동생성
	public boolean insertCommentData(CommunityCommentDTO data) {
		String mapperId = String.format(mapper, "insertCommentData");
		int res = session.insert(mapperId, data);

		return res == 1 ? true : false;
	}

	// 댓글 수정
	public boolean updateCommentData(CommunityCommentDTO data) {
		String mapperId = String.format(mapper, "updateCommentData");
		int res = session.update(mapperId, data);

		return res == 1 ? true : false;
	}

	// 댓글 추천수 수정
	public boolean updateCommentLike(CommunityCommentDTO data) {
		String mapperId = String.format(mapper, "updateCommentLike");
		int res = session.update(mapperId, data);

		return res == 1 ? true : false;
	}

	// 댓글 삭제 -> 댓글 DB 테이블의 CC_DELETED를 'Y' 처리, 웹페이지에서는 "삭제된 댓글입니다"라고 수정
	// 실제로는 update 처리
	public boolean removeCommentData(CommunityCommentDTO data) {
		String mapperId = String.format(mapper, "removeCommentData");
		int res = session.update(mapperId, data);

		return res == 1 ? true : false;
	}

	// 댓글 추천 제한 정보가 있는지 조회
	public CommunityCommentStaticsDTO selectCommentStaticsData(CommunityCommentStaticsDTO checkData) {
		String mapperId = String.format(mapper, "selectCommentStaticsData");
		CommunityCommentStaticsDTO data = session.selectOne(mapperId, checkData);

		return data;
	}

	// 추천 제한 정보 추가
	public boolean insertCommentStaticsData(CommunityCommentStaticsDTO newData) {
		String mapperId = String.format(mapper, "insertCommentStaticsData");
		int res = session.insert(mapperId, newData);
		return res == 1 ? true : false;
	}

	// 댓글 추천 제한 정보 추천 여부 수정(Y/N)
	public boolean updateCommentStaticLike(CommunityCommentStaticsDTO data) {
		String mapperId = String.format(mapper, "updateCommentStaticLike");
		int res = session.update(mapperId, data);

		return res == 1 ? true : false;

	}

	// 댓글 추천 제한 정보 삭제
	public boolean deleteCommentStaticsData(CommunityCommentStaticsDTO data) {
		String mapperId = String.format(mapper, "deleteCommentStaticsData");
		int res = session.delete(mapperId, data);

		return res == 1 ? true : false;
	}
	
	// 마이페이지용 댓글 조회
	public List<CommunityCommentDTO> myPageSelectCommentDatas(Map input){
		String mapperId = String.format(mapper, "myPageSelectCommentDatas");
		List<CommunityCommentDTO> res = session.selectList(mapperId, input);
		return res;
	}

	public int getNextSeq() {
		String mapperId = String.format(mapper, "getNextSeq");
		int seq = session.selectOne(mapperId);

		return seq;
	}

	public int maxSort(int cc_gid) {
		String mapperId = String.format(mapper, "maxSort");
		int maxSort = session.selectOne(mapperId, cc_gid);
		return maxSort;
	}

	public int maxChildSort(int cc_id) {
		String mapperId = String.format(mapper, "maxChildSort");
		int maxChildSort = session.selectOne(mapperId, cc_id);
		return maxChildSort;
	}

	public boolean updateCommentSort(CommunityCommentDTO data) {
		String mapperId = String.format(mapper, "updateCommentSort");
		int result = session.update(mapperId, data);
		return result == 1 ? true : false;
	}

	public int totalChild(int cc_id) {
		String mapperId = String.format(mapper, "totalChild");
		int totalChild = session.selectOne(mapperId, cc_id);
		return totalChild;
	}

	public boolean updateChild(CommunityCommentDTO data) {
		String mapperId = String.format(mapper, "updateChild");
		int result = session.update(mapperId, data);
		return result == 1 ? true : false;
	}

	public List<CommunityCommentDTO> selectFoldComment(int cc_gid) {
		String mapperId = String.format(mapper, "selectFoldComment");
		List<CommunityCommentDTO> res = session.selectList(mapperId, cc_gid);

		return res;
	}

	//0924 추가. 커뮤니티 댓글 조회
	public List<CommunityCommentIdDTO> selectBoardID(String wId) {
		String mapperId = String.format(mapper, "selectBoardID");
		List<CommunityCommentIdDTO> datas = session.selectList(mapperId, wId);
		return datas;
	}
	
}
