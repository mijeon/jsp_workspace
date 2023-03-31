package com.mvc3.controller.emp;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;

import com.mvc3.controller.Controller;
import com.mvc3.domain.Dept;
import com.mvc3.domain.Emp;
import com.mvc3.exception.DeptException;
import com.mvc3.exception.EmpException;
import com.mvc3.model.emp.DeptDAO;
import com.mvc3.model.emp.EmpDAO;
import com.mvc3.mybatis.MybatisConfig;

//사원 신규 등록 요청을 처리하는 하위 컨트롤러 (부서 + 사원)
//현재는 컨트롤러가 전문적임, 데이터베이스 업무는 Model이 처리해야 함
public class RegistController2 implements Controller{
	EmpDAO empDAO=new EmpDAO();
	DeptDAO deptDAO=new DeptDAO();
	MybatisConfig mybatisConfig=MybatisConfig.getInstance();
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		SqlSession sqlSession=mybatisConfig.getSqlSession();
		deptDAO.setSqlSession(sqlSession);  //주입
		empDAO.setSqlSession(sqlSession);  //주입
		
		//파라미터 받기
		String dname=request.getParameter("dname");
		String ename=request.getParameter("ename");
		String sal=request.getParameter("sal");
		
		//3단계) 일시키기
		Dept dept=new Dept();  //부서 dto
		dept.setDname(dname);
		
		Emp emp=new Emp();  //사원 dto
		emp.setEname(ename);
		emp.setSal(Integer.parseInt(sal));
		emp.setDept(dept);
		
		try {
			deptDAO.insert(dept);  //부서등록
			empDAO.insert(emp);  //사원등록
			sqlSession.commit();
		} catch (DeptException e) {
			sqlSession.rollback();
			e.printStackTrace();
		}catch (EmpException e) {
			sqlSession.rollback();
			e.printStackTrace();
		}
		mybatisConfig.release(sqlSession);  //session 닫기
	}

	@Override
	public String getViewName() {
		return "/emp/view/regist";
	}

	@Override
	public boolean ifForWard() {
		return false;
	}
	
}
