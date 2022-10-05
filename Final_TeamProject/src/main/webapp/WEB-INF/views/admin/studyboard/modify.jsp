<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>[수정] ${data.sb_title}</title>
	<c:url var="bs5" value="/static/bs5" />
	<c:url var="jQuery" value="/static/js" />
	<c:url var="css" value="/static/css" />
	<link rel="stylesheet" type="text/css" href="${bs5}/css/bootstrap.min.css">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.9.1/font/bootstrap-icons.css">
	<script type="text/javascript" src="${bs5}/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="${jQuery}/jquery-3.6.0.min.js"></script>
	<c:url var="ckeditor" value="/static/ckeditor" />
	<script type="text/javascript" src="${ckeditor}/ckeditor.js"></script>
	<%@ include file="../module/head.jsp" %>
	<link rel="stylesheet" type="text/css" href="${css}/studyboardModify.css">
</head>
<script type="text/javascript">
	function formCheck(form) {
		if(form.sb_title.value === undefined || form.sb_title.value.trim() === "") {
			var modal = new bootstrap.Modal(document.getElementById("errorModal"), {
				keyboard: false
			});
			modal.show();
			return;
		}
		form.submit();
	}
</script>
<body>
	<section class="container marg3">
		<div class="mt-3">
			<c:url var="studyBoardUrl" value="/studyboard" />
			<c:url var="studyBoardAddUrl" value="/studyboard/modify" />
			<form action="${studyBoardAddUrl}" method="post">
				<input type="hidden" name="sb_bId" value="${data.sb_bId}">
				<div class="mar-bot2">
					<div class="btn-group m-right1 wi-12" role="group" aria-label="Basic radio toggle button group">
						<input type="radio" class="btn-check" name="sb_isDone" 
							   id="doneRadio2" value="true" autocomplete="off" ${data.sb_isDone == 'true' ? 'checked' : ''}>
				  		<label class="btn btn-outline-primary font1" for="doneRadio2">모집완료</label>
				  		<input type="radio" class="btn-check" name="sb_isDone" 
				  			   id="doneRadio1" value="false" autocomplete="off" ${data.sb_isDone == 'false' ? 'checked' : ''}>
				 		<label class="btn btn-outline-primary font1" for="doneRadio1">모집중</label>
				 	</div>
					<div class="btn-group wi-12" role="group" aria-label="Basic radio toggle button group">
					  <input type="radio" class="btn-check" name="sb_catId" 
					  		 id="catRadio1" value="4" autocomplete="off" ${data.sb_catId == 4 ? 'checked' : ''}>
					  <label class="btn btn-outline-primary font1" for="catRadio1">스터디</label>
					  <input type="radio" class="btn-check" name="sb_catId"
					  		 id="catRadio2" value="5" autocomplete="off" ${data.sb_catId == 5 ? 'checked' : ''}>
					  <label class="btn btn-outline-primary font1" for="catRadio2">프로젝트</label>
					</div>
				</div>
				<div class="mb-3">
					<input class="form-control hig3" type="text" name="sb_title" value="${data.sb_title}" placeholder="제목을 입력하세요.">
				</div>
				<div class="mar-bot2">
					<textarea class="form-control" name="sb_content" rows="8"
						placeholder="내용을 입력해주세요.">${data.sb_content}</textarea>
				</div>
				
				<div class="mb-3 text-end">
					<button class="btn btn-outline-primary" type="button" onclick="location.href='${studyBoardUrl}'">취소</button>
					<button class="btn btn-primary" type="button" onclick="formCheck(this.form);">수정하기</button>
				</div>
			</form>
		</div>
		
		<div class="modal fade" id="errorModal" tabindex="-1" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h6 class="modal-title">입력 오류</h6>
						<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					</div>
					<div class="modal-body">
						제목은 공란을 입력할 수 없습니다.<br>
						반드시 제목을 입력하세요.
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-sm btn-danger" data-bs-dismiss="modal">확인</button>
					</div>
				</div>
			</div>
		</div>
	</section>
	<c:url var="studyupload" value="/studyupload/image" />
	<script type="text/javascript">
		CKEDITOR.replace("sb_content", {
			filebrowserUploadUrl: "${studyupload}?type=image"
		})
	</script>
</body>
</html>