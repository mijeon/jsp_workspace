package mvc.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import mvc.model.blood.MovieAdvisor;

public class MovieController extends HttpServlet{
	MovieAdvisor advisor=new MovieAdvisor();
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//파라미터 받기
				request.setCharacterEncoding("utf-8");
				String movie=request.getParameter("movie");
				
				//현재 코드에서, 웹이아닌 중립적인 자바 코드는 굳이 jsp 안에 둘 필요가 없음 
				//이유? 미래의 재사용성을 위해 별도로 분리시켜 놓아야 함
				String msg=advisor.getAdvice(movie);
				//출력은 가능하지만, 출력하면 안됨 그 이유는? M, V, C로 개발하기 위해 철저히 분리시키고 있는 상황에서
				//out.print() 하는 순간 뷰역활을 하게 됨
				System.out.println(msg);
				//결과를 보여주는 View 역할을 하는 페이지가 result.jsp이므로 result.jsp가 결과를 참조할 수 있도록 어딘가에 저장, session에 담아보자
				HttpSession session=request.getSession();  //세션 얻기
				session.setAttribute("msg", msg);
				
				//엔터프라이즈 급의 어플리케이션에서 모든 정보를 세션에 담아버리면 세션이 너무 비대해짐 
				//해결책 ? 세션의 역활을 수행할 수 있는 객체가 있다면 세션이 가벼워질 것임
				//요청이 들어오면 이 요청에 대해 응답을 보류하고 서버의 특정 서블릿으로 요청의 방향을 전달하는 방법을 가리켜 forwarding이라 함
				//포워딩을 이용하면 현재 요청에 대한 응답을 하지 않은 상태이므로 request, response 객체가 죽지 않고 유지됨
				//따라서 죽지 않은 request 객체에 원하는 정보를 세션에 담듯 이용할 수 있음
				//request.setAttribute("msg", msg);
				//RequestDispatcher dis=request.getRequestDispatcher("/movie/result.jsp");
				
				//포워딩 시작
				//dis.forward(request, response);  //죽지 않은 request, response 가져감
				
				PrintWriter out=response.getWriter();
				response.setContentType("text/html;charset=utf-8");
				out.print("<script>");
				out.print("location.href='/movie/result.jsp'");
				out.print("</script>");
			}
	}
