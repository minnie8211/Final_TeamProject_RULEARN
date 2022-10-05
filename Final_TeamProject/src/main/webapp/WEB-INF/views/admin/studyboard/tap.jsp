<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>학습게시판 탭</title>
	<c:url var="bs5" value="/static/bs5" />
	<c:url var="jQuery" value="/static/js" />
	<link rel="stylesheet" type="text/css" href="${bs5}/css/bootstrap.min.css">
	<script type="text/javascript" src="${bs5}/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="${jQuery}/jquery-3.6.0.min.js"></script>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.9.1/font/bootstrap-icons.css">
</head>
<body>
		<c:url var="studyBoardUrl" value="/studyboard"/>
		<!-- 탭 전환 버튼 -->
		<ul class="nav nav-tabs" role="tablist" id="commTap">
			<li class="nav-item" role="presentation">
				<a class="nav-link tap-pd font1" data-bs-toggle="tab" href="#total"
					role="tab" id="totalTap"
					onclick="location.href='${studyBoardUrl}?menu=main&sort=as_latest'">전체</a>
			</li>
			<li class="nav-item" role="presentation">
				<a class="nav-link  tap-pd font1" data-bs-toggle="tab" href="#study" 
					role="tab"  id="studyTap"
					onclick="location.href='${studyBoardUrl}?menu=study&sort=as_latest'">스터디</a>
			</li>
			<li class="nav-item" role="presentation">
				<a class="nav-link tap-pd font1" data-bs-toggle="tab" href="#project"
					role="tab" id="projectTap"
					onclick="location.href='${studyBoardUrl}?menu=project&sort=as_latest'">프로젝트</a>
			</li>
			<li class="nav-item" role="presentation">
				<a class="nav-link tap-pd font1"data-bs-toggle="tab" href="#open"
					role="tab" id="openTap"
					onclick="location.href='${studyBoardUrl}?menu=open&sort=as_latest'">모집중</a>
			</li>
			<li class="nav-item" role="presentation">
				<a class="nav-link tap-pd font1"data-bs-toggle="tab" href="#close"
					role="tab" id="closeTap"
					onclick="location.href='${studyBoardUrl}?menu=close&sort=as_latest'">모집완료</a>
			</li>	
		</ul>
<script type="text/javascript">
	$(document).ready(function(){
		var urlParams1 = window.location.search;
		var query1 = new URLSearchParams(urlParams1);
		var param_menu = query1.get('menu');
		
		if(param_menu === "main" || param_menu === null) {
			$("#totalTap").addClass("active");
		} else if(param_menu === "study") {
			$("#studyTap").addClass("active");
		} else if(param_menu === "project") {
			$("#projectTap").addClass("active");
		} else if(param_menu === "open") {
			$("#openTap").addClass("active");
		} else if(param_menu === "close") {
			$("#closeTap").addClass("active");
		}
	});

</script>

</body>
</html>