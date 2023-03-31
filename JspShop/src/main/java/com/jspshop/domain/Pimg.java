package com.jspshop.domain;

import lombok.Data;

@Data
public class Pimg {
	private int pimg_idx;
	Product product;
	private String filename;
}
