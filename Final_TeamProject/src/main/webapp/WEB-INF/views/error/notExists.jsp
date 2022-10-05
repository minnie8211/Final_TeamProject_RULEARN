<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>요청한 데이터가 존재하지 않습니다.</title>
	<c:url var="css" value="/static/css" />
	<c:url var="bs5" value="/static/bs5" />
	<link rel="stylesheet" type="text/css" href="${css}/notExists.css">
	<link rel="stylesheet" type="text/css" href="${bs5}/css/bootstrap.min.css">
</head>
<body>
	<section class="container">
	<c:url var="mainUrl" value="/" />
		<div>
			<div class="error-logo"></div>
			<div class="card_text">
				<h1 class="m-b">죄송합니다. 해당 페이지를 찾을 수 없습니다.</h1>
				<h5 class="font-siz">주소가 잘못되었거나 더 이상 제공되지 않는 페이지입니다.</h5>
			</div>
			<div>
				<button type="button" class="btn btn-success btn-lg btn-st"
				 onclick="location.href='${mainUrl}'">메인으로 돌아가기</button>
			</div>
		</div>
	</section>
</body>
</html>