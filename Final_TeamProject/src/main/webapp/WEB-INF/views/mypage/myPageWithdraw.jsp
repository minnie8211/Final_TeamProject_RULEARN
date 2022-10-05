<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 탈퇴</title>
<%@ include file="../module/head.jsp"%>
<link rel="stylesheet" type="text/css" href="${css}/mypage.css">
<script type="text/javascript">
	$(document).ready(function() {
		$("#btnDelete").click(function(form) {
			// 확인 대화 상자
			if (confirm("회원 정보를 삭제하시겠습니까?")) {
				document.deleteform.action = "/home/mypage/withdraw";
				document.deleteform.submit();
			}
		});
	});
</script>
</head>

<body>
	<header>
		<%@ include file="/WEB-INF/views/module/navigation.jsp"%>
	</header>
	<div class="banner mar-bot2">
		<div class="container">
			회원 탈퇴
		</div>
	</div>
	<div class="container m-height">
		<div class="row">
			<div class="col-md-3">
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
	                        <a href="${mypageURL}/certifyformView" class="nav-link link-dark">
	                            개인 정보 수정
	                        </a>
	                    </li>
	                    <li>
	                        <a href="${mypageURL}/withdrawView" class="nav-link active">
	                            회원 탈퇴
	                        </a>
	                    </li>
	                </ul>
				</div>
			</div>
			<div class="col_md_9 ms-3">
				<form action="/home/mypage/withdraw" method="post" id="deleteform"
					name="deleteform">
					<div class="form-group">
						<label class="col-form-label" for="AC_ID">아이디</label> <input
							class="form-control" type="text" id="AC_ID" name="AC_ID"
							value="${loginData.AC_ID}" readonly="readonly" />
					</div>
					<div class="form-group">
						<label class="col-form-label mt-3" for="AC_PW">패스워드</label> <input
							class="form-control" type="password" id="AC_PW" name="AC_PW"
							placeholder="현재 비밀번호를 입력해주세요" oninput="checkPw();" /> <span
							class="chk_message"></span>
					</div>
					<div class="form-group">
						<label class="col-form-label mt-3" for="AC_NAME">성명</label> <input
							class="form-control" type="text" id="AC_NAME" name="AC_NAME"
							value="${loginData.AC_NAME}" readonly="readonly" />
					</div>
					<br>
					<div class="d-grid gap-2">
						<input class="btn btn-lg btn-primary" type="button" value="탈퇴"
							id="btnDelete">
					</div>
				</form>
			</div>
		</div>
	</div>
	<br>
	<c:url var="joinUrl" value="/join" />
	<%@ include file="/WEB-INF/views/module/footer.jsp"%>
	<script type="text/javascript">
		var messagebox = document.querySelectorAll(".chk_message");

		function checkPw() {
			var pw1 = document.getElementById("AC_PW").value;
			if (pw1 === "") {
				messagebox[0].innerHTML = "비밀번호는 필수 입력 사항입니다.";
				messagebox[0].style.color = "#d9534f";
				messagebox[0].style.display = "block";
			} else {
				messagebox[0].innerHTML = "";
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

			form.submit();
		}
	</script>
</body>
</html>