/*

 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license

 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template

 */
package controller.manager;

import DAO.ServiceDAO;

import Model.Service;

import java.io.IOException;

import java.io.PrintWriter;

import jakarta.servlet.ServletException;

import jakarta.servlet.annotation.WebServlet;

import jakarta.servlet.http.HttpServlet;

import jakarta.servlet.http.HttpServletRequest;

import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.util.List;

/**
 *
 *
 *
 * @author admin
 *
 */
@WebServlet(name = "ViewEquipments", urlPatterns = {"/ViewEquipments"})

public class ViewService extends HttpServlet {

    /**
     *
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     *
     * methods.
     *
     *
     *
     * @param request servlet request
     *
     * @param response servlet response
     *
     * @throws ServletException if a servlet-specific error occurs
     *
     * @throws IOException if an I/O error occurs
     *
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");

        try (PrintWriter out = response.getWriter()) {

            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");

            out.println("<html>");

            out.println("<head>");

            out.println("<title>Servlet ViewEquipments</title>");

            out.println("</head>");

            out.println("<body>");

            out.println("<h1>Servlet ViewEquipments at " + request.getContextPath() + "</h1>");

            out.println("</body>");

            out.println("</html>");

        }

    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     *
     * Handles the HTTP <code>GET</code> method.
     *
     *
     *
     * @param request servlet request
     *
     * @param response servlet response
     *
     * @throws ServletException if a servlet-specific error occurs
     *
     * @throws IOException if an I/O error occurs
     *
     */
    @Override

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Lấy user từ session (giả sử bạn đã lưu Model.User vào session)
        jakarta.servlet.http.HttpSession session = request.getSession(false);
        Model.User user = (session != null) ? (Model.User) session.getAttribute("user") : null;

        // Kiểm tra quyền: nếu chưa đăng nhập hoặc không phải admin thì chuyển hướng
        if (user == null || (!"admin".equalsIgnoreCase(user.getRole())
                && !"staff".equalsIgnoreCase(user.getRole()))) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        ServiceDAO dao = new ServiceDAO();

        // Lấy filter từ request
        String keyword = request.getParameter("keyword");

        String filterStatus = request.getParameter("filterStatus");

        String service_type = request.getParameter("service_type");

        String priceRange = request.getParameter("priceRange");

        Double minPrice = null, maxPrice = null;

        // Xử lý khoảng giá từ select
        if (priceRange != null && !priceRange.isEmpty()) {

            switch (priceRange) {

                case "1":
                    minPrice = 0.0;

                    maxPrice = 50000.0;

                    break;

                case "2":

                    minPrice = 50000.0;

                    maxPrice = 100000.0;

                    break;

                case "3":

                    minPrice = 100000.0;

                    maxPrice = 200000.0;

                    break;

                case "4":

                    minPrice = 200000.01;

                    maxPrice = null;

                    break;

            }

        }

        // Phân trang
        int pageSize = 5;

        int currentPage = 1;

        String pageParam = request.getParameter("page");

        if (pageParam != null) {

            try {

                currentPage = Integer.parseInt(pageParam);

            } catch (NumberFormatException e) {

            }

        }

        int offset = (currentPage - 1) * pageSize;

        // Lấy tổng số dịch vụ
        int totalServices = dao.countServices(keyword, filterStatus, service_type, minPrice, maxPrice);

        int numberOfPages = (int) Math.ceil((double) totalServices / pageSize);

        List<Service> services = dao.getServices(keyword, filterStatus, service_type, minPrice, maxPrice, offset, pageSize);

        String status = request.getParameter("status");

        // Đặt attribute cho JSP
        request.setAttribute("status", status);

        request.setAttribute("service", services);

        request.setAttribute("currentPage", currentPage);

        request.setAttribute("numberOfPages", numberOfPages);

        request.setAttribute("keyword", keyword);

        request.setAttribute("filterStatus", filterStatus);

        request.setAttribute("service_type", service_type);

        request.setAttribute("priceRange", priceRange);

        request.setAttribute("pageSize", pageSize);

        request.setAttribute("numberOfServices", totalServices);

        request.getRequestDispatcher("ServiceView.jsp").forward(request, response);

    }

    /**
     *
     * Handles the HTTP <code>POST</code> method.
     *
     *
     *
     * @param request servlet request
     *
     * @param response servlet response
     *
     * @throws ServletException if a servlet-specific error occurs
     *
     * @throws IOException if an I/O error occurs
     *
     */
    @Override

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        processRequest(request, response);

    }

    /**
     *
     * Returns a short description of the servlet.
     *
     *
     *
     * @return a String containing servlet description
     *
     */
    @Override

    public String getServletInfo() {

        return "Short description";

    }// </editor-fold>

}