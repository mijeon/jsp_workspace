package gui.cook;

public class Cook {
	//요리사 객체는 팬 객체에 의존함
	//1) DI를 구현하기 위해서는 객체가 보유한 자료형은 하위보다는 상위 객체일수록 유연해짐
	//2) NEW 연산자로 직접 객체를 생성하지 않아야 함 - new 연산자 사용 시 대상 자료형을 명시해야 하므로
	Pan pan;  //요리사가 팬을 가짐 (has a)
	
	public Cook() {
		//pan=new Fripan();
	}
	
	public void cook(){
		pan.heat();
	}
}
