<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>커뮤니티 게시판 - Q&A</title>
<%@ include file="../module/head.jsp"%>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.9.1/font/bootstrap-icons.css">
<link rel="stylesheet" type="text/css" href="${css}/studyboard.css">
<link rel="stylesheet" type="text/css" href="${css}/communityboard.css">
</head>
<body>

	<header>
	<%@ include file="../module/navigation.jsp"%>
	 </header>
		<div class="banner mar-bot2">
			<div class="container">
				<span class="banner_font_b">소통이 필요한 초보 개발자를 위한 커뮤니티!</span>
				<span class="banner_font_s">질문하고 답하고, 수다도 떨고, 노하우 공유까지!</span>
			</div>
		</div>
	<section class="container mar-bot2 m-height">
		<!-- 탭 -->
		<%@ include file="tap.jsp"%>
		<c:url var="commQAUrl" value="/community/qa"/>
		<c:url var="commAddBoardUrl" value="/community/add"/>
		
		<!-- 게시판 검색 -->
		<div class="mar-top2 mar-bot2">
			<form action="${commQAUrl}" method="get">
				<div class="row g-1">
					<div class="flex">
						<input class="form-control m-right10 pd6 search-logo" type="text" name="search" placeholder="제목 / 작성자 / 내용 검색">
						<button class="btn btn-primary wi100 font1a" type="submit">검색</button>
					</div>
			</div>
			</form>
		</div>

		<!-- 댓글 정렬 버튼 3개(최신순, 댓글순, 좋아요순) / 글쓰기 버튼-->
		<div class="flex mar-bot1">
			<div class="flex1">
			<c:choose>
				<c:when test="${not empty  searchValue}">
					<button class="btn font1 as_view" id="as1" type="button" onclick="location.href='${commQAUrl}?search=${searchValue}&sort=latest'">• 최신순</button>
					<button class="btn font1 as_view" id="as2" type="button" onclick="location.href='${commQAUrl}?search=${searchValue}&sort=comment'">• 댓글많은순</button>
					<button class="btn font1 as_view" id="as3" type="button" onclick="location.href='${commQAUrl}?search=${searchValue}&sort=like'">• 좋아요순</button>
				</c:when>
				<c:otherwise>
					<button class="btn font1 as_view" id="as1" type="button" onclick="location.href='${commQAUrl}?sort=latest'">• 최신순</button>
					<button class="btn font1 as_view" id="as2" type="button" onclick="location.href='${commQAUrl}?sort=comment'">• 댓글많은순</button>
					<button class="btn font1 as_view" id="as3" type="button" onclick="location.href='${commQAUrl}?sort=like'">• 좋아요순</button>
				</c:otherwise>
			</c:choose> 
			</div>
			<div class="float-end" style="margin-right: 10px;">
				<select class="form-select" onchange="pageCountUrl(this.value)">
					<option value="5" ${sessionScope.pageCount == 5 ? 'selected' : ''}>5 개</option>
					<option value="10" ${sessionScope.pageCount == 10 ? 'selected' : ''}>10 개</option>
					<option value="15" ${sessionScope.pageCount == 15 ? 'selected' : ''}>15 개</option>
					<option value="20" ${sessionScope.pageCount == 20 ? 'selected' : ''}>20 개</option>
				</select>
			</div>
			<div class="">
				<button class="btn btn-secondary font1 w7 edit-logo" type="button" onclick="location.href='${commAddBoardUrl}'">글쓰기</button>
			</div>
		</div>
		<div>
		<table class="table table-hover mar-bot3 bor-col">
				<colgroup>
					<col width="140 style=" "/>
					<col width="" style="" />
					<col width="200" style="" />
					<col width="200" style="" />
					<col width="85" style="" />
				</colgroup>
				<!-- <thead class="table-primary">
				<th>카테고리</th>
				<th>제목</th>
				<th>작성자</th>
				<th>작성일</th>
				<th>추천수</th>
				<th>댓글수</th>
				</thead> -->
			<tbody>
				<c:choose>
				<c:when test="${not empty qaBoardList}">
					<c:forEach items="${qaBoardList}" var="qaBoard">
						<c:url var="commBoardDetailUrl" value="/community/detail">
							<!-- 게시판 상세 페이지로 넘어갈 때 RequestParam으로 게시판 id 넘겨주기 -->
							<c:param name="cb_bid">${qaBoard.cb_bid}</c:param>
						</c:url>
						<tr onclick="location.href='${commBoardDetailUrl}'">
							<c:if test="${qaBoard.cb_catid eq 1}">
								<td class="txt-center"><span class="comm-cat-qa">Q&A</span></td>
							</c:if>
							<c:if test="${qaBoard.cb_catid eq 2}">
								<td class="txt-center"><span class="comm-cat-forum">고민/자유</span></td>
							</c:if>
							<c:if test="${qaBoard.cb_catid eq 3}">
								<td class="txt-center"><span class="comm-cat-tip">노하우/팁</span></td>
							</c:if>
							<td>${qaBoard.cb_title}&nbsp;&nbsp;[${qaBoard.cb_commentNum}]</td>
							<td>${qaBoard.cb_nickName}</td>
							<td>${qaBoard.cb_date}</td>
							<td><i class="bi bi-heart-fill"></i> ${qaBoard.cb_like}</td>
							<%-- <td>${totalBoard.cb_commentNum}</td> --%>
						</tr>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<div class="txt-center no-result">
						<i class="bi bi-exclamation-circle"></i><br>
						"${searchValue}"에 대한 검색 결과가 없습니다
					</div>
				</c:otherwise>
				</c:choose>
			</tbody>
		</table>
		</div>
		
		
		<!-- 페이징 -->
		<nav>
			<div>
				<ul class="pagination justify-content-center">
					<c:if test="${pageData.hasPrevPage()}">
						<li class="page-item">
							<a class="page-link" href="#" onclick="pageUrlMove(${pageData.prevPageNumber});">&laquo;</a>
						</li>
					</c:if>
					<c:forEach items="${pageData.getPageNumberList(pageData.currentPageNumber - 2, pageData.currentPageNumber + 2)}" var="num">
						<li class="page-item ${pageData.currentPageNumber eq num ? 'active' : ''}">
							<a class="page-link" href="#" onclick="pageUrlMove(${num});">${num}</a>
						</li>
					</c:forEach>
					<c:if test="${pageData.hasNextPage()}">
						<li class="page-item">
							<a class="page-link" href="#" onclick="pageUrlMove(${pageData.nextPageNumber});">&raquo;</a>
						</li>
					</c:if>
				</ul>
			</div>
		</nav>
	</section>
	<footer>
		<%@ include file="../module/footer.jsp"%>
	</footer>
	
