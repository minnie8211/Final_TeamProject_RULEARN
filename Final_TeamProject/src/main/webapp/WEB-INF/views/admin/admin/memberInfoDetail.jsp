<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<title>${data.AC_ID}님의 회원 정보</title>
	<%@ include file="../module/head.jsp" %>
	<c:url var="css" value="/static/css" />
	<link rel="stylesheet" type="text/css" href="${css}/search.css">
	<link rel="stylesheet" type="text/css" href="${css}/admin.css">
</head>
<body>
	<header>
		<%@ include file="../module/navigation.jsp" %>
	</header>
	<div class="banner_admin">
		<div class="container">
			${data.AC_ID}님의 회원 정보
		</div>
	</div>
	<section class="container p-4 mt-2 m-height">
		<c:url var="adminUrl" value="/admin" />
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
					<option value="${data.AC_ROLE}">${data.RO_NAME}</option>
				</select>
			</div>
			<div class="form-group float-end w_49 info_label_text">
				<label class="col-form-label mt-3" for="role">회원가입일</label>
				<input class="form-control p-2" type="text" id="createDate" name="createDate" value="${data.AC_DATE}" readonly>
			</div>
			<div class="form-group float-end mt-3 ">
				<c:url var="infoModifyUrl" value="/admin/memberInfo/modify">
					<c:param name="id" value="${data.AC_ID}" />
				</c:url>
				<button class="btn btn-primary" type="button" onclick="location.href='${adminUrl}/memberInfo'">목록</button>
				<button class="btn btn-success ms-1" type="button" onclick="location.href='${infoModifyUrl}'">수정</button>
				<button class="btn btn-danger ms-1" type="button" data-bs-toggle="modal" data-bs-target="#removeModal">삭제</button>
			</div>
		</div>
		<!-- 삭제확인모달 -->
		<div class="modal fade" id="removeModal" tabindex="-1" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h6 class="modal-title">삭제 확인</h6>
						<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					</div>
					<div class="modal-body">
						해당 회원의 모든 정보 및 데이터가 삭제됩니다.<br>
						회원 정보를 삭제하겠습니까?
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-sm btn-danger" data-bs-dismiss="modal" onclick="memberDelete()">확인</button>
					</div>
				</div>
			</div>
		</div>
	</section>
	<footer>
		<%@ include file="../module/footer.jsp" %>
	</footer>
	<c:url var="memberDeleteUrl" value="/admin/memberDelete" />
	<script type="text/javascript">
		function memberDelete() {
			$.ajax({
				url: "${memberDeleteUrl}",
				type: "post",
				data: {
					id: "${data.AC_ID}"
				},
				dataType: "json",
				success: function(data) {
					if(data.code === "success") {
						alert(data.message);
						location.href="${adminUrl}/memberInfo";
					} else if(data.code === "fail") {
						alert(data.message);
						location.href="${adminUrl}/memberInfo/detail?id=${data.AC_ID}";
					} else if(data.code === "permissionError") {
						alert(data.message);
						location.href="${adminUrl}/memberInfo/detail?id=${data.AC_ID}";
					} else if(data.code === "notExists") {
						alert(data.message);
						location.href="${adminUrl}/memberInfo/detail?id=${data.AC_ID}";
					}
				}
			});
		}
	</script>

</body>
</html>