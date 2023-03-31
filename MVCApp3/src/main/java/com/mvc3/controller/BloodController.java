package com.mvc3.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mvc3.model.BloodAdvisor;

//혈액형에 대한 요청을 처리하는 하위 컨트롤러
//3단계 : 로직 객체에게 일 시키기
//4단계 : 결과가 존재한다면 저장
public class BloodController implements Controller{
	String TAG=this.getClass().getName();  //인스턴스가 메모리에 올라갈 때 명칭이 담아짐
	BloodAdvisor advisor=new BloodAdvisor();
	
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		System.out.println(TAG+"의 execute 호출");
		
		//3단계) 알맞는 로직객체에 일시키기
		String blood=request.getParameter("blood");
		String msg=advisor.getAdvice(blood);
		
		//4단계) 결과가 존재한다면 저장 -> request와 response 객체가 아직 살아있으므로, 요청 객체에 결과 저장
		//결과 저장 절차가 있을 경우 request는 무조건 살아있어야 하므로 5단계에서 포워딩함(유지)
		request.setAttribute("msg", msg);  //set의 경우 (key, value)
	}
	
	@Override
	public String getViewName() {
		return "/blood/view";
	}
}
