<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:url var="mainUrl" value="/" />
<link rel="stylesheet" type="text/css" href="${css}/main.css">
<nav class="py-2">
   	<div class="container d-flex flex-wrap justify-content-end">
   		
   		<ul class="nav">
   		<c:if test="${empty sessionScope.loginData}">
			<li class="nav-item"><a href="${mainUrl}login" class="ru_top_nav_link px-2">로그인 </a></li>
			<li class="nav-item"><a href="${mainUrl}join" class="ru_top_nav_link px-2">회원가입</a></li>
   		</c:if>
   		<c:if test="${not empty sessionScope.loginData}">
   			<li class="nav-item"><a href="${mainUrl}mypage/board/QnA" class="ru_top_nav_link px-2">마이페이지 </a></li>
			<li class="nav-item"><a href="${mainUrl}mypage/wishlist/${sessionScope.loginData.AC_ID}" class="ru_top_nav_link px-2">수강바구니</a></li>
			<li class="nav-item"><a href="${mainUrl}logout" class="ru_top_nav_link px-2">로그아웃</a></li>
   		</c:if>
		</ul>
   	</div>
</nav>
<div class="py-3 border-bshadow">
	<div class="container d-flex flex-wrap">
		<a href="/home" class="d-flex align-items-center mb-3 mb-lg-0 me-lg-auto">
			<img src="${img}/logo/logo_b.png" alt="" width="218" height="35">
		</a>
		<ul class="nav me-4">
			<li class="nav-item"><a href="${mainUrl}community/main" class="ru_nav_link px-3">커뮤니티</a></li>
			<li class="nav-item"><a href="${mainUrl}studyboard" class="ru_nav_link px-3">스터디</a></li>
			<li class="nav-item"><a href="${mainUrl}course" class="ru_nav_link px-3">강의</a></li>
			<li class="nav-item"><a href="#" class="ru_nav_link px-3">취업/기업</a></li>
		</ul>
		<form action="${mainUrl}allsearch" method="get" class="col-12 col-lg-auto mb-lg-0 mt-1">
			<div class="input-group">
				<input class="form-control search_background" type="text" id="search" name="search" placeholder="통합검색">
			</div>
		</form>
	</div>
</div>