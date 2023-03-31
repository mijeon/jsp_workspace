package emp.repository;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import emp.mybatis.MybatisConfig;

public class EmpDAO {
	MybatisConfig config=MybatisConfig.getInstance();
	
	//부서번호에 소속된 모든 사원가져오기
	public List selectByFkey(int deptno) {
		List list=null;
		SqlSession sqlSession=config.getSqlSession();
		list=sqlSession.selectList("Emp.selectByFkey", deptno);
		config.release(sqlSession);
		
		return list;
	}
	
	//사원검색
	public List selectBySearch(Map map) {
		List list=null;
		SqlSession sqlSession=config.getSqlSession();
		list=sqlSession.selectList("Emp.selectBySearch", map);
		config.release(sqlSession);
		
		return list;
	}
	
}
