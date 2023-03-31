<%@page import="com.google.gson.Gson"%>
<%@page import="emp.domain.Dept"%>
<%@page import="java.util.List"%>
<%@page import="emp.repository.DeptDAO"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%!
	DeptDAO deptDAO=new DeptDAO();
%>
<%
	//out.print("안녕");
	List<Dept> deptList=deptDAO.selectAll();
	Gson gson=new Gson();  //자바객체 <-- 서로 변환 --> json
	 String jsonList=gson.toJson(deptList);
	out.print(jsonList);
%>