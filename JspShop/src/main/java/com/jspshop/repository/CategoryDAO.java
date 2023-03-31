package com.jspshop.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.jspshop.mybatis.MybatisConfig;

public class CategoryDAO {
	MybatisConfig config=MybatisConfig.getInstance();
	
	//목록 가져오기
	public List selectAll() {
		List list=null;
		SqlSession sqlSession=config.getSqlSession();
		list=sqlSession.selectList("Category.selectAll");
		config.release(sqlSession);
		
		return list;
	}
}

