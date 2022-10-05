<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>댓글</title>
<%@ include file="../module/head.jsp"%>
<link rel="stylesheet" type="text/css" href="${css}/mypage.css">
</head>

<body>
	<%@ include file="/WEB-INF/views/module/navigation.jsp"%>
	<div class="banner mar-bot2">
		<div class="container">
			내가 쓴 댓글
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
	                        <a href="${mypageURL}/comment/QnA" class="nav-link active">
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
	                        <a href="${mypageURL}/withdrawView" class="nav-link link-dark">
	                            회원 탈퇴
	                        </a>
	                    </li>
	                </ul>
				</div>
			</div>
			<div class="col_md_9 ms-3">
				<c:url var="myPageCommentUrl" value="/mypage/comment" />
				<ul class="nav nav-tabs" role="tablist">
					<li class="nav-item" role="presentation"><a class="nav-link"
						data-bs-toggle="tab" href="#QAndA" role="tab" id="QAndATab"
						onclick="location.href='${myPageCommentUrl}/QnA'">Q&A</a></li>
					<li class="nav-item" role="presentation"><a class="nav-link"
						data-bs-toggle="tab" href="#free" role="tab" id="freeTab"
						onclick="location.href='${myPageCommentUrl}/free'">고민/자유</a></li>
					<li class="nav-item" role="presentation"><a class="nav-link"
						data-bs-toggle="tab" href="#knowhow" role="tab" id="knowhowTab"
						onclick="location.href='${myPageCommentUrl}/knowhow'">노하우&팁</a></li>
					<li class="nav-item" role="presentation"><a class="nav-link"
						data-bs-toggle="tab" href="#study" role="tab" id="studyTab"
						onclick="location.href='${myPageCommentUrl}/study'">스터디</a></li>
					<li class="nav-item" role="presentation"><a class="nav-link"
						data-bs-toggle="tab" href="#project" role="tab" id="projectTab"
						onclick="location.href='${myPageCommentUrl}/project'">프로젝트</a></li>
				</ul>
				<div id="myTabContent" class="tab-content">
					<br>
					<c:if test="${not empty projectCommentList}">
						<c:forEach items="${projectCommentList}" var="projectComment">
							<c:url var="studyBoardDetailUrl" value="/studyboard/detail">
								<c:param name="id">${projectComment.sc_bId}</c:param>
							</c:url>
							<c:set var="origin_title" value="${projectComment.sc_content}" />
							<c:set var="diff_title"
								value="${fn:substring(origin_title, 0, 10)}" />
							<div class="tab-pane active show" id="QAndA" role="tabpanel"
								onclick="location.href='${studyBoardDetailUrl}'">
								<ul class="list-group">
									<li
										class="list-group-item d-flex justify-content-between align-items-center">
										<span class="col-1 badge bg-primary"> 프로젝트 </span>
										<div class="inner col-5">${diff_title}</div>
										<div class="col-3">${projectComment.sc_wId}</div>
										<div class="col-2">${projectComment.sc_date}</div>
										<div class="col-1">♥${projectComment.sc_like}</div>
									</li>
								</ul>
							</div>
						</c:forEach>
					</c:if>
					<!-- 페이징 -->
					<br>
					<nav>
						<div>
							<ul class="pagination justify-content-center">
								<c:if test="${pageData.hasPrevPage()}">
									<li class="page-item"><a class="page-link"
										href="${commBoardUrl}?page=${pageData.prevPageNumber}">&laquo;</a>
									</li>
								</c:if>
								<c:forEach
									items="${pageData.getPageNumberList(pageData.currentPageNumber - 2, pageData.currentPageNumber + 2)}"
									var="num">
									<li
										class="page-item ${pageData.currentPageNumber eq num ? 'active' : ''}">
										<a class="page-link" href="${commBoardUrl}?page=${num}">
											${num} </a>
									</li>
								</c:forEach>
								<c:if test="${pageData.hasNextPage()}">
									<li class="page-item"><a class="page-link"
										href="${commBoardUrl}?page=${pageData.nextPageNumber}">&raquo;</a></li>
								</c:if>
							</ul>
						</div>
					</nav>
				</div>
			</div>
		</div>
	</div>
	<%@ include file="/WEB-INF/views/module/footer.jsp"%>
	<script type="text/javascript">
	$(document).ready(function(){
		var url = $(location).attr('pathname');
		console.log(url);
		if(url == "/home/mypage/comment/QnA"){
			$("#QAndATab").addClass("active");
		} else if (url == "/home/mypage/comment/free"){
			$("#freeTab").addClass("active");
		} else if (url == "/home/mypage/comment/knowhow"){
			$("#knowhowTab").addClass("active");
		} else if (url == "/home/mypage/comment/study"){
			$("#studyTab").addClass("active");
		} else if (url == "/home/mypage/comment/project"){
			$("#projectTab").addClass("active");
		}
	});
	</script>
</body>
</html>