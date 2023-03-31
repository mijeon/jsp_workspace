<%@page import="com.google.gson.Gson"%>
<%@page import="emp.domain.Emp"%>
<%@page import="java.util.List"%>
<%@page import="emp.repository.EmpDAO"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%! EmpDAO empDAO=new EmpDAO();%>
<%
	List<Emp> empList=empDAO.selectAll();

	Gson gson=new Gson();
	
	String result = gson.toJson(empList);
	out.print(result);
%>