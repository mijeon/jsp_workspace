<%@page import="com.google.gson.Gson"%>
<%@page import="com.jspshop.util.MessageObj"%>
<%@page import="com.jspshop.domain.Admin"%>
<%@page import="com.jspshop.repository.AdminDAO"%>
<%@ page contentType="application/json; charset=UTF-8"%>
<%!
	AdminDAO adminDAO=new AdminDAO();
%>
<%
	//로그인 폼으로 부터 전송된 파라미터 받기
	String admin_id=request.getParameter("admin_id");
	String admin_pass=request.getParameter("admin_pass");
	
	//System.out.println(admin_id);
	//System.out.println(admin_pass);
	
	//dto 담기
	Admin admin=new Admin();  //empty dto
	admin.setAdmin_id(admin_id);
	admin.setAdmin_pass(admin_pass);
	
	Admin obj=adminDAO.select(admin);
	MessageObj msg=new MessageObj();
	Gson gson=new Gson();  //자바 객체 <--> json 변환
	
	if(obj!=null){  //객체가 존재한다는 것은 로그인이 일치, 즉 로그인 성공
		//세션객체에 obj를 담아두고 다음번에 들어왔을 경우에도 이 유저를 저장함
		//Session은 Map임 key-value 쌍으로 관리함
		session.setAttribute("admin", obj);  //세션에 저장
		msg.setCode(1);  //value 값
		msg.setMsg("인증성공");
		
	}else{  
		msg.setCode(0);
		msg.setMsg("로그인 정보가 올바르지 않습니다.");
	}
	String result=gson.toJson(msg);
	out.print(result);
%>