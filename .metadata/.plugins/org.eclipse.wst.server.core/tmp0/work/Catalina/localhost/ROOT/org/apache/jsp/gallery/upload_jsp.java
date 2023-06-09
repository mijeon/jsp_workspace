/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/9.0.70
 * Generated at: 2023-01-10 01:27:52 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp.gallery;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import gallery.domain.Gallery;
import gallery.repository.GalleryDAO;
import gallery.util.FileManager;
import java.io.File;
import java.io.IOException;
import com.oreilly.servlet.MultipartRequest;

public final class upload_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent,
                 org.apache.jasper.runtime.JspSourceImports {

 
	GalleryDAO galleryDAO=new GalleryDAO();

  private static final javax.servlet.jsp.JspFactory _jspxFactory =
          javax.servlet.jsp.JspFactory.getDefaultFactory();

  private static java.util.Map<java.lang.String,java.lang.Long> _jspx_dependants;

  private static final java.util.Set<java.lang.String> _jspx_imports_packages;

  private static final java.util.Set<java.lang.String> _jspx_imports_classes;

  static {
    _jspx_imports_packages = new java.util.HashSet<>();
    _jspx_imports_packages.add("javax.servlet");
    _jspx_imports_packages.add("javax.servlet.http");
    _jspx_imports_packages.add("javax.servlet.jsp");
    _jspx_imports_classes = new java.util.HashSet<>();
    _jspx_imports_classes.add("gallery.util.FileManager");
    _jspx_imports_classes.add("gallery.repository.GalleryDAO");
    _jspx_imports_classes.add("gallery.domain.Gallery");
    _jspx_imports_classes.add("java.io.IOException");
    _jspx_imports_classes.add("java.io.File");
    _jspx_imports_classes.add("com.oreilly.servlet.MultipartRequest");
  }

  private volatile javax.el.ExpressionFactory _el_expressionfactory;
  private volatile org.apache.tomcat.InstanceManager _jsp_instancemanager;

  public java.util.Map<java.lang.String,java.lang.Long> getDependants() {
    return _jspx_dependants;
  }

  public java.util.Set<java.lang.String> getPackageImports() {
    return _jspx_imports_packages;
  }

  public java.util.Set<java.lang.String> getClassImports() {
    return _jspx_imports_classes;
  }

  public javax.el.ExpressionFactory _jsp_getExpressionFactory() {
    if (_el_expressionfactory == null) {
      synchronized (this) {
        if (_el_expressionfactory == null) {
          _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
        }
      }
    }
    return _el_expressionfactory;
  }

  public org.apache.tomcat.InstanceManager _jsp_getInstanceManager() {
    if (_jsp_instancemanager == null) {
      synchronized (this) {
        if (_jsp_instancemanager == null) {
          _jsp_instancemanager = org.apache.jasper.runtime.InstanceManagerFactory.getInstanceManager(getServletConfig());
        }
      }
    }
    return _jsp_instancemanager;
  }

  public void _jspInit() {
  }

  public void _jspDestroy() {
  }

  public void _jspService(final javax.servlet.http.HttpServletRequest request, final javax.servlet.http.HttpServletResponse response)
      throws java.io.IOException, javax.servlet.ServletException {

    if (!javax.servlet.DispatcherType.ERROR.equals(request.getDispatcherType())) {
      final java.lang.String _jspx_method = request.getMethod();
      if ("OPTIONS".equals(_jspx_method)) {
        response.setHeader("Allow","GET, HEAD, POST, OPTIONS");
        return;
      }
      if (!"GET".equals(_jspx_method) && !"POST".equals(_jspx_method) && !"HEAD".equals(_jspx_method)) {
        response.setHeader("Allow","GET, HEAD, POST, OPTIONS");
        response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "JSP들은 오직 GET, POST 또는 HEAD 메소드만을 허용합니다. Jasper는 OPTIONS 메소드 또한 허용합니다.");
        return;
      }
    }

    final javax.servlet.jsp.PageContext pageContext;
    javax.servlet.http.HttpSession session = null;
    final javax.servlet.ServletContext application;
    final javax.servlet.ServletConfig config;
    javax.servlet.jsp.JspWriter out = null;
    final java.lang.Object page = this;
    javax.servlet.jsp.JspWriter _jspx_out = null;
    javax.servlet.jsp.PageContext _jspx_page_context = null;


    try {
      response.setContentType("text/html; charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;

      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");

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

      out.write("\r\n");
      out.write("<!DOCTYPE html>\r\n");
      out.write("<html>\r\n");
      out.write("<head>\r\n");
      out.write("<meta charset=\"UTF-8\">\r\n");
      out.write("<title>Insert title here</title>\r\n");
      out.write("</head>\r\n");
      out.write("<body>\r\n");
      out.write("\r\n");
      out.write("</body>\r\n");
      out.write("</html>");
    } catch (java.lang.Throwable t) {
      if (!(t instanceof javax.servlet.jsp.SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          try {
            if (response.isCommitted()) {
              out.flush();
            } else {
              out.clearBuffer();
            }
          } catch (java.io.IOException e) {}
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
