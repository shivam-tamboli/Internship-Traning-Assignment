import java.awt.*;
import java.awt.event.*;

public class AWTProgram extends Frame implements ActionListener {
    Button b1, b2;
    Label l;
    AWTProgram() {
    b1 = new Button("A");
    b2 = new Button("B");
    l = new Label();
    setLayout(new FlowLayout());
    add(b1);
    add(b2);
    add(l);
    b1.addActionListener(this);
    b2.addActionListener(this);
    setSize(400, 200);
    setVisible(true);
    }
    public void actionPerformed(ActionEvent e) {
    if (e.getSource() == b1) {
    l.setText("Name: Shivam | Course: MCA | Roll: 1272240906 | College: MIT WPU");
    }
    if (e.getSource() == b2) {
    l.setText("Previous Semester CGPA was: 7.61");
    }
    }
    public static void main(String[] args) {
    new AWTProgram();
    }
    }