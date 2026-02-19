<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Leave Management System - Login</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: Arial, sans-serif; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); min-height: 100vh; display: flex; justify-content: center; align-items: center; }
        .container { background: white; padding: 40px; border-radius: 10px; box-shadow: 0 10px 30px rgba(0,0,0,0.3); width: 100%; max-width: 400px; }
        h1 { text-align: center; color: #333; margin-bottom: 30px; }
        .tabs { display: flex; margin-bottom: 20px; gap: 10px; }
        .tab-btn { flex: 1; padding: 12px; border: none; background: #ddd; cursor: pointer; border-radius: 5px; font-weight: bold; transition: all 0.3s; }
        .tab-btn.active { background: #667eea; color: white; }
        .tab-content { display: none; }
        .tab-content.active { display: block; }
        .form-group { margin-bottom: 15px; }
        label { display: block; margin-bottom: 5px; color: #333; font-weight: bold; }
        input[type="text"], input[type="password"] { width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 5px; font-size: 14px; }
        input[type="submit"] { width: 100%; padding: 12px; background: #667eea; color: white; border: none; border-radius: 5px; font-weight: bold; cursor: pointer; transition: all 0.3s; }
        input[type="submit"]:hover { background: #764ba2; }
        .message { text-align: center; color: #d32f2f; margin-bottom: 15px; font-weight: bold; }
    </style>
    <script>
        function showTab(tabName) {
            // Hide all tabs
            document.querySelectorAll('.tab-content').forEach(el => el.classList.remove('active'));
            document.querySelectorAll('.tab-btn').forEach(el => el.classList.remove('active'));

            // Show selected tab
            document.getElementById(tabName + 'Tab').classList.add('active');
            document.getElementById(tabName + 'Btn').classList.add('active');
        }
        // Show user tab by default
        window.onload = function() {
            showTab('user');
        };
    </script>
</head>
<body>
    <div class="container">
        <h1>🔐 Leave Management System</h1>

        <% if(request.getParameter("message") != null) { %>
            <div class="message"><%= request.getParameter("message") %></div>
        <% } %>

        <div class="tabs">
            <button class="tab-btn active" id="userBtn" onclick="showTab('user')">👤 User Login</button>
            <button class="tab-btn" id="adminBtn" onclick="showTab('admin')">👨‍💼 Admin Login</button>
        </div>

        <!-- USER LOGIN TAB -->
        <div id="userTab" class="tab-content active">
            <form action="login" method="post">
                <div class="form-group">
                    <label for="userUsername">Username:</label>
                    <input type="text" id="userUsername" name="username" required placeholder="Enter username">
                </div>
                <div class="form-group">
                    <label for="userPassword">Password:</label>
                    <input type="password" id="userPassword" name="password" required placeholder="Enter password">
                </div>
                <input type="submit" value="Login as User">
            </form>
        </div>

        <!-- ADMIN LOGIN TAB -->
        <div id="adminTab" class="tab-content">
            <form action="adminLogin" method="post">
                <div class="form-group">
                    <label for="adminUsername">Admin Username:</label>
                    <input type="text" id="adminUsername" name="username" required placeholder="Enter admin username">
                </div>
                <div class="form-group">
                    <label for="adminPassword">Admin Password:</label>
                    <input type="password" id="adminPassword" name="password" required placeholder="Enter admin password">
                </div>
                <input type="submit" value="Login as Admin">
            </form>
        </div>
    </div>
</body>
</html>
