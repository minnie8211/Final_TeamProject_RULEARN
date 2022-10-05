<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>게시글 수정 - ${boardData.cb_title}</title>
	<%@ include file="../module/head.jsp"%>
	<link rel="stylesheet" type="text/css" href="${css}/studyboardModify.css">
	<!-- ckeditor 추가 -->
	<c:url var="ckeditor" value="/static/ckeditor"></c:url>
	<script type="text/javascript" src="${ckeditor}/ckeditor.js"></script>
</head>
<script type="text/javascript">
	 // 카테고리 탭 처리
	 $(document).ready(function () {	
		 
		 // 기존의 카테고리 값으로 탭을 선택한다
		 if(${boardData.cb_catid} === 1){
			 $("input:radio[id='btnradio1']").attr("checked", true);   
			 $("input:radio[id='btnradio2']").attr("checked", false);
			 $("input:radio[id='btnradio3']").attr("checked", false);
		 }else if(${boardData.cb_catid} === 2){
			 $("input:radio[id='btnradio1']").attr("checked", false);   
			 $("input:radio[id='btnradio2']").attr("checked", true);
			 $("input:radio[id='btnradio3']").attr("checked", false);
		 }else if(${boardData.cb_catid} === 3){
			 $("input:radio[id='btnradio1']").attr("checked", false);   
			 $("input:radio[id='btnradio2']").attr("checked", false);
			 $("input:radio[id='btnradio3']").attr("checked", true);
		 }
		 
		 // 다른 카테고리 값으로 눌렀을 때 라디오버튼 체크
		 var value = $('input[name="tapRadio"]:checked').val();
		 $('input[name=catid]').attr('value',value);
		 
		 $("input[name='tapRadio']").click(function(){
			 $(this).prop("checked", true);
			 var newCatid = $('input[name="tapRadio"]:checked').val();
			 $('input[name=catid]').attr('value',newCatid);
		 });
		 
	 });  
	 
	function formCheck(form) {
		if(form.title.value === undefined || form.title.value.trim() === "" || form.catid.value === "") {
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
	<c:url var="boardModifyUrl" value="/community/modify" />
	<!-- 게시판 카테고리 선택 탭 -->
	<section class="container marg3">
		<!-- 카테고리 수정 라디오 버튼 -->
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
	<div>		
		<form action="${boardModifyUrl}" method="post">
		<input type="hidden" name="cb_bid" value="${boardData.cb_bid}"> <!-- 페이지에서 cb_bid 정보를 넣어놔야 RequestParam 데이터 처리 -->
			<div> <!-- controller로 RequestParam boardVO 넘기는 용도 -->
				<input class="form-control" type="hidden" name="catid" value = "">
			</div>
			<div class="mb-3">
					<input class="form-control" type="text" name="title" value="${boardData.cb_title}" placeholder="제목을 입력하세요.">
				</div>
				<div class="mb-3">
					<textarea class="form-control" id="content" name="content" rows="8"
						placeholder="내용을 입력하세요.">${boardData.cb_content}</textarea>
				</div>
				<div class="mb-3 text-end">
				<button class="btn btn-outline-secondary" type="button" onclick="history.back();">취소</button>
				<button class="btn btn-primary" type="button" onclick="formCheck(this.form);">수정</button>
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
	<!-- ckeditor -->
<c:url var="upload" value="/community/image" />
<script type="text/javascript">
	CKEDITOR.replace('content', {
		filebrowserUploadUrl: "${upload}?type=image"
	})
</script>
</body>
</html>