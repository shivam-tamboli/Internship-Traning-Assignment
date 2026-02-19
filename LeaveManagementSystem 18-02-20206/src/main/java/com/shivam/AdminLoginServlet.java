package com.shivam;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;

public class AdminLoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        try {
            Connection con = DBConnection.getConnection();
            if (con != null) {
                PreparedStatement ps = con.prepareStatement(
                        "SELECT * FROM admins WHERE username=? AND password=?"
                );
                ps.setString(1, username);
                ps.setString(2, password);

                ResultSet rs = ps.executeQuery();

                if (rs.next()) {
                    request.getSession().setAttribute("admin", username);
                    request.getSession().setAttribute("role", "admin");
                    response.sendRedirect("adminDashboard.jsp");
                } else {
                    response.sendRedirect("login.jsp?error=Invalid Admin Credentials");
                }
                ps.close();
                con.close();
            } else {
                response.sendRedirect("login.jsp?error=Database Connection Failed");
            }

        } catch (Exception e) {
            e.printStackTrace();
            try {
                response.sendRedirect("login.jsp?error=System Error");
            } catch (IOException ioException) {
                ioException.printStackTrace();
            }
        }
    }
}


