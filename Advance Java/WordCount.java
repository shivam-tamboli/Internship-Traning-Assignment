import javax.swing.*;
import java.awt.event.*;

public class WordCount {

    public static void main(String[] args) {

        JFrame frame = new JFrame("Word Counter");

        JTextArea textArea = new JTextArea(5, 20);
        JButton button = new JButton("Count");
        JLabel result = new JLabel("Words: 0  Characters: 0");

        button.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent e) {

                String text = textArea.getText();

                int characters = text.length();

                String wordsArray[] = text.trim().split("\\s+");
                int words = text.trim().isEmpty() ? 0 : wordsArray.length;

                result.setText("Words: " + words + "  Characters: " + characters);
            }
        });

        frame.setLayout(new java.awt.FlowLayout());
        frame.add(textArea);
        frame.add(button);
        frame.add(result);

        frame.setSize(300,250);
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setVisible(true);
    }
}