package com.mvc3.model;

public class MovieAdvisor {
	public String getAdvice(String movie) {
		String msg=null;  //결과 메세지를 담을 변수
		
		if(movie.equals("movie1")) {
			msg="영상미 오짐";
		}else if(movie.equals("movie2")) {
			msg="건우야 내가 미안해~~~~";
		}else if(movie.equals("movie3")) {
			msg="흡흡껑컹";
		}else if(movie.equals("movie4")) {
			msg="볼 예정";
		}
		return msg;
	}
}
