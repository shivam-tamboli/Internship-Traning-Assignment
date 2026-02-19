<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.shivam.DBConnection" %>
<!DOCTYPE html>
<html>
<head>
    <title>User Dashboard - Leave Management System</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: Arial, sans-serif; background: #f5f5f5; }
        .navbar { background: #333; color: white; padding: 15px 30px; display: flex; justify-content: space-between; align-items: center; }
        .navbar h2 { margin: 0; }
        .navbar a { color: white; text-decoration: none; margin-left: 20px; padding: 8px 15px; background: #667eea; border-radius: 5px; transition: all 0.3s; }
        .navbar a:hover { background: #764ba2; }
        .container { max-width: 1000px; margin: 30px auto; padding: 0 20px; }
        .welcome-card { background: white; padding: 30px; border-radius: 10px; box-shadow: 0 5px 15px rgba(0,0,0,0.1); margin-bottom: 30px; text-align: center; }
        .welcome-card h1 { color: #667eea; margin-bottom: 15px; }
        .actions { display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 15px; margin-top: 20px; }
        .action-btn { padding: 15px; background: #667eea; color: white; text-decoration: none; border-radius: 5px; text-align: center; font-weight: bold; transition: all 0.3s; }
        .action-btn:hover { background: #764ba2; transform: translateY(-2px); }
        .history-section { background: white; padding: 30px; border-radius: 10px; box-shadow: 0 5px 15px rgba(0,0,0,0.1); }
        .history-section h2 { color: #333; margin-bottom: 20px; }
        table { width: 100%; border-collapse: collapse; }
        table th, table td { padding: 12px; text-align: left; border-bottom: 1px solid #ddd; }
        table th { background: #667eea; color: white; font-weight: bold; }
        table tr:hover { background: #f5f5f5; }
        .status { padding: 5px 10px; border-radius: 3px; font-weight: bold; }
        .status.pending { background: #fff3cd; color: #856404; }
        .status.approved { background: #d4edda; color: #155724; }
        .status.rejected { background: #f8d7da; color: #721c24; }
        .no-leaves { text-align: center; color: #999; padding: 30px; }
    </style>
</head>
<body>
    <%
        String user = (String) session.getAttribute("user");
        String role = (String) session.getAttribute("role");

        if (user == null || !role.equals("user")) {
            response.sendRedirect("login.jsp");
            return;
        }
    %>

    <div class="navbar">
        <h2>Welcome, <%= user %>!</h2>
        <div>
            <a href="logout">Logout</a>
        </div>
    </div>

    <div class="container">
        <div class="welcome-card">
            <h1>📋 Leave Management System</h1>
            <p>Manage your leaves easily</p>
            <div class="actions">
                <a href="applyLeave.jsp" class="action-btn">📝 Apply New Leave</a>
                <a href="#leaveHistory" class="action-btn">📊 View History</a>
            </div>
        </div>

        <div class="history-section" id="leaveHistory">
            <h2>Your Leave History</h2>
            <%
                try {
                    Connection con = DBConnection.getConnection();
                    String query = "SELECT id, reason, status, DATE_FORMAT(applied_date, '%Y-%m-%d') as applied_date FROM leaves WHERE username=? ORDER BY applied_date DESC";
                    PreparedStatement ps = con.prepareStatement(query);
                    ps.setString(1, user);
                    ResultSet rs = ps.executeQuery();

                    if (!rs.isBeforeFirst()) {
            %>
                        <div class="no-leaves">No leaves applied yet. <a href="applyLeave.jsp">Apply for leave</a></div>
            <%
                    } else {
            %>
                        <table>
                            <thead>
                                <tr>
                                    <th>Leave ID</th>
                                    <th>Reason</th>
                                    <th>Applied Date</th>
                                    <th>Status</th>
                                </tr>
                            </thead>
                            <tbody>
            <%
                        while (rs.next()) {
                            String status = rs.getString("status");
                            String statusClass = status.equals("Pending") ? "pending" : (status.equals("Approved") ? "approved" : "rejected");
            %>
                                <tr>
                                    <td>#<%= rs.getInt("id") %></td>
                                    <td><%= rs.getString("reason") %></td>
                                    <td><%= rs.getString("applied_date") %></td>
                                    <td><span class="status <%= statusClass %>"><%= status %></span></td>
                                </tr>
            <%
                        }
            %>
                            </tbody>
                        </table>
            <%
                    }
                    con.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            %>
        </div>
    </div>
</body>
</html>
