package controller.manager;

import DAO.BookingDAO;
import DAO.BookingServiceDAO;
import DAO.CourtDAO;
import DAO.UserDAO;
import DAO.AreaDAO;
import DAO.ServiceDAO;
import DAO.PromotionDAO;
import Model.Branch;
import Model.Courts;
import Model.Service;
import Model.User;
import Model.Promotion;
import Model.Shift;
import DAO.ShiftDAO;
import utils.PasswordUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.Time;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.List;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

/**
 * Servlet used by staff or admin to create a new booking for customers.
 */
@WebServlet(name = "AddBookingServlet", urlPatterns = {"/add-booking"})
public class AddBookingServlet extends HttpServlet {


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (!hasAccess(session)) {
            response.sendRedirect("login");
            return;
        }
        User currentUser = (User) session.getAttribute("user");
        populateFormData(request, currentUser);

        String courtIdStr = request.getParameter("courtId");
        String dateStr = request.getParameter("date");
        if (courtIdStr != null && dateStr != null && !courtIdStr.isEmpty() && !dateStr.isEmpty()) {
            try {
                int courtId = Integer.parseInt(courtIdStr);
                LocalDate date = LocalDate.parse(dateStr);
                BookingDAO dao = new BookingDAO();
                java.util.List<Model.Slot> slots = dao.getAvailableSlots(courtId, date);
                request.setAttribute("slots", slots);
                request.setAttribute("selectedCourtId", courtId);
                request.setAttribute("selectedDate", date);
            } catch (Exception e) {
                // ignore invalid parameters
            }
        }

        request.getRequestDispatcher("add_booking.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (!hasAccess(session)) {
            response.sendRedirect("login");
            return;
        }
        User currentUser = (User) session.getAttribute("user");
        request.setCharacterEncoding("UTF-8");


        String courtIdStr = request.getParameter("courtId");
        String username = request.getParameter("username");
        String dateStr = request.getParameter("date");
        String startTimeStr = request.getParameter("startTime");
        String endTimeStr = request.getParameter("endTime");
        String[] selectedServices = request.getParameterValues("selectedServices");

        int parsedCourtId = -1;
        LocalDate parsedDate = null;
        try {
            if (courtIdStr != null && !courtIdStr.isEmpty()) {
                parsedCourtId = Integer.parseInt(courtIdStr);
            }
        } catch (NumberFormatException ignored) { }
        try {
            if (dateStr != null && !dateStr.isEmpty()) {
                parsedDate = LocalDate.parse(dateStr);
            }
        } catch (Exception ignored) { }

        loadSlotsAndSelection(request, parsedCourtId, parsedDate);

        // Validate required parameters
        if (courtIdStr == null || courtIdStr.isEmpty()
                || dateStr == null || dateStr.isEmpty()
                || startTimeStr == null || startTimeStr.isEmpty()
                || endTimeStr == null || endTimeStr.isEmpty()
                || username == null || username.trim().isEmpty()) {
            request.setAttribute("error", "Vui lòng nhập đầy đủ thông tin ngày, giờ và sân.");
            populateFormData(request, currentUser);
            loadSlotsAndSelection(request, parsedCourtId, parsedDate);
            request.getRequestDispatcher("add_booking.jsp").forward(request, response);
            return;
        }

