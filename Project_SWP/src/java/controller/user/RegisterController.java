package controller.user;

import DAO.UserDAO;
import Model.User;
import utils.PasswordUtil;

import java.io.IOException;
import java.sql.Date;
import java.time.LocalDate;
import java.time.LocalDateTime;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "RegisterController", urlPatterns = {"/register"})
public class RegisterController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Lấy dữ liệu từ form
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirm_password");
        String email = request.getParameter("email");
        String phoneNumber = request.getParameter("phone_number");
        String gender = request.getParameter("gender");
        String firstname = request.getParameter("firstname");
        String lastname = request.getParameter("lastname");
        String dobStr = request.getParameter("date_of_birth");

        // Validate mật khẩu
        String passwordPattern = "^(?=.*[A-Z])(?=.*\\d)(?=.*[^a-zA-Z0-9]).{6,}$";
        if (password == null || !password.matches(passwordPattern)) {
            request.setAttribute("error", "Password must be at least 6 characters, with at least 1 uppercase letter, 1 number and 1 special character.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // Validate username
        if (username == null || username.trim().isEmpty() || !username.matches("^[a-zA-Z0-9_\\.]{3,20}$")) {
            request.setAttribute("error", "Invalid username! Only letters, numbers, underscores (_) and dots (.) are allowed. Length 3-20 characters.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // Validate số điện thoại
        if (phoneNumber == null || phoneNumber.trim().isEmpty()) {
            request.setAttribute("error", "Phone number is required!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        if (!phoneNumber.matches("^(09|03)\\d{8}$")) {
            request.setAttribute("error", "Invalid phone number! Must start with 09 or 03 and contain exactly 10 digits.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // Check tồn tại số điện thoại
        UserDAO userDAO = new UserDAO();
        if (userDAO.isPhoneExists(phoneNumber)) {
            request.setAttribute("error", "Phone number already exists! Please use another one.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // Validate xác nhận mật khẩu
        if (confirmPassword == null || !confirmPassword.equals(password)) {
            request.setAttribute("error", "Passwords do not match!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // Parse ngày sinh
        Date dateOfBirth = null;
        try {
            if (dobStr != null && !dobStr.isEmpty()) {
                LocalDate localDate = LocalDate.parse(dobStr);
                dateOfBirth = Date.valueOf(localDate);
            }
        } catch (Exception e) {
            request.setAttribute("error", "Invalid date of birth format!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // Tạo đối tượng User
        User newUser = new User();
        newUser.setUsername(username);
        newUser.setPassword(PasswordUtil.hashPassword(password));
        newUser.setEmail(email != null ? email : "");
        newUser.setPhone_number(phoneNumber);
        newUser.setRole("user");
        newUser.setCreatedAt(LocalDateTime.now());
        newUser.setGender(gender);
        newUser.setFirstname(firstname);
        newUser.setLastname(lastname);
        newUser.setFullname(lastname + " " + firstname);
        newUser.setDateOfBirth(dateOfBirth);

        // Đăng ký tài khoản
        boolean success = userDAO.register(newUser);

        if (success) {
            request.getSession().setAttribute("message", "Registration successful! You can now login.");
            response.sendRedirect("login");
        } else {
            request.setAttribute("error", "Username or email already exists, please try another.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "RegisterController - handles user registration including full user profile";
    }
}