<script type="text/javascript">	
$(document).ready(function(){
	// 게시판 정렬 버튼 전환
	var param_sort = "${sortValue}";
			
	var as_view = document.getElementsByClassName("as_view");
	var as_latest = document.getElementById("as1");
	var as_reply = document.getElementById("as2");
	var as_likes = document.getElementById("as3");
	const CLICKED_CLASS = "clicked";
			
	var sortState = "${sortValue}";
	if(param_sort === null || param_sort === "latest"){
		for (var i = 0; i < as_view.length; i++) {
		 	as_view[i].classList.remove("clicked");
		}
		as_latest.classList.add(CLICKED_CLASS);
	}else if(param_sort === "comment"){
		for (var i = 0; i < as_view.length; i++) {
		 	as_view[i].classList.remove("clicked");
		}
		as_reply.classList.add(CLICKED_CLASS);
	}else if(param_sort === "like"){
		for (var i = 0; i < as_view.length; i++) {
		 	as_view[i].classList.remove("clicked");
		}
		as_likes.classList.add(CLICKED_CLASS);
	}
});
// 페이지 이동할 때 현재 주소로 따라가기
function pageUrlMove(num) {
	var sort = "${sortValue}";
	var search = "${searchValue}";
	var page = "${commQAUrl}";
	
	var url = "";	
	
	if(sort === "" && search === ""){
		url = "${commQAUrl}?page=";		
	}else if(sort !== "" && search === ""){
		url = page + "?sort=" + sort + "&page=";
	}else if(sort === "" && search !== ""){
		url = page + "?search=" + search + "&page=";
	}else{
		url = page + "?search=" + search + "&sort=" + sort + "&page=";
	}

	location.href = url + num;
}

function pageCountUrl(count) {
	var sort = "${sortValue}";
	var search = "${searchValue}";
	var page = "${commQAUrl}";
	
	var url = "";	
	
	if(sort === "" && search === ""){
		url = "${commMainUrl}?pageCount=";		
	}else if(sort !== "" && search === ""){
		url = page + "?sort=" + sort + "&pageCount=";
	}else if(sort === "" && search !== ""){
		url = page + "?search=" + search + "&pageCount=";
	}else{
		url = page + "?search=" + search + "&sort=" + sort + "&pageCount=";
	}

	location.href = url + count;
}
	
</script>
</body>
</html>