<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:url var="mainUrl" value="/" />
<script>
	alert("카카오 회원 등록이 완료되었습니다. \n 다시 한 번 카카오 로그인을 해주세요.")
	location.href = "${mainUrl}login";
</script>