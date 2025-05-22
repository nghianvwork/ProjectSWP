/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.user;

import DAO.UserDAO;
import dal.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import Model.User;

/**
 *
 * @author Hoang Tan Bao
 */
public class LoginServlet extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
  
    @Override
  
protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    
    // Lấy thông tin từ form login
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    String rememberMe = request.getParameter("rememberMe"); 

    HttpSession session = request.getSession();
    Cookie[] cookies = request.getCookies();

    // Giả sử bạn đã có phương thức login trả về User (account)
    UserDAO userDAO = new UserDAO(); // tạo mới đối tượng DAO
    User account = userDAO.login(username, password);
    if (account != null) {
        // ====== Xử lý Cookie userActivity ======
        Cookie userActivity = null;
        if (cookies != null) {
            for (Cookie c : cookies) {
                if ("userActivity".equals(c.getName())) {
                    userActivity = c;
                    break;
                }
            }
        }

        if (userActivity != null) {
            String[] userIdActivity = userActivity.getValue().split("&");
            boolean isExist = false;
            for (String userId : userIdActivity) {
                if (userId.equals(String.valueOf(account.getUser_Id()))) { // chú ý getUser_Id()
                    isExist = true;
                    break;
                }
            }
            if (!isExist && "user".equalsIgnoreCase(account.getRole())) {
                userActivity.setValue(userActivity.getValue() + "&" + account.getUser_Id());
            }
        } else {
            if ("user".equalsIgnoreCase(account.getRole())) {
                userActivity = new Cookie("userActivity", String.valueOf(account.getUser_Id()));
            }
        }

        if (userActivity != null) {
            userActivity.setMaxAge(60 * 60 * 24 * 30); // 30 ngày
            userActivity.setPath("/"); // Quan trọng để cookie có hiệu lực cho toàn bộ app
            response.addCookie(userActivity);
        }

        // ====== Xử lý Cookie rememberMe ======
        if (rememberMe != null) {
            Cookie rememberAccount = new Cookie("rememberMe", String.valueOf(account.getUser_Id()));
            rememberAccount.setMaxAge(60 * 60 * 24 * 30); // 30 ngày
            rememberAccount.setPath("/");
            response.addCookie(rememberAccount);
        } else {
            if (cookies != null) {
                for (Cookie c : cookies) {
                    if ("rememberMe".equalsIgnoreCase(c.getName())) {
                        c.setMaxAge(0); // Xóa cookie
                        c.setPath("/");
                        response.addCookie(c);
                        break;
                    }
                }
            }
        }

        // ====== Lưu session và chuyển hướng ======
        session.setAttribute("account", account);
        response.sendRedirect("home");
    } else {
        // Đăng nhập thất bại
        request.setAttribute("errorLogin", "Username or password information is incorrect, please re-enter");
        request.getRequestDispatcher("views/common/user/login.jsp").forward(request, response);
    }
   
}
@Override
protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    // Ví dụ: chuyển hướng sang trang login.jsp
    request.getRequestDispatcher("views/common/user/login.jsp").forward(request, response);
}

}
