<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>회원정보관리 탭</title>
	<c:url var="bs5" value="/static/bs5" />
	<c:url var="jQuery" value="/static/js" />
	<link rel="stylesheet" type="text/css" href="${bs5}/css/bootstrap.min.css">
	<script type="text/javascript" src="${bs5}/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="${jQuery}/jquery-3.6.0.min.js"></script>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.9.1/font/bootstrap-icons.css">
</head>
<body>
	<c:url var="adminUrl" value="/admin" />
	<!-- 탭 전환 버튼 -->
	<ul class="nav nav-tabs" role="tablist" id="commTap">
		<li class="nav-item" role="presentation">
			<a class="nav-link tap-pd font1" data-bs-toggle="tab" href="#total"
				role="tab" id="totalTap"
				onclick="location.href='${adminUrl}/memberInfo?menu=main'">전체</a>
		</li>
		<li class="nav-item" role="presentation">
			<a class="nav-link  tap-pd font1" data-bs-toggle="tab" href="#sitelogin" 
				role="tab"  id="siteloginTap"
				onclick="location.href='${adminUrl}/memberInfo?menu=sitelogin'">일반로그인</a>
		</li>
		<li class="nav-item" role="presentation">
			<a class="nav-link tap-pd font1" data-bs-toggle="tab" href="#kakaologin"
				role="tab" id="kakaologinTap"
				onclick="location.href='${adminUrl}/memberInfo?menu=kakaologin'">카카오로그인</a>
		</li>
		<li class="nav-item" role="presentation">
			<a class="nav-link tap-pd font1"data-bs-toggle="tab" href="#pmember"
				role="tab" id="pmemberTap"
				onclick="location.href='${adminUrl}/memberInfo?menu=pmember'">일반회원</a>
		</li>
		<li class="nav-item" role="presentation">
			<a class="nav-link tap-pd font1"data-bs-toggle="tab" href="#instructor"
				role="tab" id="instructorTap"
				onclick="location.href='${adminUrl}/memberInfo?menu=instructor'">강사</a>
		</li>	
		<li class="nav-item" role="presentation">
			<a class="nav-link tap-pd font1"data-bs-toggle="tab" href="#admin"
				role="tab" id="adminTap"
				onclick="location.href='${adminUrl}/memberInfo?menu=admin'">관리자</a>
		</li>
	</ul>
	<script type="text/javascript">
		$(document).ready(function(){
			var urlParams1 = window.location.search;
			var query1 = new URLSearchParams(urlParams1);
			var param_menu = query1.get('menu');
			
			if(param_menu === "main" || param_menu === null) {
				$("#totalTap").addClass("active");
			} else if(param_menu === "sitelogin") {
				$("#siteloginTap").addClass("active");
			} else if(param_menu === "kakaologin") {
				$("#kakaologinTap").addClass("active");
			} else if(param_menu === "pmember") {
				$("#pmemberTap").addClass("active");
			} else if(param_menu === "instructor") {
				$("#instructorTap").addClass("active");
			} else if(param_menu === "admin") {
				$("#adminTap").addClass("active");
			} 
		});
	
	</script>

</body>
</html>