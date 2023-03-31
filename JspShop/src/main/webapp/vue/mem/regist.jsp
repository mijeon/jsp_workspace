<%@page import="com.google.gson.Gson"%>
<%@page import="com.jspshop.util.MessageObj"%>
<%@page import="com.jspshop.exception.MemberException"%>
<%@page import="org.apache.ibatis.session.SqlSession"%>
<%@page import="com.jspshop.mybatis.MybatisConfig"%>
<%@page import="com.jspshop.repository.MemberDAO"%>
<%@ page contentType="application/json;charset=UTF-8"%>
<%!
	MybatisConfig mybatisConfig=MybatisConfig.getInstance(); 
	MemberDAO memberDAO=new MemberDAO();
%>
<%
	//dao에게 주입(injection)
	SqlSession sqlSession=mybatisConfig.getSqlSession();
	memberDAO.setSqlSession(sqlSession);
	
	//파라미터 받기 전에 설정 (한글 깨짐 방지)
	request.setCharacterEncoding("utf-8");
	
%>
<jsp:useBean id="member" class="com.jspshop.domain.Member"/>
<jsp:setProperty property="*" name="member"/>
<% 
	System.out.println(member.getId());
	System.out.println(member.getPass());
	System.out.println(member.getName());
	System.out.println(member.getEmail());
	
	MessageObj msg=new MessageObj();
	try{
		memberDAO.insert(member);
		msg.setCode(1);
		msg.setMsg("등록성공");
		sqlSession.commit();
	}catch(MemberException e){
		msg.setCode(0);
		msg.setMsg(e.getMessage());  //에러메세지 자동 채우기
	}
	Gson gson=new Gson();
	out.print(gson.toJson(msg));  //JSON 문자열로 변환하여 결과 전송
	
	
	//쿼리 수행 객체 닫기
	mybatisConfig.release(sqlSession);
%>