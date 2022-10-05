<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
   <meta charset="UTF-8">
   <title>강의</title>
   <%@ include file="../module/head.jsp"%>
   <link rel="stylesheet" type="text/css" href="${css}/mypage.css">
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
   <%@ include file="/WEB-INF/views/module/navigation.jsp"%>
   <div class="banner mar-bot2">
      <div class="container">
         수강 중 강의
      </div>
   </div>
   <div class="container m-height">
      <div class="row">
         <div class="col-md-3">
            <div class="d-flex flex-column flex-shrink-0 p-3 bg-light">
               <c:url value="/mypage" var="mypageURL"/>
                <ul class="nav nav_pills mb-auto px-3 bg-light d-flex flex-column">
                       <li class="nav-item">
                           <a href="${mypageURL}/board/QnA" class="nav-link link-dark" aria-current="page">
                               내가 쓴 게시글
                           </a>
                       </li>
                       <li>
                           <a href="${mypageURL}/comment/QnA" class="nav-link link-dark">
                               내가 쓴 댓글
                           </a>
                       </li>
                       <li>
                           <a href="${mypageURL}/lesson" class="nav-link active">
                               수강 중 강의
                           </a>
                       </li>
                       <li>
                           <a href="${mypageURL}/wishlist/${sessionScope.loginData.AC_ID}" class="nav-link link-dark">
                               수강바구니
                           </a>
                       </li>
                       <li>
                           <a href="${mypageURL}/certifyformView" class="nav-link link-dark">
                               개인 정보 수정
                           </a>
                       </li>
                       <li>
                           <a href="${mypageURL}/withdrawView" class="nav-link link-dark">
                               회원 탈퇴
                           </a>
                       </li>
                   </ul>
            </div>
         </div>
      <div class="col_md_9 ms-3">
         <div class="container-fluid">
                   <div class="row mb-2">
                      <c:forEach items="${courseDatas}" var="data">
                       <c:url var="courseDetailUrl" value="/course/detail">
                          <c:param name="id">${data.l_id}</c:param>
                  </c:url>
                        <div class="col-12 col-md-6 col-sm-12 col-lg-4 mt-3" onclick="location.href='${courseDetailUrl}'">
                            <div class="card" style="width: 100%;">
                                <img src="${data.l_thumbnail}" class="card-img-top" alt="강의 썸네일">
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
      </div>
     </div>
     </div>
     <%@ include file="/WEB-INF/views/module/footer.jsp"%>
   <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
</body>
</html>