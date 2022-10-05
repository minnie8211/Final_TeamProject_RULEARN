package com.web.home.mypage.model;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class AttachImageDAO {
	
	@Autowired
	private SqlSession session;
	
	private String mapper = "attachImageMapper.%s";
	
	public List<AttachImageDTO> getAttachList(int L_id) {
		String mapperId = String.format(mapper, "getAttachList");
		List<AttachImageDTO> res = session.selectList(mapperId, L_id);
		return res;
	}
}
