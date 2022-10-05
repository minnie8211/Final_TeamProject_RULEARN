<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:url var="mainUrl" value="/" />
<div class="f_background">
	<div class="container flex-wrap f_padding_t pb-2">
		<div class="d-flex">
			<a href="${mainUrl}" class="d-flex mb-0 mb-lg-0">
				<img src="${img}/logo/logo_w.png" alt="" width="218" height="35">
			</a>
			<ul class="nav pb-0 ps-3 mb-0">
				<li class="nav-item"><a href="#" class="f_nav_link px-2">회사소개</a></li>
				<li class="nav-item"><a href="#" class="f_nav_link px-2">공지사항</a></li>
				<li class="nav-item"><a href="#" class="f_nav_link px-2">광고문의</a></li>
				<li class="nav-item"><a href="#" class="f_nav_link px-2">개인정보취급방침</a></li>
				<li class="nav-item"><a href="#" class="f_nav_link px-2">이용약관</a></li>
			</ul>
		</div>
		<div class="f_bottom_box mt-2">
			<div class="justify-content-start">
				<p class="f_content">
				(주)RULearn | 대표자: 알유런 | 사업자번호: 123-00-00456 사업자 정보 확인 <br>
				통신판매업: 2022-성남분당B-0012 | 개인정보보호책임자: 아유런 | 이메일: info@rulearn.com <br>
				주소: 경기도 성남시 분당구 대왕판교로 660 유스페이스 1A동 405호 <br>
				© RUlearn. ALL RIGHTS RESERVED
				</p>
			</div>
			<ul class="nav justify-content-end list-unstyled d-flex f_margin_l">
				<li class="ms-3"><a class="text-muted" href="#"><img src="${img}/sns/sns_y.png" alt="" width="53" height="53"></a></li>
				<li class="ms-3"><a class="text-muted" href="#"><img src="${img}/sns/sns_f.png" alt="" width="53" height="53"></svg></a></li>
				<li class="ms-3"><a class="text-muted" href="#"><img src="${img}/sns/sns_t.png" alt="" width="53" height="53"></svg></a></li>
			</ul>
		</div>
	</div>
</div>