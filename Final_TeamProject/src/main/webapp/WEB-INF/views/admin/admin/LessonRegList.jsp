<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>수강결제정보</title>
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
			수강결제정보
		</div>
	</div>
	<section class="container mar-bot2 mar-top2 m-height">
		<c:url var="adminUrl" value="/admin" />
		<div class="row">
			<div class="col-md-3">
				<div class="d-flex flex-column flex-shrink-0 p-3 bg-light">
					 <ul class="nav nav_pills mb-auto px-3 bg-light d-flex flex-column">
	                    <li class="nav-item side_hover">
	                        <a href="${adminUrl}/memberInfo" class="nav-link link-dark">
	                            회원정보관리
	                        </a>
	                    </li>
	                    <li>
	                        <a href="${adminUrl}/lessonRegList" class="nav-link active">
	                            수강결제정보
	                        </a>
	                    </li>
	                </ul>
				</div>
			</div>
			<div class="col-md-9 mb-3">
				<form action="${adminUrl}/lessonRegList" method="get">
					<div class="row g-1">
						<div class="flex">
							<input class="form-control m-right10 pd6 search-logo" type="text" name="search" placeholder="주문번호 / 이름 / 수강결제과목 검색">
							<button class="btn btn-primary wi100 font1a" type="submit">검색</button>
						</div>
					</div>
				</form>
				<div class="flex mar-bot1 justify-content-end mt-3">
					<div class="w6">
						<c:choose>
							<c:when test="${not empty search}">
								<select class="form-select pd0-4" onchange="location.href='${adminUrl}/lessonRegList?search=${search}&pageCount=' + this.value">
									<option value="5" ${sessionScope.pageCount == 5 ? 'selected' : ''}>5 개</option>
									<option value="10" ${sessionScope.pageCount == 10 ? 'selected' : ''}>10 개</option>
									<option value="15" ${sessionScope.pageCount == 15 ? 'selected' : ''}>15 개</option>
									<option value="20" ${sessionScope.pageCount == 20 ? 'selected' : ''}>20 개</option>
								</select>
							</c:when>
							<c:otherwise>
								<select class="form-select pd0-4" onchange="location.href='${adminUrl}/lessonRegList?pageCount=' + this.value">
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
					    <col width="130" style=""/>
					    <col width="110" style="" />
					    <col width="" style="" />
					    <col width="120" style="" />
					    <col width="120" style="" />
					  </colgroup>
					<thead>
						<tr>
							<th class="text-center">주문번호</th>
							<th class="text-center">이름</th>
							<th class="text-center">수강결제과목</th>
							<th class="text-center">결제금액</th>
							<th class="text-center">결제일자</th>
						</tr>
					</thead>
					<tbody>
						<c:if test="${not empty Alldatas}">
							<c:forEach items="${Alldatas}" var="data">
						
								<tr>
									<td class="text-center">${data.p_tid}</td>
									<td class="text-center">${data.ac_name}</td>
									<td class="text-center">${data.p_item_name}</td>
									<td class="text-center">${data.p_total_amount}</td>
									<td class="text-center">
										<fmt:parseDate value="${data.p_approved_at}" var="payDate" pattern="yyyy-MM-dd HH:mm:ss" />
										<fmt:formatDate value="${payDate}" pattern="yyyy-MM-dd" />
									</td>
								</tr>
							</c:forEach>
						</c:if>
						<c:if test="${empty Alldatas}">
							<td colspan="8" class="none-border">
								<div class="txt-center pd100">해당 결제 정보가 없습니다.</div>
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
									<a class="page-link" href="${adminUrl}/lessonRegList?search=${search}&page=${pageData.prevPageNumber}">«</a>
								</c:when>
								<c:otherwise>
									<a class="page-link" href="${adminUrl}/lessonRegList?page=${pageData.prevPageNumber}">«</a>
								</c:otherwise>
							</c:choose>
							</li>
						</c:if>
						<c:forEach items="${pageData.getPageNumberList(pageData.currentPageNumber - 2, pageData.currentPageNumber + 2)}" var="num">
							<li class="page-item ${pageData.currentPageNumber eq num ? 'active' : ''}">
							<c:choose>
								<c:when test="${not empty search}">
									<a class="page-link" href="${adminUrl}/lessonRegList?search=${search}&page=${num}">${num}</a>
								</c:when>
								<c:otherwise>
									<a class="page-link" href="${adminUrl}/lessonRegList?page=${num}">${num}</a>
								</c:otherwise>
							</c:choose>
							</li>
						</c:forEach>
						<c:if test="${pageData.hasNextPage()}">
							<li class="page-item">
							<c:choose>
								<c:when test="${not empty search}">
									<a class="page-link" href="${adminUrl}/lessonRegList?search=${search}&page=${pageData.nextPageNumber}">»</a>
								</c:when>
								<c:otherwise>
									<a class="page-link" href="${adminUrl}/lessonRegList?page=${pageData.nextPageNumber}">»</a>
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