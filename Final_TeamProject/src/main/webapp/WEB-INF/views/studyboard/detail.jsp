<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>${data.sb_title}</title>
	<%@ include file="../module/head.jsp" %>
	<c:url var="jQuery" value="/static/js" />
	<c:url var="bs5" value="/static/bs5" />
	<c:url var="css" value="/static/css" />
	<script type="text/javascript" src="${jQuery}/jquery-3.6.0.min.js"></script>
	<link rel="stylesheet" type="text/css" href="${bs5}/css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="${css}/studyboardDetail.css">
	<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.9.1/font/bootstrap-icons.css">
	<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
</head>
<body>
	<c:url var="mainUrl" value="/" />
	<header class="mb-3">
		<%@ include file="../module/navigation.jsp" %>
	</header>
	<section class="container m-height">
		<c:url var="infoUrl" value="/userinfo" />
		<c:url var="studyBoardUrl" value="/studyboard" />
		<div class="mt-3 flex pd0-3-1">
			<div class="width90 mar-r3">
				<div class=mar-top1>
					<div class="mar-bot1">
						<h1 class="font15">${data.sb_title}</h1>
					</div>
					<div class="mar-bot1 flex">
						<div class="flex1">
							<label id="info2" class="pe-3 font-cor2 text-secondary text-opacity-75 mar-top-px"
							onclick="location.href='${infoUrl}/post?id=${data.sb_wId}'">${data.sb_wName}</label>
							<fmt:formatDate value="${data.sb_date}" var="createDate" dateStyle="long" />
							<label class="pe-3 font-cor2 text-secondary text-opacity-75">${createDate}</label>
						</div>
						<c:if test="${data.sb_wId eq sessionScope.loginData.AC_ID}">
							<div>
								<button class="btn2 font1 font-cor2 text-secondary text-opacity-75 pd4-p" type="button" onclick="location.href='${studyBoardUrl}/modify?id=${data.sb_bId}'">수정</button>
								<span class="text-secondary text-opacity-75">|</span>
								<button class="btn2 font1 font-cor2 text-secondary text-opacity-75 pd4-p" type="button" data-bs-toggle="modal" data-bs-target="#removeModal">삭제</button>
							</div>
						</c:if>
					</div>
				</div>
				<div class="border_b1 border_b_s border_b_c mar-bot2"></div>
				<div class="mar-bot2">
					<p>${data.sb_content}</p>
				</div>
			</div>
			<c:choose>
				<c:when test="${not empty sessionScope.loginData}">
					<div class="mar-top6">
						<button type="button" name="side" class="btn1 block side-sty side-sty3 mar-bot05" onclick="ajaxLike(id_like, ${data.sb_bId}, icon);">
							<div class="flex">
								<div>
									<span id="icon" class="material-symbols-outlined font-fam">favorite</span>
								</div>
								<div>
									<span id="id_like" class="" >${data.sb_like}</span>
								</div>
							</div>
						</button>
					  	<button class="btn1 side-sty side-sty2 block mar-bot05 nowrp" type="button" onclick="location.href='${studyBoardUrl}'">목록</button>
					</div>
				</c:when>
				<c:otherwise>
					<div class="mar-top6">
						<button type="button" name="side" class="btn1 block side-sty side-sty3 mar-bot05" onclick="checkSession();">
							<div class="flex">
								<div>
									<span class="material-symbols-outlined font-fam">favorite</span>
								</div>
								<div>
									<span id="id_like" class="" >${data.sb_like}</span>
								</div>
							</div>
						</button>
					  	<button class="btn1 side-sty side-sty2 block mar-bot05 nowrp" type="button" onclick="location.href='${studyBoardUrl}'">목록</button>
					</div>
				</c:otherwise>
			</c:choose>
		</div>
		
		<div class="bg-lg pd1-3">
			<label class="">${data.total_reply}개의 댓글이 있습니다.</label>
			<div class="mt-3 mb-3">
				<c:forEach items="${commentPage.pageData}" var="comment">
					<div class="flex">
						<c:choose>
							<c:when test="${comment.sc_depth == 1}">
								<span class="material-icons font-fam dark-cor mar-l1">subdirectory_arrow_right</span>
							</c:when>
							<c:when test="${comment.sc_depth == 2}">
								<span class="material-icons font-fam dark-cor mar-l3">subdirectory_arrow_right</span>
							</c:when>
						</c:choose>
						<div class="mar-bot10 comment com-sty">
							<div class="card border-light">
								<div class="card-header c-h-margin">
									<div class="d-flex pd-b5">
										<input type="hidden" value="${comment.sc_id}">
										<div class="flex1">
											<span class="wr-m"><small id="info" class="font1" onclick="location.href='${infoUrl}/post?id=${comment.sc_wId}'">${comment.sc_wName}</small></span>
											<span class="text-secondary text-opacity-75 font-w font-cor2 font1 mar-r"><small>${comment.sc_date}</small></span>
											<c:choose>
												<c:when test="${not empty sessionScope.loginData}">
													<c:if test="${not comment.isSc_deleted()}">
														<button type="button" class="like-btn badge rounded-pill bg-info text-decoration-none" 
															onclick="commentLike(this, ${comment.sc_id});">
														<i class="bi bi-chat-left-heart"></i> ${comment.sc_like}
														</button>
													</c:if>
												</c:when>
												<c:otherwise>
													<c:if test="${not comment.isSc_deleted()}">
														<button type="button" class="like-btn badge rounded-pill bg-info text-decoration-none" 
																onclick="checkSession();">
														<i class="bi bi-chat-left-heart"></i> ${comment.sc_like}
														</button>
													</c:if>
												</c:otherwise> 
											</c:choose>
										</div>
										<c:if test="${comment.sc_wId eq sessionScope.loginData.AC_ID}">
											<c:if test="${not comment.isSc_deleted()}">
												<div id="d1" class="text-end">
													<button id="edb" class="btn2 font-cor2 font1 text-secondary text-opacity-75 pd4-p" type="button" onclick="changeEdit(this);">수정</button>
													<span class="text-secondary text-opacity-75">|</span>
													<button class="btn2 font-cor2 font1 text-secondary text-opacity-75 pd4-p" type="button" onclick="commentDelete(this, ${comment.sc_id});">삭제</button>
												</div>
											</c:if>
										</c:if>
									</div>
										<div class="border_b1 border_b_s border_b_c"></div>
								</div>
								<div class="card-body c-b-margin">
									<input type="hidden" value="${data.sb_bId}">
									<input type="hidden" value="${comment.sc_id}">
									<c:choose>
										<c:when test="${comment.isSc_deleted()}">
											<p class="text-muted mar-bot0">삭제된 댓글 입니다.</p>
										</c:when>
										<c:otherwise>
											<c:choose>
												<c:when test="${comment.sc_depth == 1 || comment.sc_depth == 2}">
													<c:forEach items="${originalData}" var="orginData">
														<c:if test="${comment.sc_parents == orginData.sc_id }">
															<c:set var="newLine" value="<%= \"\n\" %>" />
															<p class="font-w6 dark-cor">@${orginData.sc_wName}</p>
															<p class="card-text">${fn:replace(comment.sc_content, newLine, '<br>')}</p>
														</c:if>
													</c:forEach>
												</c:when>
												<c:otherwise>
													<c:set var="newLine" value="<%= \"\n\" %>" />
													<div></div>
													<p class="card-text">${fn:replace(comment.sc_content, newLine, '<br>')}</p>
												</c:otherwise>
											</c:choose>
										</c:otherwise>
									</c:choose>
									<c:if test="${not comment.isSc_deleted()}">
										<c:if test="${comment.sc_depth == 0 || comment.sc_depth == 1}">
											<c:choose>
												<c:when test="${not empty sessionScope.loginData}">
													<button id="b1" class="btn2 font-cor2 font1 text-secondary text-opacity-75 pd0" type="button" onclick="replyForm(this, ${comment.sc_depth});">댓글쓰기</button>
												</c:when>
												<c:otherwise>
													<button id="b1" class="btn2 font-cor2 font1 text-secondary text-opacity-75 pd0" type="button" onclick="checkSession();">댓글쓰기</button>
												</c:otherwise>
											</c:choose>
										</c:if>
									</c:if>
								</div>
							</div>
						</div>

					</div>
				</c:forEach>
				<div class="mb-1 block bg-w com-sty">
					<div class="pd2-5">
						<form action="${studyBoardUrl}/comment/add" method="post">
							<input type="hidden" name="sc_bId" value="${data.sb_bId}">
							<input type="hidden" name="sc_id" value=0>
							<div class="input-group">
								<c:choose>
									<c:when test="${not empty sessionScope.loginData}">
										<textarea class="form-control w100 radi5 coment pd1" name="sc_content" rows="2" placeholder="${sessionScope.loginData.AC_NICKNAME}님, 댓글을 남겨보세요!"></textarea>
										<button class="btn btn-primary btn-lg radi5 coment-btn font1" type="button" onclick="formCheck(this.form);">댓글 등록</button>
									</c:when>
									<c:otherwise>
										<textarea class="form-control w100 radi5 coment pd1" name="sc_content" rows="2" onclick="checkSession();" placeholder="로그인을 하신 후 이용해 주시기 바랍니다."></textarea>
										<button class="btn btn-primary btn-lg radi5 coment-btn font1" type="button" onclick="checkSession();">댓글 등록</button>
									</c:otherwise>
								</c:choose>
							</div>
						</form>
					</div>
				</div>
			</div>
			<nav>
				<div>
					<ul class="pagination pagination-sm justify-content-center">
						<c:url var="studyBoardDetailUrl" value="/studyboard/detail">
							<c:param name="id">${data.sb_bId}</c:param>
						</c:url>
						<c:if test="${commentPage.hasPrevPage()}">
							<li class="page-item"><a class="page-link"
								href="${studyBoardDetailUrl}&page=${commentPage.prevPageNumber}">«</a></li>
						</c:if>
						<c:forEach
							items="${commentPage.getPageNumberList(commentPage.currentPageNumber - 2, commentPage.currentPageNumber + 2)}"
							var="num">
							<li
								class="page-item ${commentPage.currentPageNumber eq num ? 'active' : ''}">
								<a class="page-link" href="${studyBoardDetailUrl}&page=${num}">${num}</a>
							</li>
						</c:forEach>
						<c:if test="${commentPage.hasNextPage()}">
							<li class="page-item"><a class="page-link"
								href="${studyBoardDetailUrl}&page=${commentPage.nextPageNumber}">»</a></li>
						</c:if>
					</ul>
				</div>
			</nav>
		</div>
		
		
		<div class="modal fade" id="removeModal" tabindex="-1" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h6 class="modal-title">삭제 확인</h6>
						<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					</div>
					<div class="modal-body">
						게시글을 삭제하겠습니까?
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-sm btn-danger" data-bs-dismiss="modal" onclick="deleteBoard(${data.sb_bId})">확인</button>
					</div>
				</div>
			</div>
		</div>
	</section>
	<footer>
		<%@ include file="../module/footer.jsp" %>
	</footer>
	
	<script type="text/javascript">

		function replyForm(element, sc_depth) {
			var depth = sc_depth;
			var sc_bId = element.parentElement.children[0].value;
			var sc_id = element.parentElement.children[1].value;
			var commentBox = document.getElementById("comment_box");
			
			if(commentBox) {
				var comBox_scId = commentBox.children[0].children[1].value;
				
				if(comBox_scId == sc_id) {
					commentBox.remove();
				} else {
					commentBox.remove();
					commentBoxAdd(element);
				}
			} else {
				commentBoxAdd(element);
			}
		}

		function commentBoxAdd(element) {
			var sc_bId = element.parentElement.children[0].value;
			var sc_id = element.parentElement.children[1].value;
			
			var div1 = document.createElement("div");
			div1.setAttribute("id", "comment_box");
			div1.setAttribute("class", "reply-form");
			
			var form = document.createElement("form");
			form.setAttribute("action", "/home/studyboard/comment/add");
			form.setAttribute("method", "post");

			var input1 = document.createElement("input");
			input1.setAttribute("type", "hidden");
			input1.setAttribute("name", "sc_bId");
			input1.setAttribute("value", sc_bId);
			
			var input2 = document.createElement("input");
			input2.setAttribute("type", "hidden");
			input2.setAttribute("name", "sc_id");
			input2.setAttribute("value", sc_id);
			
			var div2 = document.createElement("div");
			div2.setAttribute("class", "input-group");
			
			var textarea = document.createElement("textarea");
			textarea.setAttribute("class", "form-control");
			textarea.setAttribute("name", "sc_content");
			textarea.setAttribute("rows", "2");
			
			var button = document.createElement("button");
			button.setAttribute("class", "btn btn-primary");
			button.setAttribute("type", "button");
			button.setAttribute("onclick", "formCheck(this.form);");
			button.innerText = "등록";
			
			div2.append(textarea); div2.append(button);
			form.append(input1); form.append(input2); form.append(div2);
			div1.append(form);
			
			element.parentElement.parentElement.append(div1);
		}
	
		function changeEdit(element) {
			element.innerText = "확인";
			var cancel = element.nextElementSibling.nextElementSibling;
			cancel.innerText = "취소";
			
			var cards = element.parentElement.parentElement.parentElement.nextElementSibling.children;
			var card3 = cards[3];
			var cardValue = card3.innerText;
			
			var textarea = document.createElement("textarea");
			textarea.setAttribute("class", "form-control");
			textarea.value = cardValue;
			
			card3.innerText = "";
			card3.append(textarea);
			
			cardValue =  "`"+ cardValue +"`";	//백틱 사용
			
			cancel.setAttribute("onclick", "commentEditCancle(this, " + cardValue + ");");
			element.setAttribute("onclick", "commentUpdate(this);");
		}
		
		function changeText(element) {
			element.innerText = "수정";
			element.nextElementSibling.nextElementSibling.remove();
			
			var cid = element.parentElement.parentElement.children[0].value;
			var value = element.parentElement.parentElement.parentElement.nextElementSibling.children[3].children[0].value;
			element.parentElement.parentElement.parentElement.nextElementSibling.children[3].children[0].remove();
			element.parentElement.parentElement.parentElement.nextElementSibling.children[3].innerText = value;
			
			var btnDelete = document.createElement("button");
			btnDelete.innerText = "삭제";
			btnDelete.setAttribute("class", "btn2 font-cor2 font1 text-secondary text-opacity-75 pd4-p");
			btnDelete.setAttribute("onclick", "commentDelete(this, " + cid + ");");
			
			element.parentElement.append(btnDelete);
			element.setAttribute("onclick", "changeEdit(this);");
		}
		
		function commentUpdate(element) {
			var cid = element.parentElement.parentElement.children[0].value;
			var value = element.parentElement.parentElement.parentElement.nextElementSibling.children[3].children[0].value;
			
			$.ajax({
				url: "${studyBoardUrl}/comment/modify",
				type: "post",
				data: {
					id: cid,
					content: value
				},
				success: function(data) {
					element.parentElement.parentElement.parentElement.nextElementSibling.children[3].children[0].value = data.value;
					changeText(element);
				}
			});
		}
		
		function commentEditCancle(element, cardValue) {
			//댓글 수정 취소
			element.setAttribute("id","can");
			
			var value = cardValue;
			var cid = element.parentElement.parentElement.children[0].value;
			
			element.parentElement.parentElement.parentElement.nextElementSibling.children[3].children[0].remove();
			element.parentElement.parentElement.parentElement.nextElementSibling.children[3].innerText = value;
			
			var editBtn = element.previousElementSibling.previousElementSibling;
			editBtn.innerText = "수정";
			editBtn.setAttribute("onclick", "changeEdit(this);");
			
			element.innerText = "삭제";
			element.setAttribute("class", "btn2 font-cor2 font1 text-secondary text-opacity-75 pd4-p");
			element.setAttribute("onclick", "commentDelete(this, " + cid + ");");
		}
		
		function commentDelete(element, id) {
			$.ajax({
				url: "${studyBoardUrl}/comment/delete",
				type: "post",
				data: {
					id: id
				},
				success: function(data) {
					if(data.code === "success") {
						element.parentElement.parentElement.parentElement.parentElement.parentElement.remove();
						location.reload();
					}
				}
			});
		}
		function formCheck(form) {
			if(form.sc_content.value.trim() === "") {
				alert("댓글 내용을 입력하세요.");
			} else {
				form.submit();
			}
		}
		
		function deleteBoard(sb_bId) {
			$.ajax({
				url: "${studyBoardUrl}/delete",
				type: "post",
				data: {
					id: sb_bId
				},
				dataType: "json",
				success: function(data) {
					if(data.code === "success") {
						alert("삭제 완료");
						location.href = "${studyBoardUrl}";
					} else if(data.code === "permissionError") {
						alert("권한이 오류");
					} else if(data.code === "notExists") {
						alert("이미 삭제되었습니다.")
					}
				}
			});
		}
		
		function checkSession() {
			alert("로그인을 하신 후 이용해 주시기 바랍니다.");
			location.href = "${mainUrl}login";
		}
		
		//게시글 추천
		function ajaxLike(element, id, icon) {
			
				$.ajax({
					type: "post",
					url: "${studyBoardUrl}/like",
					data: {
						id: id
					},
					success: function(data) {
						if(data.code === "success") {
							element.innerText = data.sb_like;
						} else if(data.code === "noData") {
							alert(data.message);
							location.href = "${studyBoardUrl}";
						}
					}
				});
			
		}
		
		//댓글 추천
		function commentLike(element, id) {
			$.ajax({
				type: "post",
				url: "${studyBoardUrl}/comment/like",
				data: {
					id: id
				},
				success: function(data) {
					if(data.code === "success") {
						element.innerHTML = '<i class="bi bi-chat-left-heart"></i> ' + data.like;				
					} else if(data.code === "noData") {
						alert(data.message);
						location.href = "${studyBoardUrl}";
					}
				}
			});
		}
		
	</script>
</body>
</html>



