<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원매출조회</title>
</head>
<body>
	<h3>회원 매출 조회</h3>
	<%
		out.println("<table border='1' align = 'center'>");
		out.println("<tr><th>회원번호</th><th>회원성명</th>");
		out.println("<th>고객등급</th><th>매출</th></tr>");
	
		//DB접속
		Class.forName("oracle.jdbc.OracleDriver");
		Connection con = DriverManager.getConnection("jdbc:oracle:thin:@192.168.0.100:1521/xe", "user14", "user14");
	
		PreparedStatement pstmt = con.prepareStatement("SELECT mem.custno, custname, grade, summary FROM member_tbl_02 mem, (SELECT custno, sum(price) summary FROM MONEY_TBL_02 GROUP BY custno) money WHERE mem.CUSTNO = money.custno ORDER BY summary");
		
		ResultSet rs = pstmt.executeQuery();
		
		while(rs.next()){
			out.println("<tr>");
			out.println("<td align='center'>" + 
				rs.getInt("custno") + "</td>");
			out.println("<td align='center'>" + 
				rs.getString("custname") + "</td>");
			String grade="";
			
			if(rs.getString("grade").equals("A"))
				grade="VIP";
			else if(rs.getString("grade").equals("B"))
				grade="일반";
			else if(rs.getString("grade").equals("C"))
				grade="직원";
			out.println("<td align='center'>" + 
					grade + "</td>");
			
			
			out.println("<td align='center'>" + 
				rs.getInt("summary") + "</td>");
			out.println("</tr>");
			
			
			
		}
		rs.close();
		pstmt.close();
		con.close();
		
		out.println("</table>");
	
	%>
</body>
</html>