<%@page import="repository.ReNoticeDAO"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("utf-8");  //파라미터에 대한 인코딩-> 인코딩 후 파라미터 받기%>
<% 
	//서버측에서 실행될 수 있는 jsp 태그를 가리켜 빈즈(객체) 태그라 함
%>
<jsp:useBean id="renotice" class="domain.ReNotice" />
<jsp:setProperty name="renotice" property="*" />
<%
	ReNoticeDAO reNoticeDAO=new ReNoticeDAO();
	int result=reNoticeDAO.insert(renotice);
	out.print(result);  //결과만 보내면 클라이언트가 이 결과로 무엇을 할지 알아서 하게 하자
	
	System.out.println(renotice.getTitle());
	System.out.println(renotice.getWriter());
	System.out.println(renotice.getContent());
%>
