package com.mvc3.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mvc3.model.MovieAdvisor;

//혈액형에 대한 요청을 처리하는 하위 컨트롤러
//3단계 : 로직 객체에게 일 시키기
//4단계 : 결과가 존재한다면 저장
public class MovieController implements Controller {
	String TAG=this.getClass().getName();  //인스턴스가 메모리에 올라갈 때 명칭이 담아짐
	MovieAdvisor advisor=new MovieAdvisor();
	
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		System.out.println(TAG+"의 execute 호출");
		
		//3단계) 일시키기
		String movie=request.getParameter("movie");  //파라미터 받기
		String msg=advisor.getAdvice(movie);
		
		//4단계) 결과 저장 -> 포워딩
		request.setAttribute("msg", msg);
	}
	
	@Override
	public String getViewName() {
		return "/movie/view";
	}
}
