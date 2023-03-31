<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="com.edu.noticeapp.repository.NoticeDAO"%>
<%@ page import="com.edu.noticeapp.domain.Notice"%>

<%! 
	NoticeDAO noticeDAO=new NoticeDAO();
%>

<%
	//넘겨받은 4개의 파라미터를 이용해, update 문 수행
	//그리고 다시 상세 페이지 보여주기 (상세페이지 재요청)
	request.setCharacterEncoding("utf-8");
	String notice_idx=request.getParameter("notice_idx");
	String title=request.getParameter("title");
	String writer=request.getParameter("writer");
	String content=request.getParameter("content");

	//dto에 담기
	Notice notice=new Notice();
	notice.setNotice_idx(Integer.parseInt(notice_idx));
	notice.setTitle(title);
	notice.setWriter(writer);
	notice.setContent(content);
	
	out.print("넘겨받은 notice_idx = "+notice_idx+"<br>");
	out.print("넘겨받은 title = "+title+"<br>");
	out.print("넘겨받은 writer ="+writer+"<br>");
	out.print("넘겨받은 content = "+content+"<br>");

	int result=noticeDAO.update(notice);
	out.print("넘result= "+result);

	out.print("<script>");
	if(result>0){
		out.print("alert('글 수정 성공');");
		//웹 브라우저로 하여금 지정한 url로 다시 재접속하게 하자
		out.print("location.href='/notice/content.jsp?notice_idx="+notice_idx+"';");
	}else{
		out.print("alert('글 수정 실패');");
		out.print("history.back();");
	}
	out.print("</script>");
%>

