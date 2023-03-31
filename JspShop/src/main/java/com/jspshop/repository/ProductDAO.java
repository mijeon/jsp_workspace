package com.jspshop.repository;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.jspshop.domain.Product;
import com.jspshop.exception.ProductException;

public class ProductDAO {
	private SqlSession sqlSession;
	
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	//등록
	//throw는 예외를 처리하는게 아니라 회피하는 것임 즉 전가시키는 것임 (서블릿이 처리함)
	//Exception이 객체이므로 int 보다 더 많은 정보를 담을 수 있기 때문에 void로 함, Exception은 보통 DML을 대상으로 함
	public void insert(Product product) throws ProductException {
		int result=0;
		System.out.println("mybatis 만나기 전의 product_idx="+product.getProduct_idx());
		result=sqlSession.insert("Product.insert", product);
		System.out.println("mybatis 만난 후 product_idx="+product.getProduct_idx());
		if(result<1) {
			//에러를 일부러 일으킴 즉, 에러를 잡지 않고 전달이 목적임
			throw new ProductException("상품이 등록되지 않았습니다.");
		}	
		//return result;
	}
	
	//모든 상품 가져오기
	public List selectAll(){
		return sqlSession.selectList("Product.selectAll");
	}
	
	//상품 한건 가져오기
	public Product select(int product_idx) {
		return sqlSession.selectOne("Product.select", product_idx);
	}
	
	//검색어 가져오기
	public List selectBySearch(Map map){
		return sqlSession.selectList("Product.selectBySearch", map);
	}
	
	//상위 카테고리에 소속된 상품 모두 가져오기
	public List selectByCategory(int category_idx) {
		return sqlSession.selectList("Product.selectByCategory", category_idx);
	}
}
