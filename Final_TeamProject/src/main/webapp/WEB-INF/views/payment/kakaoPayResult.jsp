<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>장바구니</title>
	<%@ include file="../module/head.jsp" %>
	<link rel="stylesheet" type="text/css" href="${css}/mypage.css">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.9.1/font/bootstrap-icons.css">

	<style type="text/css">
        table {
            --bs-border-color: rgb(50, 93, 136);
            border-top: 3px solid;
            border-bottom: 3px solid;
        }

        .items {
            background-color: #d6dfe7;
            font-weight: bolder;
            text-align: center;
        }
        
        .fs-1 {
            font-size: calc(3rem + 1.5vw) !important;
        }
    </style>
</head>

<body>
	<%@ include file="/WEB-INF/views/module/navigation.jsp"%>
	<div class="banner mar-bot2">
		<div class="container">
			수강 바구니
		</div>
	</div>
	<div class="container m-height">
		<div class="row">
			<div class="col-md-3">
				 <c:url value="/mypage" var="mypageURL"/>
				 <div class="d-flex flex-column flex-shrink-0 p-3 bg-light">
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
	                        <a href="${mypageURL}/lesson" class="nav-link link-dark">
	                           수강 중 강의
	                        </a>
	                    </li>
	                    <li>
	                        <a href="${mypageURL}/wishlist/${sessionScope.loginData.AC_ID}" class="nav-link active">
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
				<h3 class="mt-3">수강바구니</h3>
				<hr><br>
				<!-- 결제 후 -->
				<c:choose>
					<c:when test="${payResult eq 'success'}">
						<section class="text-center">
							<div>
								<i class="bi bi-cart-check-fill text-danger fs-1"></i>
							</div>
							<br>
							<h4 class="mt-2 mb-1"><mark>${payData.getItem_name()}</mark> </h4>
							<br>
							<h4>강의가 결제되었습니다. <br>
								강의는 나의 강의실에서 들을 수 있습니다.</h4>
							<c:url value="/mypage/lesson" var="lessonURL"></c:url>
							<button class="btn btn-primary float-end" 
									onclick="location.href ='${lessonURL}'">강의실로 이동하기</button>
						</section>
					</c:when>
					<c:when test="${payResult eq 'cancel'}">
						<section class="text-center">
							<div><i class="bi bi-cone-striped text-danger fs-1"></i></div>
							<h4> 강의 결제가 취소되었습니다.</h4>
						</section>
					</c:when>
					<c:when test="${payResult eq 'fail'}">
						<section class="text-center">
							<div><i class="bi bi-cone-striped text-danger fs-1"></i></div>
							<h4> 강의 결제가 실패했습니다.</h4>
						</section>
					</c:when>
					<%-- 카카오페이는 가상계좌 입금 기능이 없음 --%>
					<%-- <c:otherwise>
						<br>
			            <div class="text-center">
			                <h4 class="text-decoration-underline"> ${payload.getVirtualAccount().get("customerName")}님, </h4>
			                <h3> 입금하실 계좌번호 안내해드립니다.</h3>
			            </div>
			            <br>
			            <table class="table">
			                <colgroup>
			                    <col class="items">
			                    <col>
			                    <col class="items">
			                    <col>
			                </colgroup>
			                <tbody>
			                    <tr class="border-secondary">
			                        <th>결제 수단</th>
			                        <td>무통장입금(${payload.getMethod()})</td>
			                        <th>결제 요청일</th>
			                        <td>${payload.requestedAt}</td>
			                    </tr>
			                    <tr class="border-secondary">
				                    <fmt:formatNumber value="${payload.getTotalAmount()}" var="price"/>
			                        <th>결제 금액</th>
			                        <td>${price}원</td>
			                        <th>입금 기한일</th>
			                        <td><mark>${payload.getVirtualAccount().get("dueDate")}</mark></td>
			                    </tr>
			                    <tr class="border-secondary">
			                        <th>입금 은행</th>
			                        <td>${payload.getVirtualAccount().get("bank")}</td>
			                        <th>주문 상품명</th>
			                        <td>${payload.getOrderName()}</td>
			                    </tr>
			                    <tr class="border-secondary">
			                        <th>계좌번호</th>
			                        <td>${payload.getVirtualAccount().get("accountNumber")}</td>
			                        <th>주문번호</th>
			                        <td>${payload.getOrderId()}</td>
			                    </tr>
			                    <tr>
			                        <th>입금 계좌명</th>
			                        <td>${payload.getmId()}</td>
			                        <th></th>
			                        <td></td>
			                    </tr>
			                </tbody>
			            </table>
					</c:otherwise> --%>
				</c:choose>
			</div>
  		</div>
  	</div>
  	
	<footer>
		<%@ include file="../module/footer.jsp"%>
	</footer>
	
		<c:url value="/mypage/wishLlist" var="wishlist"></c:url>
<script type="text/javascript">
	/* //---------------------------- 최다연님
	   var clientKey = 'test_ck_4vZnjEJeQVxYq9PekLMrPmOoBN0k'
	   var tossPayments = TossPayments(clientKey)
	   var button = document.getElementById('payment-button');
	   
	   var price = document.querySelectorAll('input#price');
	   var oderId = "L" + today() + randomNum();
	   var orderName = "";
	   if(price.length > 1){
	      orderName = document.querySelectorAll('input#lesson')[0].value;
	      orderName += " 외 " + (price.length - 1);
	   }else{
	      orderName = document.querySelector('input#lesson').value;
	   }
	   
	   var amount = 0;
	   price.forEach(input => {
	           amount += parseInt(input.value);
	     });
   
 		button.addEventListener('click', function () {
         var payMethod = document.querySelector('input[name=payMethod]:checked').value;
         var paymentData = {
               amount: amount,
               orderId: oderId,
               orderName: orderName,
               customerName: "이토페", //변경 필요
               successUrl: window.location.origin + "/home/success",
               failUrl: window.location.origin + "/home/fail",
           };
         if (payMethod === '가상계좌') {
           paymentData.virtualAccountCallbackUrl = window.location.origin + '/home/virtual-account/callback';
           paymentData.validHours = 24;
       }
       tossPayments.requestPayment(payMethod, paymentData);
       console.log(paymentData);
   });
   
   function randomNum() {
    var value = "";
    for(var i = 0; i < 4; i++){
         value += parseInt(Math.random() * 10);
     }
    return value;
 }
   
   function today() {
       var today = new Date();

       const year = (today.getFullYear() + "").slice(2);
       const month = ('0' + (today.getMonth() + 1)).slice(-2);
       const day = ('0' + today.getDate()).slice(-2);
       
       return year + month + day;
   }
    */
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>