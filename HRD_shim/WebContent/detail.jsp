<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>
<%
	
	
	Class.forName("oracle.jdbc.OracleDriver");
	Connection con = DriverManager.getConnection("jdbc:oracle:thin:@192.168.0.100:1521/xe", "user14", "user14");
	
	//클릭한 custno를 가져오는 SQL을 생성
	PreparedStatement pstmt = con.prepareStatement(
			"select * from member_tbl_02 where custno=?");
	
	//custno를 이용해서 데이터 찾아오기
	int custno = Integer.parseInt(request.getParameter("custno"));
	
	pstmt.setInt(1, custno);
	
	//데이터 1개는 바로
	ResultSet rs = pstmt.executeQuery();
	
	rs.next();
	String custname = rs.getString("custname");
	String phone = rs.getString("phone");
	String address = rs.getString("address");
	String city = rs.getString("city");
	String grade = rs.getString("grade");
	java.sql.Date joindate = rs.getDate("joindate");
	
	rs.close();
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
<h2 align="center">홈쇼핑 회원정보 수정</h2>
	<form  id="updateform">
		<table align="center" border="1">
			<tr>
				<td align="center">회원번호</td>
				<td>
				<input type="text" value='<%=custno %>' id="custno" readonly="readonly"/>
				</td>
			</tr>
			<tr>
				<td align="center">회원이름</td>
				<td>
				<input type="text" name="custname" id="custname" value='<%=custname %>'/>
				</td>
			</tr>
			<tr>
				<td align="center">주소</td>
				<td>
				<input type="text" name="address" id="address" value='<%=address %>'/>
				</td>
			</tr>
			<tr>
				<td align="center">전화번호</td>
				<td>
				<input type="text" name="phone" id="phone" value='<%=phone %>'/>
				</td>
			</tr>
			<tr>
				<td align="center">가입날짜</td>
				<td>
				<input type="text" name="joindate" value= '<%=joindate %>' id="joindate" />
				</td>
			</tr>
			<tr>
				<td align="center">고객등급[A:VIP, B:일반, C:직원]</td>
				<td>
				<input type="text" name="grade" id="grade" value='<%=grade %>'/>
				</td>
			</tr>
			<tr>
				<td align="center">도시코드</td>
				<td> 
				<input type="text" name="city" id="city" value='<%=city %>'/>
				</td>
			</tr>
			<tr>
				<td colspan="2" align="center">
				<input type="button" value="수정" id="updatebtn">
				<input type="button" value="조회" id="selectbtn">
				</td>
			</tr>
		</table>
	</form>
	<script>
        document.getElementById("updatebtn").addEventListener("click", function(e){
		
		//회원 성명 입력란 찾아오기
		var n = document.getElementById('custname')
		if(n.value.trim().length ==0){
			alert("회원이름이 입력되지 않았음");
			n.foucs();
			return;
		}
		
		var a = document.getElementById('address')
		if(a.value.trim().length==0){
			alert("주소가 입력되지 않음")
			n.focus();
			return;
		}
		
		var p = document.getElementById('phone')
		if(p.value.trim().length ==0){
			alert("전화번호가 입력되지 않았음");
			p.foucs();
			return;
		}
		
		var g = document.getElementById('grade')
		if(g.value.trim().length ==0){
			alert("고객등급이 입력되지 않음");
			g.foucs();
			return;
		}
		
		var j = document.getElementById('joindate')
		if(j.value.trim() == 0 ){
			alert("날짜가 입력되지 않음");
			j.focus();
			return;
		}
		
		var c = document.getElementById('city')
		if(c.value.trim().length ==0){
			alert("도시코드가 입력되지 않았음");
			c.foucs();
			return;
		}
		//폼의 데이터 전송
		//document.getElementById("registerform").submit();
		
		
		
		//폼의 데이터를 가지고 insert.jsp 파일에 ajax 요청
		//ajax 객체 생성
		var request = new XMLHttpRequest();
		
		var url = "update.jsp?"
				
		//URL에 파라미터 붙이기
		url += "custno=" + document.getElementById('custno').value;
		url += "&custname=" + n.value;
		url += "&phone=" + p.value;
		url += "&address=" + a.value;
		url += "&joindate=" + j.value;
		url += "&grade=" + g.value;
		url += "&city=" + c.value;
		
		
		
		//ajax 요청을 생성 
		request.open('GET', encodeURI(url));
		request.send('');
		
		
		
		//요청 성공시 수행할 내용
		request.onreadystatechange = function(){
			if(request.readyState == 4){
				alert("회원 수정이 완료되었습니다.");
			}
		}

		
	})
	
	</script>
</body>
</html>


