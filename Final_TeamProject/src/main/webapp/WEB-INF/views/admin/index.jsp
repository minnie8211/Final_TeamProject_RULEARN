<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>메인 화면</title>
	<%@ include file="./module/head.jsp" %>
	<c:url var="slick" value="/static/slick" />
	<link rel="stylesheet" type="text/css" href="${slick}/slick.css"/>
	<link rel="stylesheet" type="text/css" href="${slick}/slick-theme.css"/>
	<script src="https://kit.fontawesome.com/2c1bc70929.js" crossorigin="anonymous"></script>
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
    </style>
	
</head>
<body>
	<header>
		<%@ include file="./module/navigation.jsp" %>
	</header>
	<div id="carouselExampleIndicators" class="carousel slide" data-bs-ride="true">
		<div class="carousel-indicators">
			<button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
			<button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1" aria-label="Slide 2"></button>
			<button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="2" aria-label="Slide 3"></button>
		</div>
		<div class="carousel-inner">
			<div class="carousel-item active img_back1">
				<img src="${img}/banner/main_banner01.png" class="d-block container" alt="">
			</div>
			<div class="carousel-item img_back2">
				<img src="${img}/banner/main_banner02.png" class="d-block container" alt="">
			</div>
			<div class="carousel-item img_back3">
				<img src="${img}/banner/main_banner03.png" class="d-block container" alt="">
			</div>
		</div>
		<button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
			<span class="carousel-control-prev-icon" aria-hidden="true"></span>
			<span class="visually-hidden">Previous</span>
		</button>
		<button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
			<span class="carousel-control-next-icon" aria-hidden="true"></span>
			<span class="visually-hidden">Next</span>
		</button>
	</div>
	
	<div class="container d-flex flex-wrap my-5 mx-auto">
		<div class="board_card ms-0">
			<div class="board_card_header">
				<div class="float-start board_title">커뮤니티</div>
				<div class="float-end mt-1"><a class="a_link" href="${mainUrl}community/main">+more</a></div>
			</div>
			<div class="board_card_body">
				<table class="board_table board_table_hover">
					<tbody>
						<c:if test="${not empty commBoardList}">
							<c:forEach items="${commBoardList}" var="commBoard">
								<c:url var="commBoardDetailUrl" value="/community/detail">
									<c:param name="cb_bid">${commBoard.cb_bid}</c:param>
								</c:url>
								<tr onclick="location.href='${commBoardDetailUrl}'">
									<td class="p-1 board_td_title">${commBoard.cb_title}&nbsp;&nbsp;[${commBoard.cb_commentNum}]</td>
									<td class="col-2 p-1 text-center">${commBoard.cb_nickName}</td>
									<td class="col-3 p-1 text-center">${commBoard.cb_date}</td>
								</tr>
							</c:forEach>
						</c:if>
					</tbody>
				</table>
			</div>
		</div>
		
		<div class="board_card ms-4">
			<div class="board_card_header">
				<div class="float-start board_title">스터디</div>
				<div class="float-end mt-1"><a class="a_link" href="${mainUrl}studyboard">+more</a></div>
			</div>
			<div class="board_card_body">
				<table class="board_table board_table_hover">
					<tbody>
						<c:if test="${not empty studyBoardList}">
							<c:forEach items="${studyBoardList}" var="studyBoard">
								<c:url var="studyBoardDetailUrl" value="/studyboard/detail">
									<c:param name="id">${studyBoard.sb_bId}</c:param>
								</c:url>
								<tr onclick="location.href='${studyBoardDetailUrl}'">
									<td class="p-1 board_td_title">${studyBoard.sb_title}&nbsp;&nbsp;[${studyBoard.total_reply > 0 ? studyBoard.total_reply : 0}]</td>
									<td class="col-2 p-1 text-center">${studyBoard.sb_wName}</td>
									<td class="col-3 p-1 text-center">${studyBoard.sb_date}</td>
								</tr>
							</c:forEach>
						</c:if>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	
	<div class="img_mid_back">
		<div class="container d-flex flex-wrap mx-auto">
			<img src="${img}/banner/middle_banner.png">
		</div>
	</div>
	
	<div class="container d-flex flex-wrap mt-4 mx-auto">
		<div class="title_text">인기강의</div>
			<div class="row mt-1 mb-5">
			<div class="autoplay autoplay_box">	
				<c:forEach items="${courseBoardList}" var="courseBoard">
					<c:url var="courseDetailUrl" value="/course/detail">
						<c:param name="id">${courseBoard.l_id}</c:param>
					</c:url>
					<fmt:formatNumber value="${courseBoard.l_price}" type="currency" var="price" currencySymbol="￦"/>
					<c:set var="avg" value="${courseBoard.avg}"/>
					<fmt:formatNumber var="avgFloor" value="${avg - (avg % 1)}" type="number"/>
					<fmt:formatNumber var="avgCeil" value="${avg + (1 - (avg % 1)) % 1}" type="number"/>
						<div class="col-12 col-md-6 col-sm-12 col-lg-4 mt-3" onclick="location.href='${courseDetailUrl}'">
							<div class="card" style="margin:0 10px">
								<img src="${courseBoard.l_thumbnail}" class="card-img-top" alt="강의 썸네일">
								<div class="card-body pb-0">
									<div class="card-title">
										<div class="fs-6 fw-bolder lh-base cardBox">
											${courseBoard.l_title}
										</div>
									</div>
									<div class="card-detail">
										<br>
										<p class="card-text fs-6 text-muted mt-2 mb-0">
											${courseBoard.l_wid}
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
											<small class="text-muted">(${courseBoard.amount})</small>
										</p>
										<p class="fw-bolder text-primary">${price}</p>
									</div>
								</div>
							</div>
						</div>
				</c:forEach>
			</div>
	    </div>
	</div>
	<footer>
		<%@ include file="./module/footer.jsp" %>
	</footer>
	<script type="text/javascript" src="${slick}/slick.min.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			$('.autoplay').slick({
				slidesToShow: 4,
				slidesToScroll: 1,
				autoplay: true,
				autoplaySpeed: 4000,
			});
		});
	</script>
</body>
</html>