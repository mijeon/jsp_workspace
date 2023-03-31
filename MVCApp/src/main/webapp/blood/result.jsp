<%@ page contentType="text/html;charset=UTF-8"%>
<%
	//String msg=(String)session.getAttribute("msg");
	
	//여기서의 request는 새로운 요청이 의해 생성된 request가 아니라 BloodController에게 요청을 시도할 때
	//생성된 예전의 request 객체임, 즉 죽지않고 여기까지 살아온 것임
	String msg=(String)request.getAttribute("msg");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	혈액형에 대한 판단 결과 :
	<p>
	<%=msg %>
</body>
</html>