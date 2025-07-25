/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.manager;

import DAO.PostDAO;
import Dal.DBContext;
import Model.Post;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.nio.file.Path;
import java.sql.Connection;
import java.sql.SQLException;

/**
 *
 * @author admin
 */
@WebServlet(name = "UpdatePostManager", urlPatterns = {"/UpdatePostManager"})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 1, // 1MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 15 // 15MB
)
public class UpdatePostManager extends HttpServlet {

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
            out.println("<title>Servlet UpdatePostManager</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UpdatePostManager at " + request.getContextPath() + "</h1>");
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
        String postIdStr = request.getParameter("postId");
        if (postIdStr == null) {
            response.sendRedirect("ViewPostManager");
            return;
        }
        int postId = Integer.parseInt(postIdStr);

        try {
            DBContext db = new DBContext();
            Connection conn = db.getConnection();
            PostDAO postDAO = new PostDAO(conn);

            Post post = postDAO.getPostById(postId);
            if (post == null) {
                response.sendRedirect("ViewPostManager");
                return;
            }

            request.setAttribute("post", post);
            request.getRequestDispatcher("UpdatePost.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(500, "Lỗi khi lấy dữ liệu bài viết");
        } catch (Exception e) {
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
        String postIdStr = request.getParameter("postId");
        String action = request.getParameter("action"); // có thể là approve, reject, hoặc null

        if (postIdStr == null || postIdStr.isEmpty()) {
            response.sendRedirect("ViewPostManager");
            return;
        }

        int postId;
        try {
            postId = Integer.parseInt(postIdStr);
        } catch (NumberFormatException e) {
            response.sendRedirect("ViewPostManager");
            return;
        }

        try {
            DBContext db = new DBContext();
            Connection conn = db.getConnection();
            PostDAO postDAO = new PostDAO(conn);

            if ("approve".equals(action) || "reject".equals(action)) {
                String newStatus = "approve".equals(action) ? "approved" : "rejected";
                postDAO.updatePostStatus(postId, newStatus);
            } else {
                // Lấy post hiện tại từ DB
                Post post = postDAO.getPostById(postId);
                if (post == null) {
                    response.sendRedirect("ViewPostManager");
                    return;
                }

                // Lấy dữ liệu form
                String title = request.getParameter("title");
                String content = request.getParameter("content");
                String type = request.getParameter("type");

                if (title == null || title.trim().isEmpty()
                        || content == null || content.trim().isEmpty()
                        || type == null || type.trim().isEmpty()) {
                    response.sendRedirect("UpdatePostManager?postId=" + postId);
                    return;
                }

                // Lấy file ảnh mới nếu có
                Part filePart = request.getPart("image");
                String fileName = null;
                if (filePart != null && filePart.getSize() > 0) {
                    String submittedFileName = Path.of(filePart.getSubmittedFileName()).getFileName().toString();
                    fileName = System.currentTimeMillis() + "_" + submittedFileName;

                    String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
                    File uploadDir = new File(uploadPath);
                    if (!uploadDir.exists()) {
                        uploadDir.mkdir();
                    }

                    filePart.write(uploadPath + File.separator + fileName);
                }

                // Cập nhật dữ liệu bài viết
                post.setTitle(title.trim());
                post.setContent(content.trim());
                post.setType(type.trim());
                if (fileName != null) {
                    post.setImage(fileName);
                }

                postDAO.updatePost(post);
            }

            response.sendRedirect("ViewPostManager");

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(500, "Lỗi khi cập nhật bài viết");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(500, "Lỗi hệ thống");
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
