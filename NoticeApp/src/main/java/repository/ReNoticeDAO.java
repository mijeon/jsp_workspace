package repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import domain.ReNotice;
import mybatis.MybatisConfig;

public class ReNoticeDAO {
	MybatisConfig config=MybatisConfig.getInstance();
	
	//모두 가져오기
	public List selectAll() {
		List list=null;
		SqlSession sqlSession=config.getSqlSession();
		list=sqlSession.selectList("ReNotice.selectAll");
		config.release(sqlSession);
		return list;
	}
	
	//한건 가져오기
	public ReNotice select() {
		ReNotice renotice=null;
		SqlSession sqlSession=config.getSqlSession();
		renotice=sqlSession.selectOne("ReNotice.select");
		config.release(sqlSession);
		return renotice;
	}
	
	//한건 등록
	public int insert(ReNotice renotice) {
		int result=0;
		SqlSession sqlSession=config.getSqlSession();
		result=sqlSession.insert("ReNotice.insert", renotice);
		sqlSession.commit();
		config.release(sqlSession);
		return result;
	}
	
	//수정
	public int update(ReNotice renotice) {
		int result=0;
		SqlSession sqlSession=config.getSqlSession();
		result=sqlSession.update("ReNotice.update", renotice);
		sqlSession.commit();
		config.release(sqlSession);
		return result;
	}
	
	//삭제
	public int delete(int renotice_idx) {
		int result=0;
		SqlSession sqlSession=config.getSqlSession();
		result=sqlSession.delete("ReNotice.delete", renotice_idx);
		sqlSession.commit();
		config.release(sqlSession);
		return result;
	}
}
