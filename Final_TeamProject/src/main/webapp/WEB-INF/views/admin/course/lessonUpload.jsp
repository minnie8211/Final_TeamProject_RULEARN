<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<link rel="shortcut icon" href="/favicon.ico" type="image/x-icon">
<link rel="icon" href="/favicon.ico" type="image/x-icon">

<c:url var="css" value="/static/css" />
<c:url var="bs5" value="/static/bs5" />
<c:url var="jQuery" value="/static/js" />
<c:url var="img" value="/static/img" />
<link rel="stylesheet" type="text/css" href="${css}/default.css">
<link rel="stylesheet" type="text/css" href="${css}/navigation.css">
<link rel="stylesheet" type="text/css" href="${css}/footer.css">
<link rel="stylesheet" type="text/css"
	href="${bs5}/css/bootstrap.min.css">
<script type="text/javascript" src="${jQuery}/jquery-3.6.0.min.js"></script>

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.9.1/font/bootstrap-icons.css">
	<script src="https://kit.fontawesome.com/2c1bc70929.js"></script>
	
	<c:url var="ckeditor" value="/static/ckeditor"></c:url>
	<script type="text/javascript" src="${ckeditor}/ckeditor.js"></script>
	<script type="text/javascript" src="${jQuery}/lessonFileUpload/LessonDescription_Guideline.js"></script>
	

<title>강의 업로드</title>
<style>
	body {
		background-color: #eae1d2;
		display: flex;
		flex-direction: column;
		align-items: center;
	}
	
	main {
		margin-top: 30px;
		max-width: 950px;
		border-radius: 5px;
		box-shadow: rgba(0, 0, 0, 0.16) 0px 10px 36px 0px, rgba(0, 0, 0, 0.06)
			0px 0px 0px 1px;
	}
	
	hr {
		width: 95%;
	}
	
	input {
		width: 100%;
	}
	
	td {
		vertical-align: middle;
	}
	
	tbody>tr {
		border-bottom-color: #cdcdc9;
	}
	.modal{
		--bs-modal-width: 700px;
	}
	.price{
		position : relative;
		left: 400px;
		top: -29px;
	}
	form{
		min-width: 950px;
		min-height: 637px;
	}
</style>
</head>

