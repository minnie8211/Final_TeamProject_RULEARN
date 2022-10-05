<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 모음</title>
<%@ include file="../module/head.jsp"%>
<link rel="stylesheet" type="text/css" href="${css}/mypage.css">
</head>

<body>
	<header>
		<%@ include file="/WEB-INF/views/module/navigation.jsp"%>
	</header>
	<div class="banner mar-bot2">
		<div class="container">
			내가 쓴 게시글
		</div>
	</div>
	<div class="container m-height">
		<div class="row">
			<div class="col-md-3">
				<div class="d-flex flex-column flex-shrink-0 p-3 bg-light">
					<c:url value="/mypage" var="mypageURL"/>
					 <ul class="nav nav_pills mb-auto px-3 bg-light d-flex flex-column">
	                    <li class="nav-item">
	                        <a href="${mypageURL}/board/QnA" class="nav-link active">
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
	                        <a href="${mypageURL}/withdrawView" class="nav-link link-dark">
	                            회원 탈퇴
	                        </a>
	                    </li>
	                </ul>
				</div>
			</div>
			<div class="col_md_9 ms-3">
				<c:url var="myPageBoardUrl" value="/mypage/board" />
				<ul class="nav nav-tabs" role="tablist">
					<li class="nav-item" role="presentation"><a class="nav-link"
						data-bs-toggle="tab" href="#QAndA" role="tab" id="QAndATab"
						onclick="location.href='${myPageBoardUrl}/QnA'">Q&A</a></li>
					<li class="nav-item" role="presentation"><a class="nav-link"
						data-bs-toggle="tab" href="#free" role="tab" id="freeTab"
						onclick="location.href='${myPageBoardUrl}/free'">고민/자유</a></li>
					<li class="nav-item" role="presentation"><a class="nav-link"
						data-bs-toggle="tab" href="#knowhow" role="tab" id="knowhowTab"
						onclick="location.href='${myPageBoardUrl}/knowhow'">노하우&팁</a></li>
					<li class="nav-item" role="presentation"><a class="nav-link"
						data-bs-toggle="tab" href="#study" role="tab" id="studyTab"
						onclick="location.href='${myPageBoardUrl}/study'">스터디</a></li>
					<li class="nav-item" role="presentation"><a class="nav-link"
						data-bs-toggle="tab" href="#project" role="tab" id="projectTab"
						onclick="location.href='${myPageBoardUrl}/project'">프로젝트</a></li>
				</ul>
				<div id="myTabContent" class="tab-content">
					<br>
					<c:if test="${not empty tipBoardList}">
						<c:forEach items="${tipBoardList}" var="tipBoard">
							<c:url var="commBoardDetailUrl" value="/community/detail">
								<!-- 게시판 상세 페이지로 넘어갈 때 RequestParam으로 게시판 id 넘겨주기 -->
								<c:param name="cb_bid">${tipBoard.cb_bid}</c:param>
							</c:url>
							<c:set var="origin_title" value="${tipBoard.cb_title}" />
							<c:set var="diff_title"
								value="${fn:substring(origin_title, 0, 10)}" />
							<div class="tab-pane active show" id="knowhow" role="tabpanel"
								onclick="location.href='${commBoardDetailUrl}'">
								<ul class="list-group">
									<li
										class="list-group-item d-flex justify-content-between align-items-center">
										<c:if test="${tipBoard.cb_catid eq 3}">
											<span class="badge bg-primary col-1"> 노하우&팁 </span>
											<div class="inner col-5">${diff_title}</div>
											<div class="col-3">${tipBoard.cb_wid}</div>
											<div class="col-2">${tipBoard.cb_date}</div>
											<div class="col-1">♥${tipBoard.cb_like}</div>
										</c:if>
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
		if(url == "/home/mypage/board/QnA"){
			$("#QAndATab").addClass("active");
		} else if (url == "/home/mypage/board/free"){
			$("#freeTab").addClass("active");
		} else if (url == "/home/mypage/board/knowhow"){
			$("#knowhowTab").addClass("active");
		} else if (url == "/home/mypage/board/study"){
			$("#studyTab").addClass("active");
		} else if (url == "/home/mypage/board/project"){
			$("#projectTab").addClass("active");
		}
	});
	</script>
</body>
</html>