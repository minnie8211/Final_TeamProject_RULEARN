package com.web.home.userinfo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.web.home.account.model.AccountDTO;
import com.web.home.community.board.model.CommunityBoardDAO;
import com.web.home.community.board.model.CommunityBoardDTO;
import com.web.home.community.comment.model.CommunityCommentDAO;
import com.web.home.community.comment.model.CommunityCommentIdDTO;
import com.web.home.studyboard.comment.model.StudyCommentDAO;
import com.web.home.studyboard.comment.model.StudyCommentIdDTO;
import com.web.home.studyboard.model.StudyBoardDAO;
import com.web.home.studyboard.model.StudyBoardDTO;
import com.web.home.userinfo.model.UserInfoDAO;

@Service
public class UserInfoService {
	
	@Autowired
	private UserInfoDAO dao;

	@Autowired
	private StudyBoardDAO StudyDAO;
	
	@Autowired
	private StudyCommentDAO styComent_dao;
	
	@Autowired
	private CommunityBoardDAO comm_dao;
	
	@Autowired
	private CommunityCommentDAO commComent_dao;
	
	public AccountDTO getUserData(String wId) {
		// 회원 정보 조회
		AccountDTO data = dao.selectUserData(wId);
		return data;
	}

	public List<StudyBoardDTO> getUserStudyData(String wId) {
		// 학습 게시판 사용자 글 조회
		List<StudyBoardDTO> datas = StudyDAO.selectUserStudyData(wId);
		return datas;
	}
	
	public List<CommunityBoardDTO> getUserCommuData(String wId) {
		// 커뮤니티 게시판 사용자 글 조회
		List<CommunityBoardDTO> datas = comm_dao.selectUserCommuData(wId);
		return datas;
	}

	public List<CommunityCommentIdDTO> getCommuBoardId(String wId) {
		// 커뮤니티 댓글 조회
		List<CommunityCommentIdDTO> datas = commComent_dao.selectBoardID(wId);
		return datas;
	}

	public List<CommunityBoardDTO> getCommuBoradList(List boardIdDatas) {
		// 커뮤니티 댓글 단 글 조회
		List<CommunityBoardDTO> datas = comm_dao.selectBoardList(boardIdDatas);
		return datas;
	}
	
	public List<StudyCommentIdDTO> getStudyBoardId(String wId) {
		// 스터디 댓글 조회
		List<StudyCommentIdDTO> datas = styComent_dao.selectBoardID(wId);
		return datas;
	}
	
	public List<StudyBoardDTO> getStudyBoradList(List boardIdDatas) {
		// 스터디 댓글 단 글 조회
		List<StudyBoardDTO> datas = StudyDAO.selectBoardList(boardIdDatas);
		return datas;
	}
	
}
