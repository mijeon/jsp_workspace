package news.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import news.domain.News;
import news.mybatis.MybatisConfig;

public class NewsDAO {
	//SqlSessionFactory가 객체에 존재함
	MybatisConfig config=MybatisConfig.getInstance();
	
	//글 한건 등록하기
	public int insert(News news) {
		int result=0;
		SqlSession sqlSession=config.getSqlSession();
		result=sqlSession.insert("News.insert" , news);
		sqlSession.commit();
		config.release(sqlSession);
		
		return result;
	}
	
	//목록 가져오기
	public List selectAll() {
		List list=null;
		SqlSession sqlSession=config.getSqlSession();
		list=sqlSession.selectList("News.selectAll");
		config.release(sqlSession);
		
		return list;
	}
	
	//한건 가져오기
	public News select(int news_idx) {
		News news=null;
		SqlSession sqlSession=config.getSqlSession();
		news=sqlSession.selectOne("News.select", news_idx);
		config.release(sqlSession);
		
		return news;
	}
	
	//수정
	public int update(News news) {
		int result=0;
		SqlSession sqlSession=config.getSqlSession();
		result=sqlSession.update("News.update", news);
		sqlSession.commit();
		config.release(sqlSession);
		
		return result;
	}
	
	//삭제
	public int delete(int news_idx) {
		int result=0;
		SqlSession sqlSession=config.getSqlSession();
		result=sqlSession.delete("News.delete", news_idx);
		sqlSession.commit();
		config.release(sqlSession);
		
		return result;
	}
}
