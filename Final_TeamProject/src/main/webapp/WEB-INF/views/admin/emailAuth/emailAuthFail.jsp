<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:url var="mainUrl" value="/" />
<script>
	alert("이메일이 인증되지 않았습니다. \n이메일 인증 후 다시 시도해주세요!")
	location.href = "${mainUrl}login";
</script>