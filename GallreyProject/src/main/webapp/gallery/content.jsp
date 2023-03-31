<%@page import="gallery.domain.Gallery"%>
<%@page import="gallery.repository.GalleryDAO"%>
<%@ page contentType="text/html; charset=UTF-8"%>

<%!GalleryDAO galleryDAO = new GalleryDAO();%>

<%
//list.jsp에서 파라미터를 제대로 넘기자
//idx를 파라미터로 넘겨받아 변수에 받으면 된다 > 파라미터명은 gallery_idx

int gallery_idx = Integer.parseInt(request.getParameter("gallery_idx"));
String sql = "select * from gallery where gallery_idx=" + gallery_idx;
out.print(sql);

//한건 가져오기 
Gallery gallery = galleryDAO.select(gallery_idx);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상세보기</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script type="text/javascript">
	function edit() {
		if (confirm("수정하시겠어요?")) {
			$("form").attr("method", "post");
			let v=$("input[type='file']").val();
			
			if (v.length>0) { //이미지를 업로드하기를 원하는 경우
				$("form").attr("action", "/gallery/edit");
	            $("form").attr("enctype", "multipart/form-data");
			} else {
				//텍스트만 수정하는 경우
				$("form").attr("action", "/gallery/update");
			}
			$("form").submit();
		}
	}

	function del() {
		if (confirm("삭제하시겠어요?")) {
			//삭제 요청을 받는 서버측 기술은 디자인이 요구되지 않으므로 서블릿으로 처리해도 무방함
			//enctype==encoding
			//폼태그 전송 시 개발자가 아무것도 명시하지 않으면 텍스트 전송을 하게 되며, 
			//텍스트 전송에 사용되는 인코딩 타입은 application/x-www-form-urlencode이고 
			//이 방식은 바이너리 파일 전송이 불가능함, 따라서 개발자가 파일도 함께 전송하려면 form 태그의
			//전송 인코딩 방식을 multipart/form-data

			//삭제요청, POST 방식
			$("form").attr({
				"method" : "post",
				"action" : "/gallery/del"
			});
			$("form").submit();
		}
	}

	$(function() {
		$($("input[type=button]")[0]).click(function() {
			alert("눌렀어?");
			edit();
		});

		$($("input[type=button]")[1]).click(function() {
			alert("눌렀어?");
			del();
		});

		$($("input[type=button]")[2]).click(function() {
			alert("눌렀어?");
			//목록으로 이동
			//GET : 링크
			location.href = "/gallery/list.jsp";
		});
	});
</script>
</head>
<body>
	<form>
		<table>
			<tr>
				<td><input type="hidden" name="gallery_idx"
					value="<%=gallery.getGallery_idx()%>"></td>
			</tr>
			<tr>
				<td><input type="hidden" name="filename"
					value="<%=gallery.getFilename()%>"></td>
			</tr>
			<tr>
				<td><input type="text" name="title"
					value="<%=gallery.getTitle()%>"></td>
			</tr>
			<tr>
				<td><input type="text" name="writer"
					value="<%=gallery.getWriter()%>"></td>
			</tr>
			<tr>
				<td><textarea name="content"><%=gallery.getContent()%></textarea></td>
			</tr>
			<tr>
				<td><img src="/data/<%=gallery.getFilename()%>" width="250px">
				</td>
			</tr>
			<tr>
				<td><input type="file" name="file"></td>
			</tr>
			<tr>
				<td><input type="button" value="수정"> <input
					type="button" value="삭제"> <input type="button" value="목록">
				</td>
			</tr>
			<tr>
		</table>
	</form>
</body>
</html>