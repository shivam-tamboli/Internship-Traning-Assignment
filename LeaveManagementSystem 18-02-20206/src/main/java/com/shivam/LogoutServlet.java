package com.shivam;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;

public class LogoutServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        // Invalidate the session
        HttpSession session = request.getSession();
        session.invalidate();

        // Redirect to login page
        response.sendRedirect("login.jsp?message=Logged Out Successfully");
    }
}

