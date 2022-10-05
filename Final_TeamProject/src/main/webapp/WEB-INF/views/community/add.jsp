<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>커뮤니티 게시판 글쓰기</title>
	<%@ include file="../module/head.jsp"%>
	
	<c:url var="bs5" value="/static/bs5" />
	<link rel="stylesheet" type="text/css" href="${bs5}/css/bootstrap.min.css">
	<script type="text/javascript" src="${bs5}/js/bootstrap.min.js"></script>
	<link rel="stylesheet" type="text/css" href="${css}/studyboardModify.css">
	<!-- ckeditor 추가 -->
	<c:url var="ckeditor" value="/static/ckeditor"></c:url>
	<script type="text/javascript" src="${ckeditor}/ckeditor.js"></script>
</head>
<script type="text/javascript">
	//카테고리 탭 처리
	$(document).ready(function () {			
		 // 탭 버튼 눌렸을때 카테고리 값 설정
		 $("input[name='tapRadio']").click(function(){
			 $(this).prop("checked", true);
			 var newCatid = $('input[name="tapRadio"]:checked').val();
			 $('input[name=catid]').attr('value',newCatid);
		 });
		 
	});  

	function formCheck(form) {
		if (form.title.value === undefined || form.title.value.trim() === "" || form.catid.value === "") {
			var modal = new bootstrap.Modal(document.getElementById("errorModal"), {
				keyboard : false
			});
			modal.show();
			return;
		}
		form.submit();
	}
</script>
<body>
	<c:url var="boardAddUrl" value="/community/add" />
	<c:url var="commMainUrl" value="/community/main" />
	
	<section class="container marg3">
	<!-- 카테고리 선택(버튼)  -->
	<div class="mt-3">
		<div class="btn-group w-50 p-3" role="group" aria-label="Basic radio toggle button group">
		  <input type="radio" class="btn-check" name="tapRadio" id="btnradio1" autocomplete="off" value = 1 >
		  <label class="btn btn-outline-primary" for="btnradio1">Q&A</label>
		  
		  <input type="radio" class="btn-check" name="tapRadio" id="btnradio2" autocomplete="off" value = 2 >
		  <label class="btn btn-outline-primary" for="btnradio2">고민/자유</label>
		  
		  <input type="radio" class="btn-check" name="tapRadio" id="btnradio3" autocomplete="off" value = 3 >
		  <label class="btn btn-outline-primary" for="btnradio3">노하우&팁</label>
		</div>
	</div>
	
	<!-- 제목 입력 -->
	<div class = "mt-3">	
		<form action="${boardAddUrl}" method="post" enctype="multipart/form-data">
			<div> <!-- controller로 RequestParam boardVO 넘기는 용도 -->
				<input class="form-control" type="hidden" name="catid" value = "">
			</div>
			<div class="mb-3">
					<input class="form-control" type="text" name="title" placeholder="제목을 입력하세요.">
			</div>
			<div class="mb-3">
				<textarea class="form-control" id="content" name="content" rows="20" 
					placeholder="내용을 입력하세요."></textarea>
			</div>
			<div class="mb-3 text-end">
				<button class="btn btn-outline-secondary" type="button" onclick="location.href='${commMainUrl}'">취소</button>
				<button class="btn btn-primary" type="button" onclick="formCheck(this.form);">등록</button>
			</div>
		</form>
	</div>

	</sector>


	<!-- 에러창(모달) -->
	<div class="modal fade" id="errorModal" tabindex="-1" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h6 class="modal-title">입력 오류</h6>
						<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					</div>
					<div class="modal-body">
						게시판 카테고리를 선택해야 합니다.<br>
						제목은 공란을 입력할 수 없습니다.<br>
						반드시 제목을 입력하세요.
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-sm btn-danger" data-bs-dismiss="modal">확인</button>
					</div>
				</div>
			</div>
		</div>
<c:url var="upload" value="/community/image" />
<script type="text/javascript">
	CKEDITOR.replace('content', {
		filebrowserUploadUrl: "${upload}?type=image"
	})
</script>

</body>
</html>