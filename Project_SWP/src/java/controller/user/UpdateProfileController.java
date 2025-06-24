/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.user;

import DAO.UserDAO;
import Model.User;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Date;

/**
 *
 * @author Admin
 */
@WebServlet(name = "UpdateProfileController", urlPatterns = {"/updateprofile"})
public class UpdateProfileController extends HttpServlet {

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
        
        int userId = Integer.parseInt(request.getParameter("id"));
        UserDAO dao = new UserDAO();
        try {
            User user = dao.getUserById(userId);
            request.setAttribute("user", user);
            request.getRequestDispatcher("UpdateProfile.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
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
        request.setCharacterEncoding("UTF-8");

        try {
            int userId = Integer.parseInt(request.getParameter("userId"));
            String username = request.getParameter("username");
            String fullname = request.getParameter("fullname");
            String email = request.getParameter("email");
            String phoneNumber = request.getParameter("phoneNumber");
            String gender = request.getParameter("gender");
            String role = request.getParameter("role");
            String status = request.getParameter("status");
            String note = request.getParameter("note");
            String dobStr = request.getParameter("dateOfBirth");

            Date dateOfBirth = null;
            if (dobStr != null && !dobStr.isEmpty()) {
                dateOfBirth = Date.valueOf(dobStr);
            }

            User user = new User();
            user.setUser_Id(userId);
            user.setUsername(username);
            user.setFullname(fullname);
            user.setEmail(email);
            user.setPhone_number(phoneNumber);
            user.setGender(gender);
            user.setRole(role);
            user.setStatus(status);
            user.setNote(note);
            user.setDateOfBirth(dateOfBirth);

            UserDAO dao = new UserDAO();
            boolean success = dao.updateUser(user);

            if (success) {
                response.sendRedirect("viewprofile?id=" + userId);
            } else {
                request.setAttribute("error", "Update failed!");
                request.setAttribute("user", user);
                request.getRequestDispatcher("UpdateProfile.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
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