<body>
<c:url value="/course/upload" var="uploadFilesURL" />
	<main class="mb-5">
		<c:if test="${page eq 1}">
			<form action="${uploadFilesURL}/uploadLessonInfo" method="post"
				  class="p-3 col-lg-12 bg-white overflow-hidden">
				<section class="lessonInfo1 row gy-3">
					<div class="col-12 gy-3">
						<label for="title" class="form-label">강의 제목</label>
						<input type="text" class="form-control" id="title" placeholder="강의 제목" 
							   name="l_title" required>
					</div>
					<div class="col-6 gy-3">
						<label for="category" class="form-label">강의 카테고리</label> 
						<select id="category" class="form-select" name="l_lesson_category">
							<option value="">카테고리</option>
							<option value="개발/프로그래밍">개발/프로그래밍</option>
							<option value="보안/네트워크">보안/네트워크</option>
							<option value="데이터 사이언스">데이터 사이언스</option>
							<option value="게임개발">게임개발</option>
							<option value="기타">기타</option>
						</select>
					</div>
					<div class="col-6 gy-3">
						<label for="price" class="form-label">강의 가격</label> 
						<input type="number" class="form-control" id="price" required>
						<div class="price">원</div>
					</div>
					<div class="col-12">
						<label for="content" class="form-label">강의 소개</label>
						<textarea type="text" name="content" rows="10" class="form-control" id="content"
							placeholder="강의 소개" name="l_content" required>
							<%@ include file="LessonDescription_Guideline.jsp" %>
						</textarea>
					</div>
					<hr>
					<div class="text-center">
						<p>임시저장을 하지 않고 페이지를 넘기면<br>
						<U>모든 정보가 날아가게 됩니다.</U></p>
						<button type="button" class="btn btn-outline-info btn-lg" 
								onclick="formCheckPage1()">임시저장</button>
						<button type="button" class="btn btn-primary btn-lg"
								onclick="location.href='${uploadFilesURL}/curriInfo'">
								다음 페이지
								<i class="bi bi-arrow-right"></i>
						</button>
					</div>
				</section>
			</form>
		</c:if>
		<c:if test="${page eq 2}">
			<form action="${uploadFilesURL}/uploadLessonCurri" method="post"
				  class="p-3 col-lg-12 bg-white overflow-hidden">
				<section class="lessonInfo2 row gy-3">
					<div class="clickEvent">
						<div>
							<label for="curriculum" class="form-label">커리큘럼</label>
							<table class="table text-center curriculum">
								<thead>
									<tr class="bg-light">
										<th colspan="2" id="1" name="cur_big_curid" 
											style="width: 20%;">Chapter 1.</th>
										<th colspan="3">
											<input type="text" class="form-control" placeholder="chpater 이름" 
												   id="cur_big_title" name="cur_big_title" required>
										</th>
									</tr>
								</thead>
								<tbody class="tbody">
									<tr id="tr">
										<td class="text-end">
											<i class="fa-solid fa-trash-can deleteLesson"></i>
										</td>
										<td>강의 1.1</td>
										<td><input type="text" class="form-control" placeholder="세부 강의 이름" 
												   id="cur_small_title" required></td>
										<td style="width: 15%;">
											<select id="cur_small_type" class="form-select" required>
												<option value="">강의 타입</option>
												<option value="VIDEO">동영상</option>
												<option value="DOCUMENT">강의 자료</option>
											</select>
										</td>
										<td><i class="fa-solid fa-plus addLesson"></i></td>
									</tr>
								</tbody>
							</table>
							<div class="float-end mb-5">
								<button type="button" class="btn btn-primary deleteChapter">
									<i class="fa-solid fa-minus"></i> Chapter 삭제하기
								</button>
								<button type="button" class="btn btn-primary addChapter">
									<i class="fa-solid fa-plus"></i> Chapter 추가하기
								</button>
							</div>
						</div>
					</div>
					<hr>
					<div class="text-center">
						<p>임시저장을 하지 않고 페이지를 넘기면<br>
						<U>모든 정보가 날아가게 됩니다.</U></p>
						<button class="btn btn-secondary btn-lg"
								onclick="location.href='${uploadFilesURL}/lessonInfo'">
							<i class="bi bi-arrow-left"></i>이전 페이지</button>
							<button type="button" class="btn btn-outline-info btn-lg"
									onclick="formCheckPage2()">임시저장</button>
						<button type="button" class="btn btn-primary btn-lg"
								onclick="location.href='${uploadFilesURL}/fileInfo'">
								다음 페이지
								<i class="bi bi-arrow-right"></i>
						</button>
					</div>
				</section>
			</form>
		</c:if>
		<c:if test="${page eq 3}">
			<form action="${uploadFilesURL}/uploadLesson_final" method="post"
				  class="p-3 col-lg-12 bg-white overflow-hidden" enctype="multipart/form-data">
				<section class="lessonInfo2 row gy-3">
					<div class="img col-6">
						<label for="thumbnail" class="form-label">강의 대표 이미지</label> 
						<input type="file" class="form-control" id="thumbnail" name="thumbnail">
					</div>
					<div class="fileUpload">
						<button type="button" class="btn btn-primary fw-bold submitBtn"
							 	data-bs-toggle="modal" data-bs-target="#staticBackdrop">
							강의 자료 업로드하기
						</button>
					</div>
					<hr>
					<div class="text-center">
						<p>임시저장을 하지 않고 페이지를 넘기면<br>
						<U>모든 정보가 날아가게 됩니다.</U></p>
						<button class="btn btn-secondary btn-lg" type="button"
								onclick="location.href='${uploadFilesURL}/curriInfo'">
							<i class="bi bi-arrow-left"></i>이전 페이지</button>
						<button type="button" class="btn btn-outline-info btn-lg">임시저장</button>
						<button type="button" class="btn btn-primary btn-lg"
								onclick="formCheck(this.form)">
								업로드하기
						</button>
					</div>
				</section>
			</form>
		</c:if>
		
		<!-- 강의 자료 업로드 모달 form -->
		<div class="modal fade" id="staticBackdrop"
			data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"
			aria-labelledby="staticBackdropLabel" aria-hidden="true">
			<div class="modal-dialog modal-dialog-scrollable">
				<div class="modal-content">
					<div class="modal-header border-0">
						<h5 class="modal-title" id="staticBackdropLabel">
							강의 자료 업로드</h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal"
							aria-label="Close"></button>
					</div>
					
					<form class="form_file" action="${uploadFilesURL}/lessonFiles" method="post" 
						  enctype="multipart/form-data">
						<div class="modal-body">
							<div class="form-group">
								<label for="formFile" class="form-label">
									<small>*강의 자료를 한번에 올릴 수 있습니다.</small><br>
									<small>*올릴 수 있는 파일 확장자는 ...</small>
								</label>
								<input class="form-control" type="file" 
									   id="input_file" multiple required>
							</div>
							<div class="mt-4">
								<span class="ps-2">파일 목록</span>
								<hr class="mt-0">
								<div  class="ps-2" id="articlefileChange"></div>
							</div>
						</div>
						
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary"
									data-bs-dismiss="modal">취소</button>
							<button type="submit" class="btn btn-primary fileBtn">업로드</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</main>
	<footer style="width: 100%">
		<%@ include file="../module/footer.jsp"%>
	</footer>

	<script type="text/javascript">
		CKEDITOR.replace("content", {
			filebrowserUploadUrl: "${upload}?type=image"
		})
	</script>
	<!-- 썸네일 이미지 보이기 -->
	<script type="text/javascript">
		function showThumbnail(event){
			var parent = document.querySelector('div.img');
			console.log(parent.lastElementChild.tagName);
			if(parent.lastElementChild.tagName === 'IMG'){
				parent.lastElementChild.remove();
			}
			let reader = new FileReader();
			
			reader.onload = function(e){
				var img = document.createElement("img");
				img.setAttribute("src", e.target.result);
				img.setAttribute("class", "rounded");
				img.style.width = '350px';
				img.style.height = '235px';
				
				parent.appendChild(img);
			};
			reader.readAsDataURL(event.target.files[0]);
		}
	</script>
	
	<!-- chapter와 세부 강의 목록 만들기 -->
	<script>
		const boss = document.querySelector(".clickEvent");
	
	    let lesson = 1;
	    let chapter = 1;
	
	    boss.addEventListener('click', e => {
	        let target = e.target;
	        
	        //+와 휴지통 기준 tbody
	        let tbody;
	        let ChapterID;
	        if (target.classList.contains('deleteLesson') || target.classList.contains('addLesson')) {
	            tbody = target.parentElement.parentElement.parentElement;
	            ChapterID = tbody.previousElementSibling.children[0].children[0].id;
	        }
	
	        if (target.classList.contains('deleteLesson')) {
	            lesson--;
	            if (lesson > 0) {
	                deleteLesson(target, ChapterID, tbody);
	                deleteSelect();
	                insertSelect();
	            } else {
	                lesson = 1;
	            }
	        } else if (target.classList.contains('addLesson')) {
	            lesson++;
	            addLesson(tbody, ChapterID);
	            deleteSelect();
	            insertSelect();
	        } else if (target.classList.contains('addChapter')) {
	            chapter++;
	            let buttons = addChapter(target);
	            createButton(buttons);
	            chapterNumbering();
	            deleteSelect();
	            insertSelect();
	        } else if (target.classList.contains('deleteChapter')) {
	            chapter--;
	            if (chapter > 0) {
	                deleteChapter(target);
	                deleteSelect();
	                insertSelect();
	            } else {
	                chapter = 1;
	            }
	        }
	    });
	
	    function addLesson(tbody, ChapterID) {
	        const tr = document.createElement('tr');
	        tr.setAttribute("id", "tr");
	        tr.innerHTML = `
				<td class="text-end">
	        		<i class="fa-solid fa-trash-can deleteLesson"></i>
        		</td>
                 <td></td>
                 <td><input type="text" class="form-control" placeholder="세부 강의 이름"></td>
                 <td style="width: 15%;">
                     <select id="cur_small_type" class="form-select" 
                     		  required>
                         <option value="">강의 타입</option>
                         <option value="VIDEO">동영상</option>
                         <option value="DOCUMENT">강의 자료</option>
                     </select>
                 </td>
                 <td>
                     <i class="fa-solid fa-plus addLesson"></i>
                 </td>`;
	        tbody.appendChild(tr);
	
	        lessonNumbering(tbody, ChapterID);
	    }
	
	    function deleteLesson(target, ChapterID, tbody) {
	        const tr = target.parentElement.parentElement;
	        tbody.removeChild(tr);
	
	        lessonNumbering(tbody, ChapterID);
	    }
	
	    function addChapter(target) {
	        const newTable = document.createElement('table');
	        newTable.setAttribute('class', 'table text-center curriculum');
	
	        newTable.innerHTML = `
				<thead>
                    <tr class="bg-light">
                        <th colspan="2"  id="" style="width: 20%;"></th>
                        <th colspan="3">
                        	<input type="text" class="form-control" placeholder="chpater 이름"
                        		   id="cur_big_title" name="cur_big_title" required>
                        </th>
                    </tr>
                </thead>
                <tbody>
                    <tr id="tr">
                        <td class="text-end">
                        	<i class="fa-solid fa-trash-can deleteLesson"></i>
                       	</td>
                        <td></td>
                        <td><input type="text" class="form-control" placeholder="세부 강의 이름"
                        		   id="cur_small_title" required></td>
                        <td style="width: 15%;">
                            <select id="cur_small_type" class="form-select" required>
                                <option value="">강의 타입</option>
                                <option value="VIDEO">동영상</option>
                                <option value="DOCUMENT">강의 자료</option>
                            </select>
                        </td>
                        <td><i class="fa-solid fa-plus addLesson"></i></td>
                    </tr>
                </tbody>`;
	
	        const buttons = target.parentElement;
	        buttons.after(newTable);
	
	        return buttons;
	    }
	
	    function deleteChapter(target) {
	        const prevTable = target.parentElement.previousElementSibling;
	        const buttons = target.parentElement;
	
	        const div = target.parentElement.parentElement;
	        div.removeChild(prevTable);
	        div.removeChild(buttons);
	
	        chapterNumbering();
	    }
	
	    function chapterNumbering() {
	        const all_tables = boss.querySelectorAll('div table');
	        let count = 1;
	        all_tables.forEach(table => {
	            let th = table.children[0].children[0].children[0];
	            th.id = count;
	            th.innerText = `Chapter \${count}.`;
	
	            let tbody = table.children[1];
	            lessonNumbering(tbody, count);
	            count++;
	        });
	    }
	
	    function lessonNumbering(tbody, ChapterID) {
	        const all_trs = tbody.querySelectorAll('tr');
	        let count = 1;
	        all_trs.forEach(tr => {
	            tr.children[1].innerText = `강의 \${ChapterID}.\${count}`;
	            count++;
	        });
	    }
	
	    function createButton(buttons) {
	        const newTable = buttons.nextElementSibling;
	
	        const div = document.createElement('div');
	        div.setAttribute('class', 'float-end mb-5');
	        div.innerHTML = `
	                <button type="button" class="btn btn-primary deleteChapter">
	        			<i class="fa-solid fa-minus"></i> 
	                    Chapter 삭제하기</button>
	                <button type="button" class="btn btn-primary addChapter">
	                	<i class="fa-solid fa-plus"></i> 
	                    Chapter 추가하기</button>`;
	        newTable.after(div);
	    }
	</script>
	
	<!-- ajax로 강의 기본 정보 전달하기 -->
	<script type="text/javascript">
		function formCheckPage1(){
			var title = document.querySelector('#title');
			var category = document.querySelector('#category');
			var price = document.querySelector('#price');
			var content = document.querySelector('#content');
			
			if(title.value === undefined || title.value.trim() === ""){
				alert("강의 제목을 입력하세요.");
				return;
			}else if(category.value === undefined || category.value.trim() === ""){
				alert("강의 카테고리을 지정하세요.");
				return;
			}else if(price.value === undefined || price.value.trim() === ""){
				alert("강의 가격을 입력하세요.");
				return;
			}else if(content.value === undefined || content.value.trim() === ""){
				alert("강의 소개글을 입력하세요.");
				return;
			}else{
				
				$.ajax({
					type:"post",
					url: "${uploadFilesURL}/uploadLessonInfo",
					contentType: 'application/json',
					data: JSON.stringify({
						l_title: title.value,
						l_content: content.value,
						l_price: parseInt(price.value),
						l_lesson_category: category.value
					}),
					success:function(data){
						if(data.code === "success"){
							alert("임시저장 되었습니다.");
						}
					},
					error: function (xhr, status, error) {
						alert("서버오류로 지연되고있습니다. 잠시 후 다시 시도해주시기 바랍니다.");
					}
				});
			}
		}
	</script>
	
	<!-- ajax로 강의 커리큘럼 업로드 하기 -->
	<script type="text/javascript">
		function formCheckPage2(){
			const bigTitle = document.querySelectorAll('#cur_big_title');
			const smallTitle = document.querySelectorAll('#cur_small_title');
			const fileType = document.querySelectorAll('#cur_small_type');
			
			//ok: 모든 빈칸이 채워졌는지 확인
			var ok = 0;
			//num: 각 커리큘럼마다 다 작성했는지 확인
			var num = 0;
			bigTitle.forEach(input =>{
				if(input.value === undefined || input.value.trim() === ""){
					alert("강의 Chapter를 입력하세요.");
					return;
				}
				num++;
				if(num === bigTitle.length){
					ok++;
				}
			});
			
			num = 0;
			smallTitle.forEach(input =>{
				if(input.value === undefined || input.value.trim() === ""){
					alert("강의 소제목을 입력하세요.");
					return;
				}
				num++;
				if(num === bigTitle.length){
					ok++;
				}
			});
			
			num = 0;
			fileType.forEach(select =>{
				if(select.value === undefined || select.value.trim() === ""){
					alert("강의별 자료 타입을 지정하세요.");
					return;
				}
				num++;
				if(num === bigTitle.length){
					ok++;
				}
			});
			
			console.log(ok);
			if(ok === 3){
				//java에 보낼 json 배열
				var jsonBigArr = new Array();
				var jsonSmallArr = new Array();
				//커리큘럼 정보 담을 객체
				var bigTitleObject = new Object();
				var smallTitleObject = new Object();
				
				
				bigTitle.forEach(input =>{
					//큰 커리큘럼 객체 정의하기
					let chpaterID = parseInt(input.parentElement.previousElementSibling.id);
					bigTitleObject.cur_big_chapid = chpaterID;
					bigTitleObject.cur_big_title = input.value;
					
					//큰 커리큘럼 json 배열에 담기
					jsonBigArr.push(bigTitleObject);
					
					var tbody = input.parentElement.parentElement.parentElement.nextElementSibling;
					var tr = tbody.querySelectorAll('tr#tr');
					num = 1;
					tr.forEach(tr => {
						//작은 커리큘럼 객체 정의하기
						smallTitleObject.cur_small_chapid = chpaterID;
						smallTitleObject.cur_small_curid = num++;
						smallTitleObject.cur_small_title = tr.children[2].children[0].value;
						smallTitleObject.cur_small_type = tr.children[3].children[0].value;
						
						//작은 커리큘럼 json 배열에 담기
						jsonSmallArr.push(smallTitleObject);
						smallTitleObject = new Object();
					});
					num = 0;
					bigTitleObject = new Object();
				});

				console.log(JSON.stringify(jsonSmallArr));
				console.log(JSON.stringify(jsonBigArr));
				
				$.ajax({
					type:"post",
					url: "${uploadFilesURL}/uploadLessonCurri",
					contentType: 'application/json',
					traditional: true,
					data: {
						curri_big : JSON.stringify(jsonBigArr), 
						curri_small : JSON.stringify(jsonSmallArr)
					},
					success:function(data){
						if(data.code === "success"){
							alert("임시저장 되었습니다.");
						}
					},
					error: function (xhr, status, error) {
						alert("서버오류로 지연되고있습니다. 잠시 후 다시 시도해주시기 바랍니다.");
					}
				});
			}
		}
	</script>
	
	<!-- ajax로 강의 자료 업로드 하기 -->
	<script>
		$(document).ready(function()
			// input file 파일 첨부시 fileCheck 함수 실행
			{
				$("#input_file").on("change", fileCheck);
				
			});
		
			// 파일 현재 필드 숫자 totalCount랑 비교값
			var fileCount = 0;
			// 해당 숫자를 수정하여 전체 업로드 갯수를 정한다.
			var totalCount = 10;
			// 파일 고유넘버
			var fileNum = 0;
			// 첨부파일 배열
			var content_files = new Array();
			
			function fileCheck(e){
				var files = e.target.files;
				var filesArr = Array.prototype.slice.call(files);
				
				// 각각의 파일 배열담기 및 기타
				filesArr.forEach(function (f) {
					var reader = new FileReader();
					reader.onload = function (e) {
						content_files.push(f);
						$('#articlefileChange').append(
		                        '<div id="file' + fileNum + '">'
		                        + '<i class="bi bi-dash-circle" onclick="fileDelete(\'file' + fileNum + '\')"></i>'
		                        + '<font class="ps-1" style="font-size:16px">' + f.name + '</font>'
		                        + '<div/>'
		                );
						fileNum ++;
					};
					reader.readAsDataURL(f);
				});
				$("#input_file").val("");
				content_files = [];
			}
			
			// 파일 부분 삭제 함수
			function fileDelete(fileNum){
			    var no = fileNum.replace(/[^0-9]/g, "");
			    content_files[no].is_delete = true;
				$('#' + fileNum).remove();
				fileCount --;
			}
			
			var fileBtn = document.querySelector('.fileBtn');
			
			fileBtn.addEventListener('click', (e)=>{
				e.preventDefault();
				var target = e.target;
				
				var form = $("form")[1]; 
				var formData = new FormData(form);
				
				console.log(content_files.length);
				if(content_files.length <= 0){
					alert("파일을 선택해 주세요");
					return;
				}
				for (var i = 0; i < content_files.length; i++) {
					// 삭제 안한것만 담아 준다. 
					if(!content_files[i].is_delete){
						formData.append("lessonFile", content_files[i]);
					}
				}
				$.ajax({
					type:"post",
					enctype: "multipart/form-data",
					url: "upload/lessonFiles",
					data: formData,
					processData: false, /*false: String으로 변환 안하고 data보내짐  */
					contentType: false, /*false: contentType header가 multi/form-data로 보내짐  */
					success:function(data, status){
						makeTable(data);
						insertSelect();
					},
					error: function (xhr, status, error) {
						alert("서버오류로 지연되고있습니다. 잠시 후 다시 시도해주시기 바랍니다.");
					}
				}); 
				
				$('#articlefileChange').empty();
				content_files = [];
			});
		
			/* 화면에 출력할 동영상/문서 자료 */
			function makeTable(fileData){
				const table = document.createElement('table');
			    table.setAttribute("class", "table lessonFiles");
			    table.innerHTML = `  
			    <thead>
			        <tr>
			            <th scope="col"></th>
			            <th scope="col">파일명</th>
			            <th scope="col">파일 크기</th>
			            <th scope="col">강의 구분</th>
			            <th scope="col"></th>
			            </tr>
			            </thead > `;
			    const tbody = document.createElement('tbody');
			    for(let i = 0; i < fileData.length; i++){
					insertLessonInfo(fileData[i], tbody);
				}
			    table.append(tbody);
			    const parent = document.querySelector('.fileUpload');
			    parent.append(table);
			}
			
	        function insertLessonInfo(fileData, tbody) {
			    const fileName = fileData.lu_name;
			    const fileSize = (fileData.lu_fileSize / (1024 * 1024)).toFixed(2);
			    
			    tbody.innerHTML += `
			    	<tr>
		                <td>
		                    <i class="bi bi-caret-up"></i>
		                    <i class="bi bi-caret-down-fill"></i>
		                </td>
		                <td name="lu_name" value="\${fileName}">\${fileName}</td>
		                <td>\${fileSize}MB</td>
		                <td class="select"></td>
		                <td><i class="fa-solid fa-trash-can"></i></td>
		            </tr>`;
			}
	        
	        function insertSelect() {
	        	$('.select').append(select());
	        }
	        function deleteSelect(){
	        	$('.select').empty();
	        }
	        function select() {
	            const select = document.createElement('select');
	            select.setAttribute("id", "curriculum_sort");
	            select.setAttribute("size", "3");
	            select.setAttribute("name", "lu_curid");
	            select.setAttribute("required", "true");
	            select.style.width = '100px';

	            const section2 = document.querySelector('.lessonInfo2');
	            const eachtable = section2.querySelectorAll('table.curriculum');

	            let chapterCount = 1;
	            eachtable.forEach(table => {
	                let optgroup = document.createElement('optgroup');
	                optgroup.setAttribute("label", `chapter\${chapterCount}`);

	                let trAmount = table.children[1].childElementCount;
	                for (let j = 1; j <= trAmount; j++) {
	                    optgroup.innerHTML += `
			                <option value="\${chapterCount}.\${j}">\${chapterCount}.\${j}</option>`;
	                }
	                select.append(optgroup);
	                chapterCount++;
	            });
	            return select;
	        }
	</script>
	
	<!-- 강의 최종 업로드 체크 -->
	<script type="text/javascript">
		function formCheck(form) { 
			const fileTable = document.querySelectorAll('table.lessonFiles');
			const submitBtn = document.querySelector('.submitBtn');
			if(fileTable.length <= 0){
				alert("강의 자료를 업로드해 주세요.");
			}
			
			form.submit();
		}
	</script>
	
	<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js"></script>
</body>

</html>