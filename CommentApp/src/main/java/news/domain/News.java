package news.domain;

import java.util.List;

import lombok.Data;

@Data
public class News {
	private int news_idx;
	private String title;
	private String writer;
	private String content;
	private String regdate;
	private int hit;
	//하나의 뉴스기사는 여러명의 자식들을 보유할 수 있음
	//mybatis -> 컬렉션
	private List<Comments> commentsList;
}
