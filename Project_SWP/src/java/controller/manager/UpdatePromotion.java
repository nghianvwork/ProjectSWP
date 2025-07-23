/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.manager;

import DAO.PromotionDAO;
import Model.Promotion;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author admin
 */
@WebServlet(name = "UpdatePromotion", urlPatterns = {"/edit-promotion"})
public class UpdatePromotion extends HttpServlet {

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
            out.println("<title>Servlet UpdatePromotion</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UpdatePromotion at " + request.getContextPath() + "</h1>");
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
        processRequest(request, response);
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
protected void doPost(HttpServletRequest req, HttpServletResponse resp)
        throws ServletException, IOException {
    try {
        int promotionId = Integer.parseInt(req.getParameter("promotionId"));
        String title = req.getParameter("title");
        String description = req.getParameter("description");
        double discountPercent = Double.parseDouble(req.getParameter("discountPercent"));
        double discountAmount = Double.parseDouble(req.getParameter("discountAmount"));
        LocalDate startDate = LocalDate.parse(req.getParameter("startDate"));
        LocalDate endDate = LocalDate.parse(req.getParameter("endDate"));
        String status = req.getParameter("status");

        String[] areaIdArr = req.getParameterValues("area_id");
        List<Integer> areaIds = new ArrayList<>();
        if (areaIdArr != null) {
            for (String s : areaIdArr) areaIds.add(Integer.parseInt(s));
        }

       
        LocalDate today = LocalDate.now();
        if ("active".equals(status) && endDate.isBefore(today)) {
           
            req.getSession().setAttribute("error", "Không thể đặt trạng thái Hoạt động cho khuyến mãi đã hết hạn!");
            resp.sendRedirect("promotion-admin");
            return; 
        }
        if(discountPercent <0 || discountPercent >100 || discountAmount < 0 ){
             req.getSession().setAttribute("error", "Nhập sai giá khuyến mại!");
        resp.sendRedirect("promotion-admin");
        return;
        }
        Promotion promotion = new Promotion(promotionId, title, description, discountPercent, discountAmount,
                startDate, endDate, status, null, java.time.LocalDateTime.now());

        PromotionDAO dao = new PromotionDAO();
        boolean updated = dao.updatePromotion(promotion);

        dao.deleteAllPromotionAreas(promotionId);
        for (Integer areaId : areaIds) {
            dao.insertPromotionArea(promotionId, areaId);
        }

        if (updated) {
            req.getSession().setAttribute("success", "Cập nhật khuyến mãi thành công!");
        } else {
            req.getSession().setAttribute("error", "Không tìm thấy khuyến mãi!");
        }
        resp.sendRedirect("promotion-admin");
    } catch (Exception e) {
        e.printStackTrace();
        req.getSession().setAttribute("error", "Cập nhật khuyến mãi thất bại!");
        resp.sendRedirect("promotion-admin");
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
