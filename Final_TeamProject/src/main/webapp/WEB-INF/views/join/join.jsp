<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>회원가입</title>
	<%@ include file="../module/head.jsp" %>
	<link rel="stylesheet" type="text/css" href="${css}/login.css">
	
</head>
<c:url var="mainUrl" value="/" />
<body class="text-center">
	<main class="form-signin w-100 m-auto">
		<a href="${mainUrl}"><img class="mb-4" src="${img}/logo/logo_b.png" alt="" width="250" height="40"></a>
	
		<ul class="nav login_nav_tabs mt-4">
			<li class="nav-item">
				<a class="login_nav_link" href="${mainUrl}login">로그인</a>
				</li>
			<li class="nav-item">
				<a class="login_nav_link active" href="${mainUrl}join">회원가입</a>
			</li>
		</ul>
		
		<div class="login_card text-start">
			<div class="tab-content card-body">
				<c:url var="joinUrl" value="/join" />
				<form action="${joinUrl}" method="post" name="joinForm">
					<div class="form-group">
						<label class="col-form-label" for="id">아이디</label>
						<input class="form-control p-2" type="text" id="id" name="id" oninput="checkId();" placeholder="아이디를 입력해 주세요(영문 대소문자+숫자 4~16자리)">
						<span class="chk_message"></span>
					</div>
					<div class="form-group">
						<label class="col-form-label mt-3" for="password">비밀번호</label>
						<input class="form-control p-2" type="password"  id="password" name="password" oninput="checkPw();" placeholder="영문자, 숫자, 특수문자 포함 최소 8자">
						<span class="chk_message"></span>
					</div>
					<div class="form-group">
						<label class="col-form-label mt-3" for="passwordChk">비밀번호 확인</label>
						<input class="form-control p-2" type="password"  id="passwordChk" name="passwordChk" oninput="reCheckPw();" placeholder="비밀번호를 확인해 주세요">
						<span class="chk_message"></span>
					</div>
					<div class="form-group">
						<label class="col-form-label mt-3" for="nickname">닉네임</label>
						<input class="form-control p-2" type="text"  id="nickname" name="nickname" oninput="checkNickname();" placeholder="닉네임을 입력해 주세요">
						<span class="chk_message"></span>
					</div>
					<div class="form-group">
						<label class="col-form-label mt-3" for="name">이름</label>
						<input class="form-control p-2" type="text"  id="name" name="name" placeholder="이름을 입력해 주세요">
						<span class="chk_message"></span>
					</div>
					<div class="form-group">
						<label class="col-form-label mt-3" for="phone">핸드폰번호</label>
						<input class="form-control p-2" type="text"  id="phone" name="phone" oninput="checkPhone();" placeholder="전화번호를 입력해 주세요('-' 제외하고 입력)">
						<span class="chk_message"></span>
					</div>
					<div class="form-group">
						<label class="col-form-label mt-3" for="email">본인 확인 이메일</label>
						<input class="form-control p-2" type="email" id="email" name="email" oninput="checkEmail();" placeholder="이메일 주소를 입력해 주세요">
						<span class="chk_message"></span>
					</div>
					<div class="checkbox mt-3">
						<label class="checkbox_text" for="allAgree">
							<input type="checkbox" id="allAgree" name="allAgree">
							전체동의
						</label>
					</div>
					<div class="checkbox mt-1 ms-3">
						<label class="checkbox_text" for="termsAgree">
							<input type="checkbox" id="termsAgree" name="agree" value="1">
							이용약관 동의(필수)
						</label>
					</div>
					<div class="checkbox mt-1 ms-3 mb-4">
						<label class="checkbox_text" for="infoAgree">
							<input type="checkbox" id="infoAgree" name="agree" value="2">
							개인정보 수집 및 이용 동의(필수)
						</label>
					</div>
					<button class="w-100 login_btn btn-lg btn-primary p-3 mt-3" type="button" onclick="formCheck(this.form);">가입하기</button>
				</form>
			</div>
		</div>
		<p class="mt-5 mb-3 under_text_b"><a href="#">이용약관</a>&emsp;|&emsp;<a href="#">개인정보처리방침</a>&emsp;|&emsp;<a href="#">FAQ</a></p>
		<p class="under_text_s">Copyright RUlearn. All Rights Reserved.</p>
		
	</main>
	<!-- 이용약관체크모달 -->
	<div class="modal fade" id="termsCheckModal" tabindex="-1" aria-hidden="true">
		<div class="modal-dialog modal-xl">
			<div class="modal-content">
				<%@ include file="../terms/termsInfo.jsp" %>
		  </div>
	  </div>
	</div>
	<!-- 개인정보체크모달 -->
	<div class="modal fade" id="infoCheckModal" tabindex="-1" aria-hidden="true">
		<div class="modal-dialog modal-xl">
			<div class="modal-content">
				<%@ include file="../terms/personalInfo.jsp" %>
		  </div>
	  </div>
	</div>
	<!-- 에러모달 -->
	<div class="modal fade" id="errorModal" tabindex="-1" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h6 class="modal-title"></h6>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body">
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-sm btn-danger" data-bs-dismiss="modal">확인</button>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		var messagebox = document.querySelectorAll(".chk_message");

		function checkId() {
			var id = document.getElementById("id").value;
			var idRegExp = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{4,16}$/;
	
			$.ajax({
				url:"${joinUrl}/checkId",
				type: "post",
				data: {
					id: id
				},
				dataType: "json",
				success: function(data) {
					if(data.code === "success") {
						if(id === "") {
							// 아이디 공백 체크
							messagebox[0].innerHTML = "아이디는 필수 입력 사항입니다.";
							messagebox[0].style.color = "#d9534f";
							messagebox[0].style.display = "block";
						} else if(!idRegExp.test(id)){
							// 아이디 영문, 숫자 체크
							messagebox[0].innerHTML = "아이디는 영문 대소문자와 숫자 조합의 4~16자리로 입력해야 합니다.";
							messagebox[0].style.color = "#d9534f";
							messagebox[0].style.display = "block";
						} else {
							// 사용가능한 아이디
							messagebox[0].innerHTML = data.message;
							messagebox[0].style.color = "#8c8c8c";
							messagebox[0].style.display = "block";
						}
					} else {
						// 이미 존재하는 아이디
						messagebox[0].innerHTML = data.message;
						messagebox[0].style.color = "#d9534f";
						messagebox[0].style.display = "block";
					}
				}
			});
		}
		
		function checkPw() {
			var pw1 = document.getElementById("password").value;
			var pwRegExp = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$/;
			if(pw1 === "") {
				messagebox[1].innerHTML = "비밀번호는 필수 입력 사항입니다.";
				messagebox[1].style.color = "#d9534f";
				messagebox[1].style.display = "block";
			} else if(!pwRegExp.test(pw1)) {
				messagebox[1].innerHTML = "비밀번호는 영문자, 숫자, 특수문자를 최소 1개씩 포함해야 합니다.";
				messagebox[1].style.color = "#d9534f";
				messagebox[1].style.display = "block";
			} else {
				messagebox[1].innerHTML = "사용가능한 비밀번호입니다.";
				messagebox[1].style.color = "#8c8c8c";
				messagebox[1].style.display = "block";
			}
		}
		
		function reCheckPw() {
			var pw1 = document.getElementById("password").value;
			var pw2 = document.getElementById("passwordChk").value;
			if(pw1 !== pw2) {
				messagebox[2].innerHTML = "비밀번호가 일치하지 않습니다.";
				messagebox[2].style.color = "#d9534f";
				messagebox[2].style.display = "block";
			}else {
				messagebox[2].innerHTML = "비밀번호가 일치합니다.";
				messagebox[2].style.color = "#8c8c8c";
				messagebox[2].style.display = "block";
			}
		}
		
		function checkNickname() {
			var nickname = document.getElementById("nickname").value;
	
			$.ajax({
				url:"${joinUrl}/checkNickname",
				type: "post",
				data: {
					nickname: nickname
				},
				dataType: "json",
				success: function(data) {
					if(data.code === "success") {
						if(nickname === "") {
							// 닉네임 공백 체크
							messagebox[3].innerHTML = "닉네임은 필수 입력 사항입니다.";
							messagebox[3].style.color = "#d9534f";
							messagebox[3].style.display = "block";
						} else {
							// 사용가능한 닉네임
							messagebox[3].innerHTML = data.message;
							messagebox[3].style.color = "#8c8c8c";
							messagebox[3].style.display = "block";
						}
					} else {
						// 이미 존재하는 닉네임
						messagebox[3].innerHTML = data.message;
						messagebox[3].style.color = "#d9534f";
						messagebox[3].style.display = "block";
					}
				}
			});
		}
		
		function checkPhone() {
			var phone = document.getElementById("phone").value;
			var phoneRegExp = /^010([0-9]{4})([0-9]{4})$/;
			if(phone === "") {
				messagebox[5].innerHTML = "핸드폰번호는 필수 입력 사항입니다.";
				messagebox[5].style.display = "block";
			} else if(!phoneRegExp.test(phone)) {
				messagebox[5].innerHTML = "입력된 값은 휴대전화번호가 아닙니다.";
				messagebox[5].style.display = "block";
			} else {
				messagebox[5].style.display = "none";
			}
		}
		
		function checkEmail() {
			var email = document.getElementById("email").value;
			var emailRegExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/;
			$.ajax({
				url:"${joinUrl}/checkEmail",
				type: "post",
				data: {
					email: email
				},
				dataType: "json",
				success: function(data) {
					if(data.code === "success") {
						if(email === "") {
							// 이메일 공백 체크
							messagebox[6].innerHTML = "이메일은 필수 입력 사항입니다."
								messagebox[6].style.color = "#d9534f";
							messagebox[6].style.display = "block";
						} else if(!emailRegExp.test(email)){
							// 아이디 영문, 숫자 체크
							messagebox[6].innerHTML = "이메일 주소가 올바르지 않습니다.";
							messagebox[6].style.color = "#d9534f";
							messagebox[6].style.display = "block";
						} else {
							// 사용가능한 이메일
							messagebox[6].innerHTML = data.message;
							messagebox[6].style.color = "#8c8c8c";
							messagebox[6].style.display = "block";
						}
					} else {
						// 이미 존재하는 이메일
						messagebox[6].innerHTML = data.message;
						messagebox[6].style.color = "#d9534f";
						messagebox[6].style.display = "block";
					}
				}
			});
		}
		
		$(document).ready(function() {
			$("#termsAgree").click(function() {
				$("#termsCheckModal").modal("show")
			});

			$("#infoAgree").click(function() {
				$("#infoCheckModal").modal("show")
			});
			
			$("#allAgree").click(function() {
				var checked = $("#allAgree").is(":checked");
				if(checked) {
					$("input[name=agree]").prop("checked", true);
				} else {
					$("input[name=agree]").prop("checked", false);
				}
			});
			
			$("input[name=agree]").click(function() {
				var total = $("input[name=agree]").length;
				var chk_checked = $("input[name=agree]:checked").length;
				
				if(total != chk_checked) {
					$("#allAgree").prop("checked", false);
				} else {
					$("#allAgree").prop("checked", true);
				}
			});
			
		});
		
		function formCheck(form) {
			var modal = new bootstrap.Modal(document.getElementById("errorModal"), {
				keyboard: false
			});
			var title = modal._element.querySelector(".modal-title");
			var body = modal._element.querySelector(".modal-body");
			
			if(form.id.value === undefined || form.id.value.trim() === "") {
				title.innerText = "아이디 입력 오류";
				body.innerText = "아이디는 필수 입력사항입니다.\n아이디를 입력해주세요.";
				modal.show();
				return;
			}
			
			if(form.password.value === undefined || form.password.value.trim() === "" || form.passwordChk.value === undefined || form.passwordChk.value.trim() === "") {
				title.innerText = "비밀번호 입력 오류";
				body.innerText = "비밀번호는 필수 입력사항입니다.\n비밀번호를 입력해주세요.";
				modal.show();
				return;
			}
			
			if(form.nickname.value === undefined || form.nickname.value.trim() === "") {
				title.innerText = "닉네임 입력 오류";
				body.innerText = "닉네임은 필수 입력사항입니다.\n닉네임을 입력해주세요.";
				modal.show();
				return;
			}
			
			if(form.name.value === undefined || form.name.value.trim() === "") {
				title.innerText = "이름 입력 오류";
				body.innerText = "이름은 필수 입력사항입니다.\n이름을 입력해주세요.";
				modal.show();
				return;
			}
			
			if(form.phone.value === undefined || form.phone.value.trim() === "") {
				title.innerText = "핸드폰번호 입력 오류";
				body.innerText = "핸드폰번호는 필수 입력사항입니다.\n핸드폰번호를 입력해주세요.";
				modal.show();
				return;
			}
			
			if(form.email.value === undefined || form.email.value.trim() === "") {
				title.innerText = "이메일 입력 오류";
				body.innerText = "이메일은 필수 입력사항입니다.\n이메일을 입력해주세요.";
				modal.show();
				return;
			}
			
			var allChk = document.joinForm.allAgree.checked;
			if(!allChk) {
				title.innerText = "약관 동의 오류";
				body.innerText = "약관 동의는 필수 사항입니다.\n이용약관과 개인정보 수집 및 이용에 동의해주세요";
				modal.show();
				return;
			}
			
			form.submit();
		}
	</script>
</body>
</html>