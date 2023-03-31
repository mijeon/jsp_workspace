<%@page import="com.google.gson.Gson"%>
<%@page import="renotice.domain.Renotice"%>
<%@page import="java.util.List"%>
<%@page import="renotice.repository.RenoticeDAO"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%!
	RenoticeDAO renoticeDAO=new RenoticeDAO();
%>
<%
	List<Renotice> renoticeList= renoticeDAO.selectAll();
	Gson gson=new Gson();
	String gsonList=gson.toJson(renoticeList);
	out.print(gsonList);
%>