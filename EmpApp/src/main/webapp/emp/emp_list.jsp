<%@page import="com.google.gson.Gson"%>
<%@page import="emp.domain.Emp"%>
<%@page import="java.util.List"%>
<%@page import="emp.repository.EmpDAO"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%! 
	EmpDAO empDAO=new EmpDAO();
%>
<%
	//<%="출력예정">
	String deptno=request.getParameter("deptno");
	List<Emp> empList=empDAO.selectByFkey(Integer.parseInt(deptno));
	
	Gson gson=new Gson();
	String jsonList=gson.toJson(empList);
	out.print(jsonList);
	
	//jsp 직접 접근 시
	//http://localhost:9999/emp/emp_list.jsp?deptno=20
%>
