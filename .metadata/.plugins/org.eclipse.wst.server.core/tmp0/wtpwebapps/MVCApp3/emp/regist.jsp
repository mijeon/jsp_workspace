<%@ page contentType="text/html;charset=UTF-8"%>
<!-- 순수한 jsp일 경우 직접 접근 가능 : regist.jsp -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<!-- jQuery library -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<!-- Popper JS -->
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<!-- Latest compiled JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript">
	function regist(){
		$("#form1").attr({
			action:"/emp/regist.do",
			method:"post"
		});
		$("#form1").submit();
	}
	$(function(){
		$("#bt_regist").click(function(){
			regist();
		});
	})
</script>
</head>
<body>
	<div class="container mt-3">
		<div class="row">
			<div class="col">
				<form id="form1">
				<div class="form-group">
					<input type="text" class="form-control" name="dname" placeholder="부서명">
				</div>
				<div class="form-group">
					<input type="text" class="form-control" name="ename" placeholder="사원명">
				</div>
				<div class="form-group">
					<input type="text" class="form-control" name="sal" placeholder="급여">
				</div>
				<div class="form-group">
					<button type="button" class="btn btn-warning" id="bt_regist">등록</button>
				</div>
			</div>
			</form>
		</div>
	</div>
</body>
</html>