<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<title>${data.AC_ID}님의 회원 수정</title>
	<%@ include file="../module/head.jsp" %>
	<c:url var="css" value="/static/css" />
	<link rel="stylesheet" type="text/css" href="${css}/search.css">
	<link rel="stylesheet" type="text/css" href="${css}/admin.css">
</head>
<c:if test="${not empty error}">
	<script>
	alert("${error}")
</script>
</c:if>
<body>
	<header>
		<%@ include file="../module/navigation.jsp" %>
	</header>
	
	
	<div class="banner_admin">
		<div class="container">
			${data.AC_ID}님의 회원 정보 수정
		</div>
	</div>
	<section class="container p-4 mt-2 m-height">
		<c:url var="adminUrl" value="/admin" />
		<c:url var="infoModifyUrl" value="/admin/memberInfo/modify" />
		<form action="${infoModifyUrl}" method="post">
			<div class="text-start">
				<div class="form-group float-start w_49 info_label_text">
					<label class="col-form-label" for="id">아이디</label>
					<input class="form-control p-2" type="text" id="id" name="id" oninput="checkId();" value="${data.AC_ID}" readonly>
				</div>
				<div class="form-group float-end w_49 info_label_text">
					<label class="col-form-label" for="nickname">닉네임</label>
					<input class="form-control p-2" type="text"  id="nickname" name="nickname" value="${data.AC_NICKNAME}" readonly>
				</div>
				<div class="form-group float-start w_49 info_label_text">
					<label class="col-form-label mt-3" for="name">이름</label>
					<input class="form-control p-2" type="text"  id="name" name="name" value="${data.AC_NAME}" readonly>
				</div>
				<div class="form-group float-end w_49 info_label_text">
					<label class="col-form-label mt-3" for="phone">핸드폰번호</label>
					<input class="form-control p-2" type="text"  id="phone" name="phone" value="${data.AC_PHONE}" readonly>
				</div>
				<div class="form-group float-start w_49 info_label_text">
					<label class="col-form-label mt-3" for="email">이메일</label>
					<input class="form-control p-2" type="email" id="email" name="email" value="${data.AC_EMAIL}" readonly>
				</div>
				<div class="form-group float-end w_49 info_label_text">
					<label class="col-form-label mt-3" for="acgroup">로그인구분</label>
					<select class="form-control p-2" id="acgroup" name="acgroup">
						<option value="${data.AC_GROUP}">${data.ACG_NAME}</option>
					</select>
				</div>
				<div class="form-group float-start w_49 info_label_text">
					<label class="col-form-label mt-3" for="role">회원권한</label>
					<select class="form-control p-2" id="role" name="role" >
						<c:forEach items="${roleDatas}" var="roleData">
							<c:choose>
								<c:when test="${roleData.ro_id eq data.AC_ROLE}">
									<option value="${roleData.ro_id}" selected>${roleData.ro_name}</option>
								</c:when>
								<c:otherwise>
									<option value="${roleData.ro_id}">${roleData.ro_name}</option>
								</c:otherwise>
							</c:choose>
						</c:forEach>
					</select>
				</div>
				<div class="form-group float-end w_49 info_label_text">
					<label class="col-form-label mt-3" for="createDate">회원가입일</label>
					<input class="form-control p-2" type="text" id="createDate" name="createDate" value="${data.AC_DATE}" readonly>
				</div>
				<div class="form-group float-end mt-3 ">
					<button class="btn btn-success ms-1" type="submit">수정</button>
					<button class="btn btn-danger ms-1" type="button" onclick="location.href='${adminUrl}/memberInfo'">취소</button>
				</div>
			</div>
		</form>
	</section>
	<footer>
		<%@ include file="../module/footer.jsp" %>
	</footer>
</body>
</html>