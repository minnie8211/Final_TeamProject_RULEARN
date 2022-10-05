<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:url var="mainUrl" value="/" />
<script>
	alert("이메일 인증이 완료되었습니다. \n 로그인 후 사이트를 이용해 주세요!")
	location.href = "${mainUrl}login";
</script>