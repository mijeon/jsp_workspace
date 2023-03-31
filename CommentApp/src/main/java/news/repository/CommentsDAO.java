package news.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import news.domain.Comments;
import news.mybatis.MybatisConfig;

public class CommentsDAO {
	MybatisConfig config=MybatisConfig.getInstance();
	
	//글 한건 넣기
	public int insert(Comments comments) {
		int result=0;
		SqlSession sqlSession=config.getSqlSession();
		result = sqlSession.insert("Comments.insert", comments);
		sqlSession.commit();
		config.release(sqlSession);
		
		return result;
	}
	
	//댓글수 가져오기 
	public List selectComments(int news_idx) {
		List list=null;
		SqlSession sqlSession=config.getSqlSession();
		list=sqlSession.selectList("Comments.selectAllByFkey", news_idx);
		config.release(sqlSession);
		return list;
	}
	
	//댓글 삭제
	public int delete(int comments_idx) {
		int result=0;
		SqlSession sqlSession=config.getSqlSession();
		result=sqlSession.delete("Comments.delete", comments_idx);
		sqlSession.commit();
		config.release(sqlSession);
		
		return result;
	}
}
