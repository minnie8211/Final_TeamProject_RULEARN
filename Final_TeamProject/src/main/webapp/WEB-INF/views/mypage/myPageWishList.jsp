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
<%@ include file="../module/head.jsp"%>
<link rel="stylesheet" type="text/css" href="${css}/mypage.css">
<script src="https://js.tosspayments.com/v1"></script>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.9.1/font/bootstrap-icons.css">

	<style type="text/css">
		.tossBtn{
			--bs-btn-bg: #3182f6;
		}
		.kakaoBtn{
			background-color: rgb(250, 225, 0);
			color: rgb(60, 30, 30);
		}
	</style>
</head>

<body>
	<header>
		<%@ include file="/WEB-INF/views/module/navigation.jsp"%>
	</header>
	<div class="banner mar-bot2">
		<div class="container">수강 바구니</div>
	</div>
	<div class="container m-height">
		<div class="row">
			<div class="col-md-3">
				<div class="d-flex flex-column flex-shrink-0 p-3 bg-light">
					<c:url value="/mypage" var="mypageURL" />
					<ul
						class="nav nav_pills mb-auto px-3 bg-light d-flex flex-column">
						<li class="nav-item"><a href="${mypageURL}/board/QnA"
							class="nav-link link-dark" aria-current="page"> 내가 쓴 게시글 </a></li>
						<li><a href="${mypageURL}/comment/QnA"
							class="nav-link link-dark"> 내가 쓴 댓글 </a></li>
						<li><a href="${mypageURL}/lesson" class="nav-link link-dark">
								수강 중 강의 </a></li>
						<li><a
							href="${mypageURL}/wishlist/${sessionScope.loginData.AC_ID}"
							class="nav-link active"> 수강바구니 </a></li>
						<li><a href="${mypageURL}/certifyformView"
							class="nav-link link-dark"> 개인 정보 수정 </a></li>
						<li><a href="${mypageURL}/withdrawView"
							class="nav-link link-dark"> 회원 탈퇴 </a></li>
					</ul>
				</div>
			</div>

			<div class="col_md_9 ms-3">
				<h3 class="mt-3">수강바구니</h3>
				<hr>
				<br>

				<div class="row px-4">
					<div class="form-check col ms-2 d-flex align-items-center">
						<!-- <input class="form-check-input" type="checkbox" value=""
							id="flexCheckChecked" checked=""> <label
							class="form-check-label" for="flexCheckChecked"> 전체선택 1/1
						</label> -->
					</div>
					<div class="form-check col-3 mb-2 me-2">
						<button id="totalDelete" type="button" class="btn btn-outline-dark float-end"
							style="min-width: 86px">전체삭제 x</button>
					</div>
					<hr>
				</div>
				<div class="ps-4 pe-2">
					<div class="row pb-2">

						<c:if test="${not empty wishInfoList}">
							<c:forEach items="${wishInfoList}" var="wish">
								<c:url var="courseDetailUrl" value="/course/detail">
									<c:param name="id">${wish.getL_ID()}</c:param>
								</c:url>
								<fmt:formatNumber value="${wish.getL_PRICE()}" var="price" />
								<!-- <div class="col-1">
									<div class="form-check">
										<input class="form-check-input" type="checkbox" value=""
											id="flexCheckChecked" checked="checked"> <label
											class="form-check-label" for="flexCheckChecked"></label>
									</div>
								</div> -->
								<div class="col-3 mb-2"
									onclick="location.href='${courseDetailUrl}'">
									<img src="${wish.getL_THUMBNAIL()}" class="card-img-top"
										alt="강의 썸네일">
								</div>
								<div class="col-5" onclick="location.href='${courseDetailUrl}'">
									<input id="lesson" type="hidden" value="${wish.getL_TITLE()}">
									<h5>${wish.getL_TITLE()}</h5>
									<br>
									<div class="text-muted">${wish.getL_WID()}</div>
								</div>
								<div class="col-2 pe-3 ps-3">
									<input id="price" type="hidden" value="${wish.getL_PRICE()}">
									<h5 class="text-primary ">${price}원</h5>
								</div>
								<div class="col-1">
									<%-- 삭제버튼 --%>
									<button class="btn btn-light float-end" type="button" style="border: 0; outline: 0; background: none;"
									onclick="lesson_delete(this);" value="${wish.getW_ID()}"> 
										<i class="fs-3 bi bi-trash3-fill"></i>
									</button>
								</div>
								<hr>
							</c:forEach>
							<div class="fs-5 mb-2">
								      <span class="ps-3"><strong>합계</strong></span>
			                    <span class="float-end pe-3"><strong class="totalPrice"></strong></span>
			                </div>
			                <div class="fs-5">
			                    <span class="ps-3"><strong>결제 방식</strong></span>
			                    <div class="btn-group float-end me-3 mt-1" role="group" aria-label="Basic radio toggle button group"
			                        style="user-select: auto;">
			                        <input type="radio" class="btn-check" name="payMethod" id="btnradio1" value="카드">
			                        <label class="btn btn-outline-primary" for="btnradio1" checked> 카드
			                        </label>
			                        <input type="radio" class="btn-check" name="payMethod" id="btnradio2" value="가상계좌">
			                        <label class="btn btn-outline-primary" for="btnradio2">가상계좌</label>
			                    </div>
			                    <hr>
			                    <button type="button" class="btn btn-primary border-0 float-end me-3 tossBtn"  
			                    		id="payment-button">Toss</button>
			                    
			                    <%-- 카카오페이 결제 --%>
			                    <c:url var="kakaoPayUrl" value="/kakaoPay" />
								<button class="btn btn-light float-end me-1 kakaoBtn" type="button" 
										onclick="PayRequest()"> <!-- style="border: 0; outline: 0; background: none;" -->
									<i class="bi bi-chat-fill"></i>pay
									<%-- <img alt="" src="${img}/kakao_pay/payment_icon_yellow_small.png"> --%>
								</button>
							</div>
						</c:if>

						<nav>
							<div>
								<ul class="pagination justify-content-center">
									<c:if test="${pageData.hasPrevPage()}">
										<li class="page-item"><a class="page-link"
											href="${commBoardUrl}?page=${pageData.prevPageNumber}">&laquo;</a>
										</li>
									</c:if>
									<c:forEach
										items="${pageData.getPageNumberList(pageData.currentPageNumber - 2, pageData.currentPageNumber + 2)}"
										var="num">
										<li
											class="page-item ${pageData.currentPageNumber eq num ? 'active' : ''}">
											<a class="page-link" href="${commBoardUrl}?page=${num}">
												${num} </a>
										</li>
									</c:forEach>
									<c:if test="${pageData.hasNextPage()}">
										<li class="page-item"><a class="page-link"
											href="${commBoardUrl}?page=${pageData.nextPageNumber}">&raquo;</a></li>
									</c:if>
								</ul>
							</div>
						</nav>
					</div>
				</div>
			</div>
		</div>
	</div>

	<footer>
		<%@ include file="../module/footer.jsp"%>
	</footer>

	<c:url value="/mypage/wishlist" var="wishlist"></c:url>
	<script type="text/javascript">
	 $("#totalDelete").on("click", function(e){
	     
	     $.ajax({
	         url: "${wishlist}/totalDelete",
	         type: 'POST',
	         dataType: "json",
	         success: function(data){
	        	 if(data.code === "success") {
	        		alert(data.message);
	 				location.reload();
	 			}else if(data.code === "fail"){
					alert(data.message);
				}
	         }
	      })
	   });
	
	 function lesson_delete(element) {
		 
		 var wish_wid = element.value;
		 console.log(wish_wid);
		 $.ajax({
			type: 'POST',
			url : "${wishlist}/listDelete",
			data:{
				w_id : wish_wid
			},
			dataType: "json",
			success: function(data) {
				if(data.code === "success") {
	        		alert(data.message);
	 				location.reload();
	 			}else if(data.code === "fail"){
					alert(data.message);
				}
			}
		 });
		
	}
	
	
	//---------------------------- TossPay
		//toss 연결
		var clientKey = 'test_ck_OAQ92ymxN34jNOReQLPrajRKXvdk'
		var tossPayments = TossPayments(clientKey)
		
		var button = document.getElementById('payment-button');
		var price = document.querySelectorAll('input#price');
		
		//주문번호 랜덤 숫자
		var oderId = "TP" + today() + randomNum();
		
		//주문강의 이름
		var orderName = "";
		
		if(price.length > 1){
		   orderName = document.querySelectorAll('input#lesson')[0].value;
		   
		   if(orderName.length > 25){
			   orderName = orderName.substr(0, 25) + "...";
			}
		   orderName += " 외 " + (price.length - 1);
		   
		}else{
		   orderName = document.querySelector('input#lesson').value;
		   
		   if(orderName.length > 25){
			   orderName = orderName.substr(0, 25) + "...";
	    	}
		}

		//총 금액
		var amount = 0;
		price.forEach(input => {
		        amount += parseInt(input.value);
		  });
		var totalPrice = amount.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");
   		document.querySelector('.totalPrice').innerText = totalPrice + "원";
	   
   		//버튼 클릭했을 때 토스 결제 연동
 		button.addEventListener('click', function () {
         var payMethod = document.querySelector('input[name=payMethod]:checked');
         if(payMethod == null){
        	 alert("결제 방식을 선택하세요.");
        	 return;
         }
         var paymentData = {
               amount: amount,
               orderId: oderId,
               orderName: orderName,
               customerName: "${sessionScope.loginData.AC_ID}",
               successUrl: window.location.origin + "/home/success",
               failUrl: window.location.origin + "/home/fail",
           };
         if (payMethod.value === '가상계좌') {
           paymentData.virtualAccountCallbackUrl = window.location.origin + '/home/virtual-account/callback';
           paymentData.validHours = 24;
       }
       tossPayments.requestPayment(payMethod.value, paymentData);
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
   
   //------------------------카카오페이 결제 처리
   function PayRequest() {
		var orderId = "KP" + today() + randomNum();
		
		var price = document.querySelectorAll('input#price');
		var quantity = price.length; // 제품 수량
		var orderName = "";
		if(price.length > 1){
		   orderName = document.querySelectorAll('input#lesson')[0].value;
		   
		   if(orderName.length > 25){
			   orderName = orderName.substr(0, 25) + "...";
		   }
		   
		   orderName += " 외 " + (price.length - 1) + "건";
		}else{
		   orderName = document.querySelector('input#lesson').value;
		   
		   if(orderName.length > 25){
			   orderName = orderName.substr(0, 25) + "... 1건";
		   }
		}
		
		var amount = 0; // 총 가격
		price.forEach(input => {
		        amount += parseInt(input.value);
		  });
		
		$.ajax({
			type: "post",
			url: "${kakaoPayUrl}/ready",
			data: {
				order : orderId,
				amount: amount,
               	orderName: orderName,
               	quantity : quantity
			},
			success: function(data) {
				// 결제 요청 성공시 next_redirect_pc_url 을 받아서 주소 리다이렉트 처리
				// 결제 QR 코드
				location.href = data.next_redirect_pc_url;
			}
		});
	}
   
</script>
	<script type="text/javascript">
   // 서버로 전송할 데이터
   const form = {
         W_ACID : '${wish.W_ACID}',
         W_ID : '${wish.W_ID}',
   }
   
   // 장바구니 추가 버튼
   $(".btn_cart").on("click", function(e){
      form.bookCount = $(".quantity_input").val();
      $.ajax({
         url: '/cart/add',
         type: 'POST',
         data: form,
         success: function(result){
            cartAlert(result);
         }
      })
   });
   
   function wishlistAlert(result){
      if(result == '0'){
         alert("장바구니에 추가를 하지 못하였습니다.");
      } else if(result == '1'){
         alert("장바구니에 추가되었습니다.");
      } else if(result == '2'){
         alert("장바구니에 이미 추가되어져 있습니다.");
      } else if(result == '5'){
         alert("로그인이 필요합니다.");   
      }
   }
   
   $(".delete_btn").on("click", function(e){
      e.preventDefault();
      const cartId = $(this).data("cartid");
      $(".delete_cartId").val(cartId);
      $(".quantity_delete_form").submit();
   });

   
</script>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>