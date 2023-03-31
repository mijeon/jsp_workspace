<%@page import="com.google.gson.Gson"%>
<%@page import="com.jspshop.util.MessageObj"%>
<%@page import="com.jspshop.exception.MemberException"%>
<%@page import="com.jspshop.domain.Member"%>
<%@page import="org.apache.ibatis.session.SqlSession"%>
<%@page import="com.jspshop.repository.MemberDAO"%>
<%@page import="com.jspshop.mybatis.MybatisConfig"%>
<%@ page contentType="application/json;charset=UTF-8"%>
<%!
	MybatisConfig mybatisConfig=MybatisConfig.getInstance();
	MemberDAO memberDAO=new MemberDAO();
%>
<%
	SqlSession sqlSession=mybatisConfig.getSqlSession();
	memberDAO.setSqlSession(sqlSession);
	
	//파라미터 받기 
	String id=request.getParameter("id");
	String pass=request.getParameter("pass");
	String name=request.getParameter("name");
	String email=request.getParameter("email");

	Member member=new Member();  //empty dto
	member.setId(id);
	member.setPass(pass);
	member.setName(name);
	member.setEmail(email);
	
	MessageObj messageObj = new MessageObj();
	try{
		memberDAO.insert(member);		
		messageObj.setCode(1);
		messageObj.setMsg("회원가입 성공");
		sqlSession.commit();
	}catch(MemberException e){
		e.printStackTrace();
		messageObj.setCode(0);
		messageObj.setMsg(e.getMessage());
		sqlSession.rollback();
	}finally{
		mybatisConfig.release(sqlSession);
	}
	Gson gson = new Gson();
	String msg = gson.toJson(messageObj);
	
	out.print(msg);
%>