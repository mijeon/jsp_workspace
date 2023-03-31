<%@page import="com.google.gson.Gson"%>
<%@page import="emp.domain.Emp"%>
<%@page import="java.util.List"%>
<%@page import="emp.repository.EmpDAO"%>
<%@page import="java.util.HashMap"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%!
	EmpDAO empDAO=new EmpDAO();
%>
<%
	String category = request.getParameter("category");
	String keyword = request.getParameter("keyword");
	
	System.out.println("category is "+category);
	System.out.println("keyword is "+keyword);
	
	//DTO가 검색기능을 담을 수 없기 때문에 Map에 담아서 mybatis에 전달
	HashMap<String, String> map=new HashMap();  //key, value가 문자열임
	map.put("category", category);  //컬럼명 담기
	map.put("keyword", keyword);  //컬럼명 담기
	
	List<Emp> empList=empDAO.selectBySearch(map);
	Gson gson=new Gson();
	out.print(gson.toJson(empList));
	
	//jsp 직접 접근 시 주소창에 아래로 검색 
	//http://localhost:9999/emp/emp_search.jsp?category=ename&keyword=S
%>
