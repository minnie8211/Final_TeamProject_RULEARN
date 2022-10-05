package com.web.home.join.controller;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.web.home.account.model.AccountDTO;
import com.web.home.common.util.MatchPattern;
import com.web.home.join.service.JOIN_SERVICE_STATUS;
import com.web.home.join.service.JoinService;
import com.web.home.join.vo.JoinVO;
import com.web.home.login.vo.KakaoUserInfoVO;

@Controller
@RequestMapping(value="/join")
public class JoinController {
	
	@Autowired
	private JoinService service;
	
	@GetMapping(value="")
	public String join(Model model) {
		return "join/join";
	}
	
	@PostMapping(value="")
	public String join(JoinVO joinVo, Model model
			, HttpServletRequest request, ModelMap modelmap) throws Exception {
		
		MatchPattern match = new MatchPattern();
		boolean idMatch = match.isAlphaNumber(joinVo.getId());
		boolean pwMatch = match.isAlphaNumberSpchar(joinVo.getPassword());
		boolean mobileMatch = match.isMobile(joinVo.getPhone());
		boolean emailMatch = match.isEmail(joinVo.getEmail());
		
		AccountDTO data = new AccountDTO();
		
		if(idMatch) {
			data.setAC_ID(joinVo.getId());
		} else {
			model.addAttribute("error", "유효하지 않은 아이디입니다.");
			return "join/join_m";
		}
		
		if(pwMatch) {
			if(joinVo.getPassword().equals(joinVo.getPasswordChk())) {
				data.setAC_PW(joinVo.getPassword());
			} else {
				model.addAttribute("error", "비밀번호를 확인해주세요");
				return "join/join_m";
			}
		} else {
			model.addAttribute("error", "유효하지 않은 비밀번호입니다.");
			return "join/join_m";
		}
		
		if(mobileMatch) {
			data.setAC_PHONE(joinVo.getPhone());
		} else {
			model.addAttribute("error", "유효하지 않은 핸드폰번호입니다.");
			return "join/join_m";
		}
		
		if(emailMatch) {
			data.setAC_EMAIL(joinVo.getEmail());
		} else {
			model.addAttribute("error", "유효하지 않은 이메일주소입니다.");
			return "join/join_m";
		}
		
		data.setAC_NICKNAME(joinVo.getNickname());
		data.setAC_NAME(joinVo.getName());
		data.setAC_GROUP(1);
		
		String[] chkArr = request.getParameterValues("agree");
		int termsAgree = Integer.parseInt(chkArr[0]);
		int infoAgree = Integer.parseInt(chkArr[1]);
		
		JOIN_SERVICE_STATUS status = service.chkAll(data);
		
		switch(status) {
			case SUCCESS:
				boolean result = service.getJoin(data);
				if(result) {
					service.isAgreeTerms(data.getAC_ID(), termsAgree);
					service.isAgreeInfo(data.getAC_ID(), infoAgree);
					model.addAttribute("emailAuthMng", "인증용 이메일이 발송되었습니다.\\n이메일 확인 후 인증 버튼을 눌러주세요!");
					return "emailAuth/emailAuth";
				} 
				break;
			case ID_DUPLICATED:
				model.addAttribute("error", "이미 사용 중인 아이디입니다.");
				return "join/join_m";
			case NICKNAME_DUPLICATED:
				model.addAttribute("error", "이미 사용 중인 닉네임입니다.");
				return "join/join_m";
			case EMAIL_DUPLICATED:
				model.addAttribute("error", "이미 사용 중인 이메일입니다.");
				return "join/join_m";
		}
		model.addAttribute("error", "회원 가입 중 오류가 발생했습니다.");
		return "error/error";
	}
	
	@GetMapping(value="/registerEmail")
	public String emailConfirm(String email, String mail_key, Model model) {
		
		AccountDTO data = new AccountDTO();
		data.setAC_EMAIL(email);
		data.setAC_MAIL_KEY(mail_key);
		
		boolean result = service.updateMailAuth(data);
		 if(result) {
			 return "emailAuth/emailAuthSuccess";
		 }
		 model.addAttribute("error", "메일 인증 중 오류가 발생했습니다.");
		 return "error/error";
	}
	
