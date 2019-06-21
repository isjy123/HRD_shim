<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.sql.*, java.util.*" %>
    
<%
	Class.forName("oracle.jdbc.OracleDriver");
	Connection con = DriverManager.getConnection("jdbc:oracle:thin:@192.168.0.100:1521/xe", "user14", "user14");
	//입력받아야 하는 항목이 있으면 ?로 작성
	
	PreparedStatement pstmt = con.prepareStatement("select max(custno) from member_tbl_02");
	//?가 있으면 물음표를 채우고 executeQuery()로 실행
	//select 구문은 ResultSet으로 받아야하고 나머지는 정수로 받으면 됨
	//실행할 때 select는 excuteQuery() 나머지는 executeUpdate()
	ResultSet rs = pstmt.executeQuery();
	
	//결과를 저장할 변수
	int maxno = -1;
	
	//가장 큰 글번호 찾기
	//행이 하나면 if, 목록보기면 while
	if(rs.next()){
		maxno = rs.getInt("max(custno)");
	}
	
	//마지막 번호 +1
	maxno = maxno+1;
	
	//시퀀스 쓰는것보다 더 좋음
	
	//현재 날짜 가져오기
	java.sql.Date today = new java.sql.Date(System.currentTimeMillis());
	
	//toString 호출하면 yyyy-MM-DD 형식의 문자열로 리턴
	String disp = today.toString();
	//-를 ""로 변환
	disp = disp.replace("-","");
%>   
 
 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2 align="center">홈쇼핑 회원등록</h2>
	<form action="insert.jsp" id="registerform">
		<table align="center" border="1">
			<tr>
				<td align="center">회원번호(자동발생)</td>
				<td>
				<input type="text" value='<%=maxno %>' id="custno" />
				</td>
			</tr>
			<tr>
				<td align="center">회원이름</td>
				<td>
				<input type="text" name="custname" id="custname"/>
				</td>
			</tr>
			<tr>
				<td align="center">주소</td>
				<td>
				<input type="text" name="address" id="address"/>
				</td>
			</tr>
			<tr>
				<td align="center">전화번호</td>
				<td>
				<input type="text" name="phone" id="phone"/>
				</td>
			</tr>
			<tr>
				<td align="center">가입날짜</td>
				<td>
				<input type="text" name="joindate" value= '<%=disp %>' id="joindate" />
				</td>
			</tr>
			<tr>
				<td align="center">고객등급[A:VIP, B:일반, C:직원]</td>
				<td>
				<input type="text" name="grade" id="grade"/>
				</td>
			</tr>
			<tr>
				<td align="center">도시코드</td>
				<td> 
				<input type="text" name="city" id="city" />
				</td>
			</tr>
			<tr>
				<td colspan="2" align="center">
				<input type="button" value="등록" id="registerbtn">
				<input type="button" value="조회" id="selectbtn">
				</td>
			</tr>
		</table>
	</form>
</body>
<script>
	//등록버튼을 클릭하면 
	document.getElementById("registerbtn").addEventListener("click", function(e){
		
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
		
		var url = "insert.jsp?"
				
		//URL에 파라미터 붙이기
		url += "custno=" + document.getElementById("custno").value;
		url += "&custname=" + n.value;
		url += "&phone=" + p.value;
		url += "&address=" + a.value;
		url += "&joindate=" + j.value;
		url += "&grade=" + g.value;
		url += "&city=" + c.value;
		
		alert(url);
		
		//ajax 요청을 생성 
		request.open('GET', encodeURI(url));
		request.send('');
		
		//요청 성공시 수행할 내용
		request.onreadystatechange = function(){
			if(request.readyState == 4){
				alert("회원 등록이 완료되었습니다.");
			}
		}
		
		
		
		
		
	})


</script>
</html>