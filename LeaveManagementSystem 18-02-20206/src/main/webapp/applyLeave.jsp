<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Apply Leave - Leave Management System</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: Arial, sans-serif; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); min-height: 100vh; padding: 20px; }
        .navbar { background: #333; color: white; padding: 15px 30px; display: flex; justify-content: space-between; align-items: center; margin-bottom: 30px; border-radius: 5px; }
        .navbar a { color: white; text-decoration: none; padding: 8px 15px; background: #667eea; border-radius: 5px; transition: all 0.3s; }
        .navbar a:hover { background: #764ba2; }
        .container { max-width: 600px; margin: 0 auto; background: white; padding: 40px; border-radius: 10px; box-shadow: 0 10px 30px rgba(0,0,0,0.3); }
        h1 { color: #667eea; margin-bottom: 30px; text-align: center; }
        .form-group { margin-bottom: 20px; }
        label { display: block; margin-bottom: 8px; color: #333; font-weight: bold; }
        input[type="date"], textarea { width: 100%; padding: 12px; border: 1px solid #ddd; border-radius: 5px; font-size: 14px; font-family: Arial, sans-serif; }
        textarea { resize: vertical; min-height: 100px; }
        .button-group { display: flex; gap: 10px; margin-top: 30px; }
        input[type="submit"] { flex: 1; padding: 12px; background: #667eea; color: white; border: none; border-radius: 5px; font-weight: bold; cursor: pointer; transition: all 0.3s; }
        input[type="submit"]:hover { background: #764ba2; }
        .btn-back { flex: 1; padding: 12px; background: #999; color: white; border: none; border-radius: 5px; font-weight: bold; cursor: pointer; text-decoration: none; text-align: center; transition: all 0.3s; }
        .btn-back:hover { background: #666; }
        .message { background: #d4edda; color: #155724; padding: 15px; border-radius: 5px; margin-bottom: 20px; border-left: 4px solid #28a745; }
    </style>
</head>
<body>
    <%
        String user = (String) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }
    %>

    <div class="navbar">
        <span>Apply Leave - <%= user %></span>
        <a href="logout">Logout</a>
    </div>

    <div class="container">
        <h1>📝 Apply for Leave</h1>

        <% if(request.getParameter("message") != null) { %>
            <div class="message">✓ <%= request.getParameter("message") %></div>
        <% } %>

        <form action="applyLeave" method="post">
            <div class="form-group">
                <label for="fromDate">From Date:</label>
                <input type="date" id="fromDate" name="fromDate" required>
            </div>

            <div class="form-group">
                <label for="toDate">To Date:</label>
                <input type="date" id="toDate" name="toDate" required>
            </div>

            <div class="form-group">
                <label for="reason">Reason for Leave:</label>
                <textarea id="reason" name="reason" required placeholder="Please provide a reason for your leave request..."></textarea>
            </div>

            <div class="button-group">
                <input type="submit" value="Submit Leave Request">
                <a href="dashboard.jsp" class="btn-back">Back to Dashboard</a>
            </div>
        </form>
    </div>
</body>
</html>
