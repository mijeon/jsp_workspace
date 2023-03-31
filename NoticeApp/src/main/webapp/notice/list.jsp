<%@page import="domain.ReNotice"%>
<%@page import="repository.ReNoticeDAO"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page contentType="application/json; charset=UTF-8"%>
<%!ReNoticeDAO noticeDAO=new ReNoticeDAO();%>
<%
	List<ReNotice> noticeList=noticeDAO.selectAll();  //new ArrayList()
	
	/*
	for(int i=0;i<10;i++){
			Notice notice=new Notice();
			notice.setRenotice_idx(i);
			notice.setTitle("줄넘기 "+i+"회");
			notice.setWriter("작성자"+i);
			notice.setRegdate("2023-01"+i);
			notice.setHit(i);
			noticeList.add(notice);
	}
*/
		
		Gson gson=new Gson();
		String jsonList=gson.toJson(noticeList);
		out.print(jsonList);
%>