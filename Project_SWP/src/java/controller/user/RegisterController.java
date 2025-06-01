/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.user;

import DAO.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.time.LocalDateTime;
import Model.User;
import utils.PasswordUtil;

@WebServlet(name = "RegisterController", urlPatterns = {"/register"})
public class RegisterController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet RegisterController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet RegisterController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("register.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Lấy dữ liệu từ form
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirm_password");
        String email = request.getParameter("email");
        String role = request.getParameter("role");
        String phoneNumber = request.getParameter("phone_number");
        String username = request.getParameter("username");
        
        

//  6 ký tự và có 1 số 1 chữ cái viết hoa 1 đặc biệt 
String passwordPattern = "^(?=.*[A-Z])(?=.*\\d)(?=.*[^a-zA-Z0-9]).{6,}$";

if (password == null || !password.matches(passwordPattern)) {
    request.setAttribute("error", "Mật khẩu phải có ít nhất 6 ký tự, gồm ít nhất 1 chữ hoa, 1 số và 1 ký tự đặc biệt.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
    return; 
}



// Kiểm tra username rỗng
        if (username == null || username.trim().isEmpty()) {
            request.setAttribute("error", "Username is required!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

// Kiểm tra username không chứa ký tự đặc biệt
        if (!username.matches("^[a-zA-Z0-9_\\.]{3,20}$")) {
            request.setAttribute("error", "Invalid username! Only letters, numbers, underscores (_) and dots (.) are allowed. Length 3-20 characters.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

// Kiểm tra số điện thoại
        if (phoneNumber == null || phoneNumber.trim().isEmpty()) {
            request.setAttribute("error", "Phone number is required!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

// Chỉ chấp nhận đầu 09 hoặc 03 và có đúng 10 số
        if (!phoneNumber.matches("^(09|03)\\d{8}$")) {
            request.setAttribute("error", "Invalid phone number! Only numbers starting with 09 or 03 and exactly 10 digits are allowed.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // Validate role
        if (role == null || (!role.equalsIgnoreCase("user") && !role.equalsIgnoreCase("staff"))) {
            role = "user";
        }

        // Kiểm tra password và confirm password
        if (password == null || confirmPassword == null || !password.equals(confirmPassword)) {
            request.setAttribute("error", "Passwords do not match!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // Tạo đối tượng User
        User newUser = new User();
        newUser.setUsername(username);

        String hashedPassword = PasswordUtil.hashPassword(password);

        newUser.setPassword(hashedPassword);
        newUser.setEmail(email != null ? email : "");
        newUser.setPhone_number(phoneNumber != null ? phoneNumber : "");
        newUser.setRole(role.toLowerCase());
        newUser.setCreatedAt(LocalDateTime.now());

        // Gọi DAO để đăng ký
        UserDAO ud = new UserDAO();
        boolean checkRegister = ud.register(newUser);

        if (checkRegister) {
            // Đăng ký thành công → chuyển hướng
            request.getSession().setAttribute("message", "Registration successful! You can now login.");
            response.sendRedirect("login");
        } else {
            // Đăng ký thất bại → hiển thị thông báo
            request.setAttribute("error", "Username or email already exists, please enter another!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
