package renotice.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import renotice.domain.Renotice;
import renotice.mybatis.MybatisConfig;

public class RenoticeDAO {
	MybatisConfig config=MybatisConfig.getInstance();
	
	//등록하기
	public int insert(Renotice renotice) {
		int result=0;
		SqlSession sqlSession=config.getSqlSession();
		result=sqlSession.insert("Renotice.insert", renotice);
		sqlSession.commit();
		config.release(sqlSession);
		return result;
	}
	
	//목록 전체 가져오기
	public List selectAll() {
		List list=null;
		SqlSession sqlSession=config.getSqlSession();
		list=sqlSession.selectList("Renotice.selectAll");
		config.release(sqlSession);
		
		return list;
	}
}
