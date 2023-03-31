<%@page import="com.jspshop.domain.Category"%>
<%@page import="java.util.List"%>
<%@page import="com.jspshop.repository.CategoryDAO"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html>
<html lang="zxx">

<head>
<%@ include file="/inc/header.jsp"%>
</head>

<body>
	<!-- Page Preloder -->
	<%@ include file="/inc/preloader.jsp"%>

	<!-- Offcanvas Menu Begin -->
	<!-- 
    	jsp 자체에서 지원하는 태그
    	왜 사용해야 하는지? 사실 jsp는 디자인 영역이므로 개발자만 사용하는 것이 아니라 퍼블리셔, 웹디자이너와 공유함
    	이때 JAVA에 대한 비전문가들은 java코드를 이해할 수 없기 때문에 그들이 좀 더 쉽게 다가갈 수 있도록 태그를 지원해줌 (협업)
     -->
	<%@ include file="/inc/main_navi.jsp"%>
	<!-- Offcanvas Menu End -->

	<!-- Header Section Begin -->
	<%@ include file="/inc/header_section.jsp"%>
	<!-- Header Section End -->

	<section>
		<div class="container">
			<div class="row m=5">
				<div class="col">
					<form id="form1">
						<div class="form-group">
							<label for="text">ID:</label> <input type="text" class="form-control" placeholder="Enter id" name="id">
						</div>
						<div class="form-group">
							<label for="pwd">Password:</label> <input type="password" class="form-control" placeholder="Enter password" name="pass">
						</div>
						<button type="button" class="btn btn-primary" id="bt_login">로그인</button>
						<button type="button" class="btn btn-success" id="bt_regist">신규가입</button>
					</form>
				</div>
			</div>
		</div>
	</section>

	<!-- Instagram Begin -->
	<%@ include file="/inc/insta.jsp"%>
	<!-- Instagram End -->

	<!-- Footer Section Begin -->
	<%@ include file="/inc/footer.jsp"%>
	<!-- Footer Section End -->

	<!-- Search Begin -->
	<%@ include file="/inc/search.jsp"%>
	<!-- Search End -->

	<!-- Js Plugins -->
	<%@ include file="/inc/footer_link.jsp"%>
	<!-- 외부 라이브러리 사용 시 script를 밑에 작성함 -->
	<script type="text/javascript">
		$(function(){
		    $("#bt_login").click(function(){
		        $("#form1").attr({
		            action:"/member/login.jsp",
		            method:"post"
		        });
		        $("#form1").submit();
		    });
		
		    $("#bt_regist").click(function(){
		        //location.href="";
		        $(location).attr("href","/member/joinform.jsp");
		    });
		});
	</script>
</body>
</html>