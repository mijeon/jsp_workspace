package com.jspshop.domain;

import lombok.Data;

@Data
public class Cart {
	private Product product;  //hsa a
	//상품에 존재하지 않는 속성인 개수 추가
	private int ea;
	private Member member;
}
