package com.web.home.login.service;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

import javax.mail.MessagingException;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import com.web.home.account.model.AccountDTO;
import com.web.home.login.model.LoginDAO;
import com.web.home.login.vo.KakaoUserInfoVO;
import com.web.home.login.vo.LoginVO;
import com.web.home.mail.MailHandler;
import com.web.home.mail.TempKey;

@Service
public class LoginService {

	@Autowired
	private LoginDAO dao;
	
	@Autowired
	private JavaMailSender javaMailSender;
	
	public AccountDTO getLogin(LoginVO loginVo) {
		AccountDTO data = new AccountDTO();
		data.setAC_ID(loginVo.getId());
		data.setAC_PW(loginVo.getPassword());
		
		data = dao.selectLogin(data);
		return data;
	}
	
	public boolean getAccountGroup(String id) {
		boolean result = dao.getAccountGroup(id);
		return result;
	}
	
	public boolean emailAuthFail(String id) {
		boolean result = dao.emailAuthFail(id);
		return result;
	}

	public KakaoUserInfoVO getKakaoUserInfo(String accessToken) {
		KakaoUserInfoVO data = new KakaoUserInfoVO();
		String host = "https://kapi.kakao.com/v2/user/me";
		
		try {
			URL url = new URL(host);
			HttpURLConnection urlConn = (HttpURLConnection)url.openConnection();
			urlConn.setRequestProperty("Authorization", "Bearer " + accessToken);
			urlConn.setRequestMethod("POST");

			int responseCode = urlConn.getResponseCode(); 
			System.out.println("responseCode = " + responseCode);
			
			BufferedReader br = new BufferedReader(new InputStreamReader(urlConn.getInputStream()));
			String line = "";
			String res = "";
			while((line=br.readLine()) != null) {
				res += line;
			}
			
			System.out.println("res = " + res);
			
			JSONParser parser = new JSONParser();
			JSONObject body = (JSONObject)parser.parse(res);
			JSONObject kakao_account = (JSONObject)body.get("kakao_account");
			JSONObject properties =  (JSONObject)body.get("properties");
			
			String id = body.get("id").toString();
			String nickname = properties.get("nickname").toString();
			String email = kakao_account.get("email").toString();
			
			data.setId(id);
			data.setNickname(nickname);
			data.setEmail(email);
			
		} catch (IOException | ParseException e) {
			e.printStackTrace();
		}
		return data;
	}
	
	public AccountDTO getId(AccountDTO data) throws Exception {
		data = dao.selectId(data);
		
		if(data != null) {
			if(data.getAC_GROUP() == 1) {
				MailHandler sendMail = new MailHandler(javaMailSender);
				sendMail.setSubject("RULearn ????????? ?????? ???????????????.");
				sendMail.setText(
						"<h2>RULearn ???????????????</h2>" + 
						"<br>" + data.getAC_NAME() + "?????? ???????????? [" + data.getAC_ID() + "]?????????.");
				sendMail.setFrom("rulearnmng@gmail.com", "RULearn");
				sendMail.setTo(data.getAC_EMAIL());
				sendMail.send();
			}
		}
		return data;
	}
	
	public AccountDTO getPw(AccountDTO data) throws Exception {
		String temp_pw = new TempKey().getKey(12, false);
		
		data = dao.selectId(data);
		if(data != null) {
			if(data.getAC_GROUP() == 1) {
				data.setAC_PW(temp_pw);
				boolean result = dao.updatePassword(data);
				if(result) {
					MailHandler sendMail = new MailHandler(javaMailSender);
					sendMail.setSubject("RULearn ?????????????????? ?????? ???????????????.");
					sendMail.setText(
							"<h2>RULearn ??????????????????</h2>" + 
							"<br>" + data.getAC_NAME() + "?????? ????????????????????? " + temp_pw + "?????????." +
							"<br>??????????????? ????????? ??? ????????? ?????????.");
					sendMail.setFrom("rulearnmng@gmail.com", "RULearn");
					sendMail.setTo(data.getAC_EMAIL());
					sendMail.send();
				}
			}
		}
		return data;
	}
	
	public AccountDTO getKakaoLoginInfo(AccountDTO data) {
		data = dao.selectLoginInfo(data);
		return data;
	}
	
	public void kakaoLogout(String accessToken) {
		String host = "https://kapi.kakao.com/v1/user/logout";
		
		try {
			URL url = new URL(host);
			HttpURLConnection urlConn = (HttpURLConnection)url.openConnection();
			urlConn.setRequestProperty("Authorization", "Bearer " + accessToken);
			urlConn.setRequestMethod("POST");
			
			int responseCode = urlConn.getResponseCode(); 
			System.out.println("responseCode = " + responseCode);
			
			BufferedReader br = new BufferedReader(new InputStreamReader(urlConn.getInputStream()));
			
			String line = "";
			String res = "";
			
			while((line=br.readLine()) != null) {
				res += line;
			}
			
			System.out.println("res = " + res);
			
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}

}
