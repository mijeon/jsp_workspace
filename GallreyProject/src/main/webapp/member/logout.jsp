<%@ page contentType="text/html; charset=UTF-8"%>
<% 
	//로그아웃이란 서버측의 현재 클라이언트가 사용중인 세션 객체를 무효화시키는 것
	//무효화 이후엔 더이상 해당 세션을 사용할 수 없음 객체 자체를 죽이진 못함 
	//자바에선 객체의 소멸을 가비지컬렉션이 담당함
	session.invalidate();  //세션 무효화
%>
<script type="text/javascript">
	alert("로그아웃 되었습니다.");
	location.href="/gallery/list.jsp";
</script>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>