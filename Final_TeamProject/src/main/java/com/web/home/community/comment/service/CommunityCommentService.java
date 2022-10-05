package com.web.home.community.comment.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.web.home.account.model.AccountDTO;
import com.web.home.community.comment.model.CommunityCommentDAO;
import com.web.home.community.comment.model.CommunityCommentDTO;
import com.web.home.community.comment.model.CommunityCommentStaticsDTO;

@Service
public class CommunityCommentService {
	
	@Autowired
	private CommunityCommentDAO comm_dao;
	
	public int getNextSeq() {
		int seq = comm_dao.getNextSeq();
		return seq;
	}

	
	// 댓글 식별자로 해당 데이터 조회
	public CommunityCommentDTO findComment(int cc_id) {
		CommunityCommentDTO data = comm_dao.selectCommentData(cc_id);
		
		return data;		
	}		
	
	// 특정 게시판의 댓글들 조회(게시판 id로 조회)
	public List<CommunityCommentDTO> findBoardComment(int cc_bid){
		List<CommunityCommentDTO> datas = comm_dao.selectBoardComment(cc_bid);
		
		return datas;
		
	}
	
	// 특정 사용자의 댓글들 조회(사용자 id로 쓴 댓글들 조회) -> 게시판 조회에도 추가 필요
	public List<CommunityCommentDTO> findUserComment(String cc_wid){
		List<CommunityCommentDTO> datas = comm_dao.selectUserComment(cc_wid);
		
		return datas;
		
	}
	
	// 댓글 추가(댓글 생성)
	@Transactional
	public boolean addCommComment(CommunityCommentDTO data) {
		
		if(data.getCc_id() == 0) {
			int seq = this.getNextSeq();
			data.setCc_id(seq);
			data.setCc_gid(seq);
		}
		
		boolean result = comm_dao.insertCommentData(data);
		
		return result;
	}
	
	// 댓글 수정
	public boolean modifyCommComment(CommunityCommentDTO data) {
		boolean result = comm_dao.updateCommentData(data);
		
		return result;
	}
	
	
	
	// 댓글 삭제 -> 댓글 DB 테이블의 CC_DELETED를 'Y' 처리, 웹페이지에서는 "삭제된 댓글입니다"라고 수정
	public boolean removeCommComment(CommunityCommentDTO data) {
		boolean result = comm_dao.removeCommentData(data);
		
		return result;
	}
	
	// 게시판 상세 페이지에 들어오고 댓글들의 추천 여부를 확인하기 위한 메서드
	// 해당 댓글의 추천을 눌렀을 때 작동하는걸 전제로 한다
	public void checkCommentLike(HttpSession session, CommunityCommentDTO commentData) {
		// 게시판에 들어온 회원 정보 불러오기
		AccountDTO loginData = (AccountDTO)session.getAttribute("loginData");
		
		// 체크할 정보 생성
		CommunityCommentStaticsDTO checkData = new CommunityCommentStaticsDTO();
		checkData.setCcs_cid(commentData.getCc_id());
		checkData.setCcs_wid(loginData.getAC_ID());
		
		checkData = comm_dao.selectCommentStaticsData(checkData);
		
		if(checkData == null) {
			// 댓글을 추천한 적이 없는 경우 추천 제한 정보를 추가하고 댓글 추천수 수정
			CommunityCommentStaticsDTO newData = new CommunityCommentStaticsDTO();
			newData.setCcs_cid(commentData.getCc_id());
			newData.setCcs_wid(loginData.getAC_ID()); // ccs_wid
			
			// 추천 제한 정보 추가(생성)
			boolean result = comm_dao.insertCommentStaticsData(newData);
			
			if(!result) {
				// 댓글 추천 제한 정보 추가 안됨
				
			}else {
				// 댓글의 추천 수 +1, 추천 제한 정보는 'Y'로 추가됨
				commentData.setCc_like(commentData.getCc_like() + 1);
				
			}
			
		}else {
			// 추천 제한 정보 Y/N 확인 후 수정
			if(checkData.isCcs_liked()) {
				checkData.setCcs_liked(false);
				commentData.setCc_like(commentData.getCc_like() - 1);
			}else {
				checkData.setCcs_liked(true);
				commentData.setCc_like(commentData.getCc_like() + 1);
			}
			
			comm_dao.updateCommentStaticLike(checkData);
		}
		
		comm_dao.updateCommentLike(commentData);
		
	}
	
	
	
	// 마이페이지전용 댓글 가져오기(스터디, 프로젝트)
	public List<CommunityCommentDTO> myPageGetCommentDatas(Map input){
		List<CommunityCommentDTO> datas = comm_dao.myPageSelectCommentDatas(input);
		return datas;
	}


	// 대댓글 순서 설정
	public int maxSort(int cc_gid) {
		int res = comm_dao.maxSort(cc_gid);
		return res;
	}


	public int maxChildSort(int cc_id) {
		int res = comm_dao.maxChildSort(cc_id);
		return res;
	}


	public boolean updateSort(CommunityCommentDTO data) {
		boolean res = comm_dao.updateCommentSort(data);
		return res;
		
	}


	public int findTotalChild(int cc_id) {
		int childs = comm_dao.totalChild(cc_id);
		return childs;
	}


	public boolean updateChild(CommunityCommentDTO data) {
		boolean result = comm_dao.updateChild(data);
		return result;
		
	}


	public List<CommunityCommentDTO> findFoldComment(int cc_gid) {
		List<CommunityCommentDTO> replys = comm_dao.selectFoldComment(cc_gid);
		
		return replys;
	}

}
