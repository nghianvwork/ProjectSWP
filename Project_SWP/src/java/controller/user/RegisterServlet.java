/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.user;

import dal.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.User;

/**
 *
 * @author Hoang Tan Bao
 */
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email"); // nếu có
        String phoneNumber = request.getParameter("phone_number"); // nếu có
        String role = request.getParameter("role");  // Lấy role từ form

        if (role == null || (!role.equalsIgnoreCase("user") && !role.equalsIgnoreCase("staff"))) {
            // Nếu role không hợp lệ, mặc định là user
            role = "user";
        }

        UserDAO ud = new UserDAO();

        User newUser = new User();
        newUser.setUsername(username);
        newUser.setPassword(password);
        newUser.setEmail(email != null ? email : "");
        newUser.setPhone_number(phoneNumber != null ? phoneNumber : "");
        newUser.setRole(role.toLowerCase());
        newUser.setCreatedAt(java.time.LocalDateTime.now());

        boolean checkRegister = ud.register(newUser);

        if (checkRegister) {
            response.sendRedirect("home");
        } else {
            request.setAttribute("errorRegister", "Username already exists, please enter another username!!!");
            request.getRequestDispatcher("views/common/user/register.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("views/common/user/register.jsp").forward(request, response);
    }
}
