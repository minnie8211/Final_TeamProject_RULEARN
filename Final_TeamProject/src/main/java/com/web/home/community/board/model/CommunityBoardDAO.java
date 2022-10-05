package com.web.home.community.board.model;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class CommunityBoardDAO {

	@Autowired
	private SqlSession session = null;

	private String mapper = "commBoardMapper.%s";

	// 특정 게시판 1개 조회
	public CommunityBoardDTO selectBoardData(int cb_bid) {
		String mapperId = String.format(mapper, "selectBoardData");
		CommunityBoardDTO res = session.selectOne(mapperId, cb_bid);

		return res;
	}
	
	// 유저 id로 해당 유저가 작성한 게시판들 조회
	public List<CommunityBoardDTO> selectUserBoard(String cb_wid) {
		String mapperId = String.format(mapper, "selectUserBoard");
		List<CommunityBoardDTO> res = session.selectList(mapperId, cb_wid);

		return res;
	}

	// 모든 게시판 조회 -> between 1 and 3
	public List<CommunityBoardDTO> selectBoardAll() {
		String mapperId = String.format(mapper, "selectBoardAll");
		List<CommunityBoardDTO> res = session.selectList(mapperId);

		return res;
	}
	
	// 댓글순 모든 게시판 조회
	public List<CommunityBoardDTO> selectBoardOrderByCommentAll() {
		String mapperId = String.format(mapper, "selectBoardOrderByCommentAll");
		List<CommunityBoardDTO> res = session.selectList(mapperId);

		return res;
	}
	
	// 추천순 모든 게시판 조회
	public List<CommunityBoardDTO> selectBoardOrderByLikeAll() {
		String mapperId = String.format(mapper, "selectBoardOrderByLikeAll");
		List<CommunityBoardDTO> res = session.selectList(mapperId);

		return res;
	}

	// 특정 카테고리로 게시판 조회
	// QA 1, 자유 2, 팁 3 -> 이거 외에 카테고리가 들어가면 안됨!
	// 기본적으로 최신순 정렬
	public List<CommunityBoardDTO> selectBoardCategory(int cb_catid) {
		String mapperId = String.format(mapper, "selectBoardCategory");
		List<CommunityBoardDTO> res = session.selectList(mapperId, cb_catid);

		return res;
	}
	
	public List<CommunityBoardDTO> myPageselectBoardCategory(Map input) {
		String mapperId = String.format(mapper, "myPageselectBoardCategory");
		List<CommunityBoardDTO> res = session.selectList(mapperId, input);

		return res;
	}
	
	// 최신순(기본), 댓글순, 추천순 정렬
	public List<CommunityBoardDTO> selectBoardOrderByComment(int cb_catid) {
		String mapperId = String.format(mapper, "selectBoardOrderByComment");
		List<CommunityBoardDTO> res = session.selectList(mapperId, cb_catid);

		return res;
	}

	public List<CommunityBoardDTO> selectBoardOrderByLike(int cb_catid) {
		String mapperId = String.format(mapper, "selectBoardOrderByLike");
		List<CommunityBoardDTO> res = session.selectList(mapperId, cb_catid);

		return res;
	}

	// 게시판 추가
	public boolean insertBoardData(CommunityBoardDTO data) {
		String mapperId = String.format(mapper, "insertBoardData");
		int res = session.insert(mapperId, data);

		return res == 1 ? true : false;
	}

	// 게시판 수정
	public boolean updateBoardData(CommunityBoardDTO data) {
		String mapperId = String.format(mapper, "updateBoardData");
		int res = session.update(mapperId, data);
		return res == 1 ? true : false;
	}
	
	// 게시판 추천수 수정
	public boolean updateBoardLike(CommunityBoardDTO data) {
		String mapperId = String.format(mapper, "updateBoardLike");
		int res = session.update(mapperId, data);
		return res == 1 ? true : false;
		
	}

	// 게시판 삭제
	public boolean deleteBoardData(CommunityBoardDTO data) {
		String mapperId = String.format(mapper, "deleteBoardData");
		int res = session.delete(mapperId, data);

		return res == 1 ? true : false;
	}


	// ============================
	// 커뮤니티 게시판 추천 제한 정보

	// 제한 정보 조회
	public CommunityBoardStaticsDTO selectStaticsData(CommunityBoardStaticsDTO staticsData) {
		String mapperId = String.format(mapper, "selectStaticsData");
		CommunityBoardStaticsDTO data = session.selectOne(mapperId, staticsData);
		return data;
	}
	

	// 게시판 추천 제한 정보 추가
	public boolean insertStaticsData(CommunityBoardStaticsDTO staticsData) {
		String mapperId = String.format(mapper, "insertStaticsData");
		int res = session.insert(mapperId, staticsData);
		return res == 1 ? true : false;
	}	
	
	// 게시판 추전 제한 정보 삭제
	public boolean deleteStaticsData(CommunityBoardStaticsDTO staticsData) {
		String mapperId = String.format(mapper, "deleteStaticsData");
		int res = session.delete(mapperId, staticsData);

		// 삭제 결과가 1 이상이어야 한다
		return res > 0 ? true : false;

	}

	// 게시판 추천 제한 정보 수정(추천여부 Y, N)
	public boolean updateStaticsData(CommunityBoardStaticsDTO staticsData) {
		String mapperId = String.format(mapper, "updateStaticsData");
		int res = session.update(mapperId, staticsData);
		return res == 1 ? true : false;
		
	}

	// 모든 게시판에서 키워드(작성자, 제목, 내용) 조회
	public List<CommunityBoardDTO> selectSearchAll(Map<String, String> map) {
		String mapperId = String.format(mapper, "selectSearchAll");
		List<CommunityBoardDTO> res = session.selectList(mapperId, map);

		return res;
	}

	// 카테고리별로 키워드 조회
	public List<CommunityBoardDTO> selectSearchCategory(Map<String, String> map) {
		String mapperId = String.format(mapper, "selectSearchCategory");
		List<CommunityBoardDTO> res = session.selectList(mapperId, map);

		return res;
	}

	public int getNextSeq() {
		String mapperId = String.format(mapper, "getNextSeq");
		int seq = session.selectOne(mapperId);
		
		return seq;
	}
	
	//0924 추가
	public List<CommunityBoardDTO> selectUserCommuData(String wId) {
		// 커뮤니티 게시판 사용자 글 조회
		String mapperId = String.format(mapper, "selectUserCommuData");
		List<CommunityBoardDTO> result = session.selectList(mapperId, wId);
		return result;
	}

	//0924 추가
	public List<CommunityBoardDTO> selectBoardList(List boardIdDatas) {
		// 커뮤니티 댓글 단 글 조회
		String mapperId = String.format(mapper, "selectBoardList");
		List<CommunityBoardDTO> result = session.selectList(mapperId, boardIdDatas);
		return result;
	}

}
