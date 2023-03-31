<%@page import="repository.ReNoticeDAO"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%!
	ReNoticeDAO reNoticeDAO=new ReNoticeDAO();
%>
<% 
	String renotice_idx=request.getParameter("renotice_idx");
	int result=reNoticeDAO.delete(Integer.parseInt(renotice_idx));
	out.print(result);
%>