        try {
            int courtId = Integer.parseInt(courtIdStr);
            UserDAO userDao = new UserDAO();
            User u = userDao.getUserByUsername(username.trim());
            if (u == null) {
                User newUser = new User();
                newUser.setUsername(username.trim());
                newUser.setPassword(PasswordUtil.hashPassword("123456"));
                newUser.setRole("user");
                newUser.setStatus("active");
                if (!userDao.insertUser(newUser)) {
                    request.setAttribute("error", "Không thể tạo người dùng mới.");
                    populateFormData(request, currentUser);
                    loadSlotsAndSelection(request, parsedCourtId, parsedDate);
                    request.getRequestDispatcher("add_booking.jsp").forward(request, response);
                    return;
                }
                u = userDao.getUserByUsername(username.trim());
            }
            int userId = u.getUser_Id();
            LocalDate date = LocalDate.parse(dateStr);

            CourtDAO courtDAO = new CourtDAO();
            Courts court = courtDAO.getCourtById(courtId);
            if (court == null) {
                request.setAttribute("error", "Sân không tồn tại.");
                populateFormData(request, currentUser);
                loadSlotsAndSelection(request, parsedCourtId, parsedDate);
                request.getRequestDispatcher("add_booking.jsp").forward(request, response);
                return;
            }

            BookingDAO bookingDAO = new BookingDAO();
            Branch branch = new AreaDAO().getAreaByIdWithManager(court.getArea_id());

            java.util.List<Service> serviceList = new java.util.ArrayList<>();
            double serviceTotal = 0;
            if (selectedServices != null) {
                for (String id : selectedServices) {
                    try {
                        Service s = ServiceDAO.getServiceById(Integer.parseInt(id));
                        if (s != null) {
                            serviceList.add(s);
                            serviceTotal += s.getPrice();
                        }
                    } catch (NumberFormatException ignored) { }
                }
            }

            PromotionDAO proDao = new PromotionDAO();
            Promotion promotion = proDao.getCurrentPromotionForArea(court.getArea_id(), date);

            if (startTimeStr.length() == 5) {
                startTimeStr += ":00";
            }
            if (endTimeStr.length() == 5) {
                endTimeStr += ":00";
            }
            Time startTime = Time.valueOf(startTimeStr);
            Time endTime = Time.valueOf(endTimeStr);

            java.util.List<String> conflicts = new java.util.ArrayList<>();

            if (!startTime.before(endTime)) {
                conflicts.add("Giờ bắt đầu phải trước giờ kết thúc");
            }

            if (branch != null) {
                Time open = branch.getOpenTime();
                Time close = branch.getCloseTime();
                if (startTime.before(open) || endTime.after(close)) {
                    conflicts.add("Khung giờ ngoài giờ mở cửa");
                }
            }

            LocalDateTime startDateTime = LocalDateTime.of(date, startTime.toLocalTime());
            if (startDateTime.isBefore(LocalDateTime.now())) {
                conflicts.add("Khung giờ đã qua");
            }

            boolean slotAvailable = bookingDAO.checkSlotAvailable(courtId, date, startTime, endTime);
            boolean continuous = bookingDAO.checkContinuousSlotsAvailable(courtId, date, startTime, endTime);
            if (!slotAvailable || !continuous) {
                conflicts.add("Một hoặc nhiều slot đã chọn không khả dụng");
            }

            ShiftDAO shiftDAO = new ShiftDAO();
            List<Shift> shifts = shiftDAO.getShiftsByCourt(courtId);

            BigDecimal slotPrice = BigDecimal.ZERO;
            LocalTime startLocal = startTime.toLocalTime();
            LocalTime endLocal = endTime.toLocalTime();
            for (Shift sh : shifts) {
                LocalTime shStart = sh.getStartTime().toLocalTime();
                LocalTime shEnd = sh.getEndTime().toLocalTime();
                if (endLocal.isAfter(shStart) && startLocal.isBefore(shEnd)) {
                    slotPrice = slotPrice.add(sh.getPrice());
                }
            }

            // if (promotion != null) {
            //     if (promotion.getDiscountPercent() > 0) {
            //         BigDecimal percent = BigDecimal.valueOf(promotion.getDiscountPercent())
            //                 .divide(BigDecimal.valueOf(100), 4, RoundingMode.HALF_UP);
            //         slotPrice = slotPrice.subtract(slotPrice.multiply(percent));
            //     }
            //     if (promotion.getDiscountAmount() > 0) {
            //         slotPrice = slotPrice.subtract(BigDecimal.valueOf(promotion.getDiscountAmount()));
            //     }
            // }
            if (slotPrice.compareTo(BigDecimal.ZERO) < 0) {
                slotPrice = BigDecimal.ZERO;
            }

            BigDecimal finalPrice = slotPrice.add(BigDecimal.valueOf(serviceTotal)).setScale(0, RoundingMode.HALF_UP);

            if (!conflicts.isEmpty()) {
                request.setAttribute("error", String.join(", ", conflicts));
                populateFormData(request, currentUser);
                loadSlotsAndSelection(request, parsedCourtId, parsedDate);
                request.getRequestDispatcher("add_booking.jsp").forward(request, response);
                return;
            }

             boolean repeatWeekly = request.getParameter("repeatWeekly") != null;
            int weeks = repeatWeekly ? 4 : 1;
            java.util.List<Integer> ids = new java.util.ArrayList<>();
            LocalDate current = date;

            for (int i = 0; i < weeks; i++) {
                if (!bookingDAO.checkSlotAvailable(courtId, current, startTime, endTime)
                        || !bookingDAO.checkContinuousSlotsAvailable(courtId, current, startTime, endTime)) {
                    current = current.plusWeeks(1);
                    continue;
                }
                int bookingId = bookingDAO.insertBookingWithTotalPrice(userId, courtId, current,
                        startTime, endTime, "pending", finalPrice);
                if (bookingId != -1 && selectedServices != null) {
                    BookingServiceDAO bsDao = new BookingServiceDAO();
                    for (String id : selectedServices) {
                        try {
                            bsDao.addServiceToBooking(bookingId, Integer.parseInt(id));
                        } catch (NumberFormatException ignored) { }
                    }
                }
                ids.add(bookingId);
                current = current.plusWeeks(1);
            }
            String msg = URLEncoder.encode("Đặt sân thành công " + ids.size() + " lượt!", StandardCharsets.UTF_8);
            response.sendRedirect("manager-booking-schedule?msg=" + msg);
        } catch (Exception e) {
            request.setAttribute("error", "Dữ liệu không hợp lệ hoặc lỗi hệ thống!");
            populateFormData(request, currentUser);
            loadSlotsAndSelection(request, parsedCourtId, parsedDate);
            request.getRequestDispatcher("add_booking.jsp").forward(request, response);
        }
    }

    private boolean hasAccess(HttpSession session) {
        if (session == null) return false;
        User user = (User) session.getAttribute("user");
        if (user == null) return false;
        String role = user.getRole();
        return "staff".equals(role) || "admin".equals(role);
    }

    private void populateFormData(HttpServletRequest request, User user) {
        CourtDAO courtDAO = new CourtDAO();

        List<Courts> courts;
        if ("admin".equals(user.getRole())) {
            courts = courtDAO.getAllCourts();
        } else {
            courts = courtDAO.getCourtsByManager(user.getUser_Id());
            if (courts == null || courts.isEmpty()) {
                request.setAttribute("courtMessage", "Không tìm thấy sân nào thuộc khu vực bạn quản lý.");
                courts = courts == null ? new java.util.ArrayList<>() : courts;
            }
        }

        List<Service> services = ServiceDAO.getAllService();

        request.setAttribute("courts", courts);
        request.setAttribute("services", services);
    }

    private void loadSlotsAndSelection(HttpServletRequest request, int courtId, LocalDate date) {
        if (courtId > 0 && date != null) {
            try {
                BookingDAO dao = new BookingDAO();
                List<Model.Slot> slots = dao.getAvailableSlots(courtId, date);
                request.setAttribute("slots", slots);
            } catch (Exception ignored) {
            }
            request.setAttribute("selectedCourtId", courtId);
            request.setAttribute("selectedDate", date);
        }
    }
}
