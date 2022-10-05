package com.web.home.login.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClientBuilder;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.http.client.HttpComponentsClientHttpRequestFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

import com.web.home.account.model.AccountDTO;
import com.web.home.join.service.JoinService;
import com.web.home.login.service.LoginService;
import com.web.home.login.vo.KakaoUserInfoVO;
import com.web.home.login.vo.LoginVO;

@Controller
public class LoginController {

	@Autowired
	private LoginService service;
	
	@Autowired
	private JoinService joinService;
	
	@GetMapping(value="/login")
	public String login(Model model) {
		return "login/login";
	}
	
	@PostMapping(value="/login")
	public String login(LoginVO loginVo, String url 
			, HttpServletRequest request
			, HttpSession session, Model model) {
		
		AccountDTO data = service.getLogin(loginVo);
		
		if(data != null) {
			boolean accountGroup = service.getAccountGroup(data.getAC_ID());
			boolean emailAuthFail = service.emailAuthFail(data.getAC_ID());
			if(!accountGroup) {
				model.addAttribute("error", "회원정보가 올바르지 않습니다.\\n아이디를 확인해주세요.");
				return "error/login_error";
			}
			if(!emailAuthFail) {
				return "emailAuth/emailAuthFail";
			}
			
			// 로그인 성공
			session.setAttribute("loginData", data);
			if(!url.isEmpty()) {
				if(url.startsWith(request.getContextPath())) {
					url = url.replace(request.getContextPath(), "");
				}
				return "redirect:" + url;
			}
			return "redirect:/";
		} else {
			// 로그인 실패
			model.addAttribute("error", "아이디 또는 비밀번호가 올바르지 않습니다.");
			return "error/login_error";
		}
	}

	@GetMapping(value="/login/kakao")
	public String kakaoLogin(HttpServletRequest request, Model model
			, @RequestParam(value="url", required=false) String url) {
		// URI 주소 생성(GET 요청을 할 때 미리 쿼리 스트링을 만들어 둔다)
		
		
		UriComponents kakaoAuthUri = UriComponentsBuilder.newInstance()
				.scheme("https").host("kauth.kakao.com").path("/oauth/authorize")
				.queryParam("client_id", "db5f0823bdb6f8b974c27a1d8cb37a50")
				.queryParam("redirect_uri", "http://localhost/home/login/kakao/auth_code")
				.queryParam("response_type", "code")
				.queryParam("state", url).build();
		
		RestTemplate rest = new RestTemplate();
		
		
		// 302 리다이렉트 응답에 대한 핸들링을 하지 않게 만들기 위해 적용
		CloseableHttpClient httpClient = HttpClientBuilder.create().disableRedirectHandling().build();
		
		// Http 요청 정보를 만들어 주는 팩토리
		HttpComponentsClientHttpRequestFactory factory = new HttpComponentsClientHttpRequestFactory();
		
		factory.setHttpClient(httpClient);
		rest.setRequestFactory(factory);
		
		// GET 요청 후 응답 정보를 저장
		ResponseEntity<String> restResponse = rest.getForEntity(kakaoAuthUri.toString(), String.class);
		System.out.println("restResponse값: " + restResponse);	
		
		return "redirect:" + restResponse.getHeaders().getLocation();
	}
	
