<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<%
	request.setCharacterEncoding("utf-8");
	String custno = request.getParameter("custno");
	String custname = request.getParameter("custname");
	String address = request.getParameter("address");
	String phone = request.getParameter("phone");
	String joindate = request.getParameter("joindate");
	String city = request.getParameter("city");
	String grade = request.getParameter("grade");
	
	int year = Integer.parseInt(joindate.substring(0,4));
	
	//월 2자리 가져오기
	int month = Integer.parseInt(joindate.substring(5, 7));
	//일 2자리 가져오기
	int day = Integer.parseInt(joindate.substring(8));
	
	Date updatedate = new Date(year-1900, month-1, day);
	
	Class.forName("oracle.jdbc.OracleDriver");
	Connection con = DriverManager.getConnection("jdbc:oracle:thin:@192.168.0.100:1521/xe", "user14", "user14");
	
	PreparedStatement pstmt = con.prepareStatement("update member_tbl_02 set custname=?, phone=?, address=?, joindate=?, grade=?, city=? where custno=?");
	
	
	
	pstmt.setString(1, custname);
	pstmt.setString(2, phone);
	pstmt.setString(3, address);
	pstmt.setDate(4, updatedate);
	pstmt.setString(5, grade);
	pstmt.setString(6, city);
	pstmt.setInt(7, Integer.parseInt(custno));
	
	System.out.println("ㅇㅇ");
	pstmt.executeQuery();
	System.out.println("ㅇㅇ");
	
	
	
	
	pstmt.close();
	con.close();
	
	
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>