package renotice.domain;

import lombok.Data;

@Data
public class Renotice {
	private int renotice_idx;
	private String title;
	private String writer;
	private String content;
	private String regdate;
	private int hit;
}
