package com.web.home.mypage.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.web.home.mypage.model.AttachImageDAO;
import com.web.home.mypage.model.AttachImageDTO;

@Service
public class AttachImageService {
	@Autowired
	private AttachImageDAO attachImagedao;
	
	public List<AttachImageDTO> getAttachList(int L_id) {
		return attachImagedao.getAttachList(L_id);
	}
}
