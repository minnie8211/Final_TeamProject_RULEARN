<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>카카오회원가입</title>
	<%@ include file="../module/head.jsp" %>
	<link rel="stylesheet" type="text/css" href="${css}/login.css">
</head>
<script>
	alert("첫 방문을 환영합니다.\n카카오로그인으로 사이트를 이용하기 위해서\n카카오 회원가입이 필요합니다.")
</script>
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
					<form action="${joinUrl}/kakao" method="post" name="joinForm">
						<input type="hidden" id="id" name="id" value="${kakaoUserdata.id}">
						<input type="hidden" id="password" name="password" value="${kakaoUserdata.id}">
						<input type="hidden" id="email" name="email" value="${kakaoUserdata.email}">
						<div class="form-group">
							<label class="col-form-label mt-3" for="nickname">닉네임</label>
							<input class="form-control p-2" type="text"  id="nickname" name="nickname" value="${kakaoUserdata.nickname}" oninput="checkNickname();">
							<span class="chk_message"></span>
						</div>
						<div class="form-group">
							<label class="col-form-label mt-3" for="name">이름</label>
							<input class="form-control p-2" type="text"  id="name" name="name" placeholder="이름을 입력해 주세요">
							<span class="chk_message"></span>
						</div>
						<div class="form-group">
							<label class="col-form-label mt-3" for="phone">전화번호</label>
							<input class="form-control p-2" type="text"  id="phone" name="phone" oninput="checkPhone();" placeholder="전화번호를 입력해 주세요('-' 제외하고 입력)">
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
							messagebox[0].innerHTML = "닉네임은 필수 입력 사항입니다.";
							messagebox[0].style.color = "#d9534f";
							messagebox[0].style.display = "block";
						} else {
							// 사용가능한 닉네임
							messagebox[0].innerHTML = data.message;
							messagebox[0].style.color = "#8c8c8c";
							messagebox[0].style.display = "block";
						}
					} else {
						// 이미 존재하는 닉네임
						messagebox[0].innerHTML = data.message;
						messagebox[0].style.color = "#d9534f";
						messagebox[0].style.display = "block";
					}
				}
			});
		}
		
		function checkPhone() {
			var phone = document.getElementById("phone").value;
			var phoneRegExp = /^010([0-9]{4})([0-9]{4})$/;
			if(phone === "") {
				messagebox[2].innerHTML = "핸드폰번호는 필수 입력 사항입니다.";
				messagebox[2].style.display = "block";
			} else if(!phoneRegExp.test(phone)) {
				messagebox[2].innerHTML = "입력된 값은 휴대전화번호가 아닙니다.";
				messagebox[2].style.display = "block";
			} else {
				messagebox[2].style.display = "none";
			}
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