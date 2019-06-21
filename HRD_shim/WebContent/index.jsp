<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>쇼핑몰 회원관리</title>
</head>
<body>
	<header><h2 align="center">쇼핑몰 회원관리 ver1.0</h2></header>
	<nav>
		<a href ="register.jsp" target="content">회원 등록</a>&nbsp;&nbsp;
		<a href ="" target="content">회원 목록 조회/수정</a>&nbsp;&nbsp;  <!-- &nbsp; : 공백 -->
		<a href ="" target="content">회원 매출 조회</a>&nbsp;&nbsp;
		<a href ="main.jsp" target="content">홈으로</a>&nbsp;&nbsp;
	</nav>
	
	<section>
		<iframe width="100%" height="300px" src="main.jsp" name="content" id="content"></iframe>
	</section>
	
	<footer>HRDKOREA </footer>
</body>
</html>