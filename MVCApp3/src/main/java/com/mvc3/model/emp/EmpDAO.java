package com.mvc3.model.emp;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.mvc3.domain.Emp;
import com.mvc3.exception.EmpException;

public class EmpDAO {
	private SqlSession sqlSession;
	
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	//사원 등록
	public void insert(Emp emp) throws EmpException {
		int result=0;
		result=sqlSession.insert("Emp.insert", emp);
		if(result<1) {
			throw new EmpException("사원등록 실패");
		}
	}
	
	//모든 사원 가져오기
	public List selectAll() {
		return sqlSession.selectList("Emp.selectAll");
	}
	
	//사원 한명 가져오기
	public Emp select(int empno) {
		return sqlSession.selectOne("Emp.select", empno);
	}
	
	//사원 한명 지우기
	public void delete(int empno) throws EmpException {
		int result=sqlSession.delete("Emp.delete", empno);
		if(result<1) {
			throw new EmpException("사원삭제 실패");
		}
	}
}
