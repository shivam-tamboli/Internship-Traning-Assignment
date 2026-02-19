<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.shivam.DBConnection" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard - Leave Management System</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: Arial, sans-serif; background: #f5f5f5; }
        .navbar { background: #d32f2f; color: white; padding: 15px 30px; display: flex; justify-content: space-between; align-items: center; }
        .navbar h2 { margin: 0; }
        .navbar a { color: white; text-decoration: none; margin-left: 20px; padding: 8px 15px; background: #b71c1c; border-radius: 5px; transition: all 0.3s; }
        .navbar a:hover { background: #7f0000; }
        .container { max-width: 1200px; margin: 30px auto; padding: 0 20px; }
        .welcome-card { background: white; padding: 30px; border-radius: 10px; box-shadow: 0 5px 15px rgba(0,0,0,0.1); margin-bottom: 30px; }
        .welcome-card h1 { color: #d32f2f; margin-bottom: 10px; }
        .admin-section { background: white; padding: 30px; border-radius: 10px; box-shadow: 0 5px 15px rgba(0,0,0,0.1); }
        .admin-section h2 { color: #333; margin-bottom: 20px; border-bottom: 2px solid #d32f2f; padding-bottom: 10px; }
        table { width: 100%; border-collapse: collapse; }
        table th, table td { padding: 12px; text-align: left; border-bottom: 1px solid #ddd; }
        table th { background: #d32f2f; color: white; font-weight: bold; }
        table tr:hover { background: #f5f5f5; }
        .status { padding: 5px 10px; border-radius: 3px; font-weight: bold; }
        .status.pending { background: #fff3cd; color: #856404; }
        .status.approved { background: #d4edda; color: #155724; }
        .status.rejected { background: #f8d7da; color: #721c24; }
        .action-buttons { display: flex; gap: 10px; }
        .btn-approve { background: #28a745; color: white; padding: 6px 12px; border: none; border-radius: 3px; cursor: pointer; font-weight: bold; transition: all 0.3s; }
        .btn-approve:hover { background: #218838; }
        .btn-reject { background: #d32f2f; color: white; padding: 6px 12px; border: none; border-radius: 3px; cursor: pointer; font-weight: bold; transition: all 0.3s; }
        .btn-reject:hover { background: #b71c1c; }
        .no-leaves { text-align: center; color: #999; padding: 30px; }
        .message { background: #d4edda; color: #155724; padding: 15px; border-radius: 5px; margin-bottom: 20px; border-left: 4px solid #28a745; }
    </style>
</head>
<body>
    <%
        String admin = (String) session.getAttribute("admin");
        String role = (String) session.getAttribute("role");

        if (admin == null || role == null || !role.equals("admin")) {
            response.sendRedirect("login.jsp");
            return;
        }
    %>

    <div class="navbar">
        <h2>👨‍💼 Admin Panel - <%= admin %></h2>
        <div>
            <a href="logout">Logout</a>
        </div>
    </div>

    <div class="container">
        <div class="welcome-card">
            <h1>🔐 Leave Management Admin Dashboard</h1>
            <p>Manage and approve all employee leave requests</p>
        </div>

        <% if(request.getParameter("message") != null) { %>
            <div class="message">✓ <%= request.getParameter("message") %></div>
        <% } %>

        <div class="admin-section">
            <h2>⏳ Pending Leave Requests</h2>
            <%
                try {
                    Connection con = DBConnection.getConnection();
                    if (con != null) {
                        String query = "SELECT id, username, reason, status, applied_date FROM leaves WHERE status='Pending' ORDER BY applied_date ASC";
                        PreparedStatement ps = con.prepareStatement(query);
                        ResultSet rs = ps.executeQuery();

                        if (!rs.isBeforeFirst()) {
            %>
                            <div class="no-leaves">✓ No pending leave requests</div>
            <%
                        } else {
            %>
                            <table>
                                <thead>
                                    <tr>
                                        <th>Leave ID</th>
                                        <th>Employee Name</th>
                                        <th>Reason</th>
                                        <th>Applied Date</th>
                                        <th>Status</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
            <%
                            while (rs.next()) {
            %>
                                    <tr>
                                        <td>#<%= rs.getInt("id") %></td>
                                        <td><%= rs.getString("username") %></td>
                                        <td><%= rs.getString("reason") %></td>
                                        <td><%= rs.getString("applied_date") %></td>
                                        <td><span class="status pending"><%= rs.getString("status") %></span></td>
                                        <td>
                                            <div class="action-buttons">
                                                <form action="approveLeave" method="post" style="display:inline;">
                                                    <input type="hidden" name="leaveId" value="<%= rs.getInt("id") %>">
                                                    <input type="hidden" name="action" value="approve">
                                                    <button type="submit" class="btn-approve">✓ Approve</button>
                                                </form>
                                                <form action="approveLeave" method="post" style="display:inline;">
                                                    <input type="hidden" name="leaveId" value="<%= rs.getInt("id") %>">
                                                    <input type="hidden" name="action" value="reject">
                                                    <button type="submit" class="btn-reject">✗ Reject</button>
                                                </form>
                                            </div>
                                        </td>
                                    </tr>
            <%
                            }
                            ps.close();
            %>
                                </tbody>
                            </table>
            <%
                        }
                        con.close();
                    } else {
            %>
                        <div class="no-leaves">Database connection error</div>
            <%
                    }
                } catch (Exception e) {
                    out.println("<div class='no-leaves'>Error: " + e.getMessage() + "</div>");
                    e.printStackTrace();
                }
            %>
        </div>

        <br>

        <div class="admin-section">
            <h2>📊 All Leave Records (Processed)</h2>
            <%
                try {
                    Connection con = DBConnection.getConnection();
                    if (con != null) {
                        String query = "SELECT id, username, reason, status, applied_date FROM leaves WHERE status IN ('Approved', 'Rejected') ORDER BY applied_date DESC LIMIT 20";
                        PreparedStatement ps = con.prepareStatement(query);
                        ResultSet rs = ps.executeQuery();

                        if (!rs.isBeforeFirst()) {
            %>
                            <div class="no-leaves">No processed leave requests yet</div>
            <%
                        } else {
            %>
                            <table>
                                <thead>
                                    <tr>
                                        <th>Leave ID</th>
                                        <th>Employee Name</th>
                                        <th>Reason</th>
                                        <th>Applied Date</th>
                                        <th>Status</th>
                                    </tr>
                                </thead>
                                <tbody>
            <%
                            while (rs.next()) {
                                String status = rs.getString("status");
                                String statusClass = status.equals("Approved") ? "approved" : "rejected";
            %>
                                    <tr>
                                        <td>#<%= rs.getInt("id") %></td>
                                        <td><%= rs.getString("username") %></td>
                                        <td><%= rs.getString("reason") %></td>
                                        <td><%= rs.getString("applied_date") %></td>
                                        <td><span class="status <%= statusClass %>"><%= status %></span></td>
                                    </tr>
            <%
                            }
                            ps.close();
            %>
                                </tbody>
                            </table>
            <%
                        }
                        con.close();
                    } else {
            %>
                        <div class="no-leaves">Database connection error</div>
            <%
                    }
                } catch (Exception e) {
                    out.println("<div class='no-leaves'>Error: " + e.getMessage() + "</div>");
                    e.printStackTrace();
                }
            %>
        </div>
    </div>
</body>
</html>




