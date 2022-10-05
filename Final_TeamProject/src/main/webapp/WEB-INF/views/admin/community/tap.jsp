<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>커뮤니티 탭</title>
<%@ include file="../module/head.jsp"%>
</head>
<body>
		<c:url var="commBoardUrl" value="/community"/>
		<!-- 탭 전환 버튼 -->
		<ul class="nav nav-tabs" role="tablist" id="commTap">
			<li class="nav-item" role="presentation">
				<a class="nav-link tap-pd font1" data-bs-toggle="tab" href="#total"
					role="tab" id="totalTap"
					onclick="location.href='${commBoardUrl}/main'">전체</a>
			</li>
			<li class="nav-item" role="presentation">
				<a class="nav-link tap-pd font1"	data-bs-toggle="tab" href="#qa" 
					role="tab"  id="qaTap"
					onclick="location.href='${commBoardUrl}/qa'">Q&A</a>
			</li>
			<li class="nav-item" role="presentation">
				<a class="nav-link tap-pd font1"	data-bs-toggle="tab" href="#forum"
					role="tab" id="forumTap"
					onclick="location.href='${commBoardUrl}/forum'">고민/자유</a>
			</li>
			<li class="nav-item" role="presentation">
				<a class="nav-link tap-pd font1"	data-bs-toggle="tab" href="#tip"
					role="tab" id="tipTap"
					onclick="location.href='${commBoardUrl}/tip'">노하우/팁</a>
			</li>			
		</ul>
<script type="text/javascript">
// 페이지가 로딩되면 작동한다(window.onload 와 비슷)
$(document).ready(function(){
	// 게시판 탭 전환
	var url = $(location).attr('pathname');
	
	if(url == "/home/community/main"){
		$("#totalTap").addClass("active");
	}else if(url == "/home/community/qa"){
		$("#qaTap").addClass("active");
	}else if(url == "/home/community/forum"){
		$("#forumTap").addClass("active");
	}else if(url == "/home/community/tip"){
		$("#tipTap").addClass("active");
	}
	
});

</script>

</body>
</html>