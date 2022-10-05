package com.web.home.join.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import com.web.home.account.model.AccountDTO;
import com.web.home.account.model.AgreementDTO;
import com.web.home.join.model.JoinDAO;
import com.web.home.mail.MailHandler;
import com.web.home.mail.TempKey;

@Service
public class JoinService {

	@Autowired
	private JoinDAO dao;
	
	@Autowired
	private JavaMailSender javaMailSender;
	
	public boolean getJoin(AccountDTO data) throws Exception {
		String mail_key = new TempKey().getKey(30, false);	// 랜덤키 길이 설정
		data.setAC_MAIL_KEY(mail_key);
		
		boolean result = dao.insertData(data);
		int mailKey = dao.updateMailKey(data);
		if(result) {
			if(mailKey == 1) {
				MailHandler sendMail = new MailHandler(javaMailSender);
				sendMail.setSubject("RULearn 가입 인증 메일입니다.");
				sendMail.setText(
						"<h2>RULearn 메일인증</h2>" + 
						"<br>RULearn 가입을 환영합니다." + 
						"<br>아래 [이메일 인증 확인]을 눌러주세요." + 
						"<br><a href='http://localhost/home/join/registerEmail?email=" + data.getAC_EMAIL() +
						"&mail_key=" + mail_key +
						"' target='_blank'>이메일 인증 확인</a>");
				sendMail.setFrom("rulearnmng@gmail.com", "RULearn");
				sendMail.setTo(data.getAC_EMAIL());
				sendMail.send();
			}
		}
		
		return result;
	}
	
	public boolean updateMailAuth(AccountDTO data) {
		boolean result = dao.updateMailAuth(data);
		return result;
	}
	
	public boolean getKakaoJoin(AccountDTO data) {
		boolean result = dao.insertData(data);
		return result;
	}
	
	public void updateKakaoMailAuth(AccountDTO data) {
		dao.updateKakaoMailAuth(data);
	}

	public int checkId(String id) {
		int result = dao.checkId(id);
		return result;
	}
	
	public int getNickname(String nickname) {
		int result = dao.selectNickname(nickname);
		return result;
	}

	public int getEmail(String email) {
		int result = dao.selectEmail(email);
		return result;
	}

	public JOIN_SERVICE_STATUS chkAll(AccountDTO data) {
		JOIN_SERVICE_STATUS status = JOIN_SERVICE_STATUS.SUCCESS;
		
		int idChk =  dao.checkId(data.getAC_ID());
		int nicknameChk =  dao.selectNickname(data.getAC_NICKNAME());
		int emailChk =  dao.selectEmail(data.getAC_EMAIL());
		
		if(idChk == 1) {
			status = JOIN_SERVICE_STATUS.ID_DUPLICATED;
		}
		if(nicknameChk == 1) {
			status = JOIN_SERVICE_STATUS.NICKNAME_DUPLICATED;
		}
		if(emailChk == 1) {
			status = JOIN_SERVICE_STATUS.EMAIL_DUPLICATED;
		}
		return status;
		
	}

	public void isAgreeTerms(String id, int agree) {
		AgreementDTO data = new AgreementDTO();
		data.setAg_acid(id);
		data.setAg_tid(agree);
		
		dao.insertAgree(data);
		
	}

	public void isAgreeInfo(String id, int agree) {
		AgreementDTO data = new AgreementDTO();
		data.setAg_acid(id);
		data.setAg_tid(agree);
		
		dao.insertAgree(data);
	}
}
