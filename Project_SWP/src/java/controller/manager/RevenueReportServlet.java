/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.manager;

import DAO.BookingDAO;
import Model.Bookings;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;
import java.util.Map;
import com.google.gson.Gson;

@WebServlet("/revenue-report")
public class RevenueReportServlet extends HttpServlet {

    private BookingDAO bookingDAO = new BookingDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String fromDateStr = request.getParameter("fromDate");
        String toDateStr = request.getParameter("toDate");
        String courtIdStr = request.getParameter("courtId");

        LocalDate from = (fromDateStr != null) ? LocalDate.parse(fromDateStr) : LocalDate.now().minusDays(30);
        LocalDate to = (toDateStr != null) ? LocalDate.parse(toDateStr) : LocalDate.now();
        Integer courtId = (courtIdStr != null && !courtIdStr.isEmpty()) ? Integer.parseInt(courtIdStr) : null;

        List<Bookings> bookings = bookingDAO.getBookingHistoryByFilter(from, to, courtId);
        BigDecimal totalRevenue = bookingDAO.getTotalRevenue(from, to, courtId);

        // Thống kê doanh thu theo tháng và theo tuần
        Map<String, BigDecimal> revenueByMonth = bookingDAO.getRevenueByMonth(from.getYear());
        Map<String, BigDecimal> revenueByWeek = bookingDAO.getRevenueByWeek(from.getYear());

        // Convert sang JSON để JS vẽ chart
        Gson gson = new Gson();
        String revenueByMonthJson = gson.toJson(revenueByMonth);
        String revenueByWeekJson = gson.toJson(revenueByWeek);

        request.setAttribute("bookings", bookings);
        request.setAttribute("totalRevenue", totalRevenue);
        request.setAttribute("fromDate", from);
        request.setAttribute("toDate", to);
        request.setAttribute("courtId", courtId);
        request.setAttribute("revenueByMonthJson", revenueByMonthJson);
        request.setAttribute("revenueByWeekJson", revenueByWeekJson);

        request.getRequestDispatcher("revenueReport.jsp").forward(request, response);
    }
}
