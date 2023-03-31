package mvcapp2.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

//어플리케이션의 모든 요청을 혼자 다 받아서, 보다 전문적인 하위 컨트롤러에 전달하기 위한 진입점 컨트롤러 클래스
//이 클래스의 존재가 없을 경우, 하위 모든 컨트롤러들은 직접 서블릿으로 정의하여 매핑하기 때문에 
//각 컨트롤러 간의 일관성이 없어서 유지보수성이 오히려 힘들어짐
public class DispatcherServlet extends HttpServlet {
	//온갖 종류의 요청을 받아야 하므로 Get, Post 가리지 않고 처리되어야함
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doRequest(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doRequest(request, response);
	}
	
	//post와 get 요청을 하나의 공통 메서드에서 처리
	protected void doRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//1단계) 요청 받음
		//요청 파라미터에 대한 처리를 이 시점에 해두면 하위컨트롤러에서 처리할 필요가 없음
		request.setCharacterEncoding("utf-8");  //한글 깨짐 방지
		
		//2단계) 요청 분석
		String uri=request.getRequestURI();  //uri 받아옴
		if(uri.equals("/blood.do")) {
			//혈액형 전문 하위컨트롤러 생성 후 메서드 호출
			BloodController controller=new BloodController();
			controller.excute(request, response);
			
			//5단계) 결과 응답 방법1) 포워딩 : 포워딩은 서블릿에서 해줌 (코드 중복 방지)
			//request를 살려서 뷰인 jsp까지 가져가기
			//클라이언트는 blood.do 주소값이지만 result.jsp 화면을 보여줌
			RequestDispatcher dis=request.getRequestDispatcher("/blood/result.jsp");
			dis.forward(request, response);  //포워딩 (기존 요청, 응답 객체)
			
			//5단계) 결과응답 방법2) 재접속 : 응답을 받은 클라이언트가 지정한 url로 다시 접속 = out.print("<script>")와 동일
			//response.sendRedirect("/blood/result.jsp");
			
		}else if(uri.equals("/movie.do")){
			//영화 전문 하위컨트롤러 생성 후 메서드 호출
			MovieController controller=new MovieController();
			controller.hendle(request, response);
		}
		
		//5단계) 결과 응답 포워딩 : 포워딩은 서블릿에서 해줌 (코드 중복 방지)
		//request를 살려서 뷰인 jsp까지 가져가기
		RequestDispatcher dis=request.getRequestDispatcher("/movie/result.jsp");
		dis.forward(request, response);  //포워딩 (기존 요청, 응답 객체)
		
	}
}
