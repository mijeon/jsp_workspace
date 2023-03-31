package mvcapp2.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mvcapp2.model.blood.BloodAdvisor;

//3단계) 알맞는 비즈니스 로직 객체에게 일을 시키는 하위컨트롤러 정의
public class BloodController {
	BloodAdvisor advisor=new BloodAdvisor();  
	
	public void excute(HttpServletRequest request, HttpServletResponse response) {
		//3단계) 알맞는 로직 객체에 일 시키기
		String blood=request.getParameter("blood");
		String msg=advisor.getAdvice(blood);  //클라이언트에게 전달해야 함
		
		//4단계) (클라이언트에게 전달할)결과가 있으므로 임시적으로 저장해 놓아야 함, 저장 시 session 보다는 request에 보관함
		//여기서의 request 객체는 응답하기 전까지는 생명력이 있으므로 포워딩 처리로 전달하면 뷰인 jsp까지는 죽지않고 도달할 수 있음
		//이 경우 굳이 session을 이용할 필요없음
		//이 단계에서 응답하지 않고 꾹 참고 있다가 5단계에서 포워딩함
		request.setAttribute("msg", msg);  //결과저장	
	}
}
