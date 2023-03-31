package com.mvc3.model.emp;

import org.apache.ibatis.session.SqlSession;

import com.mvc3.domain.Dept;
import com.mvc3.exception.DeptException;

public class DeptDAO {
	private SqlSession sqlSession;
	
	//트랜잭션을 위해 주입받음
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	//부서 등록
	public void insert(Dept dept) throws DeptException {
		int result=0;
		result=sqlSession.insert("Dept.insert", dept);
		if(result<1) {
			throw new DeptException("부서등록 실패");
		}
	}
	
	//부서 한개 지우기
	public void delete(int deptno) throws DeptException {
		int result=sqlSession.delete("Dept.delete", deptno);
		if(result<1) {
			throw new DeptException("부서삭제 실패");
		}
	}
}
