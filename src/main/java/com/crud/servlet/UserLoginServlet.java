package com.crud.servlet;

import com.crud.model.User;
import com.crud.service.UserService;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet("/login")
public class UserLoginServlet extends HttpServlet {
    private UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        if ("logout".equals(request.getParameter("action"))) {
            HttpSession session = request.getSession(false);
            if (session != null) {
                session.invalidate();
            }
            response.sendRedirect("LoginPage.jsp?message=logout_success");
            return;
        }
        
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            redirectBasedOnRole((User) session.getAttribute("user"), response);
            return;
        }
        
        request.getRequestDispatcher("LoginPage.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String email = request.getParameter("email").trim();
        String password = request.getParameter("password");
        
        try {
            if (email.isEmpty() || password.isEmpty()) {
                request.setAttribute("error", "Email and password are required");
                request.getRequestDispatcher("LoginPage.jsp").forward(request, response);
                return;
            }

            User user = userService.validateUser(email, password);
            
            if (user != null) {
                HttpSession session = request.getSession();
                session.setAttribute("user", user);
                session.setAttribute("email", user.getEmail());
                session.setAttribute("userId", user.getId());
                session.setAttribute("userRole", user.getUserRole());
                session.setAttribute("fullName", user.getFname() + " " + user.getLname());
                session.setMaxInactiveInterval(30 * 60);
                
                redirectBasedOnRole(user, response);
            } else {
                request.setAttribute("error", "Invalid email or password");
                request.setAttribute("email", email);
                request.getRequestDispatcher("LoginPage.jsp").forward(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("error", "System error. Please try again later.");
            request.getRequestDispatcher("LoginPage.jsp").forward(request, response);
            e.printStackTrace();
        }
    }

    private void redirectBasedOnRole(User user, HttpServletResponse response) throws IOException {
        String role = user.getUserRole().toLowerCase();
        String redirectPage = "LHomePage.jsp";
        
        if ("employee".equals(role)) {
            redirectPage = "HomePage.jsp";
        } else if ("admin".equals(role)) {
            redirectPage = "Adminview";
        }
        
        response.sendRedirect(redirectPage + "?welcome=true");
    }
}