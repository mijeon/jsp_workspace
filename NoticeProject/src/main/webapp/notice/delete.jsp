<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="com.edu.noticeapp.repository.NoticeDAO"%>
<%!
	NoticeDAO noticeDAO=new NoticeDAO();
%>

<%
	int notice_idx=Integer.parseInt(request.getParameter("notice_idx"));

	String sql="delete notice where notice_idx="+notice_idx;
	out.print(sql);
	
	//삭제하기
	int result=noticeDAO.delete(notice_idx);  //pk
	out.print("<script>");
	if(result>0){
		out.print("alert('삭제 성공');");
		out.print("location.href='/notice/list.jsp';");
	}else{
		out.print("alert('삭제 실패');");
		out.print("history.back();");
	}
		out.print("</script>");
%>