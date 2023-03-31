<%@page import="news.domain.Comments"%>
<%@page import="news.domain.News"%>
<%@page import="news.repository.NewsDAO"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%!
	NewsDAO newsDAO=new NewsDAO();
%>
<%
	String news_idx=request.getParameter("news_idx");
	News news=newsDAO.select(Integer.parseInt(news_idx));
	out.print(news);
	out.print("<br>댓글 갯수"+news.getCommentsList().size());
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상세보기</title>
<%@ include file="/inc/header_link.jsp"%>
<script type="text/javascript">
	$(function() {
		$($("button")[0]).click(function() { //수정버튼
			$("#form1").attr({
				"action" : "/news/edit",
				"method" : "post"
			});
			$("#form1").submit();
		});
		
		$($("button")[1]).click(function() { //삭제버튼
			$("#form1").attr({
				"action" : "/news/del",
				"method" : "post"
			});
			$("#form1").submit();
		});

		$($("button")[2]).click(function() {//목록버튼
			$(location).attr("href", "/news/list.jsp");
		});
		
		//댓글 등록 버튼 이벤트 연결
		$("#form2 button").click(function(){
			$("#form2").attr({
				"action":"/comments/regist",
				"method":"post"
			});
			$("#form2").submit();
		});
	});
</script>
</head>
<body>
	<div class="container mt-3 border">
		<h2 class="text-center">상세보기</h2>
		<form id="form1">
			<input type="hidden" name="news_idx" value="<%=news.getNews_idx()%>">
			<input type="hidden" name="commentsSize" value="<%=news.getCommentsList().size()%>">
			<div class="form-group">
				<input type="text" class="form-control" value="<%=news.getTitle() %>"
					name="title">
			</div>
			<div class="form-group">
				<input type="text" class="form-control" value="<%=news.getWriter() %>"
					name="writer">
			</div>

			<div class="form-group">
				<textarea class="form-control" placeholder="내용입력" name="content"><%=news.getContent() %></textarea>
			</div>

			<div class="form-group text-center">
				<button type="button" class="btn btn-secondary">수정</button>
				<button type="button" class="btn btn-secondary">삭제</button>
				<button type="button" class="btn btn-secondary">목록</button>
			</div>
		</form>
		<form id="form2">
			<input type="hidden" name="news_idx" value="<%=news.getNews_idx()%>">
			<div class="form-group row">
				<div class="col-md-6">
					<input type="text" class="form-control" placeholder="Enter title" name="msg">
					</div>
				<div class="col-md-4">
					<input type="text" class="form-control" placeholder="Enter title" name="author">
				</div>
				<div class="col-md-2">
					<button type="button" class="btn btn-secondary">댓글등록</button>
				</div>
			</div>
		</form>
		<table class="table table-hover">
			<thead>
				<tr>
					<th>댓글 메세지</th>
					<th>작성자</th>
					<th>등록일</th>
				</tr>
			</thead>
			<tbody>
			<%for(int i=0;i<news.getCommentsList().size();i++){ %>
			<%Comments comments=news.getCommentsList().get(i); %>
				<tr>
					<td><%=comments.getMsg()%></td>
					<td><%=comments.getAuthor() %></td>
					<td><%=comments.getWritedate() %></td>
				</tr>
			<%} %>	
			</tbody>
		</table>
	</div>
</body>
</html>