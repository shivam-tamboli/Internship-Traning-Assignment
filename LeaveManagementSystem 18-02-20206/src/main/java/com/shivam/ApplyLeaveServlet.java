package com.shivam;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;

public class ApplyLeaveServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String fromDate = request.getParameter("fromDate");
        String toDate = request.getParameter("toDate");
        String reason = request.getParameter("reason");
        String username = (String) request.getSession().getAttribute("user");

        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(
                    "INSERT INTO leaves(username, from_date, to_date, reason, status) VALUES (?, ?, ?, ?, 'Pending')"
            );
            ps.setString(1, username);
            ps.setString(2, fromDate);
            ps.setString(3, toDate);
            ps.setString(4, reason);

            ps.executeUpdate();
            ps.close();
            con.close();

            response.sendRedirect("dashboard.jsp?message=Leave Applied Successfully!");

        } catch (Exception e) {
            e.printStackTrace();
            try {
                response.getWriter().println("Error: " + e.getMessage());
            } catch (IOException ioException) {
                ioException.printStackTrace();
            }
        }
    }
}
