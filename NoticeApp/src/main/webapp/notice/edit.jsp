<%@page import="repository.ReNoticeDAO"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	ReNoticeDAO reNoticeDAO=new ReNoticeDAO();
%>
<% request.setCharacterEncoding("utf-8");%>
<jsp:useBean id="renotice" class="domain.ReNotice"/>
<jsp:setProperty property="*" name="renotice"/>
<% 
	int result=reNoticeDAO.update(renotice);
	out.print(result);
%>