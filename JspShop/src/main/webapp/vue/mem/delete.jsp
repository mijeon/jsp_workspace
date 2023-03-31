<%@page import="com.google.gson.Gson"%>
<%@page import="com.jspshop.util.MessageObj"%>
<%@page import="com.jspshop.exception.MemberException"%>
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

	String member_idx=request.getParameter("member_idx");
	
	MessageObj msg=new MessageObj();
	
	try{
		memberDAO.delete(Integer.parseInt(member_idx));
		sqlSession.commit();
		msg.setCode(1);
		msg.setMsg(member_idx+"회원삭제 성공");
	}catch(MemberException e){
		msg.setCode(0);
		msg.setMsg("회원삭제 실패");
	}
	mybatisConfig.release(sqlSession);
	Gson gson=new Gson();
	out.print(gson.toJson(msg));
	
%>