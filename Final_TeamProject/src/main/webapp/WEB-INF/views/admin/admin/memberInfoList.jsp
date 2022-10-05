<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>회원 정보 관리</title>
	<%@ include file="../module/head.jsp" %>
	<c:url var="css" value="/static/css" />
	<link rel="stylesheet" type="text/css" href="${css}/admin.css">
	<link rel="stylesheet" type="text/css" href="${css}/search.css">
	<link rel="stylesheet" type="text/css" href="${css}/studyboard.css">
	<link rel="stylesheet" type="text/css" href="${css}/communityboard.css">
</head>
<body>
	<header>
		<%@ include file="../module/navigation.jsp" %>
	</header>
	<div class="banner_admin">
		<div class="container">
			회원정보관리
		</div>
	</div>
	<section class="container mar-bot2 mar-top2 m-height">
		<c:url var="adminUrl" value="/admin" />
		<div class="row">
			<div class="col-md-3">
				<div class="d-flex flex-column flex-shrink-0 p-3 bg-light">
					 <ul class="nav nav_pills mb-auto px-3 bg-light d-flex flex-column">
	                    <li class="nav-item side_hover">
	                        <a href="${adminUrl}/memberInfo" class="nav-link active">
	                            회원정보관리
	                        </a>
	                    </li>
	                    <li>
	                        <a href="${adminUrl}/lessonRegList" class="nav-link link-dark">
	                            수강결제정보
	                        </a>
	                    </li>
	                </ul>
				</div>
			</div>
			<div class="col-md-9 mar-top2 mb-3">
			<%@ include file="memberTap.jsp"%>
				
				<form action="${adminUrl}/memberInfo" method="get">
					<div class="row g-1">
						<div class="flex mt-4">
							<input class="form-control m-right10 pd6 search-logo" type="text" name="search" placeholder="아이디 / 이름 / 전화번호('-'제외) / 이메일주소 검색">
							<button class="btn btn-primary wi100 font1a" type="submit">검색</button>
						</div>
					</div>
				</form>
				<div class="flex mar-bot1 justify-content-end mt-3">
					<div class="w6">
						<c:choose>
							<c:when test="${not empty search}">
								<select class="form-select pd0-4" onchange="location.href='${adminUrl}/memberInfo?search=${search}&pageCount=' + this.value">
									<option value="5" ${sessionScope.pageCount == 5 ? 'selected' : ''}>5 개</option>
									<option value="10" ${sessionScope.pageCount == 10 ? 'selected' : ''}>10 개</option>
									<option value="15" ${sessionScope.pageCount == 15 ? 'selected' : ''}>15 개</option>
									<option value="20" ${sessionScope.pageCount == 20 ? 'selected' : ''}>20 개</option>
								</select>
							</c:when>
							<c:otherwise>
								<select class="form-select pd0-4" onchange="location.href='${adminUrl}/memberInfo?menu=${menu}&pageCount=' + this.value">
									<option value="5" ${sessionScope.pageCount == 5 ? 'selected' : ''}>5 개</option>
									<option value="10" ${sessionScope.pageCount == 10 ? 'selected' : ''}>10 개</option>
									<option value="15" ${sessionScope.pageCount == 15 ? 'selected' : ''}>15 개</option>
									<option value="20" ${sessionScope.pageCount == 20 ? 'selected' : ''}>20 개</option>
								</select>
							</c:otherwise>
						</c:choose>
					</div> 
				</div>
			
				<table class="table table-hover bor-col mb-4">
					 <colgroup>
					    <col width="100" style=""/>
					    <col width="100" style="" />
					    <col width="110" style="" />
					    <col width="" style="" />
					    <col width="130" style="" />
					    <col width="110" style="" />
					    <col width="110" style="" />
					  </colgroup>
					<thead>
						<tr>
							<th class="text-center">아이디</th>
							<th class="text-center">이름</th>
							<th class="text-center">핸드폰번호</th>
							<th class="text-center">이메일주소</th>
							<th class="text-center">로그인구분</th>
							<th class="text-center">회원권한</th>
							<th class="text-center">이메일인증</th>
						</tr>
					</thead>
					<tbody>
						<c:if test="${not empty Alldatas}">
							<c:forEach items="${Alldatas}" var="data">
								<c:url var="memberInfoDetailUrl" value="/admin/memberInfo/detail">
									<c:param name="id">${data.AC_ID}</c:param>
								</c:url>
								<tr onclick="location.href='${memberInfoDetailUrl}'">
									<td class="text-center">${data.AC_ID}</td>
									<td class="text-center">${data.AC_NAME}</td>
									<td class="text-center">${data.AC_PHONE}</td>
									<td class="text-center">${data.AC_EMAIL}</td>
									<td class="text-center">${data.ACG_NAME}</td>
									<td class="text-center">${data.RO_NAME}</td>
									<c:choose>
										<c:when test="${data.AC_MAIL_AUTH == 1}">
											<td class="text-center">Y</td>
										</c:when>
										<c:when test="${data.AC_MAIL_AUTH == 0}">
											<td class="text-center">N</td>
										</c:when>
									</c:choose>
								</tr>
							</c:forEach>
						</c:if>
						<c:if test="${empty Alldatas}">
							<td colspan="8" class="none-border">
								<div class="txt-center pd100">등록된 회원이 없습니다.</div>
							</td>
						</c:if>
					</tbody>
				</table>
				<nav>
					<ul class="pagination justify-content-center">
						<c:if test="${pageData.hasPrevPage()}">
							<li class="page-item">
							<c:choose>
								<c:when test="${not empty search}">
									<a class="page-link" href="${adminUrl}/memberInfo?search=${search}&page=${pageData.prevPageNumber}">«</a>
								</c:when>
								<c:otherwise>
									<a class="page-link" href="${adminUrl}/memberInfo?menu=${menu}&page=${pageData.prevPageNumber}">«</a>
								</c:otherwise>
							</c:choose>
							</li>
						</c:if>
						<c:forEach items="${pageData.getPageNumberList(pageData.currentPageNumber - 2, pageData.currentPageNumber + 2)}" var="num">
							<li class="page-item ${pageData.currentPageNumber eq num ? 'active' : ''}">
							<c:choose>
								<c:when test="${not empty search}">
									<a class="page-link" href="${adminUrl}/memberInfo?search=${search}&page=${num}">${num}</a>
								</c:when>
								<c:otherwise>
									<a class="page-link" href="${adminUrl}/memberInfo?menu=${menu}&page=${num}">${num}</a>
								</c:otherwise>
							</c:choose>
							</li>
						</c:forEach>
						<c:if test="${pageData.hasNextPage()}">
							<li class="page-item">
							<c:choose>
								<c:when test="${not empty search}">
									<a class="page-link" href="${adminUrl}/memberInfo?search=${search}&page=${pageData.nextPageNumber}">»</a>
								</c:when>
								<c:otherwise>
									<a class="page-link" href="${adminUrl}/memberInfo?menu=${menu}&page=${pageData.nextPageNumber}">»</a>
								</c:otherwise>
							</c:choose>
							</li>
						</c:if>
					</ul>
				</nav>
			</div>
		</div>
	</section>
	<footer>
		<%@ include file="../module/footer.jsp" %>
	</footer>
</body>
</html>