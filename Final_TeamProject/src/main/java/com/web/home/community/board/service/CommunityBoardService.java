package com.web.home.community.board.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.web.home.account.model.AccountDTO;
import com.web.home.community.board.model.CommunityBoardDAO;
import com.web.home.community.board.model.CommunityBoardDTO;
import com.web.home.community.board.model.CommunityBoardStaticsDTO;

@Service
public class CommunityBoardService {

	@Autowired
	private CommunityBoardDAO comm_dao;
	
	// 게시판 식별자로 해당 데이터 조회
	public CommunityBoardDTO findBoard(int cb_bid) {
		CommunityBoardDTO data = comm_dao.selectBoardData(cb_bid);
		
		return data;		
	}	
	
	// 특정 게시판 정보들 불러오기(사용자 id)
	List<CommunityBoardDTO> findUserBoard(String cb_wid){
		List<CommunityBoardDTO> datas = comm_dao.selectUserBoard(cb_wid);
		return datas;
	}	

	// 전체 화면(main) - 모든 게시판 조회
	public List<CommunityBoardDTO> findBoardAll() {
		List<CommunityBoardDTO> datas = comm_dao.selectBoardAll();
		return datas;
	}
	
	// 댓글순으로 모든 게시판 조회
	public List findBoardOrderByCommentAll() {
		List<CommunityBoardDTO> datas = comm_dao.selectBoardOrderByCommentAll();
		return datas;
	}
	
	// 추천순으로 모든 게시판 조회
	public List findBoardOrderByLikeAll() {
		List<CommunityBoardDTO> datas = comm_dao.selectBoardOrderByLikeAll();
		return datas;
	}
	
	// 전체 게시판에서 검색(정렬 검색은 map) - 통합검색/게시판 내 검색
	public List<CommunityBoardDTO> findSearchAll(String keyword, String sort) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("keyword", keyword);
		map.put("sort", sort);

