package BasicOfJava;

public class NumberPattern {
    public static void main(String[] args) {

        int n = 5;

        for (int i = n; i >= 1; i--) {

            for (int j = 1; j <= i; j++) {
                System.out.print(j);
            }

            for (int space = 1; space <= (n - i) * 2; space++) {
                System.out.print(" ");
            }

            for (int j = i; j >= 1; j--) {
                System.out.print(j);
            }

            System.out.println();
        }
    }
}