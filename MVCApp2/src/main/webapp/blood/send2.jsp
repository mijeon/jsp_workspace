<%@ page contentType="text/html;charset=UTF-8"%>
<%
	//파라미터 받기
	request.setCharacterEncoding("utf-8");
	String blood=request.getParameter("blood");
	
	String msg=null;  //결과 메세지를 담을 변수
	if(blood.equals("A")){
		msg="꼼꼼함";
	}else if(blood.equals("B")){
		msg="자기 주관이 뚜렷함";
	}else if(blood.equals("O")){
		msg="친구가 많음";
	}else if(blood.equals("AB")){
		msg="선택지를 많이둠";
	}
	out.print(msg);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	function send(){
		//서버에 폼 전송하기
		//window.document 생략가능
		form1.action="/blood/send.jsp";
		form1.method="post";
		form1.submit();
	}
</script>
</head>
<body>
	<form name="form1">
		<select name="blood">
			<option value="A">A형</option>
			<option value="B">B형</option>
			<option value="O">O형</option>
			<option value="AB">AB형</option>
		</select>
	</form>
	<p>
	<button onClick="send()">분석요청</button>
</body>
</html>