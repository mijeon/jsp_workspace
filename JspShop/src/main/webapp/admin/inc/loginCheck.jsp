<%@page import="com.jspshop.domain.Admin"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%
    //지금 요청이 들어온 클라이언트와 연계된 세션에 admin이라는 키값이 있다면 그 키값을 이용하여 adminDTO를 끄집어낸다
    Admin admin=(Admin)session.getAttribute("admin");
	
	/*
	out.print("<script>");
	if(admin==null){
		out.print("alert('로그인이 필요한 서비스입니다.');");
		out.print("history.back();");
	}
	out.print("</script>");
	*/
%>