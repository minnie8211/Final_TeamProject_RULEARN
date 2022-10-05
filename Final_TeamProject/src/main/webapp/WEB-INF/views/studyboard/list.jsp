<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>학습 게시판</title>
	<%@ include file="../module/head.jsp" %>
	<link rel="stylesheet" type="text/css" href="${css}/studyboard.css">
</head>
<body>
	<header>
		<%@ include file="../module/navigation.jsp" %>
	</header>
		<div class="banner mar-bot2">
			<div class="container">
				<span class="banner_font_b">혼자서는 힘들었던 스터디, 프로젝트!</span>
				<span class="banner_font_s">함께 성장할 팀원을 만나보세요!</span>
			</div>
		</div>
	<section class="container mar-bot2 mar-top2 m-height">
		<%@ include file="tap.jsp"%>
		
		<div class="mar-top2 mar-bot2">
			<c:url var="studyBoardUrl" value="/studyboard" />
			<form action="${studyBoardUrl}" method="get">
				<div class="row g-1">
					<div class="">
						<div class="flex">
							<input class="form-control m-right10 pd6 search-logo" type="text" name="search" placeholder="제목 / 작성자 / 내용 검색">
							<button class="btn btn-primary w8 font1a" type="submit">검색</button>
						</div>
					</div>
				</div>
			</form>
		</div>
		
		<div class="flex mar-bot1">
			<div class="flex3">
				<button class="btn font1 as_view" id="as1" type="button" onclick="location.href='${studyBoardUrl}?menu=${menu}&search=${search}&sort=as_latest'">• 최신순</button>
				<button class="btn font1 as_view" id="as2" type="button" onclick="location.href='${studyBoardUrl}?menu=${menu}&search=${search}&sort=as_reply'">• 댓글많은순</button>
				<button class="btn font1 as_view" id="as3" type="button" onclick="location.href='${studyBoardUrl}?menu=${menu}&search=${search}&sort=as_likes'">• 좋아요순</button> 
			</div>
			<div class="w6 m-right10">
				<c:choose>
					<c:when test="${not empty search}">
						<select class="form-select pd0-4" onchange="location.href='${studyBoardUrl}?search=${search}&sort=${sort}&pageCount=' + this.value">
							<option value="5" ${sessionScope.pageCount == 5 ? 'selected' : ''}>5 개</option>
							<option value="10" ${sessionScope.pageCount == 10 ? 'selected' : ''}>10 개</option>
							<option value="15" ${sessionScope.pageCount == 15 ? 'selected' : ''}>15 개</option>
							<option value="20" ${sessionScope.pageCount == 20 ? 'selected' : ''}>20 개</option>
						</select>
					</c:when>
					<c:otherwise>
						<select class="form-select pd0-4" onchange="location.href='${studyBoardUrl}?menu=${menu}&sort=${sort}&pageCount=' + this.value">
							<option value="5" ${sessionScope.pageCount == 5 ? 'selected' : ''}>5 개</option>
							<option value="10" ${sessionScope.pageCount == 10 ? 'selected' : ''}>10 개</option>
							<option value="15" ${sessionScope.pageCount == 15 ? 'selected' : ''}>15 개</option>
							<option value="20" ${sessionScope.pageCount == 20 ? 'selected' : ''}>20 개</option>
						</select>
					</c:otherwise>
				</c:choose>
			</div>
			<div class="mar-top1-8">
				<button class="btn btn-secondary font1 w7 edit-logo nowrp" type="button" onclick="location.href='${studyBoardUrl}/add'">글쓰기</button>
			</div>
		</div>
		
		<table class="table table-hover mar-bot3 bor-col">
			 <colgroup>
			    <col width="120" style=""/>
			    <col />
			    <col width="180" style="" />
			    <col width="180" style="" />
			    <col width="120" style="" />
			  </colgroup>
			<thead>
			</thead>
			<tbody>
				<c:if test="${not empty Alldatas}">
					<c:forEach items="${Alldatas}" var="data">
						<c:url var="studyBoardDetailUrl" value="/studyboard/detail">
							<c:param name="id">${data.sb_bId}</c:param>
						</c:url>
						<tr onclick="location.href='${studyBoardDetailUrl}'">
							<c:choose>
								<c:when test="${data.sb_isDone == 'true' }">
									<td class="txt-center"><span class="done-y-style nowrp">모집완료</span></td>
								</c:when>
								<c:otherwise>
									<td class="txt-center"><span class="done-f-style nowrp">모집중</span></td>
								</c:otherwise>
							</c:choose>
							<c:choose>
								<c:when test="${data.sb_catId == 4 }">
									<td style="cursor : pointer;"><b>[스터디]</b> ${data.sb_title}&nbsp;&nbsp;[${data.total_reply > 0 ? data.total_reply : 0}]</td>
								</c:when>
								<c:when test="${data.sb_catId == 5 }">
									<td style="cursor : pointer;"><b>[프로젝트]</b> ${data.sb_title}&nbsp;&nbsp;[${data.total_reply > 0 ? data.total_reply : 0}]</td>
								</c:when>
							</c:choose>
							<td>${data.sb_wName}</td>
							<td>${data.sb_date}</td>
							<td class="txt-center">♥&nbsp;${data.sb_like}</td>
						</tr>
					</c:forEach>
				</c:if>
				<c:if test="${empty Alldatas}">
					<td colspan="5" class="none-border no-hover">
						<div class="txt-center pd100">등록된 게시글이 없습니다.</div>
					</td>
				</c:if>
			</tbody>
		</table>
		<nav class="mar-bot3">
			<div>
				<ul class="pagination justify-content-center">
					<c:if test="${pageData.hasPrevPage()}">
						<li class="page-item">
						<c:choose>
							<c:when test="${not empty search}">
								<a class="page-link" href="${studyBoardUrl}?search=${search}&sort=${sort}&page=${pageData.prevPageNumber}">«</a>
							</c:when>
							<c:otherwise>
								<a class="page-link" href="${studyBoardUrl}?menu=${menu}&sort=${sort}&page=${pageData.prevPageNumber}">«</a>
							</c:otherwise>
						</c:choose>
						</li>
					</c:if>
					<c:forEach items="${pageData.getPageNumberList(pageData.currentPageNumber - 2, pageData.currentPageNumber + 2)}" var="num">
						<li class="page-item ${pageData.currentPageNumber eq num ? 'active' : ''}">
						<c:choose>
							<c:when test="${not empty search}">
								<a class="page-link" href="${studyBoardUrl}?search=${search}&sort=${sort}&page=${num}">${num}</a>
							</c:when>
							<c:otherwise>
								<a class="page-link" href="${studyBoardUrl}?menu=${menu}&sort=${sort}&page=${num}">${num}</a>
							</c:otherwise>
						</c:choose>
						</li>
					</c:forEach>
					<c:if test="${pageData.hasNextPage()}">
						<li class="page-item">
						<c:choose>
							<c:when test="${not empty search}">
								<a class="page-link" href="${studyBoardUrl}?search=${search}&sort=${sort}&page=${pageData.nextPageNumber}">»</a>
							</c:when>
							<c:otherwise>
								<a class="page-link" href="${studyBoardUrl}?menu=${menu}&sort=${sort}&page=${pageData.nextPageNumber}">»</a>
							</c:otherwise>
						</c:choose>
						</li>
					</c:if>
				</ul>
			</div>
		</nav>
	</section>
	<footer>
		<%@ include file="../module/footer.jsp" %>
	</footer>
	<c:url var="mainUrl" value="/" />
	<script type="text/javascript">
		$(document).ready(function(){
			var urlParams2 = window.location.search;
			var query2 = new URLSearchParams(urlParams2);
			var param_sort = query2.get('sort');
			
			var as_view = document.getElementsByClassName("as_view");
			var as_latest = document.getElementById("as1");
			var as_reply = document.getElementById("as2");
			var as_likes = document.getElementById("as3");
			const CLICKED_CLASS = "clicked";
			
			if(param_sort === "as_latest" || param_sort === null) {
				for (var i = 0; i < as_view.length; i++) {
				 	as_view[i].classList.remove("clicked");
				}
				as_latest.classList.add(CLICKED_CLASS);
			} else if(param_sort === "as_reply") {
				for (var i = 0; i < as_view.length; i++) {
				 	as_view[i].classList.remove("clicked");
				}
				as_reply.classList.add(CLICKED_CLASS);
			} else if(param_sort === "as_likes") {
				for (var i = 0; i < as_view.length; i++) {
				 	as_view[i].classList.remove("clicked");
				}
				as_likes.classList.add(CLICKED_CLASS);
			} 
		});

	</script>
</body>
</html>