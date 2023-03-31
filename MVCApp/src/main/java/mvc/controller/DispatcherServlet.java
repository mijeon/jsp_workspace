package mvc.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mvc.controller.board.RegistController;

/*
	하위 컨트롤러들이 직접 요청을 받게 되면, 업무의 효율성과 유지보수성이 저하됨
	우리의 경우 너무 많은 서블릿 매핑이 필요하게 됨 따라서 규모가 아무리 커질지라도 
	모든 요청을 하나의 진입점으로 몰아서 요청의 유형을 분석하여 적절한 하위 컨트롤러들에게 배분
	
	컨트롤러의 전형적 업무
	1) 요청 받음 (입구컨트롤러)
	2) 요청 분석 (입구컨트롤러)
		-. 알맞는 하위컨트롤러를 선택해 요청 전달
	--------------------------------------------
	3) 알맞는 모델 객체에 업무 분배 (하위컨트롤러)
	4) 결과가 있을 경우 결과 저장 (웹인 경우 session, request에 저장) - (하위컨트롤러)
	5) 결과 보여줌 (.jsp) - (입구컨트롤러)
		-. DML은 반환 결과가 없으므로 select만 존재함
*/
public class DispatcherServlet extends HttpServlet{
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doRequest(request, response);
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doRequest(request, response);
	}
	
	protected void doRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		//1단계 : 요청 받음
		System.out.println("요청 받음");
		
		//2단계 : 현재 컨트롤러는 전문성이 없으므로 담당 컨트롤러를 선택함
		//"http://naver.com/news/list" -> url
		//"http://naver.com" -> uri
		String uri=request.getRequestURI();
		System.out.println("클라이언트의 요청 URI는 "+uri);
		
		//요청을 분석하자 왜? 
		//담당 컨트롤러에게 업무를 전달하기 위해
		if(uri.equals("/blood.do")) {
			//2단계) 혈액형 담당 컨트로러 호출
			BloodController controller=new BloodController();
			controller.excute(request, response);
			
		}else if(uri.equals("/movie.do")) {
			//2단계) 영화 담당 컨트롤러 호출
			MovieController controller=new MovieController();
			//controller.메세지();
		}else if(uri.equals("/board/regist.do")) {
			//2단계) 
			RegistController controller=new RegistController();
			controller.regist();
		}
		//5단계
		RequestDispatcher dis=request.getRequestDispatcher("/blood/result.jsp");
		
		//포워딩 시작
		dis.forward(request, response);  //죽지 않은 request, response 가져감
	}
}
