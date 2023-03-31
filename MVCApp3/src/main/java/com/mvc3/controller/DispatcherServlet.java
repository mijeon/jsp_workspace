package com.mvc3.controller;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.util.Properties;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/*
	모든 요청을 받는 1차 진입점이 되어야 하므로, mvc에서의 컨트롤로써의 역활을 서블릿이 담당하면 됨
	1) 요청 받음 (메인 컨트롤러)
	2) 요청 분석 (메인 컨트롤러)
	3) 로직객체에게 일 시킴 (서브 컨트롤러)
	4) 결과가 존재한다면 결과 저장 (서브 컨트롤러) -> 어디에 (application, session, request)
	5) 알맞는 결과 페이지를 보여줌 (메인 컨트롤러)
*/
public class DispatcherServlet extends HttpServlet {
	//2단계 업무인 '요청 분석' 단계에서 if문을 사용하지 않으려면 적어도 2단계 이전에는
	//이미 Properties가 준비되어 있어야 함 따라서 서블릿이 태어날 때 이미 준비해 놓자
	Properties props;
	FileInputStream fis;
	
	//ServletConfig : 서블릿에 전달된 환경 정보를 담고 있는 객체
	public void init(ServletConfig config) throws ServletException {
		props=new Properties();  //key-value 쌍을 해석할 수 있는 객체 생성
		
		try {
			//getRealPath()를 이용하려면, jsp의 경우 내장객체 중 application 내장객체를 이용하면 됨
			//하지만 이 영역은 서블릿이기에 application 내장객체의 자료형인 ServletContext 이용
			
			//서버가 가동될 때 서버의 전역적 정보를 가진 객체
			//jsp의 application 내장객체임
			ServletContext context=config.getServletContext();  
			
			String contextConfigLocation=config.getInitParameter("contextConfigLocation");
			System.out.println("넘겨받은 초기화 파라미터는 "+contextConfigLocation);
			
			String realPath=context.getRealPath(contextConfigLocation);
			System.out.println("매핑파일의 실제 파일 위치는 "+realPath);
			
			fis=new FileInputStream(realPath);  //(매핑파일의 위치)
			props.load(fis);
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doRequest(request, response);
	}
	
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doRequest(request, response);
	}
	
	protected void doRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//1단계) 요청 받음
		System.out.println("나 호출됨");
		
		//파라미터 인코딩 처리
		request.setCharacterEncoding("utf-8");
		
		//2단계) 요청 분석
		String uri=request.getRequestURI();
		System.out.println("당신의 요청 uri는 "+uri);
		
		String controllerPath=props.getProperty(uri); 
		System.out.println("요청 uri에 동작할 하위 컨트롤러의 경로는 "+controllerPath);
		try {
			//정적 영역에 원본을 올리고, 그 반환된 결과로 Class 자료형을 반환받자
			Class controllerClass=Class.forName(controllerPath);  //static 영역에 올라감 (거푸집 원본)
			
			//인스턴스 올리기
			//인스턴스를 메모리에 올리는 방법은 new 연산자만 있는 것이 아님
			Controller controller=(Controller)controllerClass.getDeclaredConstructor().newInstance();  //new 연산자 대체
			controller.execute(request, response);
			
			String viewName=controller.getViewName();  //주소 반환받기
			System.out.println("하위 컨트롤러에서 반환받은 뷰이름은 "+viewName);
			String viewPage=props.getProperty(viewName);  //jsp 검색
			System.out.println("뷰이름의 검색결과는 "+viewPage);
			
			//5단계) 결과가 있을 경우 포워딩, 결과가 없을 경우 redirect(재접속)
			//RequestDispatcher dis=request.getRequestDispatcher(viewName);  //포워딩 하고 싶은 주소 
			if(controller.ifForWard()) {  //포워딩할 경우
				RequestDispatcher dis=request.getRequestDispatcher(viewPage);  //포워딩 하고 싶은 주소 
				dis.forward(request, response);  //전달
			}else {  //리다이렉트할 경우 (재접속)
				//지정한 url로 재접속을 유도함, 클라이언트인 웹브라우저는 서버로부터 응답을 받자마자 지정한 url로 재접속을 시도하게됨
				//전화 끊구 새로운 다이얼을 눌러 새롭게 전화거는것과 같음
				response.sendRedirect(viewPage);
			}
			
			
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (InstantiationException e) {
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		} catch (IllegalArgumentException e) {
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			e.printStackTrace();
		} catch (NoSuchMethodException e) {
			e.printStackTrace();
		} catch (SecurityException e) {
			e.printStackTrace();
		}
	}
	//서블릿이 소멸될 때 호출되는 생명주기 메서드
	public void destroy() {
		//주로 자원을 닫는 코드를 작성
		if(fis!=null) {
			try {
				fis.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}
}