package com.jspshop.util;

import lombok.Data;

@Data
public class MessageObj {
	//맴버변수는 json의 key값이 됨
	private int code;  //성공 또는 실패를 식별하는 코드, 1, 0
	private String msg;  //클라이언트에게 전송하고픈 말
	
}
