package controller.manager;

import DAO.BookingDAO;
import DAO.BookingServiceDAO;
import DAO.CourtDAO;
import DAO.UserDAO;
import DAO.AreaDAO;
import DAO.ServiceDAO;
import Model.Branch;
import Model.Bookings;
import Model.Courts;
import Model.User;
import Model.Service;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Time;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet("/update-booking")
public class UpdateBookingServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null) {
            response.sendRedirect("login");
            return;
        }
        User user = (User) session.getAttribute("user");
        if (user == null || !"staff".equals(user.getRole())) {
            response.sendRedirect("login");
            return;
        }
        String idRaw = request.getParameter("bookingId");
        if (idRaw == null) {
            response.sendRedirect("manager-booking-schedule");
            return;
        }
        try {
            int bookingId = Integer.parseInt(idRaw);
            BookingDAO dao = new BookingDAO();
            Bookings booking = dao.getBookingById(bookingId);
            if (booking == null) {
                response.sendRedirect("manager-booking-schedule");
                return;
            }
            CourtDAO courtDAO = new CourtDAO();
            Courts court = courtDAO.getCourtById(booking.getCourt_id());
            UserDAO userDAO = new UserDAO();
            User customer = userDAO.getUserById(booking.getUser_id());
            BookingServiceDAO bsDao = new BookingServiceDAO();
            List<Service> services = ServiceDAO.getAllService();
            List<Integer> selectedIds = bsDao.getServicesByBookingId(bookingId)
                    .stream().map(Service::getService_id).collect(Collectors.toList());
            request.setAttribute("booking", booking);
            request.setAttribute("court", court);
            request.setAttribute("customer", customer);
            request.setAttribute("services", services);
            request.setAttribute("selectedServiceIds", selectedIds);
            request.getRequestDispatcher("update_booking.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            response.sendRedirect("manager-booking-schedule");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null) {
            response.sendRedirect("login");
            return;
        }
        User user = (User) session.getAttribute("user");
        if (user == null || !"staff".equals(user.getRole())) {
            response.sendRedirect("login");
            return;
        }
        // 1. Lấy tham số từ form
        String bookingIdStr = request.getParameter("bookingId");
        String dateStr = request.getParameter("date");
        String startStr = request.getParameter("startTime");
        String endStr = request.getParameter("endTime");
        String status = request.getParameter("status");
        String[] selectedServices = request.getParameterValues("selectedServices");
        List<Service> servicesList = ServiceDAO.getAllService();
        List<Integer> selectedIdsParam = new java.util.ArrayList<>();
        if (selectedServices != null) {
            for (String s : selectedServices) {
                try { selectedIdsParam.add(Integer.parseInt(s)); } catch (NumberFormatException ignored) {}
            }
        }
        request.setAttribute("services", servicesList);
        request.setAttribute("selectedServiceIds", selectedIdsParam);

        // 2. Kiểm tra null/rỗng
        if (bookingIdStr == null || bookingIdStr.isEmpty()
                || dateStr == null || dateStr.isEmpty()
                || startStr == null || startStr.isEmpty()
                || endStr == null || endStr.isEmpty()
                || status == null || status.isEmpty()) {
            request.setAttribute("error", "Vui lòng nhập đầy đủ thông tin!");
            request.getRequestDispatcher("update_booking.jsp").forward(request, response);
            return;
        }

        int bookingId, courtId;
        LocalDate date;
        Time startTime, endTime;
        Bookings currentBooking = null;

        try {
            bookingId = Integer.parseInt(bookingIdStr);
            date = LocalDate.parse(dateStr);
            startTime = Time.valueOf(startStr.length() == 5 ? startStr + ":00" : startStr);
            endTime = Time.valueOf(endStr.length() == 5 ? endStr + ":00" : endStr);

            // 3. Lấy booking hiện tại để lấy courtId và hiển thị lại thông tin
            BookingDAO dao = new BookingDAO();
            currentBooking = dao.getBookingById(bookingId);
            if (currentBooking == null) {
                request.setAttribute("error", "Booking không tồn tại!");
                request.getRequestDispatcher("update_booking.jsp").forward(request, response);
                return;
            }
            courtId = currentBooking.getCourt_id();

            // 4. Kiểm tra logic thời gian
            if (!startTime.before(endTime)) {
                request.setAttribute("error", "Giờ bắt đầu phải trước giờ kết thúc.");
                // Gửi lại dữ liệu cho form để hiển thị
                request.setAttribute("booking", currentBooking);
                request.setAttribute("court", new CourtDAO().getCourtById(courtId));
                request.setAttribute("customer", new UserDAO().getUserById(currentBooking.getUser_id()));
                request.getRequestDispatcher("update_booking.jsp").forward(request, response);
                return;
            }

            CourtDAO courtDAO = new CourtDAO();
            Courts court = courtDAO.getCourtById(courtId);
            AreaDAO areaDAO = new AreaDAO();
            Branch area = areaDAO.getAreaByIdWithManager(court.getArea_id());

            if (area != null) {
                Time open = area.getOpenTime();
                Time close = area.getCloseTime();
                if (startTime.before(open) || endTime.after(close)) {
                    request.setAttribute("error", "Thời gian đặt sân phải trong khoảng mở cửa: " + open + " - " + close);
                    request.setAttribute("booking", currentBooking);
                    request.setAttribute("court", court);
                    request.setAttribute("customer", new UserDAO().getUserById(currentBooking.getUser_id()));
                    request.getRequestDispatcher("update_booking.jsp").forward(request, response);
                    return;
                }
            }

            LocalDateTime startDateTime = LocalDateTime.of(date, startTime.toLocalTime());
            if (startDateTime.isBefore(LocalDateTime.now())) {
                request.setAttribute("error", "Không thể đặt sân trong thời gian đã qua.");
                request.setAttribute("booking", currentBooking);
                request.setAttribute("court", court);
                request.setAttribute("customer", new UserDAO().getUserById(currentBooking.getUser_id()));
                request.getRequestDispatcher("update_booking.jsp").forward(request, response);
                return;
            }

            // 5. Kiểm tra trùng lịch (loại trừ chính booking này)
            boolean slotAvailable = dao.checkSlotAvailableForUpdate(bookingId, courtId, date, startTime, endTime);
            if (!slotAvailable) {
                request.setAttribute("error", "Khung giờ này đã có người đặt, vui lòng chọn khung giờ khác.");
                request.setAttribute("booking", currentBooking);
                request.setAttribute("court", new CourtDAO().getCourtById(courtId));
                request.setAttribute("customer", new UserDAO().getUserById(currentBooking.getUser_id()));
                request.getRequestDispatcher("update_booking.jsp").forward(request, response);
                return;
            }

            // 6. Cập nhật booking cùng dịch vụ
            List<Integer> serviceIds = new java.util.ArrayList<>();
            if (selectedServices != null) {
                for (String sidStr : selectedServices) {
                    try {
                        serviceIds.add(Integer.parseInt(sidStr));
                    } catch (NumberFormatException ignored) {}
                }
            }

            boolean updateSuccess = dao.updateBooking(bookingId, date, startTime, endTime, status, serviceIds);

            if (updateSuccess) {
                String msg = URLEncoder.encode("Cập nhật thành công!", StandardCharsets.UTF_8);
                response.sendRedirect("manager-booking-schedule?msg=" + msg);
            } else {
                request.setAttribute("error", "Cập nhật thất bại! Vui lòng thử lại.");
                request.setAttribute("booking", currentBooking);
                request.setAttribute("court", new CourtDAO().getCourtById(courtId));
                request.setAttribute("customer", new UserDAO().getUserById(currentBooking.getUser_id()));
                request.getRequestDispatcher("update_booking.jsp").forward(request, response);
            }

        } catch (Exception e) {
            request.setAttribute("error", "Dữ liệu không hợp lệ hoặc định dạng sai!");
            if (currentBooking != null) {
                request.setAttribute("booking", currentBooking);
                request.setAttribute("court", new CourtDAO().getCourtById(currentBooking.getCourt_id()));
                request.setAttribute("customer", new UserDAO().getUserById(currentBooking.getUser_id()));
            }
            request.getRequestDispatcher("update_booking.jsp").forward(request, response);
        }
    }
}
