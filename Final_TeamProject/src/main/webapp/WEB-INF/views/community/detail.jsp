<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${boardData.cb_title}</title>
	<%@ include file="../module/head.jsp"%>
	<c:url var="bs5" value="/static/bs5" />
	<link rel="stylesheet" type="text/css" href="${bs5}/css/bootstrap.min.css">
	<script type="text/javascript" src="${bs5}/js/bootstrap.min.js"></script>
	<link rel="stylesheet" type="text/css" href="${css}/studyboardDetail.css">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.9.1/font/bootstrap-icons.css">

</head>
<body>
	<header>
		<%@ include file="../module/navigation.jsp"%>
	</header>
	
	<div>			
		<c:url var="communityURL" value="/community" />
		<c:url var="infoUrl" value="/userinfo" />
		<c:choose>
			<c:when test="${boardData.cb_catid eq 1}">
				<c:url var="commBoarListUrl" value="/community/qa" />
			</c:when>
			<c:when test="${boardData.cb_catid eq 2}">
				<c:url var="commBoarListUrl" value="/community/forum" />
			</c:when>
			<c:when test="${boardData.cb_catid eq 3}">
				<c:url var="commBoarListUrl" value="/community/tip" />
			</c:when>
			<c:otherwise>
				<c:url var="commBoarListUrl" value="/community/main" />
			</c:otherwise>
		</c:choose>
	</div>
	

	<section class="container m-height">
		<div class="mt-3 flex pd0-3-1">
			<div class="width90 mar-r3">
				<div class=mar-top1>
					<div class="mar-bot1">
						<h1 class="font15">${boardData.cb_title}</h1>
					</div>
					<div class="mar-bot1 flex">
						<div class="flex1">
							<label
								class="pe-3 font-cor2 texts-secondary text-opacity-75 mar-top-px"
								id="info2" onclick="location.href='${infoUrl}/post?id=${boardData.cb_wid}'" >${boardData.cb_nickName}</label>
							<fmt:formatDate value="${boardData.cb_date}" var="createDate" dateStyle="long" />
							<label class="pe-3 font-cor2 text-secondary text-opacity-75">${createDate}</label>
						</div>
						<div>
							<!-- 로그인 아이디와 같을 때만 수정,삭제 -->
							<c:if test="${boardData.cb_wid eq sessionScope.loginData.AC_ID}">
								<button
									class="btn font1 font-cor2 text-secondary text-opacity-75 pd4-p" type="button"
									href="#" onclick="location.href='${communityURL}/modify?cb_bid=${boardData.cb_bid}'">수정</button>
								<span class="text-secondary text-opacity-75">|</span>
								<button
									class="btn font1 font-cor2 text-secondary text-opacity-75 pd4-p"
									type="button" data-bs-toggle="modal"
									data-bs-target="#removeModal">삭제</button>
							</c:if>
						</div>
					</div>
				</div>
				<div class="border_b1 border_b_s border_b_c mar-bot2"></div>
					<div class="mar-bot2">
						<p>${boardData.cb_content}</p>
					</div>
			</div>
			<div class="mar-top6">
				<div class="btn block side-sty side-sty3 mar-bot05"	onclick="boardLike(board_like, ${boardData.cb_bid});">
					<label id="board_like" class="text"> 
						<c:choose>
							<c:when test="${boardStaticData.cbs_liked == true}">
								<i id="liked_icon" class="bi bi-heart-fill"></i>
							</c:when>
							<c:otherwise>
								<i id="liked_icon" class="bi bi-heart"></i>
							</c:otherwise>
						</c:choose> 
						${boardData.cb_like}
					</label>
				</div>
				<button class="btn side-sty side-sty2 block mar-bot05" type="button" href="#" onclick="location.href='${commBoarListUrl}'">목록</button>
			</div>
		</div>
		
		<!-- 댓글 -->
		<div class="bg-lg pd1-3">
			<label class="">${boardData.cb_commentNum}개의 댓글이 있습니다.</label>
			<div class="mt-3 mb-3">
				<c:forEach items="${commentPage.pageData}" var="comment">
				<%-- 댓글 전체를 id div로 감싸기 --%>
				<div id="comment${comment.cc_id}">
					<div class="mar-bot1 comment com-sty" style="margin-left: ${comment.cc_depth * 20}px;">
					<div class="card border-light">
						<%-- 댓글 헤더 부분(작성자 닉네임, 댓글 추천 아이콘 & 추천수, 날짜 | 수정, 삭제 버튼 --%>
						<div class="card-header c-h-margin">
							<%--댓글 작성자, 작성일자 정보 --%>
							<div class="d-flex pd-b5">
								<input type="hidden" value="${comment.cc_id}">
								<div class="flex1">
									<%-- 댓글 추천 버튼 --%>
									<c:if test="${not comment.isCc_deleted()}">
										<span class="wr-m">
											<small id="info" onclick="location.href='${infoUrl}/post?id=${comment.cc_wid}'">${comment.cc_nickName}</small>
											<button type="button" class="like-btn badge rounded-pill bg-info text-decoration-none" onclick="commentLike(this, ${comment.cc_id});">
												<i class="bi bi-chat-left-heart"></i> ${comment.cc_like}
											</button>
										</span>
									</c:if>
									<span class ="text-secondary text-opacity-75 font-w font-cor2"><small>${comment.cc_date}</small></span>
								</div>
								<%-- 댓글 삭제할 때 댓글을 작성한 사람인지 확인 필요 --%>
								<c:if test="${sessionScope.loginData.AC_ID eq comment.cc_wid}">
									<c:if test="${not comment.isCc_deleted()}">
										<div class="text-end">
											<button class="btn font-cor2 font875 text-secondary text-opacity-75 pd4-p" type="button" onclick="changeEdit(this);">수정</button>
											<span class="text-secondary text-opacity-75">|</span>
											<button class="btn font-cor2 font875 text-secondary text-opacity-75 pd4-p" type="button" onclick="commentDelete(this, ${comment.cc_id});">삭제</button>
										</div>
									</c:if>
								</c:if>
							</div>
							<div class="border_b1 border_b_s border_b_c"></div>
						</div>
						<%-- 댓글 내용 부분 --%>
						<div class="card-body c-b-margin">
							<c:choose>
								<c:when test="${comment.isCc_deleted()}">
									<p class="text-muted">삭제된 댓글입니다.</p>
								</c:when>
								<c:otherwise>
									<c:set var="newLine" value="<%= \"\n\" %>" />
									<p class="card-text">${fn:replace(comment.cc_content, newLine, '<br>')}</p>
								</c:otherwise>
							</c:choose>
							<%-- 대댓글 버튼 --%>
							<c:if test="${not comment.isCc_deleted() && sessionScope.loginData != null}">
								<button class="btn font-cor2 font1 text-secondary text-opacity-75 pd0" type="button" onclick="replyForm(this);">댓글쓰기</button>
							</c:if>
							<%-- 대댓글 접기/펼치기 버튼 --%>
							<c:if test="${comment.cc_parents == 0 && comment.cc_child > 0}">
								<button class="float-end btn font-cor2 font1 text-secondary text-opacity-75 pd0" 
										type="button" onclick="replyFolding(this, ${comment.cc_gid})">
									<i class="bi bi-arrow-down-circle"></i>
								</button>
							</c:if>
						</div>
						<%-- 대댓글 등록 칸 --%>
						<div id="reply" class="reply-form" style="display: none;">
							<form action="${communityURL}/comment/add" method="post">
								<input type="hidden" name="cb_bid" value="${boardData.cb_bid}">
								<input type="hidden" name="cc_id" value="${comment.cc_id}">
								<div class="input-group">
									<textarea class="form-control" name="cc_content" rows="2"></textarea>
									<button class="btn btn-outline-dark" type="button" onclick="formCheck(this.form);">등록</button>
								</div>
							</form>
						</div>
						
					</div>
				</div> 
			</div> <%-- id comment${comment_.cc_id} 끝 --%>
			</c:forEach>
			<%--댓글 등록 버튼 --%>
			<div class="mb-1">
				<%-- <c:if test="${sessionScope.loginData != null}"> --%>
				<form action="${communityURL}/comment/add" method="post">
					<%-- 등록될 댓글이 가질 게시판id 정보(안보이게 처리) --%>
					<input type="hidden" name="cb_bid" value="${boardData.cb_bid}">					
					<div class="input-group">
						<textarea class="form-control" name="cc_content" rows="2"></textarea>
						<button class="btn btn-outline-dark" type="button" onclick="formCheck(this.form);">등록</button>
					</div>
				</form>
				<%-- </c:if> --%>
			</div>
		</div>
		
		<!-- 댓글 페이지 처리 -->
		<nav>
			<div>
				<ul class="pagination pagination-sm justify-content-center">
					<c:url var="boardDetailUrl" value="/community/detail">
						<c:param name="cb_bid">${boardData.cb_bid}</c:param>
					</c:url>
					<c:if test="${commentPage.hasPrevPage()}">
						<li class="page-item"><a class="page-link"
							href="${boardDetailUrl}&page=${commentPage.prevPageNumber}">&laquo;</a></li>
					</c:if>
					<c:forEach
						items="${commentPage.getPageNumberList(commentPage.currentPageNumber - 2, commentPage.currentPageNumber + 2)}"
						var="num">
						<li
							class="page-item ${commentPage.currentPageNumber eq num ? 'active' : ''}">
							<a class="page-link" href="${boardDetailUrl}&page=${num}">${num}</a>
						</li>
					</c:forEach>
					<c:if test="${commentPage.hasNextPage()}">
						<li class="page-item"><a class="page-link"
							href="${boardDetailUrl}&page=${commentPage.nextPageNumber}">&raquo;</a></li>
					</c:if>
				</ul>
			</div>
		</nav>
		
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
						<button type="button" class="btn btn-sm btn-danger" data-bs-dismiss="modal" onclick="deleteBoard(${boardData.cb_bid})">확인</button>
					</div>
				</div>
			</div>
		</div>
	</section>
		
	
	<footer>
		<%@ include file="../module/footer.jsp"%>
	</footer>
	
	
<!-- ajax -->
<script type="text/javascript">

/* $(document).ready(function(){
	// var replyName = document.getElementByName(${comment})
	<c:forEach items="${commentPage.pageData}" var="comment">
		console.log("${comment.cc_id}");
	</c:forEach>
		
});  */

function replyFolding(element, gid) {
	<c:forEach items="${commentPage.pageData}" var="comment">
		if(${comment.cc_gid} == gid && ${comment.cc_sort} > 0){
			// var foldReply = document.getElementById("comment" + ${comment.cc_id});
			$("#comment${comment.cc_id}").slideToggle("fast");
		}
	</c:forEach>
	
	var iconClass = element.getElementsByTagName("i")[0].classList;
	
	if(iconClass.contains("bi-arrow-down-circle")){
		iconClass.remove("bi-arrow-down-circle");
		iconClass.add("bi-arrow-up-circle");
	}else{
		iconClass.remove("bi-arrow-up-circle");
		iconClass.add("bi-arrow-down-circle");
	}
}


// 대댓글 버튼
function replyForm(element) {
	
	var recomt = element.parentElement.nextElementSibling;
	
	if(recomt.style.display === "none") {
		recomt.style.display = "block";
	} else {
		recomt.style.display = "none";
	}
}


// 게시판 추천
function boardLike(element, id) {
	
	if("${sessionScope.loginData.AC_ID}" == ""){
		alert("로그인이 필요합니다.");
	}else{
		$.ajax({
			type: "post",
			url: "${communityURL}/like",
			data: {
				cb_bid: id
			},
			success: function(data) {
				if(data.code === "success") {
					if(data.isLiked === true){
						element.innerHTML = '<i class="bi bi-heart-fill"></i> ' + data.like;					
					}else{
						element.innerHTML = '<i class="bi bi-heart"></i> ' + data.like;
					}						
				} else if(data.code === "noData") {
					// 게시판 정보가 없기 떄문에 에러 발생 -> 게시판 목록으로
					alert(data.message);
					location.href = "${communityURL}/main";
				}
			}
		});
	}
	
		
	
}

//게시판 추천
function commentLike(element, id) {
	$.ajax({
		type: "post",
		url: "${communityURL}/comment/like",
		data: {
			cc_id: id
		},
		success: function(data) {
			if(data.code === "success") {
				element.innerHTML = '<i class="bi bi-chat-left-heart"></i> ' + data.like;				
			} else if(data.code === "noData") {
				alert(data.message);
				location.href = "${communityURL}/main";
			}
		}
	});
}

// 게시판 삭제
function deleteBoard(cb_bid) {
	$.ajax({
		url: "${communityURL}/delete", 
		type: "post",
		data: {
			cb_bid: cb_bid 
		},
		dataType: "json",
		success: function(data) {
			if(data.code === "success") {
				alert("삭제 완료");
				location.href = "${communityURL}/main"; // 삭제가 성공하면 목록 페이지로(/community)
			} else if(data.code === "permissionError") {
				alert("권한 오류 : 작성자가 아닙니다");
			} else if(data.code === "fail") {
				alert("삭제 실패")
			} 
		}
	});
}

// 댓글 추가 버튼 처리
function formCheck(form) {
	if("${sessionScope.loginData.AC_ID}" == ""){
		alert("로그인이 필요합니다.");
	}else{
		if(form.cc_content.value.trim() === "") {
			alert("댓글 내용을 입력하세요.");
		} else {
			form.submit();
		}
	}
}

let beforeContent; // 댓글 내용 백업 변수
// 페이지에서 수정된 댓글 내용을 받아온다
function changeEdit(element) {
	
	element.innerText = "확인";
	element.nextElementSibling.remove();
	element.nextElementSibling.remove();
	
	var line = document.createElement("span");
	line.innerText = " | ";
	line.setAttribute("class", "text-secondary text-opacity-75");
	element.parentElement.append(line);
	
	// 원래 댓글의 내용
	var cards = element.parentElement.parentElement.parentElement.nextElementSibling.children;
	var card0 = cards[0];
	var cardValue = card0.innerText;
	beforeContent = cardValue;
			
	var cancleBtn = document.createElement("button");
	cancleBtn.innerText = "취소";
	cancleBtn.setAttribute("class", "btn font-cor2 font875 text-secondary text-opacity-75 pd4-p");
	cancleBtn.setAttribute("type", "button");
	cancleBtn.setAttribute("onclick", "cancleUpdate(this)");
	element.parentElement.append(cancleBtn);
	
	var textarea = document.createElement("textarea");
	textarea.setAttribute("class", "form-control");
	textarea.value = cardValue;
	
	card0.innerText = "";
	card0.append(textarea);
	
	element.setAttribute("onclick", "commentUpdate(this);");
}

function cancleUpdate(element) {
	element.innerText = "수정";
	element.previousElementSibling.remove();
	element.previousElementSibling.remove();
	
	var cid = element.parentElement.parentElement.children[0].value;
	var value = element.parentElement.parentElement.parentElement.nextElementSibling.children[0].children[0].value = beforeContent;
	element.parentElement.parentElement.parentElement.nextElementSibling.children[0].children[0].remove();
	element.parentElement.parentElement.parentElement.nextElementSibling.children[0].innerText = value;
	
	
	var line = document.createElement("span");
	line.innerText = " | ";
	line.setAttribute("class", "text-secondary text-opacity-75");
	
	var btnDelete = document.createElement("button");
	btnDelete.innerText = "삭제";
	btnDelete.setAttribute("class", "btn font-cor2 font875 text-secondary text-opacity-75 pd4-p");
	btnDelete.setAttribute("onclick", "commentDelete(this, " + cid + ");");
	
	element.parentElement.append(line);
	element.parentElement.append(btnDelete);
	element.setAttribute("onclick", "changeEdit(this);");
	
}

// 댓글 수정 처리(DB)
function commentUpdate(element) {
	// changeEdit에서 받아온 내용을 컨트롤러에 전송(ajax)
	var cid = element.parentElement.parentElement.children[0].value;
	var value = element.parentElement.parentElement.parentElement.nextElementSibling.children[0].children[0].value;
			
	$.ajax({
		url: "${communityURL}/comment/modify",
		type: "post",
		data: {
			cc_id: cid,
			cc_content: value
		},
		success: function(data) {
			element.parentElement.parentElement.parentElement.nextElementSibling.children[0].children[0].value = data.value;
			changeText(element);
		}
	});
}
	
function changeText(element) {
	element.innerText = "수정";
	element.nextElementSibling.remove();
	element.nextElementSibling.remove();
	var cid = element.parentElement.parentElement.children[0].value;
	var value = element.parentElement.parentElement.parentElement.nextElementSibling.children[0].children[0].value;
	element.parentElement.parentElement.parentElement.nextElementSibling.children[0].children[0].remove();
	element.parentElement.parentElement.parentElement.nextElementSibling.children[0].innerText = value;
	
	var line = document.createElement("span");
	line.innerText = "|";
	line.setAttribute("class", "text-secondary text-opacity-75");
	
	var btnDelete = document.createElement("button");
	btnDelete.innerText = "삭제";
	btnDelete.setAttribute("class", "btn font-cor2 font875 text-secondary text-opacity-75 pd4-p");
	btnDelete.setAttribute("onclick", "commentDelete(this, " + cid + ");");
	
	element.parentElement.append(line);
	element.parentElement.append(btnDelete);
	element.setAttribute("onclick", "changeEdit(this);");
}		

function commentDelete(element, id) {
	$.ajax({
		url: "${communityURL}/comment/delete",
		type: "post",
		data: {
			cc_id: id
		},
		success: function(data) {
			if(data.code === "success") {
				alert(data.message);
				location.reload();
			}else if(data.code === "fail"){
				alert(data.message);
			}else if(data.code === "poermissionError"){
				alert(data.message);
			}
		}
	});
}		
	
</script>

</body>
</html>