<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
	<link rel="stylesheet" type="text/css"	href="${bs5}/css/bootstrap.min.css">
	<script type="text/javascript" src="${jQuery}/jquery-3.6.0.min.js"></script>
	<script src="https://kit.fontawesome.com/2c1bc70929.js" crossorigin="anonymous"></script>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.9.1/font/bootstrap-icons.css">
    
    <title>전체 강의</title>

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
        .card:hover{
        	cursor: pointer;
        	transform: scale(1.02);
 			transition: transform 300ms ease-in;
        }
        
        .side_menu:hover {
        	color: #325d88 !important;
        }
    </style>

</head>

<body>
	<header>
    	<%@ include file="../module/navigation.jsp" %>
    </header>
    <c:url var="courseUrl" value="/course" />
    <div class="container">
        <div class="row">
            <!-- 강의 카테고리 -->
            <div class="col-3 mt-2 me-3 p-0">
                <!-- .navbar-light는 navbar의 글자색 -->
                <!-- .bg-light 는 navbar의 background-color -->
                <nav class="navbar navbar-expand-md sticky-top">
                    <button class="navbar-toggler" type="button" data-toggle="collapse"
                        data-target="#navbarNavAltMarkup">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    <div class="collapse navbar-collapse" id="navbarNavAltMarkup">
                        <div class="container pt-4 px-0">
                            <div class="border-bottom pb-1 ps-2" style="font-size:21px; font-weight:600;">
                               강의
                            </div>

                            <!-- navbar-nav는 네비의 항목 -->
                            <nav class="navbar-nav flex-column mt-2">
                                <a class="text-dark nav-link mt-1 side_menu" style="font-size:18px;" aria-current="page" 
                                	href="${courseUrl}?sort=allCourse">전체 강의</a>
                                <a class="text-dark nav-link mt-1 side_menu" style="font-size:18px;" 
                                	href="${courseUrl}?sort=programming">개발/프로그래밍</a>
                                <a class="text-dark nav-link mt-1 side_menu" style="font-size:18px;"
                                	href="${courseUrl}?sort=secure/network">보안/네트워크</a>
                                <a class="text-dark nav-link mt-1 side_menu" style="font-size:18px;"
                                	href="${courseUrl}?sort=dataScience">데이터 사이언스</a>
                                <a class="text-dark nav-link mt-1 side_menu" style="font-size:18px;"
                                	href="${courseUrl}?sort=game">게임개발</a>
                                <a class="text-dark nav-link mt-1 side_menu" style="font-size:18px;"
                                	href="${courseUrl}?sort=etc">기타</a>
                            </nav>
                        </div>
                    </div>
                </nav>
            </div>

            <!-- main -->
            <div class="col mt-4 lessons">
                <div class="row search py-2 ms-2 me-3">
					<form action="${courseUrl}"  method="get" class="col" role="search">
						<div class="input-group">
							<input type="text" class="form-control" placeholder="강의명/강사명으로 검색" 
								   aria-describedby="button-addon2" name="lessonSearch">
							<button class="btn btn-primary" type="submit" id="button-addon2">검색</button>
						</div>
					</form>
					<c:if test="${sessionScope.loginData.AC_ROLE eq 2}">
						<button class="btn btn-success upload col-2" type="button" 
								style="min-width: 110px" onclick="location.href='${courseUrl}/upload/lessonInfo'">
							<div style="font-size: 14px;"> 강의 업로드</div>
						</button>
					</c:if>
                </div>
                <c:choose>
	                <c:when test="${foundNothing eq 0}">
						<div class="foundNothing bg-light text-center fw-5 mx-auto my-4 py-4">
							<i class="bi bi-cone-striped text-danger fs-1"></i>
							<br>
							검색 결과가 없습니다.
						</div>	                
	                </c:when>
	                <c:otherwise>
		                <div class="container-fluid">
		                    <div class="row mb-2">
		                    	<c:forEach items="${courseDatas}" var="data">
			                    	<c:url var="courseDetailUrl" value="/course/detail">
			                    		<c:param name="id">${data.l_id}</c:param>
									</c:url>
									<fmt:formatNumber value="${data.l_price}" type="currency" 
		                    				  		  var="price" currencySymbol="￦"/>
		            				<c:set var="avg" value="${data.avg}"/>
		                         	<fmt:formatNumber var="avgFloor" value="${avg - (avg % 1)}" type="number"/>
		                           	<fmt:formatNumber var="avgCeil" value="${avg + (1 - (avg % 1)) % 1}" type="number"/>
		                        
		                        <div class="col-12 col-md-6 col-sm-12 col-lg-4 mt-3" 
		                        	 onclick="location.href='${courseDetailUrl}'">
		                            <div class="card" style="width: 100%;">
		                                <img src="${data.l_thumbnail}"
		                                     class="card-img-top" alt="강의 썸네일">
		                                <div class="card-body pb-0">
		                                    <div class="card-title">
		                                        <div class="fs-6 fw-bolder lh-base cardBox">
		                                        	${data.l_title}
		                                        </div>
		                                    </div>
		                                    <div class="card-detail">
		                                    	<br>
		                                        <p class="card-text fs-6 text-muted mt-2 mb-0">
		                                        	${data.l_wid}
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
						                            <small class="text-muted">(${data.amount})</small>
		                                        </p>
		                                        <p class="fw-bolder text-primary">${price}</p>
		                                    </div>
		                                </div>
		                            </div>
		                        </div>
		                        </c:forEach>
		                    </div>
		                </div>
		                <div>
							<ul class="pagination justify-content-center">
								<c:if test="${pageData.hasPrevPage()}">
									<li class="page-item">
										<a class="page-link" href="${courseUrl}?page=${pageData.prevPageNumber}">&laquo;</a>
									</li>
								</c:if>
								<c:forEach items="${pageData.getPageNumberList(pageData.currentPageNumber - 2, pageData.currentPageNumber + 2)}" var="num">
									<li class="page-item ${pageData.currentPageNumber eq num ? 'active' : ''}">
										<a class="page-link" href="${courseUrl}?page=${num}">${num}</a>
									</li>
								</c:forEach>
								<c:if test="${pageData.hasNextPage()}">
									<li class="page-item">
										<a class="page-link" href="${courseUrl}?page=${pageData.nextPageNumber}">&raquo;</a>
									</li>
								</c:if>
							</ul>
						</div>		
            		</c:otherwise>
            	</c:choose>
            </div>
        </div>
    </div>
	<footer>
    	<%@ include file="../module/footer.jsp" %>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-A3rJD856KowSb7dwlZdYEkO39Gagi7vIsF0jrRAoQmDKKtQBHUuLZ9AsSv4jD4Xa"
        crossorigin="anonymous"></script>
</body>

</html>

</body>

</html>