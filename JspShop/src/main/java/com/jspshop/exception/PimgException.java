package com.jspshop.exception;

public class PimgException extends RuntimeException{
	
	//개발자가 전달하고픈 에러 메세지
	public PimgException(String msg) {
		super(msg);
	}
}
