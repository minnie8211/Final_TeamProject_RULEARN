<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>통합 검색</title>
	<%@ include file="../module/head.jsp" %>
	<link rel="stylesheet" type="text/css" href="${css}/search.css">
	<link rel="stylesheet" type="text/css" href="${css}/studyboard.css">
	<link rel="stylesheet" type="text/css" href="${css}/communityboard.css">
	<script src="https://kit.fontawesome.com/2c1bc70929.js" crossorigin="anonymous"></script>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.9.1/font/bootstrap-icons.css">
	<style>
        .bd-placeholder-img {
            font-size: 1.125rem;
            text-anchor: middle;
            -webkit-user-select: none;
            -moz-user-select: none;
            user-select: none;
        }

        @media (min-width: 768px) {
            .bd-placeholder-img-lg {
                font-size: 3.5rem;
            }
        }

        .card-title {
            height: 3rem;
        }

        .cardBox {
            height: 50px;
            overflow: hidden;
            overflow-wrap: break-all;
        }
        .lessons{
        	min-height: 700px;
        }
        .foundNothing{
        	max-width: 785px;
        }
    </style>

</head>
<body>
	<header>
		<%@ include file="../module/navigation.jsp" %>
	</header>
	<c:url var="searchUrl" value="/allsearch" />
	<div class="banner_search">
		<div class="container">
			통합 검색
		</div>
	</div>
		<section class="container mt-4 m-height" >
			<div class="text-center contents">
				"${search}" 검색 결과입니다.
			</div>
			<div class="board_CAT">
				커뮤니티
			</div>
			<table class="table table-hover bor-col mt-4 mb-3 contents">
				 <colgroup>
				    <col width="140 style=""/>
				    <col width="" style="" />
				    <col width="200" style="" />
				    <col width="200" style="" />
				    <col width="85" style="" />
				  </colgroup>
				<thead>
				</thead>
				<tbody>
					<c:if test="${not empty commSearch}">
						<c:forEach items="${commSearch}" var="commData">
							<c:url var="commBoardDetailUrl" value="/community/detail">
								<c:param name="cb_bid">${commData.cb_bid}</c:param>
							</c:url>
							<tr onclick="location.href='${commBoardDetailUrl}'">
								<c:if test="${commData.cb_catid eq 1}">
									<td class="txt-center"><span class="comm-cat-qa">Q&A</span></td>
								</c:if>
								<c:if test="${commData.cb_catid eq 2}">
									<td class="txt-center"><span class="comm-cat-forum">고민/자유</span></td>
								</c:if>
								<c:if test="${commData.cb_catid eq 3}">
									<td class="txt-center"><span class="comm-cat-tip">노하우/팁</span></td>
								</c:if>
								<td>${commData.cb_title}&nbsp;&nbsp;[${commData.cb_commentNum}]</td>
								<td>${commData.cb_nickName}</td>
								<td>${commData.cb_date}</td>
								<td class="txt-center">♥&nbsp;${commData.cb_like}</td>
							</tr>
						</c:forEach>
					</c:if>
					<c:if test="${empty commSearch}">
						<td colspan="5" class="none-border">
							<div class="txt-center pd100">"${search}" 검색된 내용이 없습니다.</div>
						</td>
					</c:if>
				</tbody>
			</table>
			<c:url var="commSearchlUrl" value="/community/main" />
			<c:if test="${not empty commSearch}">
				<a href="${commSearchlUrl}?search=${search}" class="a_box_style mt-0">
					+ 검색 결과 더보기
				</a>
			</c:if>
			<div class="board_CAT">
				스터디
			</div>
			<table class="table table-hover bor-col mt-4 mb-3 contents">
				 <colgroup>
				    <col width="120" style=""/>
				    <col width="" style="" />
				    <col width="200" style="" />
				    <col width="200" style="" />
				    <col width="85" style="" />
				  </colgroup>
				<thead>
				</thead>
				<tbody>
					<c:if test="${not empty studySearch}">
						<c:forEach items="${studySearch}" var="studyData">
							<c:url var="studyBoardDetailUrl" value="/studyboard/detail">
								<c:param name="id">${studyData.sb_bId}</c:param>
							</c:url>
							<tr onclick="location.href='${studyBoardDetailUrl}'">
								<c:choose>
									<c:when test="${studyData.sb_isDone == 'true' }">
										<td class="txt-center"><span class="done-y-style nowrp">모집완료</span></td>
									</c:when>
									<c:otherwise>
										<td class="txt-center"><span class="done-f-style nowrp">모집중</span></td>
									</c:otherwise>
								</c:choose>
								<c:choose>
									<c:when test="${studyData.sb_catId == 4 }">
										<td style="cursor : pointer;"><b>[스터디]</b> ${studyData.sb_title}&nbsp;&nbsp;[${studyData.total_reply > 0 ? studyData.total_reply : 0}]</td>
									</c:when>
									<c:when test="${studyData.sb_catId == 5 }">
										<td style="cursor : pointer;"><b>[프로젝트]</b> ${studyData.sb_title}&nbsp;&nbsp;[${studyData.total_reply > 0 ? studyData.total_reply : 0}]</td>
									</c:when>
								</c:choose>
								<td>${studyData.sb_wName}</td>
								<td>${studyData.sb_date}</td>
								<td class="txt-center">♥&nbsp;${studyData.sb_like}</td>
							</tr>
						</c:forEach>
					</c:if>
					<c:if test="${empty studySearch}">
						<td colspan="5" class="none-border no-hover">
							<div class="txt-center pd100">"${search}" 검색된 내용이 없습니다.</div>
						</td>
					</c:if>
				</tbody>
			</table>
			<c:url var="studySearchlUrl" value="/studyboard" />
			<c:if test="${not empty studySearch}">
				<a href="${studySearchlUrl}?search=${search}" class="a_box_style mt-0">
					+ 검색 결과 더보기
				</a>
			</c:if>
			<div class="board_CAT">
				강의
			</div>
			<c:if test="${not empty courseSearch}">
				<div class="container-fluid contents">
					<div class="row mt-4 mb-4">
						<c:forEach items="${courseSearch}" var="courseData">
							<c:url var="courseDetailUrl" value="/course/detail">
								<c:param name="id">${courseData.l_id}</c:param>
							</c:url>
							<fmt:formatNumber value="${courseData.l_price}" type="currency" 
                    				  		  var="price" currencySymbol="￦"/>
							<c:set var="avg" value="${courseData.avg}"/>
							<fmt:formatNumber var="avgFloor" value="${avg - (avg % 1)}" type="number"/>
							<fmt:formatNumber var="avgCeil" value="${avg + (1 - (avg % 1)) % 1}" type="number"/>
                        
							<div class="col-12 col-md-6 col-sm-12 col-lg-4 mt-3" onclick="location.href='${courseDetailUrl}'">
	                            <div class="card" style="width: 100%;">
									<img src="${courseData.l_thumbnail}" class="card-img-top" alt="강의 썸네일">
									<div class="card-body pb-0">
										<div class="card-title">
											<div class="fs-6 fw-bolder lh-base cardBox">
												${courseData.l_title}
											</div>
										</div>
										<div class="card-detail">
											<br>
											<p class="card-text fs-6 text-muted mt-2 mb-0">
												${courseData.l_wid}
											</p>
											<p class="mb-0 text-warning">
												<!-- 리뷰 평균 별점 표기 -->
												<c:choose>
													<c:when test="${avg != 0.0}">
														<c:forEach begin="1" end="${avgFloor}">
															<i class="fa-solid fa-star"></i>
							                            </c:forEach>
														<c:if test="${avgCeil != avgFloor}">
															<i class="fa-solid fa-star-half-stroke"></i>
														</c:if>
														<c:forEach begin="1" end="${5 - avgCeil}">
															<i class="fa-regular fa-star"></i>
														</c:forEach>
													</c:when>
													<c:otherwise>
														<c:forEach begin="1" end="5">
															<i class="fa-regular fa-star"></i>
														</c:forEach>
													</c:otherwise>
												</c:choose>
												<small class="text-muted">(${courseData.amount})</small>
											</p>
											<p class="fw-bolder text-primary">${price}</p>
										</div>
									</div>
								</div>
							</div>
						</c:forEach>
					</div>
				</div>
			</c:if>
			<c:if test="${empty courseSearch}">
				<div class="txt-center pd100 mt-5 search_box contents">
					"${search}" 검색된 내용이 없습니다.
				</div>	                
			</c:if>
			<c:url var="courseSearchlUrl" value="/course" />
			<c:if test="${not empty courseSearch}">
				<a href="${courseSearchlUrl}?lessonSearch=${search}" class="a_box_style mt-0">
					+ 검색 결과 더보기
				</a>
			</c:if>
		</section>
	<footer>
		<%@ include file="../module/footer.jsp" %>
	</footer>
	<script type="text/javascript">
		var search = "${search}";
		$(".contents:contains('"+search+"')").each(function() {
			var regex = new RegExp(search, 'gi');
			$(this).html($(this).html().replace(regex, "<span style='color:red;'>"+search+"</span>"));
		});
	</script>
</body>
</html>