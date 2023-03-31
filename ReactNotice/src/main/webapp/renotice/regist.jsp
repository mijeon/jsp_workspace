<%@page import="renotice.domain.Renotice"%>
<%@page import="renotice.repository.RenoticeDAO"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%!
	RenoticeDAO renoticeDAO=new RenoticeDAO();
%>
<%
	//파라미터 받기
	String title=request.getParameter("title");
	String writer=request.getParameter("writer");
	String content=request.getParameter("content");
	
	//dto 넣기
	Renotice renotice=new Renotice();  //empty dto
	renotice.setTitle(title);
	renotice.setWriter(writer);
	renotice.setContent(content);
	
	System.out.print("title is "+title);
	System.out.print("writer is "+writer);
	System.out.print("content is "+content);
	
	int result=renoticeDAO.insert(renotice);
	out.print(result);
%>