	@PostMapping(value="/kakao")
	public String kakaoJoin(JoinVO joinVo, Model model, KakaoUserInfoVO kakaoUserInfoVo
			, HttpServletRequest request, ModelMap modelmap){
		
		MatchPattern match = new MatchPattern();
		boolean mobileMatch = match.isMobile(joinVo.getPhone());
		
		AccountDTO data = new AccountDTO();
		data.setAC_ID(joinVo.getId());
		data.setAC_PW(joinVo.getPassword());
		data.setAC_NICKNAME(joinVo.getNickname());
		data.setAC_NAME(joinVo.getName());
		data.setAC_EMAIL(joinVo.getEmail());
		
		kakaoUserInfoVo.setId(data.getAC_ID());
		kakaoUserInfoVo.setNickname(data.getAC_NICKNAME());
		kakaoUserInfoVo.setEmail(data.getAC_EMAIL());
		
		if(mobileMatch) {
			data.setAC_PHONE(joinVo.getPhone());
		} else {
			model.addAttribute("kakaoUserdata", kakaoUserInfoVo);
			model.addAttribute("error", "유효하지 않은 핸드폰번호입니다.");
			return "join/joinKakao_m";
		}
		data.setAC_GROUP(2);
		
		String[] chkArr = request.getParameterValues("agree");
		int termsAgree = Integer.parseInt(chkArr[0]);
		int infoAgree = Integer.parseInt(chkArr[1]);

		
		int nicknameChk = service.getNickname(data.getAC_NICKNAME());
		
		if(nicknameChk == 0) {
			boolean result = service.getKakaoJoin(data);
			if(result) {
				service.updateKakaoMailAuth(data);
				service.isAgreeTerms(data.getAC_ID(), termsAgree);
				service.isAgreeInfo(data.getAC_ID(), infoAgree);

				return "join/joinSuccess";
			}
		} else {
			model.addAttribute("kakaoUserdata", kakaoUserInfoVo);
			model.addAttribute("error", "이미 사용 중인 닉네임입니다.");
			return "join/joinKakao_m";
		}
		model.addAttribute("error", "회원 가입 중 오류가 발생했습니다.");
		return "error/error";
	}
	
	@PostMapping(value="/checkId", produces="application/json; charset=utf-8")
	@ResponseBody
	public String checkId(@RequestParam("id") String id) {
		int idChk = service.checkId(id);
		JSONObject json = new JSONObject();
		
		if(idChk == 0) {
			json.put("code", "success");
			json.put("message", "사용할 수 있는 아이디입니다.");
		} else {
			json.put("code", "fail");
			json.put("message", "이미 사용 중인 아이디입니다.");
		}
		return json.toJSONString();
	}
	
	@PostMapping(value="/checkNickname", produces="application/json; charset=utf-8")
	@ResponseBody
	public String checkNickname(@RequestParam("nickname") String nickname) {
		int nicknameChk = service.getNickname(nickname);
		JSONObject json = new JSONObject();
		
		if(nicknameChk == 0) {
			json.put("code", "success");
			json.put("message", "사용할 수 있는 닉네임입니다.");
		} else {
			json.put("code", "fail");
			json.put("message", "이미 사용 중인 닉네임입니다.");
		}
		return json.toJSONString();
	}
	
	@PostMapping(value="/checkEmail", produces="application/json; charset=utf-8")
	@ResponseBody
	public String checkEmail(@RequestParam("email") String email) {
		int emailChk = service.getEmail(email);
		JSONObject json = new JSONObject();
		
		if(emailChk == 0) {
			json.put("code", "success");
			json.put("message", "사용할 수 있는 이메일입니다.");
		} else {
			json.put("code", "fail");
			json.put("message", "이미 사용 중인 이메일입니다.");
		}
		return json.toJSONString();
	}

}
