<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="generator" content="Hugo 0.88.1">
<c:url var="css" value="/static/css" />
<c:url var="bs5" value="/static/bs5" />
<c:url var="jQuery" value="/static/js" />
<c:url var="img" value="/static/img" />
<link rel="stylesheet" type="text/css" href="${css}/default.css">
<link rel="stylesheet" type="text/css" href="${css}/navigation.css">
<link rel="stylesheet" type="text/css" href="${css}/footer.css">
<link rel="stylesheet" type="text/css" href="${bs5}/css/bootstrap.css">
<script type="text/javascript" src="${jQuery}/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.9.1/font/bootstrap-icons.css">
<script src="https://kit.fontawesome.com/2c1bc70929.js" crossorigin="anonymous"></script>

<title>${lessonData.l_title}</title>


<style>
	.bd-placeholder-img {
		font-size: 1.125rem;
		text-anchor: middle;
		-webkit-user-select: none;
		-moz-user-select: none;
		user-select: none;
	}
	
	@media ( min-width : 768px) {
		.bd-placeholder-img-lg {
			font-size: 3.5rem;
		}
	}
	
	.bannerImg {
		width: 100%;
		height: 100%;
	}
	
	.card-name {
		height: 5rem;
	}
	
	.btn-sale {
		width: 100%;
	}
	
	.active {
		border-bottom: solid 2px black;
		font-weight: 900;
	}
	
	.shadow-bottom {
		box-shadow: 0 5px 15px -10px;
	}
	
	.shadow-top {
		box-shadow: 0 -5px 15px -10px;
	}
	
	.fs-0 {
		font-size: 60px;
	}
	
	.sticky-bottom {
		position: -webkit-sticky;
		position: sticky;
		top: 0;
		background-color: white;
	}
	
	.accordion-button { -
		-bs-accordion-active-color: black;
	}
	
	.addReviewContent {
		width: 95%;
	}
	
	.addReviewContent:focus {
		outline: none;
	}
	
	.modify:hover, .delete:hover {
		cursor: pointer;
		color: #93c54b;
	}
	.LessonName{
		vertical-align: middle;
	}
	.bi{
		vertical-align: bottom;
	}
	.accordion-button:not(.collapsed) {
		color: black;
	}
</style>

</head>

