<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>유저 활동 내역</title>
	<%@ include file="../module/head.jsp" %>
	<c:url var="css" value="/static/css" />
	<link rel="stylesheet" type="text/css" href="${css}/userInfo.css">
	<link rel="stylesheet" type="text/css" href="${css}/studyboard.css">
	<link rel="stylesheet" type="text/css" href="${css}/communityboard.css">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.9.1/font/bootstrap-icons.css">
</head>
<body>
	<header>
		<%@ include file="../module/navigation.jsp" %>
	</header>
	<section class="container mar-bot2 mar-top2 m-height">
	<c:url var="infoUrl" value="/userinfo" />
		<div class="info-box1">
			<div class="flex">
				<div class="info-img1">
					<div class="info-img2"></div>
				</div>
				<div>
					<div class="info-nick">${userData.AC_NICKNAME}</div>
					<div class="info-lenght">댓글 단 글 ${fn:length(originalDatas)}</div>	
				</div>
			</div>
			<div class="info-box2 flex">
				<div id="postTap" class="info-menu magin-lf" style="cursor : pointer;" onclick="location.href='${infoUrl}/post?id=${userData.AC_ID}&menu=community'">작성글</div>
				<div id="replyTap" class="info-menu" style="cursor : pointer;" onclick="location.href='${infoUrl}/reply?id=${userData.AC_ID}&menu=community'">댓글 단 글</div>
			</div>
		</div>
		<%@ include file="replyTap.jsp"%>
		<table class="table table-hover mar-bot3 bor-col">
			 <colgroup>
			    <col width="120" style=""/>
			    <col />
			    <col width="200" style="" />
			    <col width="200" style="" />
			    <col width="120" style="" />
			  </colgroup>
			<thead>
			</thead>
			<tbody>
				<c:choose>
					<c:when test="${menu eq 'community'}">
						<c:if test="${not empty Alldatas}">
							<c:forEach items="${Alldatas}" var="data">
								<c:url var="commBoardDetailUrl" value="/community/detail">
									<!-- 게시판 상세 페이지로 넘어갈 때 RequestParam으로 게시판 id 넘겨주기 -->
									<c:param name="cb_bid">${data.cb_bid}</c:param>
								</c:url>
								<tr onclick="location.href='${commBoardDetailUrl}'">
									<c:if test="${data.cb_catid eq 1}">
										<td class="txt-center"><span class="comm-cat-qa">Q&A</span></td>
									</c:if>
									<c:if test="${data.cb_catid eq 2}">
										<td class="txt-center"><span class="comm-cat-forum">고민/자유</span></td>
									</c:if>
									<c:if test="${data.cb_catid eq 3}">
										<td class="txt-center"><span class="comm-cat-tip">노하우/팁</span></td>
									</c:if>
									<td style="cursor : pointer;"><b>${data.cb_title}</b>&nbsp;&nbsp;[${data.cb_commentNum}]</td>
									<td>${data.cb_nickName}</td>
									<td>${data.cb_date}</td>
									<td><i class="bi bi-heart-fill"></i> ${data.cb_like}</td>
								</tr>
							</c:forEach>
						</c:if>
						<c:if test="${empty Alldatas}">
							<td colspan="5" class="none-border no-hover">
								<div class="txt-center pd100">등록된 게시글이 없습니다.</div>
							</td>
						</c:if>
					</c:when>
					<c:when test="${menu eq 'study'}">
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
					</c:when>
				</c:choose>
			</tbody>
		</table>
		<c:if test="${not empty pageData}">
			<nav class="mar-bot3">
				<div>
					<ul class="pagination justify-content-center">
						<c:if test="${pageData.hasPrevPage()}">
							<li class="page-item">
								<a class="page-link" href="${infoUrl}/reply?id=${userData.AC_ID}&menu=${menu}&page=${pageData.prevPageNumber}">«</a>
							</li>
						</c:if>
						<c:forEach items="${pageData.getPageNumberList(pageData.currentPageNumber - 2, pageData.currentPageNumber + 2)}" var="num">
							<li class="page-item ${pageData.currentPageNumber eq num ? 'active' : ''}">
								<a class="page-link" href="${infoUrl}/reply?id=${userData.AC_ID}&menu=${menu}&page=${num}">${num}</a>
							</li>
						</c:forEach>
						<c:if test="${pageData.hasNextPage()}">
							<li class="page-item">
								<a class="page-link" href="${infoUrl}/reply?id=${userData.AC_ID}&menu=${menu}&page=${pageData.nextPageNumber}">»</a>
							</li>
						</c:if>
					</ul>
				</div>
			</nav>
		</c:if>
	</section>
	<footer>
		<%@ include file="../module/footer.jsp" %>
	</footer>
	<script>
		$(document).ready(function(){
			var url = $(location).attr('pathname');
			
			if(url == "/home/userinfo/post"){
				$("#postTap").addClass("tap-active");
			} else if(url == "/home/userinfo/reply"){
				$("#replyTap").addClass("tap-active");
			}
		});
	</script>
</body>
</html>