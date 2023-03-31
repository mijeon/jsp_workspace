package emp.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import store.mybatis.MybatisConfig;

public class DeptDAO {
	MybatisConfig config=MybatisConfig.getInstance();
	
	//부서 목록 가져오기
	public List selectAll() {
		List list=null;
		SqlSession sqlSession=config.getSqlSession();
		list=sqlSession.selectList("Dept.selectAll");
		config.release(sqlSession);
		
		return list;
	}
}
