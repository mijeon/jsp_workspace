package com.jspshop.repository;

import org.apache.ibatis.session.SqlSession;

import com.jspshop.domain.Admin;
import com.jspshop.mybatis.MybatisConfig;

public class AdminDAO {
	MybatisConfig config=MybatisConfig.getInstance();  //트랜잭션 처리 시 해당 위치에 있으면 안됨
	
	//관리자 한명 조회하기(id, pass 일치할 경우)
	public Admin select(Admin admin) {
		Admin obj=null;  //db 가져온 회원
		SqlSession sqlSession=config.getSqlSession();
		obj=sqlSession.selectOne("Admin.select", admin);
		config.release(sqlSession);
		return obj;
	}
}
