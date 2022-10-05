<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>결제 준비</title>
<%@ include file="../module/head.jsp"%>
</head>
<body>
	<h1> 카카오페이 결제</h1>
	<c:url var="kakaoPayUrl" value="/kakaoPay" />
	<button type="button" style="border: 0; outline: 0; background: none;"
	onclick="PayRequest()">
		<img alt="" src="${img}/kakao_pay/payment_icon_yellow_small.png">
	</button>
	
<script type="text/javascript">
	
	function PayRequest() {
		var orderId = "KP" + today() + randomNum();
		
		var price = document.querySelectorAll('input#price');
		var quantity = price.length; // 제품 수량
		var orderName = "";
		if(price.length > 1){
		   orderName = document.querySelectorAll('input#lesson')[0].value;
		   orderName += " 외 " + (price.length - 1) + "건";
		}else{
		   orderName = document.querySelector('input#lesson').value;
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
				if(data.code === "success"){
					// 결제 요청 성공시 next_redirect_pc_url 을 받아서 주소 리다이렉트 처리
					location.href = data.next_redirect_pc_url;
				}else if(data.code === "fail"){
					alert("결제 실패");
				}else{
					alert("알 수 없는 오류");
				}
				
			}
		});
	}

	// 랜덤 난수 생성
	function randomNum() {
		var value = "";

		for (var i = 0; i < 4; i++) {
			value += parseInt(Math.random() * 10);
		}
		return value;
	}
	
	// 연도 + 달 + 일 
	function today() {
		var today = new Date();

		const year = (today.getFullYear() + "").slice(2);
		const month = ('0' + (today.getMonth() + 1)).slice(-2);
		const day = ('0' + today.getDate()).slice(-2);

		return year + month + day;
	}
</script>

</body>
</html>