<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>결제 실패</title>
	<meta http equiv="x-ua-compatible" content="ie=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
    <link rel="stylesheet" href="static/css/payment.css" />
</head>
<body>
	<div><i class="bi bi-cone-striped" style="width: 400px;"></i></div>
	<div class="text-center">
		<p>${error}</p>
		<hr>
		<p><string>${code} : ${message}</string></p>
	</div>
</body>
</html>