/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.user;

import DAO.AreaDAO;
import DAO.CourtDAO;
import DAO.ReviewDAO;

import Model.Branch;
import Model.Courts;

import Model.User;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import jakarta.servlet.http.HttpSession;

//import java.awt.geom.Area;
import java.util.List;

/**
 *
 * @author sangn
 */
@WebServlet(name = "AreaDetail", urlPatterns = {"/AreaDetail"})
public class AreaDetail extends HttpServlet {

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
            out.println("<title>Servlet AreaDetail</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AreaDetail at " + request.getContextPath() + "</h1>");
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
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("login");
            return;
        }
        String areaIdParam = request.getParameter("area_id");

        if (areaIdParam != null) {
            int areaId = Integer.parseInt(areaIdParam);

            CourtDAO courtDAO = new CourtDAO();
            AreaDAO areaDAO = new AreaDAO();
            ReviewDAO reviewDAO = new ReviewDAO();
            Branch area = areaDAO.getAreaByIdWithManager(areaId);

            // Bổ sung filter thời gian
            String dateStr = request.getParameter("date");
            String fromTimeStr = request.getParameter("fromTime");
            String toTimeStr = request.getParameter("toTime");

            List<Courts> courts;
            if (dateStr != null && fromTimeStr != null && toTimeStr != null
                    && !dateStr.isEmpty() && !fromTimeStr.isEmpty() && !toTimeStr.isEmpty()) {
                // Nếu có filter => chỉ lấy sân còn trống
                java.sql.Date date = java.sql.Date.valueOf(dateStr);
                java.sql.Time fromTime = java.sql.Time.valueOf(fromTimeStr + ":00");
                java.sql.Time toTime = java.sql.Time.valueOf(toTimeStr + ":00");
                courts = courtDAO.findAvailableCourts(areaId, date, fromTime, toTime);

                // Để hiện lại filter trên form (không reset)
                request.setAttribute("date", dateStr);
                request.setAttribute("fromTime", fromTimeStr);
                request.setAttribute("toTime", toTimeStr);
            } else {
                // Nếu chưa filter hoặc thiếu thông tin => hiện tất cả sân
                courts = courtDAO.getCourtsByAreaId(areaId);
            }

            request.setAttribute("area", area);
            request.setAttribute("courts", courts);
            request.setAttribute("reviews", reviewDAO.getReviewsByArea(areaId));
            request.getRequestDispatcher("CourtDetail.jsp").forward(request, response);
        } else {
            response.sendRedirect("ListBranch");
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
        processRequest(request, response);
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
