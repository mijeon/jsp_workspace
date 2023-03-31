package mvc.gui;

import java.awt.FlowLayout;

import javax.swing.JButton;
import javax.swing.JComboBox;
import javax.swing.JFrame;
import javax.swing.JOptionPane;

import mvc.model.blood.MovieAdvisor;

public class MovieMain extends JFrame{
	JComboBox<String> box;
	JButton bt;
	MovieAdvisor advisor;
	
	public MovieMain() {
		box=new JComboBox<String>();
		bt=new JButton("분석요청");
		advisor=new MovieAdvisor();
		
		//영화 초기화
		box.addItem("movie1");
		box.addItem("movie2");
		box.addItem("movie3");
		box.addItem("movie4");
		
		//부착
		setLayout(new FlowLayout());
		add(box);
		add(bt);
		
		setVisible(true);
		setSize(300, 400);
		setDefaultCloseOperation(EXIT_ON_CLOSE);
		
		bt.addActionListener((e)->{
			getAdvice();
		});
	}
	public void getAdvice() {
		String result=advisor.getAdvice((String)box.getSelectedItem());
		JOptionPane.showMessageDialog(this, result);
	}
	
	public static void main(String[] args) {
		new MovieMain();
	}
}
