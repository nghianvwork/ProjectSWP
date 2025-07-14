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
@WebServlet(name="AddPromotion", urlPatterns={"/add-promotion"})
public class AddPromotion extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
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
            out.println("<title>Servlet AddPromotion</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddPromotion at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
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
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
  @Override
protected void doPost(HttpServletRequest req, HttpServletResponse response)
throws ServletException, IOException {
   try {
        String title = req.getParameter("title");
        String description = req.getParameter("description");
        double discountPercent = Double.parseDouble(req.getParameter("discountPercent"));
        double discountAmount = Double.parseDouble(req.getParameter("discountAmount"));
        LocalDate startDate = LocalDate.parse(req.getParameter("startDate"));
        LocalDate endDate = LocalDate.parse(req.getParameter("endDate"));
        String status = req.getParameter("status");

        String[] areaIdArr = req.getParameterValues("areaIds");
        List<Integer> areaIds = new ArrayList<>();
        if(areaIdArr != null){
            for(String s : areaIdArr) areaIds.add(Integer.parseInt(s));
        }

        Promotion promotion = new Promotion(0, title, description, discountPercent, discountAmount,
                startDate, endDate, status, LocalDateTime.now(), null);

        PromotionDAO dao = new PromotionDAO();

       
        for(Integer areaId : areaIds){
    if (dao.isDuplicatePromotionForArea(title, startDate, endDate, areaId)) {
        req.getSession().setAttribute("success", "Đã tồn tại khuyến mãi với tên này và ngày giao nhau cho khu vực!");
        response.sendRedirect("promotion-admin");
        return;
    }
}
        int newPromotionId = dao.insertPromotion(promotion);

        for(Integer areaId : areaIds){
            dao.insertPromotionArea(newPromotionId, areaId);
        }

        req.getSession().setAttribute("success", "Thêm khuyến mãi thành công!");
        response.sendRedirect("promotion-admin");
    } catch (Exception e) {
        e.printStackTrace();
        req.getSession().setAttribute("error", "Thêm khuyến mãi thất bại!");
        response.sendRedirect("promotion-admin");
    }
}

    

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
