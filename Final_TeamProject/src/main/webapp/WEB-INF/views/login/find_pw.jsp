<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>로그인</title>
	<%@ include file="../module/head.jsp" %>
	<link rel="stylesheet" type="text/css" href="${css}/login.css">
	
</head>
<c:url var="mainUrl" value="/" />
<body class="text-center">
	<main class="form-signin w-100 m-auto">
		<a href="${mainUrl}"><img class="mb-4" src="${img}/logo/logo_b.png" alt="" width="250" height="40"></a>
	
		<ul class="nav login_nav_tabs mt-4">
			<li class="nav-item">
				<a class="find_nav_link" href="${mainUrl}login/find_id">아이디찾기</a>
				</li>
			<li class="nav-item">
				<a class="find_nav_link active" href="${mainUrl}login/find_pw">비밀번호찾기</a>
			</li>
		</ul>
		<div class="login_card text-start">
			<div class="tab-content card-body">
					<c:url var="loginUrl" value="/login" />
					<form action="${loginUrl}/find_pw" method="post">
						<div class="form-group">
							<input class="form-control p-3" type="text" id="name" name="name" placeholder="이름">
						</div>
						<div class="form-group mt-4">
							<input class="form-control p-3" type="email" id="email" name="email" placeholder="이메일주소" >
						</div>

						<button class="w-100 login_btn btn-lg btn-primary p-3 mt-4" type="submit">비밀번호찾기</button>
					</form>
			</div>
		</div>
		<p class="mt-5 mb-3 under_text_b"><a href="#">이용약관</a>&emsp;|&emsp;<a href="#">개인정보처리방침</a>&emsp;|&emsp;<a href="#">FAQ</a></p>
		<p class="under_text_s">Copyright RUlearn. All Rights Reserved.</p>
	</main>
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
	
		$(document).ready(function() {
			// 저장된 쿠키값을 가져와서 ID칸에 넣어주기. 없으면 공백
			var key = getCookie("key");
			$("#id").val(key);
			
			// 그 전에 ID를 저장했던 적이 있어 페이지 로딩시 입력칸에 ID가 표시된 상태인 경우
			if($("#id").val() != "") {
				$("#rememberId").attr("checked", true); // ID 저장하기 체크상태로 표시
			}
			
			$("#rememberId").change(function() {	
				if($("#rememberId").is(":checked")) {	// ID 저장하기 체크했을 때
					setCookie("key", $("#id").val(), 7);	// 7일동안 쿠키 보관
				} else {
					deleteCookie("key");	// ID 저장하기 체크해제하면 쿠키삭제
				}
			});
			
			// ID 저장하기를 체크한 상태에서 ID를 입력하는 경우 쿠키저장
			$("#id").keyup(function() {
				if($("#rememberId").is(":checked")) {
					setCookie("key", $("#id").val(), 7);
				}
			});
			
		});
		
		// 쿠키 저장
		function setCookie(cookieName, value, exdays) {
			var exdate = new Date();
			exdate.setDate(exdate.getDate() + exdays);
			var cookieValue = escape(value) + ((exdays == null) ? "" : "; expire=" + exdate.toGMTString());
			document.cookie = cookieName + "=" + cookieValue;
		}
		
		// 쿠키 삭제
		function deleteCookie(cookieName) {
			var expireDate = new Date();
			expireDate.setDate(expireDate.getDate() - 1);
			document.cookie = cookieName + "= " + "; expires=" + expireDate.toGMTString();
		}
		
		// 쿠기 가져오기
		function getCookie(cookieName) {
			cookieName = cookieName + '=';
			var cookieData = document.cookie;
			var start = cookieData.indexOf(cookieName);
			var cookieValue = '';
			if(start != -1) {	// 쿠키가 존재하면
				start += cookieName.length;
				var end = cookieData.indexOf(';', start);
				if(end == -1) {	// 쿠키 값의 마지막 위치 인덱스 번호 설정
					end = cookieData.lenght;
					cookieValue = cookieData.substring(start, end);
				}
				return unescape(cookieValue);
			}
		}
	</script>
</body>
</html>