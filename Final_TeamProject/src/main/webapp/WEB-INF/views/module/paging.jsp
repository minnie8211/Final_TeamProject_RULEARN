<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:if test="${not empty pageList}">
	<c:set var="pageList" value="${pageList}" />
	<c:set var="currentPage" value="${page}" />
	<div class="paging">
		<ul class="page center">
			<c:if test="${currentPage - 1 > 0 }">
				<li class="page-item">
					<a class="page-link" href="./${whatPage}?page=${currentPage - 1}">Prev</a>
				</li>
			</c:if>
			<c:set var="i" value="${currentPage - 1}"/>
			<c:set var="maxPage" value="${i+5 > pageList.size() ? pageList.size() : i + 5}" />
			<c:forEach begin="${i}" end="${maxPage - 1}" var="num">
				<li class="page-item">
					<a class="page-link" href="./${whatPage}?page=${pageList.get(num)}">${pageList.get(num)}</a>
				</li>
			</c:forEach>
			<c:if test="${currentPage + 1 <= pageList.size()}">
				<li class="page-item">
					<a class="page-link" href="./${whatPage}?page=${currentPage + 1}">Next</a>
				</li>
			</c:if>
		</ul>
	</div>
</c:if>