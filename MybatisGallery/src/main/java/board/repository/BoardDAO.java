package board.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import board.domain.Board;
import board.mybatis.MybatisConfig;

public class BoardDAO {
	//아래의 싱글턴 객체의 인스턴스가 메모리에 생성될 때, 동시에 맴버변수로 존재하는 SqlSessionFactory로 올라감 (한번만)
	MybatisConfig config=MybatisConfig.getInstance();
	
	//등록
	public int insert(Board board) {
		int result=0;
		SqlSession sqlSession= config.getSqlSession();
		result=sqlSession.insert("Board.insert", board);  //(쿼리문 들어있는 xml 코드 id, dao)
		sqlSession.commit();  //DML일 경우 커밋
		config.release(sqlSession);  //닫기
		return result;
	}
	
	//모두 가져오기
	public List selectAll() {	
		List list=null;
		SqlSession sqlSession=config.getSqlSession();
		list=sqlSession.selectList("Board.selectAll");
		config.release(sqlSession);
		
		return list;
	}
	
	//한건 가져오기
	public Board select(int board_idx) {
		Board board=null;
		SqlSession sqlSession=config.getSqlSession();
		board=sqlSession.selectOne("Board.select", board_idx);
		config.release(sqlSession);
		
		return board;
	}
	
	//수정
	public int update(Board board) {
		/*
		 * System.out.println("board_idx = "+board.getBoard_idx());
		 * System.out.println("title = "+board.getTitle());
		 * System.out.println("writer = "+board.getWriter());
		 * System.out.println("content = "+board.getContent());
		 * System.out.println("filename = "+board.getFilename());
		 */		
		
		int result=0;
		SqlSession sqlSession=config.getSqlSession();
		result=sqlSession.update("Board.update", board);
		sqlSession.commit();  //DML
		config.release(sqlSession);
		
		return result;
	}
}
