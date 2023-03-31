<%@ page contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	function send(){
		//서버에 폼 전송하기
		//window.document 생략가능
		form1.action="/movie.do";
		form1.method="post";
		form1.submit();
	}
</script>
</head>
<body>
	<form name="form1">
		<select name="movie">
			<option value="movie1">아바타2</option>
			<option value="movie2">엽기적인 그녀</option>
			<option value="movie3">클래식</option>
			<option value="movie4">헤어질 결심</option>
		</select>
	</form>
	<p>
	<button onClick="send()">분석요청</button>
</body>
</html>