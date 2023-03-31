package com.jspshop.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.jspshop.domain.Member;
import com.jspshop.exception.MemberException;


public class MemberDAO {
	private SqlSession sqlSession;
	
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	//등록
	public void insert(Member member) throws MemberException {
		int result=0;
		result= sqlSession.insert("Member.insert", member);
		if(result<1) {
			throw new MemberException("등록 실패");
		}
	}
	
	//모든 회원 가져오기
	public List selectAll() {
		return sqlSession.selectList("Member.selectAll");
	}
	
	//회원 한명 가져오기 (id, pass 일치하는 사람 가져오기)
	public Member select(Member member) throws MemberException{
		Member dto=null;
		dto=sqlSession.selectOne("Member.select", member);
		if(dto==null) {
			throw new MemberException("회원정보가 올바르지 않습니다.");
		}
		return dto;
	}
	
	//삭제
	public void delete(int member_idx) throws MemberException {
		int result=0;
		result=sqlSession.delete("Member.delete", member_idx);
		if(result<1) {
			throw new MemberException("삭제 실패");
		}
	}
	
	//수정
	public void update(Member member) throws MemberException{
		int result=0;
		result=sqlSession.update("Member.update", member);
		if(result<1) {
			throw new MemberException("수정 실패");
		}
	}
}
