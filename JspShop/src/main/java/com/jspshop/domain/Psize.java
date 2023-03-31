package com.jspshop.domain;

import lombok.Data;

@Data
public class Psize {
	private int psize_idx;
	Product product;  //부모인 Product를 assocation으로 가져옴 (나 : 부모 -> 1:1)
	private String psize_name;
}
