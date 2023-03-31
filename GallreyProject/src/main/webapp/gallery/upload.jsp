<%@page import="gallery.domain.Gallery"%>
<%@page import="gallery.repository.GalleryDAO"%>
<%@page import="board.util.FileManager"%>
<%@page import="java.io.File"%>
<%@page import="java.io.IOException"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page contentType="text/html; charset=UTF-8"%>

<%! 
	GalleryDAO galleryDAO=new GalleryDAO();
%>

<%
	//파라미터를 받아 오라클에 넣기
	request.setCharacterEncoding("utf-8");  //파라미터에 대한 한글깨짐 방지
	
	//클라이언트가 파일을 포함하여, 인코딩된 형식으로 요청을 시도할 경우 
	//기존의 텍스트 파라미터를 받을 때 사용한 getParameter() 메서드로는 
	//바이너리파일을 포함한 기타 파라미터도 받을 수 없음
	//해결책) 업로드 라이브러리를 이용해야 함
	//ServletContext context=request.getServletContext();
	
	//우리가 서블릿에서 사용하던 ServletContext 인터페이스는 jsp에서 내장 객체로 지원을 하고 있음
	//따라서 서블릿을 할줄 모르는 개발자는 내장객체를 이용할 수 있음
	String savePath=application.getRealPath("/data/");
	
	//String savePath="C:/jsp_workspace/GallreyProject/src/main/webapp/data/";
	int maxSize=1024*1024*5;  //5MB 제한
	MultipartRequest multi=null;
	
	try{
		multi=new MultipartRequest(request, savePath, maxSize, "utf-8");
		//이미 생성자에서 업로드가 완료되었기 때문에, 생성된 파일을 대상으로 파일명을 바꾸자
		File file=multi.getFile("file");  //html에서의 컴포넌트 이름
		long time=System.currentTimeMillis();  //파일명에 사용할 숫자
		String ext=FileManager.getExt(file.getName());  //파일명
		
		file.renameTo(new File(savePath+time+"."+ext));  //바꿀 파일명 
		
		String title=multi.getParameter("title");
		String writer=multi.getParameter("writer");
		String content=multi.getParameter("content");
		
		//DTO에 담기
		Gallery gallery=new Gallery();
		gallery.setTitle(title);
		gallery.setWriter(writer);
		gallery.setContent(content);
		gallery.setFilename(time+"."+ext);
		
		//dao insert 호출
		int result=galleryDAO.insert(gallery);
		
		out.print("<script>");
		if(result>0){
			out.print("alert('업로드 성공');");
			out.print("location.href='/gallery/list.jsp';");
		}
		out.print("</script>");
	}catch(IOException e){
		out.print("<script>");
		out.print("alert('파일의 크기는 5MB 이하로 재한되어 있습니다.');");
		out.print("history.back();");
		out.print("<script>");
	}
	
	//String file=request.getParameter("file");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>