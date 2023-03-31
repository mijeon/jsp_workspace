package mvcapp2.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mvcapp2.model.movie.MovieAdvisor;

//3단계) 알맞는 비즈니스 로직 객체에게 일을 시키는 하위컨트롤러 정의
public class MovieController {
	MovieAdvisor advisor=new MovieAdvisor();
	
	public void hendle(HttpServletRequest request, HttpServletResponse response) {
		//3단계) 알맞는 로직 객체에 일 시키기
		String movie=request.getParameter("movie");
		String msg=advisor.getAdvice(movie);
		
		//4단계) 추후 DispatcherSevlet이 포워딩을 처리할 때 request 객체를 사용하므로 결과를 이 객체어 저장
		request.setAttribute("msg", msg);
	}
}
