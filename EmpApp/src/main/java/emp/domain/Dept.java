package emp.domain;

import java.util.List;
import lombok.Data;

@Data
public class Dept {
	private int deptno;
	private String dname;
	private String loc;
	//모은 자식
	private List<Emp> empList;  //mybatis의 collection 사용
}
