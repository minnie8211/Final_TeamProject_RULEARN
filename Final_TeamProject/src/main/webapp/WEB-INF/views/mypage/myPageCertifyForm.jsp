<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page import="com.web.home.account.model.AccountDTO"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 정보 수정</title>
<%@ include file="../module/head.jsp"%>
<link rel="stylesheet" type="text/css" href="${css}/mypage.css">
<script type="text/javascript">
	$(document).ready(function() {
		$("#btnUpdate").click(function() {
			// 확인 대화 상자
			if (confirm("회원 정보를 수정하시겠습니까?")) {
				document.certifyform.action = "/home/mypage/certifyform";
				document.certifyform.submit();
			}

		});
	});
</script>
</head>

<body>
	<%@ include file="/WEB-INF/views/module/navigation.jsp"%>
	<div class="banner mar-bot2">
		<div class="container">
			개인 정보 수정
		</div>
	</div>
	<div class="container m-height">
		<div class="row">
			<div class=col-md-3>
				<div class="d-flex flex-column flex-shrink-0 p-3 bg-light">
					<c:url value="/mypage" var="mypageURL"/>
					 <ul class="nav nav_pills mb-auto px-3 bg-light d-flex flex-column">
	                    <li class="nav-item">
	                        <a href="${mypageURL}/board/QnA" class="nav-link link-dark" aria-current="page">
	                            내가 쓴 게시글
	                        </a>
	                    </li>
	                    <li>
	                        <a href="${mypageURL}/comment/QnA" class="nav-link link-dark">
	                            내가 쓴 댓글
	                        </a>
	                    </li>
	                    <li>
	                        <a href="${mypageURL}/lesson" class="nav-link link-dark">
	                            수강 중 강의
	                        </a>
	                    </li>
	                    <li>
	                        <a href="${mypageURL}/wishlist/${sessionScope.loginData.AC_ID}" class="nav-link link-dark">
	                            수강바구니
	                        </a>
	                    </li>
	                    <li>
	                        <a href="${mypageURL}/certifyformView" class="nav-link active">
	                            개인 정보 수정
	                        </a>
	                    </li>
	                    <li>
	                        <a href="${mypageURL}/withdrawView" class="nav-link link-dark">
	                            회원 탈퇴
	                        </a>
	                    </li>
	                </ul>
				</div>
			</div>
			<%
			if (session.getAttribute("accessToken") == null) {
			%>
			<div class="col_md_9 ms-3">
				<form action="/home/mypage/certifyform" method="post"
					id="certifyform" name="certifyform">
					<div class="form-group">
						<label class="col-form-label" for="AC_ID">아이디</label> <input
							type="text" class="form-control" id="AC_ID" name="AC_ID"
							value="${loginData.AC_ID}" readonly>
					</div>
					<div class="form-group">
						<label class="col-form-label mt-3" for="AC_PW_ORIGIN">변경 전
							비밀번호 확인</label> <input type="password" class="form-control"
							name="AC_PW_ORIGIN" placeholder="현재 비밀번호를 입력해주세요"
							id="AC_PW_ORIGIN" required="required">
					</div>
					<div class="form-group">
						<label class="col-form-label mt-3" for="AC_PW">변경 할 비밀번호</label> <input
							type="password" class="form-control" name="AC_PW"
							placeholder="변경할 비밀번호를 입력해주세요" id="AC_PW" oninput="checkPw();" required="required">
						<span class="chk_message"></span>
					</div>
					<div class="form-group">
						<label class="col-form-label mt-3" for="AC_NICKNAME">닉네임</label> <input
							type="text" class="form-control" id="AC_NICKNAME"
							name="AC_NICKNAME" value="${loginData.AC_NICKNAME}"
							oninput="checkNickname();"> <span class="chk_message"></span>
					</div>
					<div class="form-group">
						<label class="col-form-label mt-3" for="AC_NAME">이름</label> <input
							type="text" class="form-control" id="AC_NAME" name="AC_NAME"
							value="${loginData.AC_NAME}" readonly>
					</div>
					<div class="form-group">
						<label class="col-form-label mt-3" for="AC_PHONE">전화번호</label> <input
							type="text" class="form-control" value="${loginData.AC_PHONE}"
							id="AC_PHONE" name="AC_PHONE" oninput="checkPhone();"> <span
							class="chk_message"></span>
					</div>
					<div class="form-group">
						<label class="col-form-label mt-3" for="AC_EMAIL"> 이메일</label> <input
							type="text" class="form-control" value="${loginData.AC_EMAIL}"
							id="AC_EMAIL" name="AC_EMAIL" readonly>
					</div>
					<br>
					<div class="d-grid gap-2">
						<input class="btn btn-lg btn-primary" type="button" value="수정"
							id="btnUpdate">
					</div>
				</form>
			</div>
			<%
			} else {
			%>
			<div class="col_md_9 ms-3">
				<form action="/home/mypage/certifyform" method="post"
					id="certifyform" name="certifyform">
					<div class="form-group">
						<label class="col-form-label mt-3" for="AC_NICKNAME">닉네임</label> <input
							type="text" class="form-control" id="AC_NICKNAME"
							name="AC_NICKNAME" value="${loginData.AC_NICKNAME}"
							oninput="checkNickname();"> <span class="chk_message"></span>
					</div>
					<div class="form-group">
						<label class="col-form-label mt-3" for="AC_NAME">이름</label> <input
							type="text" class="form-control" id="AC_NAME" name="AC_NAME"
							value="${loginData.AC_NAME}" readonly>
					</div>
					<div class="form-group">
						<label class="col-form-label mt-3" for="AC_PHONE">전화번호</label> <input
							type="text" class="form-control" value="${loginData.AC_PHONE}"
							id="AC_PHONE" name="AC_PHONE" oninput="checkPhone();"> <span
							class="chk_message"></span>
					</div>
					<div class="form-group">
						<label class="col-form-label mt-3" for="AC_EMAIL"> 이메일</label> <input
							type="text" class="form-control" value="${loginData.AC_EMAIL}"
							id="AC_EMAIL" name="AC_EMAIL" readonly>
					</div>
					<br>
					<div class="d-grid gap-2">
						<input class="btn btn-lg btn-primary" type="button" value="수정"
							id="btnUpdate">
					</div>
				</form>
			</div>
			<%
			}
			%>
		</div>
	</div>
	<br>
	<c:url var="joinUrl" value="/join" />
	<%@ include file="/WEB-INF/views/module/footer.jsp"%>
	<script type="text/javascript">
		var messagebox = document.querySelectorAll(".chk_message");

		function checkPw() {
			var pw1 = document.getElementById("AC_PW").value;
			var pwRegExp = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$/;
			if (pw1 === "") {
				messagebox[0].innerHTML = "비밀번호는 필수 입력 사항입니다.";
				messagebox[0].style.color = "#d9534f";
				messagebox[0].style.display = "block";
			} else if (!pwRegExp.test(pw1)) {
				messagebox[0].innerHTML = "비밀번호는 영문자, 숫자, 특수문자를 최소 1개씩 포함해야 합니다.";
				messagebox[0].style.color = "#d9534f";
				messagebox[0].style.display = "block";
			} else {
				messagebox[0].innerHTML = "사용가능한 비밀번호입니다.";
				messagebox[0].style.color = "#8c8c8c";
				messagebox[0].style.display = "block";
			}
		}

		function checkNickname() {
			var nickname = document.getElementById("AC_NICKNAME").value;

			$.ajax({
				url : "${joinUrl}/checkNickname",
				type : "post",
				data : {
					nickname : nickname
				},
				dataType : "json",
				success : function(data) {
					if (data.code === "success") {
						if (nickname === "") {
							// 닉네임 공백 체크
							messagebox[1].innerHTML = "닉네임은 필수 입력 사항입니다.";
							messagebox[1].style.color = "#d9534f";
							messagebox[1].style.display = "block";
						} else {
							// 사용가능한 닉네임
							messagebox[1].innerHTML = data.message;
							messagebox[1].style.color = "#8c8c8c";
							messagebox[1].style.display = "block";
						}
					} else {
						// 이미 존재하는 닉네임
						messagebox[1].innerHTML = data.message;
						messagebox[1].style.color = "#d9534f";
						messagebox[1].style.display = "block";
					}
				}
			});
		}

		function checkPhone() {
			var phone = document.getElementById("AC_PHONE").value;
			var phoneRegExp = /^010([0-9]{4})([0-9]{4})$/;
			if (phone === "") {
				messagebox[2].innerHTML = "핸드폰번호는 필수 입력 사항입니다.";
				messagebox[2].style.display = "block";
			} else if (!phoneRegExp.test(phone)) {
				messagebox[2].innerHTML = "입력된 값은 휴대전화번호가 아닙니다.";
				messagebox[2].style.display = "block";
			} else {
				messagebox[2].innerHTML = "사용가능한 휴대전화번호입니다.";
				messagebox[2].style.display = "none";
			}
		}

		function formCheck(form) {
			var modal = new bootstrap.Modal(document
					.getElementById("errorModal"), {
				keyboard : false
			});
			var title = modal._element.querySelector(".modal-title");
			var body = modal._element.querySelector(".modal-body");

			if (form.AC_PW.value === undefined
					|| form.AC_PW.value.trim() === "") {
				title.innerText = "비밀번호 입력 오류";
				body.innerText = "비밀번호는 필수 입력사항입니다.\n비밀번호를 입력해주세요.";
				modal.show();
				return;
			}

			if (form.AC_NICKNAME.value === undefined
					|| form.AC_NICKNAME.value.trim() === "") {
				title.innerText = "닉네임 입력 오류";
				body.innerText = "닉네임은 필수 입력사항입니다.\n닉네임을 입력해주세요.";
				modal.show();
				return;
			}

			if (form.AC_PHONE.value === undefined
					|| form.AC_PHONE.value.trim() === "") {
				title.innerText = "핸드폰번호 입력 오류";
				body.innerText = "핸드폰번호는 필수 입력사항입니다.\n핸드폰번호를 입력해주세요.";
				modal.show();
				return;
			}

			form.submit();
		}
	</script>
</body>
</html>