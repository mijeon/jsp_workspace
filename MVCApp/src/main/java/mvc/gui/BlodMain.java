package mvc.gui;

import java.awt.FlowLayout;

import javax.swing.JButton;
import javax.swing.JComboBox;
import javax.swing.JFrame;
import javax.swing.JOptionPane;

import mvc.model.blood.BloodAdvisor;

//swing - M
public class BlodMain extends JFrame {
	JComboBox<String> box;
	JButton bt;
	BloodAdvisor advisor;
	
	public BlodMain() {
		box=new JComboBox<String>();
		bt=new JButton("분석요청");
		advisor=new BloodAdvisor();
		
		//혈액형 초기화
		box.addItem("A");
		box.addItem("B");
		box.addItem("O");
		box.addItem("AB");
		
		//부착
		setLayout(new FlowLayout());
		add(box);
		add(bt);
		
		setVisible(true);
		setDefaultCloseOperation(EXIT_ON_CLOSE);
		setSize(300, 400);
		
		//로직을 짧게 작성하기 위해 사용되지만 이름이 없어서 재사용 불가함
		bt.addActionListener((e)->{
            getAdvice();
        });
	}
	
	public void getAdvice() {
		String result=advisor.getAdvice((String)box.getSelectedItem());
		JOptionPane.showMessageDialog(this, result);
	}
	public static void main(String[] args) {
		new BlodMain();
	}
}