		List<CommunityBoardDTO> datas = comm_dao.selectSearchAll(map);
		return datas;
	}

	// QA, 팁, 자유(포럼) 카테고리별로 조회 - 기본 최신순
	// - QA 1, 자유 2, 팁 3
	public List<CommunityBoardDTO> findBoardCategory(int cb_catid) {
		List<CommunityBoardDTO> datas = comm_dao.selectBoardCategory(cb_catid);
		return datas;
	}
	
	public List<CommunityBoardDTO> myPagefindBoardCategory(Map input) {
		List<CommunityBoardDTO> datas = comm_dao.myPageselectBoardCategory(input);
		return datas;
	}
	
	// - 댓글 많은 순 
	public List<CommunityBoardDTO> findBoardOrderByComment(int cb_catid){	
		List<CommunityBoardDTO> datas = comm_dao.selectBoardOrderByComment(cb_catid);
		return datas;		
	}
	
	// - 추천수 많은 순
	public List<CommunityBoardDTO> findBoardOrderByLike(int cb_catid){
		List<CommunityBoardDTO> datas = comm_dao.selectBoardOrderByLike(cb_catid);
		return datas;		
	}	
	
	// 카테고리별로 검색
	public List<CommunityBoardDTO> findSearchCategory(String keyword, String sort, int catid) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("keyword", keyword);
		map.put("sort", sort);
		
		switch(catid) {
		case 1:
			map.put("catid", "QA");
			break;
		case 2:
			map.put("catid", "FORUM");
			break;
		case 3:
			map.put("catid", "TIP");
			break;
		}
		
		List<CommunityBoardDTO> datas = comm_dao.selectSearchCategory(map);
		return datas;
	}
	
	// 추가 기능 -> 시퀀스 생성(sql문에서 식별자 자동생성 처리)
	public int addBoard(CommunityBoardDTO data) {	
		// cb_bid 미리 받아오기
		int seq = comm_dao.getNextSeq();
		data.setCb_bid(seq);
		
		boolean result = comm_dao.insertBoardData(data); // 게시판 추가

		if (result) {
			return data.getCb_bid(); // 추가 완료되면 식별자값 반환
		}

		return -1;
	}
	
	// 수정 기능
	public boolean modifyBoard(CommunityBoardDTO data) {
		boolean result = comm_dao.updateBoardData(data);

		return result;
	}
	
	// 삭제 기능
	public boolean removeBoard(CommunityBoardDTO data) {
		CommunityBoardStaticsDTO staticsData = new CommunityBoardStaticsDTO();
		staticsData.setCbs_bid(data.getCb_bid()); // 게시판 식별자id 설정
		
		comm_dao.deleteStaticsData(staticsData); // 커뮤니티 게시판 제한 정보 삭제
		
		boolean result = comm_dao.deleteBoardData(data);
		
		return result;
	}

	// 추천 기능(게시판 추천 제한 정보 수정) -> 추천하기 눌렀을 때 제한 정보가 없으면 생성해주자
	// 하단의 추천 제한 정보가 이미 있는지 확인하는 메서드 후 사용
	public void modifyBoardLike(HttpSession session, CommunityBoardDTO data) {
		
		AccountDTO loginData = (AccountDTO)session.getAttribute("loginData");
		
		CommunityBoardStaticsDTO staticsData = new CommunityBoardStaticsDTO();
		staticsData.setCbs_bid(data.getCb_bid()); // 추천할 게시판 id를 제한 정보 id로 설정
		staticsData.setCbs_wid(loginData.getAC_ID());
		
		staticsData = comm_dao.selectStaticsData(staticsData); // 로그인한 회원의 id로 해당 게시판의 추천 제한 정보를 조회
		
		if(staticsData.isCbs_liked()) {
			staticsData.setCbs_liked(false); // 추천 했었을 경우 추천 취소로 값 변경
			
			data.setCb_like(data.getCb_like() - 1); // 해당 게시판의 추천수 데이터를 -1 
			
		}else {
			staticsData.setCbs_liked(true);// 추천 안했을 경우 추천으로 값 변경
			data.setCb_like(data.getCb_like() + 1); // 해당 게시판의 추천수 데이터를 +1 
		}
		
		// 변경된 추천 제한 정보를 서버에 반영
		comm_dao.updateStaticsData(staticsData);
		
		// 변경된 게시판의 추천수 정보를 서버에 반영
		comm_dao.updateBoardLike(data);
		
		
	}
	
	// 게시판 상세 페이지에 들어간 경우 작동
	public void checkBoardStatics(HttpSession session, CommunityBoardDTO data) {
		
		AccountDTO loginData = (AccountDTO)session.getAttribute("loginData");
				
		// 체크할 추천 제한 정보 생성
		CommunityBoardStaticsDTO staticsData = new CommunityBoardStaticsDTO();
		staticsData.setCbs_bid(data.getCb_bid()); // 추천 제한 정보에 해당 게시판 id 설정
		staticsData.setCbs_wid(loginData.getAC_ID()); // 추천 제한 정보에 유저 id 설정 
		
		staticsData = comm_dao.selectStaticsData(staticsData); // 해당 회원의 게시판 추천 제한 정보가 있는지 조회
		
		if(staticsData == null) {
			// 추천 제한 정보가 없다면(해당 게시판을 처음 방문)
			// 추천 제한 정보를 생성해서 서버에 추가
			CommunityBoardStaticsDTO newStaticsData = new CommunityBoardStaticsDTO();
			newStaticsData.setCbs_bid(data.getCb_bid());
			newStaticsData.setCbs_wid(loginData.getAC_ID()); 
			
			comm_dao.insertStaticsData(newStaticsData);
			
		}
	}

	// 게시판 추천 제한 정보 조회 - 유저 ID(AC_ID)로 조회
	public CommunityBoardStaticsDTO findBoardStatic(CommunityBoardStaticsDTO staticsData) {
		CommunityBoardStaticsDTO data = comm_dao.selectStaticsData(staticsData);
		
		return data;
		
	}
	
	

}