<body>
	<c:url var="wishlistUrl" value="/mypage/wishlist"/>
	<c:url var="courseUrl" value="/course" />
	
	<header>
		<%@ include file="../module/navigation.jsp"%>
	</header>
	<main>
		<!-- 큰 강의 소개 이미지 -->
		<div class="container-fluid bg-dark">
			<div class="container">
				<div class="row p-5 mx-auto">
					<!-- 강의 이미지 -->
					<div class="col-12 col-md-9 col-lg-5 p-2 d-flex flex-column justify-content-center">
						<div class="ratio ratio-4x3 align-self-center">
						<img class="rounded bannerImg" src="${lessonData.l_thumbnail}"
							alt="강의 썸네일">
						</div>
					</div>
					<!-- 강의 배너 -->
					<div class="col-12 col-md-9 col-lg-7 mt-4">
						<nav class="text-dark" style="-bs-breadcrumb-divider: '&gt;';"
							aria-label="breadcrumb">
							<ol class="breadcrumb">
								<li class="breadcrumb-item"><a href="/home/course">Course</a></li>
								<li class="breadcrumb-item" aria-current="page">${lessonData.l_lesson_category}</li>
							</ol>
						</nav>
						<div class="card-body mt-3 text-light">
							<div class="card-title card-name">
								<div class="fs-4 fw-bolder lh-base cardBox">${lessonData.l_title}
								</div>
							</div>
							<div class="card-detail">
								<br>
								<p class="card-text fs-6 mt-2">${lessonData.l_wid}</p>
								<p class="text-success">
	
									<c:set var="avg" value="${reviewStatics.AVG}" />
									<fmt:formatNumber var="avgFloor" value="${avg - (avg % 1)}"
										type="number" />
									<fmt:formatNumber var="avgCeil"
										value="${avg + (1 - (avg % 1)) % 1}" type="number" />
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
									(${reviewStatics.AVG})
								</p>
								<p class="text-muted">${reviewStatics.AMOUNT}개의수강평</p>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

		<!-- 강의 소개 -->
		<section>
			<!-- 강의 nav -->
			<div class="border-bottom my-2 ps-3 pt-1 sticky-top bg-white shadow-bottom">
				<div class="container">
					<nav class="nav nav-course">
						<c:url var="courseQnAUrl" value="/course/detail/QnA">
							<c:param name="id">${lessonData.l_id}</c:param>
						</c:url>
						<a class="description nav-link text-dark active"
						   href="#description">강의소개</a>
						<a class="curriculum nav-link text-dark" 
						   href="#curriculum">컬리큘럼</a>
						<a class="review nav-link text-dark" 
						   href="#review">수강평(${reviewStatics.AMOUNT})</a>
						<a class="QnA nav-link text-dark" href="${courseQnAUrl}#QnA">QnA</a>
					</nav>
				</div>
			</div>
			<div class="container">
				<div class="row">
					<!-- 강의 설명 -->
					<div class="col-md-12 col-lg-8 pt-3 px-4">
						<!-- 강의소개 -->
						<section class="courseDescription mb-5" id="description">
							<p class="fs-4 fw-bold">강의 소개</p>
							<c:set var="newLine" value="<%=\"\n\" %>"></c:set>
							<p>${fn:replace(lessonData.l_content, newLine, '<br>')}</p>
						</section>
						<!-- 커리큘럼 -->
						<section class="courseDescription mb-5" id="curriculum">
							<p class="fs-4 fw-bold">컬리큘럼</p>
							<div class="accordion" id="accordionPanelsStayOpenExample">
								<c:forEach items="${bigTitle}" var="title" varStatus="num">
									<div class="accordion-item">
										<h2 class="accordion-header" id="panelsStayOpen-headingOne">
											<button class="accordion-button bg-light collapsed" 
													type="button" style="font-size: 17px;"
													data-bs-toggle="collapse" aria-expanded="true" 
													data-bs-target="#panelsStayOpen-collapseOne${num.count}"
													aria-controls="panelsStayOpen-collapseOne">강의
												${num.count}.${title.cur_big_title}</button>
										</h2>
										<c:forEach items="${curriData}" var="curri">
											<c:if test="${curri.cur_small_chapid eq title.cur_big_chapid}">
												<div id="panelsStayOpen-collapseOne${num.count}"
													 class="accordion-collapse collapse"
													 aria-labelledby="panelsStayOpen-headingOne">
													<div class="accordion-body border-bottom fw-light">
														<c:choose>
															<c:when test="${curri.cur_small_type eq 'VIDEO'}">
																<i class="bi bi-play-btn-fill me-2"></i>
															</c:when>
															<c:otherwise>
																<i class="bi bi-file-earmark-text me-2"></i>
															</c:otherwise>
														</c:choose>
														<span class="d-inline-block text-truncate LessonName"
															style="max-width: 400px;">
															${curri.cur_small_title} </span> 
														<span class="float-end">${curri.cur_small_running_time}</span>
													</div>
												</div>
											</c:if>
										</c:forEach>
									</div>
								</c:forEach>
							</div>
						</section>
						<!-- 수강평 -->
						<section class="courseDescription mb-5" id="review">
							<p class="fs-4 fw-bold">수강평</p>
							<c:choose>
							<c:when test="${reviewStatics.AMOUNT > 0}">
								<!-- 리뷰 별점 평균 통계 -->
								<div class="row px-0 justify-content-center">
									<div class="col-md-3 bg-light rounded mx-1 text-center mb-1">
										<h1 class="fw-bold fs-0 mt-4 mb-0">${reviewStatics.AVG}</h1>
										<p class="text-warning fs-5 mb-0">
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
										</p>
										<p class="text-muted small">${reviewStatics.AMOUNT}개의수강평</p>
									</div>
									<div class="col-md-8 bg-light rounded mx-1 ps-0 mb-1">
										<div class="container mt-4">
											<div class="row">
												<div class="col-2 ps-0">
													<div class="text-end">5점</div>
													<div class="text-end">4점</div>
													<div class="text-end">3점</div>
													<div class="text-end">2점</div>
													<div class="text-end">1점</div>
												</div>
												<!-- 리뷰 갯수 progress bar -->
												<div class="col-9 ps-0">
													<div class="progress mb-2">
														<div class="progress-bar bg-secondary" role="progressbar"
															style="width: ${reviewStatics.scorePercent[4]}%;"
															aria-valuenow="${reviewStatics.scorePercent[4]}"
															aria-valuemin="0" aria-valuemax="100"></div>
													</div>
													<div class="progress mb-2">
														<div class="progress-bar bg-secondary" role="progressbar"
															style="width: ${reviewStatics.scorePercent[3]}%;"
															aria-valuenow="${reviewStatics.scorePercent[3]}"
															aria-valuemin="0" aria-valuemax="100"></div>
													</div>
													<div class="progress mb-2">
														<div class="progress-bar bg-secondary" role="progressbar"
															style="width: ${reviewStatics.scorePercent[2]}%;"
															aria-valuenow="${reviewStatics.scorePercent[2]}"
															aria-valuemin="0" aria-valuemax="100"></div>
													</div>
													<div class="progress mb-2">
														<div class="progress-bar bg-secondary" role="progressbar"
															style="width: ${reviewStatics.scorePercent[1]}%;"
															aria-valuenow="${reviewStatics.scorePercent[1]}"
															aria-valuemin="0" aria-valuemax="100"></div>
													</div>
													<div class="progress mb-2">
														<div class="progress-bar bg-secondary" role="progressbar"
															style="width: ${reviewStatics.scorePercent[0]}%;"
															aria-valuenow="${reviewStatics.scorePercent[0]}"
															aria-valuemin="0" aria-valuemax="0"></div>
													</div>
												</div>
												<!-- 리뷰 갯수 -->
												<div class="reviewCount col-1 px-0">
													<div>${reviewStatics.score[4]}</div>
													<div>${reviewStatics.score[3]}</div>
													<div>${reviewStatics.score[2]}</div>
													<div>${reviewStatics.score[1]}</div>
													<div>${reviewStatics.score[0]}</div>
												</div>
											</div>
										</div>
									</div>
								</div>

								<!-- review 게시판 nav -->
								<c:url var="courseDetailUrl" value="/course/detail">
									<c:param name="id">${lessonData.l_id}</c:param>
								</c:url>
								<div class="border-secondary border-bottom my-2 bg-white">
									<nav class="nav review-sort">
										<a class="nav-link text-dark ${sort == 'latest'? 'active' : ''}"
											id="latest" href="${courseDetailUrl}&sort=latest#review">
											최신순</a> 
										<a class="nav-link text-dark ${sort == 'highScore'? 'active' : ''}"
											id="highScore" href="${courseDetailUrl}&sort=highScore#review"> 
											별점 높은 순</a>
										<a class="nav-link text-dark ${sort == 'lowScore'? 'active' : ''}"
											id="lowScore" href="${courseDetailUrl}&sort=lowScore#review">
											별점 낮은 순</a>
									</nav>
								</div>
								<!-- review 게시판 글 -->
					                
								<div class="realReview">
									<c:forEach items="${reviewData}" var="review"
										varStatus="modalNum">
										<div>
											<!-- 리뷰 작성자 -->
											<div class="row py-1">
												<input type="hidden" value="${review.rb_id}"> 
												<input type="hidden" value="${review.rb_wid}">
												<div class="col-1">
													<img alt="user-image" class="rounded-circle"
														src="https://t4.ftcdn.net/jpg/03/73/50/09/360_F_373500999_wAWkzJZRb2XHm9KeHEDcCJBkx4wR67us.jpg"
														style="width: 50px; height: 50px;">
												</div>
												<div class="col-3 flex-fill pt-1">
													<div class="nickname">${review.rb_wid}</div>
													<div class="text-warning">
														<c:forEach begin="1" end="5" var="i">
															<c:choose>
																<c:when test="${review.rb_score >= i}">
																	<i class="fa-solid fa-star"></i>
																</c:when>
																<c:otherwise>
																	<i class="fa-regular fa-star"></i>
																</c:otherwise>
															</c:choose>
														</c:forEach>
													</div>
													<br>
												</div>
											</div>
											<!-- 리뷰 내용 -->
											<div class="review-content ps-4 ms-4 mb-2 me-2">
												<c:set var="newLine" value="<%=\"\n\" %>"></c:set>
												${fn:replace(review.rb_content, newLine, '<br>')}
											</div>
											<br>
											<!-- 수정 및 삭제 버튼 -->
											<div class="hstack gap-3 ps-4 pe-4">
												<fmt:formatDate value="${review.rb_date}" var="createDate"
													dateStyle="short" pattern="yy-MM-dd" />
												<div class="ps-4 text-muted">${createDate}</div>
												<c:if test="${review.rb_wid eq sessionScope.loginData.AC_ID}">
													<input type="hidden" value="${review.rb_id}">
													<span class="ms-auto modify" data-bs-toggle="modal" 
														  data-bs-target="#reviewModal" >수정</span>
													<div class="vr"></div>
													<span class="ms-1 delete" data-bs-toggle="modal"
														data-bs-target="#Modal${modalNum.count}Toggle">삭제</span>

													<!-- 리뷰 삭제 Modal -->
													<div class="modal fade" id="Modal${modalNum.count}Toggle"
														aria-hidden="true"
														aria-labelledby="Modal${modalNum.count}ToggleLabel"
														tabindex="-1">
														<div class="modal-dialog modal-dialog-centered">
															<div class="modal-content">
																<div class="modal-header">
																	<h5 class="modal-title"
																		id="Modal${modalNum.count}ToggleLabel">삭제하기</h5>
																	<button type="button" class="btn-close"
																		data-bs-dismiss="modal" aria-label="Close"></button>
																</div>
																<div class="modal-body">강의에 대한 리뷰를 삭제하시겠습니까?</div>
																<div class="modal-footer">
																	<input type="hidden" value="${review.rb_id}"> 
																	<button type="button" class="btn btn-secondary"
																		data-bs-dismiss="modal">취소</button>
																	<button class="btn btn-primary" data-bs-toggle="modal"
																		data-bs-target="#Modal${modalNum.count}Toggle2"
																		onclick="commentDelete(this, 'Modal${modalNum.count}Toggle2');">
																		확인</button>
																</div>
															</div>
														</div>
													</div>
													<div class="modal fade" id="Modal${modalNum.count}Toggle2"
														aria-hidden="true"
														aria-labelledby="Modal${modalNum.count}ToggleLabel2"
														tabindex="-1">
														<div class="modal-dialog modal-dialog-centered">
															<div class="modal-content">
																<div class="modal-header">
																	<h5 class="modal-title"
																		id="Modal${modalNum.count}ToggleLabel2">삭제 확인</h5>
																	<button type="button" class="btn-close"
																		data-bs-dismiss="modal" aria-label="Close"></button>
																</div>
																<div class="modal-body"></div>
																<div class="modal-footer">
																	<button class="check-btn btn btn-primary"
																		data-bs-toggle="modal">확인</button>
																</div>
															</div>
														</div>
													</div>
												</c:if>
											</div>
											<hr>
										</div>
									</c:forEach>
								</div>
							</c:when>
							<c:otherwise>
								<div class="bg-light text-center mx-auto my-4 py-4 rounded">
									<div class="fs-1">✍</div>
									<br>
									<div class="fs-5">모두에게 도움이 되는 수강평의 주인공이 되어주세요!</div>
								</div>
							</c:otherwise>
							</c:choose>
						</section>
					</div>

					<!-- sale 정보/ md 이상일 때 show -->
					<fmt:formatNumber value="${lessonData.l_price}" var="price"/>
					<div class="col-lg-4 p-4">
						<div class="position-sticky d-none d-lg-block" style="top: 2rem;">
							<div class="p-4 mb-3 bg-light rounded">
								<p class="small mt-2 mb-0">${lessonData.l_wid}</p>
								<p class="fs-5 fw-bolder">${lessonData.l_title}</p>
								<br>
								<br>
								<c:if test="${!historyExist}">
									<fmt:formatNumber var="installmentPrice" type="number" 
													  value="${lessonData.l_price / 5}" />
									<c:choose>
										<c:when test="${lessonData.l_price >= 70000}">
											<p class="small fw-bold text-primary m-0">￦${price}</p>
											<p class="fs-5 fw-bolder text-warning m-0">월 ${installmentPrice}원</p>
											<p class="small text-muted mt-0">5개월 할부시</p>
										</c:when>
										<c:otherwise>
											<p class="fs-5 fw-bolder text-warning ps-1">${price}원</p>
										</c:otherwise>
									</c:choose>
									<%-- <p class="small fw-bold text-primary m-0">${price}</p>
									<p class="fs-5 fw-bolder text-warning m-0">월 19,360원</p>
									<p class="small text-muted mt-0">5개월 할부시</p> --%>
								</c:if>
								<div>
									<c:choose>
										<c:when test="${!historyExist and !isExistInCart}">
											<button class="btn btn-success d-block btn-sale mb-1" 
													id="goToCart" type="button">
												수강신청 하기</button>
											<button class="btn btn-outline-success btn-sale d-block"
													id="addCart" type="button">장바구니에 담기</button>
										</c:when>
										<c:when test="${!historyExist and isExistInCart}">
											<button class="btn btn-success d-block btn-sale mb-1" type="button" 
													onclick="location.href='${wishlistUrl}/${sessionScope.loginData.AC_ID}'">
												장바구니로 이동</button>
										</c:when>
										<c:otherwise>
											<button class="btn btn-success d-block btn-sale mb-1"
												type="button">이어 학습하기</button>
											<c:if test="${!hasReviewHistory}">
												<button class="btn btn-outline-success btn-sale d-block"
													type="button" data-bs-toggle="modal"
													data-bs-target="#reviewModal">수강평 작성하기</button>
											</c:if>
										</c:otherwise>
									</c:choose>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- sale 정보/ md 이하일 때 show -->
			<div class="col-md-12 d-lg-none py-2 shadow-top sticky-bottom">
				<div class="container-fluid">
					<div class="row btn-sale justify-content-center">
						<c:choose>
							<c:when test="${!historyExist and !isExistInCart}">
								<div class="col-2 align-self-center">
									<p class="fw-bold text-black text-center m-0">${price}</p>
								</div>
								<div class="col-5 p-1">
									<button class="btn btn-success btn-sale" type="button" id="goToCart">
										수강신청 하기</button>
								</div>
								<div class="col-5 p-1">
									<button class="btn btn-outline-success btn-sale" id="addCart" type="button">
										장바구니에	담기</button>
								</div>
							</c:when>
							<c:when test="${!historyExist and isExistInCart}">
								<div class="col-5 p-1">
									<button class="btn btn-outline-success btn-sale" type="button"
											onclick="location.href='${wishlistUrl}/${sessionScope.loginData.AC_ID}'">
										장바구니로 이동</button>
								</div>
							</c:when>
							<c:otherwise>
								<div class="col-5 p-1">
									<button class="btn btn-success btn-sale" type="button">
										이어 학습하기</button>
								</div>
								<div class="col-5 p-1">
									<button class="btn btn-outline-success btn-sale" type="button"
										data-bs-toggle="modal" data-bs-target="#reviewModal">
											수강평 작성하기</button>
								</div>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
			</div>
			
			<!-- 수강평 작성 Modal -->
			<div class="modal fade" id="reviewModal" tabindex="-1"
				aria-labelledby="reviewModalLabel" aria-hidden="true">
				<div
					class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
					<div class="modal-content text-center">
						<div class="modal-header border-0">
							<button type="button" class="btn-close d-block float-end"
								data-bs-dismiss="modal" aria-label="Close"></button>
						</div>
						<h5 class="modal-title fw-bold" id="reviewModalLabel">
							수강 후기가 궁금해요!</h5>
						<div class="addReviewScore fs-2">
							<i class="fa-solid fa-star text-muted" id="1"></i> 
							<i class="fa-solid fa-star text-muted" id="2"></i> 
							<i class="fa-solid fa-star text-muted" id="3"></i> 
							<i class="fa-solid fa-star text-muted" id="4"></i> 
							<i class="fa-solid fa-star text-muted" id="5"></i>
						</div>

						<div class="modal-body">
							<form action="${courseUrl}/detail/review/add" method="post">
								<input type="hidden" name="rb_id" value="">
								<input type="hidden" name="rb_lid" value="${lessonData.l_id}">
								<input type="hidden" name="rb_score" value="">
								<input type="hidden" name="rb_wid"
									value="${sessionScope.loginData.AC_ID}"> 
								<textarea name="rb_content" rows="10"
									class="addReviewContent border rounded m-2 p-3"
									placeholder="강의의 리뷰는 강의자에게 강의 피드백으로, 예비 학습자에게는 큰 정보가 되어 날아간답니다.🍀"></textarea>
								<div class="modal-footer border-0">
									<button type="button" class="btn btn-secondary"
										data-bs-dismiss="modal">취소하기</button>
									<button type="button" class="btn btn-primary"
										onclick="formCheck(this.form);">작성하기</button>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</section>

	</main>
	<footer>
		<%@ include file="../module/footer.jsp"%>
	</footer>

	<!-- 강의 소개 navbar 스크롤 -->
	<script>
        const sections = document.querySelectorAll('section.courseDescription');
        const navLi = document.querySelectorAll('nav.nav-course a');

        window.addEventListener("scroll", () => {
            var current = "";
            sections.forEach((section) => {
                const sectionTop = section.offsetTop; //4
                const sectionHeight = section.clientHeight; //42
                if (pageYOffset >= sectionTop - sectionHeight / 2) {
                    current = section.getAttribute("id");
                }
            });

            navLi.forEach((a) => {
                a.classList.remove("active");
                if (a.classList.contains(current)) {
                    a.classList.add("active");
                }
            });
        });

    </script>
	<!-- 리뷰 별점 클릭 이벤트 -->
	<script>
        const starDiv = document.querySelector('.addReviewScore');
        const stars = document.querySelectorAll('div.addReviewScore i');

        starDiv.addEventListener('click', e => {
            let id = e.target.getAttribute('id');
            console.log(id);
            stars.forEach(i => {
                if (i.getAttribute('id') <= id) {
                    i.classList.remove("text-muted");
                    i.classList.add("text-warning");
                } else {
                    i.classList.remove("text-warning");
                    i.classList.add("text-muted");
                }
            });
        });
    </script>
	<!-- 리뷰 수정 -->
	<script>
		const modifyBtn = document.querySelector('span.modify');
		modifyBtn.addEventListener('click', ()=>{
			const reviewBox = modifyBtn.parentElement.parentElement;
			const reviewScoreBox = reviewBox.children[0].children[3];
			
			//리뷰 별점
			const reviewScore = reviewScoreBox.querySelectorAll('i.fa-solid').length;
			//리뷰 내용
			const reviewContent = reviewBox.children[1].innerText;
			
			//별점 복붙하기
			const stars = document.querySelectorAll('div.addReviewScore i');
			let num = 1;
			stars.forEach(i => {
				if(num <= reviewScore){
					i.classList.remove("text-muted");
					i.classList.add("text-warning");
				}
				num++;
	         });
			
			//리뷰 내용 복붙하기
			const textarea = document.querySelector('textarea.addReviewContent');
			textarea.innerText = reviewContent;
			
			//모달 안내 문구 바꾸기
			document.querySelector('h5#reviewModalLabel').innerText = '수강평을 수정해 주세요.';
			
			//form action주소 변경
			const form = textarea.parentElement;
			form.action = '${courseUrl}/detail/review/modify';
			
			//리뷰 id 넣어주기
			form.children[0].value = modifyBtn.previousElementSibling.value;
		});
	
    </script>
	<!-- 리뷰 삭제 -->
	<script>
	    function commentDelete(element, modalName) {
	        const id = element.parentElement.children[0].value;
	        const modal = document.getElementById(modalName);
	        const checkMessage = modal.children[0].children[0].children[1];
	        const boss = element.parentElement.parentElement.parentElement.
							parentElement.parentElement.parentElement;
	     	$.ajax({
	            url: "${courseUrl}/review/delete",
	            type: "post",
	            data: {
	            	rb_id: id,
	            },
	            success: function (data) {
	                if (data.type === "success") {
	                	checkMessage.innerText = data.message;
	                    boss.remove();
	                }else if(data.type === "fail"){
	                	checkMessage.innerText = data.message;
	                }else{ //notExist
	                	checkMessage.innerText = data.message;
	                }
	            }
	        });
	    }
    </script>
	<!-- 리뷰 등록 -->
	<script>
	    function formCheck(form) {
	        if (form.rb_content.value.trim() === "") {
	            alert("리뷰 내용을 입력하세요.");
	        } else if(document.querySelectorAll('.addReviewScore .text-muted').length === 5){
	        	alert("별점은 최소 1개 이상이어야 합니다.");
	        }else{
	        	const score = document.querySelectorAll('.addReviewScore .text-warning');
	            form.rb_score.value = score.length;
	            if(form.rb_id.value.trim() === ""){
	            	form.rb_id.value = 0;
	            }
	            form.submit();
	        }
	    }
    </script>
    <!-- 장바구니 추가 버튼 -->
    <script>
   		var addCartBtn = document.querySelector('button#addCart');
	    addCartBtn.addEventListener('click', ()=>{
	    	let login = checkLogin();

	    	if(login){
	    		$.ajax({
					url: "${wishlistUrl}/add",
					type: "post",
					dataType: "JSON",
					data: {
						l_id: ${lessonData.l_id}
					},
					success: function(data){
						if(data.result === 'goToCart'){
							location.href = "${wishlistUrl}/${sessionScope.loginData.AC_ID}";
						}else {
							alert(data.msg);
							location.reload();
						}
					},
					error: function(data){
						alert("error");
					}
				});
	    	}
	    	
	    });
	    
	    var goToCartBtn = document.querySelector('button#goToCart');
	    goToCartBtn.addEventListener('click', ()=>{
	    	let login = checkLogin();
	    	
	    	if(login){
		    	$.ajax({
					url: "${wishlistUrl}/add?direct=3",
					type: "post",
					dataType: "JSON",
					data: {
						l_id: ${lessonData.l_id}
					},
					success: function(data){
						if(data.result === 'goToCart'){
							location.href = "${wishlistUrl}/${sessionScope.loginData.AC_ID}";
						}else {
							alert(data.msg);
						}
					},
					error: function(data){
						alert("error");
					}
				});
	    	}
	    });
		
	    function checkLogin(){
	    	var loginData = "";
	    	loginData += "${sessionScope.loginData.AC_ID}";
	    	
	    	if(loginData.trim() === ""){
	    		alert("로그인해 주세요.");
	    		return false;
	    	}
	    	return true;
	    }
    </script>
	<script type="text/javascript"
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-A3rJD856KowSb7dwlZdYEkO39Gagi7vIsF0jrRAoQmDKKtQBHUuLZ9AsSv4jD4Xa"
		crossorigin="anonymous"></script>
</body>
</html>