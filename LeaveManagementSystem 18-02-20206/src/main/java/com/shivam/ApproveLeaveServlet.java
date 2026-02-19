package com.shivam;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;

public class ApproveLeaveServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String leaveId = request.getParameter("leaveId");
        String action = request.getParameter("action"); // "approve" or "reject"
        String status = action.equalsIgnoreCase("approve") ? "Approved" : "Rejected";

        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(
                    "UPDATE leaves SET status=? WHERE id=?"
            );
            ps.setString(1, status);
            ps.setInt(2, Integer.parseInt(leaveId));

            ps.executeUpdate();

            response.sendRedirect("adminDashboard.jsp?message=" + status + " Successfully");

        } catch (Exception e) {
            e.printStackTrace();
            try {
                response.getWriter().println("Error updating leave status");
            } catch (IOException ioException) {
                ioException.printStackTrace();
            }
        }
    }
}

