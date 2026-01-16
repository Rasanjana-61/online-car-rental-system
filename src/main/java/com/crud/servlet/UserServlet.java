package com.crud.servlet;

import com.crud.model.User;
import com.crud.model.Rent;
import com.crud.service.RentService;
import com.crud.service.UserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/user")
public class UserServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserService userService;

    @Override
    public void init() throws ServletException {
        super.init();
        userService = new UserService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null) {
            request.setAttribute("users", userService.getAllUsers());
            request.getRequestDispatcher("userList.jsp").forward(request, response);
        } else if (action.equals("create")) {
            request.getRequestDispatcher("register.jsp").forward(request, response);
        } else if (action.equals("getById")) {
            int id = Integer.parseInt(request.getParameter("id"));
            User user = userService.getUser(id);
            request.setAttribute("user", user);
            request.getRequestDispatcher("userDetails.jsp").forward(request, response);
        } else if (action.equals("edit")) {
            int id = Integer.parseInt(request.getParameter("id"));
            User user = userService.getUser(id);
            request.setAttribute("user", user);
            request.getRequestDispatcher("editUser.jsp").forward(request, response);
        } else if (action.equals("delete")) {
            int id = Integer.parseInt(request.getParameter("id"));
            userService.deleteUser(id);
            response.sendRedirect("user");
        }else if (action.equals("rent")) {
            RentService rentService = new RentService(); // Declare and initialize here
            List<Rent> rents = rentService.getAllRents();
            request.setAttribute("rents", rents); // Correct variable name
            request.getRequestDispatcher("rent.jsp").forward(request, response);
        }


    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action.equals("create")) {
            handleCreate(request, response);
        } else if (action.equals("update")) {
            handleUpdate(request, response);
        } else if (action.equals("delete")) {
            handleDelete(request, response);
        }
    }

    private void handleCreate(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String fname = request.getParameter("fname");
        String lname = request.getParameter("lname");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String userrole = request.getParameter("userrole");

        User user = new User();
        user.setFname(fname);
        user.setLname(lname);
        user.setPhone(phone);
        user.setEmail(email);
        user.setPassword(password);
        user.setUserRole(userrole);

        if (userService.createUser(user)) {
            response.sendRedirect("LoginPage.jsp");
        } else {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to create user");
        }
    }

    private void handleUpdate(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String fname = request.getParameter("fname");
        String lname = request.getParameter("lname");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        

        User user = new User();
        user.setId(id);
        user.setFname(fname);
        user.setLname(lname);
        user.setPhone(phone);
        user.setEmail(email);
        user.setPassword(password);
    

        if (userService.updateUser(user)) {
            response.sendRedirect("user");
        } else {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to update user");
        }
    }

    private void handleDelete(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        if (userService.deleteUser(id)) {
            response.sendRedirect("user");
        } else {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to delete user");
        }
    }
}