	@GetMapping(value="/login/kakao/auth_code")
	public String kakaoAuthCode(HttpSession session, Model model
			, HttpServletRequest request, String code, String state, String error
			, @RequestParam(name="error_description", required=false) String errorDescription) {
		String tokenType = null, accessToken = null, refreshToken = null;
		long expiresIn = -1, refreshTokenExpiresIn = -1;
		System.out.println("state값: " + state);
		if(error == null) {
			UriComponents kakaoAuthUri = UriComponentsBuilder.newInstance()
					.scheme("https").host("kauth.kakao.com").path("/oauth/token").build();
			
			HttpHeaders headers = new HttpHeaders();
			headers.add("Content-type", MediaType.APPLICATION_FORM_URLENCODED_VALUE + ";charset=utf-8");
			
			MultiValueMap<String, String> param = new LinkedMultiValueMap<String, String>();
			param.add("grant_type", "authorization_code");
			param.add("client_id", "db5f0823bdb6f8b974c27a1d8cb37a50");
			param.add("redirect_uri", "http://localhost/home/login/kakao/auth_code");
			param.add("code", code);
			
			HttpEntity<MultiValueMap<String, String>> entity = new HttpEntity<MultiValueMap<String, String>>(param, headers);
			
			RestTemplate rest = new RestTemplate();
			rest.setRequestFactory(new HttpComponentsClientHttpRequestFactory());
			
			ResponseEntity<String> restResponse = rest.postForEntity(kakaoAuthUri.toUriString(), entity, String.class);
			
			JSONParser jsonParser = new JSONParser();
			try {
				JSONObject json = (JSONObject)jsonParser.parse(restResponse.getBody());
				tokenType = json.get("token_type").toString();
				accessToken = json.get("access_token").toString();
				expiresIn = Long.valueOf(json.get("expires_in").toString());
				refreshToken = json.get("refresh_token").toString();
				
				refreshTokenExpiresIn = Long.valueOf(json.get("refresh_token_expires_in").toString());
				
				KakaoUserInfoVO data = service.getKakaoUserInfo(accessToken);
				int idChk = joinService.checkId(data.getId());
				int emailChk = joinService.getEmail(data.getEmail());
				if(idChk == 0) {
					if(emailChk == 1) {
						model.addAttribute("error", "이미 가입된 회원입니다.\\n아이디를 확인해주세요.");
						service.kakaoLogout(accessToken);
						return "error/kakao_auth_error";
					}
					model.addAttribute("kakaoUserdata", data);
					service.kakaoLogout(accessToken);
					return "join/joinKakao";
				}
				
				//카카오 로그인 성공
				AccountDTO kakaoLoginData = new AccountDTO();
				kakaoLoginData.setAC_ID(data.getId());
				kakaoLoginData.setAC_EMAIL(data.getEmail());
				
				kakaoLoginData = service.getKakaoLoginInfo(kakaoLoginData);
				
				session.setAttribute("loginData", kakaoLoginData);
				session.setAttribute("accessToken", accessToken);
				
				if(!state.isEmpty()) {
					if(state.startsWith(request.getContextPath())) {
						state = state.replace(request.getContextPath(), "");
					}
					return "redirect:" + state;
				}
				
				
			} catch (ParseException e) {
				e.printStackTrace();
			}
			return "redirect:/";
		}
		model.addAttribute("error", "카카오 로그인 중 오류가 발생하였습니다.");
		return "error/kakao_auth_error";
	}

	@GetMapping(value="/login/find_id")
	public String find_id() {
		return "login/find_id";
	}
	
	@PostMapping(value="/login/find_id")
	public String find_id(LoginVO loginVo, Model model) throws Exception {
		
		AccountDTO data = new AccountDTO();
		data.setAC_NAME(loginVo.getName());
		data.setAC_EMAIL(loginVo.getEmail());
		
		data = service.getId(data);
		
		if(data != null) {
			if(data.getAC_GROUP() == 1) {
				model.addAttribute("emailAuthMng", "아이디가 메일로 발송되었습니다.\\n메일을 확인해주세요.");
				return "emailAuth/emailAuth";
			} else {
				model.addAttribute("error", "카카오로그인 회원입니다.\\n카카오로그인 후 이용해 주세요.");
				return "error/login_error";
			}
		} else {
			model.addAttribute("error", "회원정보가 올바르지 않습니다.\\n아이디와 이메일주소를 확인해주세요.");
			return "error/login_error";
		}
	}
	
	@GetMapping(value="/login/find_pw")
	public String find_pw() {
		return "login/find_pw";
	}
	
	@PostMapping(value="/login/find_pw")
	public String find_pw(LoginVO loginVo, Model model) throws Exception {
		AccountDTO data = new AccountDTO();
		data.setAC_NAME(loginVo.getName());
		data.setAC_EMAIL(loginVo.getEmail());
		
		data = service.getPw(data);
		
		if(data != null) {
			if(data.getAC_GROUP() == 1) {
				model.addAttribute("emailAuthMng", "임시비밀번호가 메일로 발송되었습니다.\\n메일을 확인해주세요.");
				return "emailAuth/emailAuth";
			} else {
				model.addAttribute("error", "카카오로그인 회원입니다.\\n카카오로그인 후 이용해 주세요.");
				return "error/login_error";
			}
		} else {
			model.addAttribute("error", "회원정보가 올바르지 않습니다.\\n아이디와 이메일주소를 확인해주세요.");
			return "error/login_error";
		}
		
		
	}
	
	@GetMapping(value="/logout")
	public String logout(HttpSession session) {
		String accessToken = (String)session.getAttribute("accessToken");
		if(accessToken != null) {
			service.kakaoLogout(accessToken);
			session.invalidate();
		} else {
			session.invalidate();
		}
		return "redirect:/";
	}
	
}
