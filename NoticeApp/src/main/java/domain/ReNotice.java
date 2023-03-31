package domain;

import lombok.Data;

@Data
public class ReNotice {
	private int renotice_idx;
	private String title;
	private String writer;
	private String content;
	private String regdate;
	private int hit;
}
