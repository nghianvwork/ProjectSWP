/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.user;

import DAO.ChatDAO;
import Model.ChatMessage;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import jakarta.security.auth.message.callback.PrivateKeyCallback.Request;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.eclipse.jetty.server.Response;

import okhttp3.OkHttpClient;

import okhttp3.MediaType;
import okhttp3.RequestBody;




import com.google.gson.JsonParser;
import okhttp3.RequestBody;
/**
 *
 * @author admin
 */
@WebServlet(name="ChatboxServlet", urlPatterns={"/chatbot"})
public class ChatbotServlet extends HttpServlet {
   
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
            out.println("<title>Servlet ChatboxServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ChatboxServlet at " + request.getContextPath () + "</h1>");
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
   private static final String OPENAI_API_KEY = "YOUR_API_KEY_HERE";
    private static final String OPENAI_ENDPOINT = "https://api.openai.com/v1/chat/completions";
 @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("user_id"); 
        
        String userMessage = request.getParameter("message");

        try {
         
            ChatDAO chatDAO = new ChatDAO();

            // Lưu tin nhắn người dùng
            ChatMessage userChat = new ChatMessage(userId, userMessage, "user");
            chatDAO.saveMessage(userChat);

            // Giả lập gọi AI API (Thay bằng code gọi AI thực tế)
            String botResponse = getAIResponse(userMessage);

            // Lưu phản hồi của chatbot
            ChatMessage botChat = new ChatMessage(null, botResponse, "bot");
            chatDAO.saveMessage(botChat);

            response.getWriter().write(botResponse);
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("Lỗi: " + e.getMessage());
        }
    }

    // Giả lập AI Chatbot Response (Cần tích hợp API AI thực tế)
   private String getAIResponse(String message) {
    String lowerMsg = message.toLowerCase();

    if (lowerMsg.contains("đặt sân") || lowerMsg.contains("đăng ký sân")) {
        return "Bạn muốn đặt sân vào thời gian nào và ở khu vực nào?";
    }

    if (lowerMsg.contains("giá") || lowerMsg.contains("bao nhiêu") || lowerMsg.contains("phí thuê")) {
        return "Giá thuê sân phụ thuộc vào từng khu vực và khung giờ. Bạn muốn xem giá ở sân nào?";
    }

    if (lowerMsg.contains("giờ mở cửa") || lowerMsg.contains("hoạt động lúc mấy giờ")) {
        return "Hệ thống sân bãi hoạt động từ 6:00 sáng đến 22:00 mỗi ngày.";
    }

    if (lowerMsg.contains("có sân trống") || lowerMsg.contains("kiểm tra sân") || lowerMsg.contains("sân nào còn")) {
        return "Vui lòng cung cấp ngày và khung giờ bạn muốn kiểm tra sân trống.";
    }

    if (lowerMsg.contains("hủy đặt") || lowerMsg.contains("hủy lịch") || lowerMsg.contains("xóa đặt sân")) {
        return "Bạn vui lòng cung cấp mã đặt sân hoặc thời gian để chúng tôi hỗ trợ hủy lịch.";
    }

    if (lowerMsg.contains("cảm ơn") || lowerMsg.contains("thanks")) {
        return "Rất vui được hỗ trợ bạn. Chúc bạn một ngày tốt lành!";
    }

    if (lowerMsg.contains("hello") || lowerMsg.contains("xin chào") || lowerMsg.contains("chào bot")) {
        return "Xin chào! Tôi là trợ lý đặt sân. Bạn cần hỗ trợ gì?";
    }

    return "Tôi có thể giúp gì cho bạn? Ví dụ: đặt sân, kiểm tra giờ mở cửa, giá thuê...";
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
