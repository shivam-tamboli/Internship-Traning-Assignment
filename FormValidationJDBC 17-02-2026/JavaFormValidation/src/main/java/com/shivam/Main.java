package com.shivam;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Scanner;

public class Main {

    static final String URL = "jdbc:mysql://localhost:3306/formdb";
    static final String USER = "root";
    static final String PASSWORD = "1234";

    public static void main(String[] args) {

        Scanner sc = new Scanner(System.in);

        System.out.print("Enter Name: ");
        String name = sc.nextLine();

        System.out.print("Enter Email: ");
        String email = sc.nextLine();

        System.out.print("Enter Password: ");
        String password = sc.nextLine();

        // -------------------------
        // FORM VALIDATION
        // -------------------------

        if (name.isEmpty() || email.isEmpty() || password.isEmpty()) {
            System.out.println("All fields are required!");
            return;
        }

        if (!email.contains("@")) {
            System.out.println("Invalid email format!");
            return;
        }

        if (password.length() < 6) {
            System.out.println("Password must be at least 6 characters!");
            return;
        }

        // -------------------------
        // DATABASE INSERT
        // -------------------------

        try {
            Connection con = DriverManager.getConnection(URL, USER, PASSWORD);

            String query = "INSERT INTO users(name, email, password) VALUES (?, ?, ?)";

            PreparedStatement ps = con.prepareStatement(query);

            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, password);

            ps.executeUpdate();

            System.out.println("User registered successfully!");

            con.close();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
