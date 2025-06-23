/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Time;
import java.sql.Statement;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import DAO.CourtDAO;

import Dal.DBContext;
import Model.BookingScheduleDTO;
import Model.Bookings;
import Model.Courts;
import Model.Service;
import DAO.ServiceDAO;
import DAO.BookingServiceDAO;
import java.math.BigDecimal;
import java.util.LinkedHashMap;
import java.util.Map;

/**
 *
 * @author admin
 */
public class BookingDAO extends DBContext {

    Connection conn;

    public BookingDAO() {
        try {
            conn = getConnection();
        } catch (Exception e) {
            System.out.println("Connect failed");
        }
    }

    public int countBookingsByManager(int managerId) {
        String sql = "SELECT COUNT(*) FROM Bookings b "
                + "JOIN Courts c ON b.court_id = c.court_id "
                + "JOIN Areas a ON c.area_id = a.area_id "
                + "WHERE a.manager_id = ?";

        try (
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, managerId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return 0;
    }

    public int countBookingsByArea(int areaId) {
        String sql = "SELECT COUNT(*) "
                + "FROM Bookings b "
                + "JOIN Courts c ON b.court_id = c.court_id "
                + "WHERE c.area_id = ?";

        try (
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, areaId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return rs.getInt(1); // return the count
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }

        return 0;
    }

    public List<Bookings> getBookingsByCourtAndDate(int courtId, LocalDate date) {
        List<Bookings> bookings = new ArrayList<>();
        String sql = "SELECT * FROM Bookings WHERE court_id = ? AND date = ? AND status NOT IN ('cancelled', 'rejected')";

        try (
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, courtId);
            ps.setDate(2, java.sql.Date.valueOf(date));

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Bookings booking = new Bookings();
                booking.setBooking_id(rs.getInt("booking_id"));
                booking.setUser_id(rs.getInt("user_id"));
                booking.setCourt_id(rs.getInt("court_id"));
                booking.setDate(rs.getDate("date").toLocalDate());
                booking.setStart_time(rs.getTime("start_time"));
                booking.setEnd_time(rs.getTime("end_time"));
                booking.setStatus(rs.getString("status"));
                booking.setRating(rs.getInt("rating"));
                booking.setTotal_price(rs.getDouble("total_price"));

                bookings.add(booking);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return bookings;
    }

    public boolean checkSlotAvailable(int courtId, LocalDate date, Time startTime, Time endTime) {
        String sql = "SELECT * FROM Bookings "
                + "WHERE court_id = ? AND date = ? AND status != 'cancelled' "
                + "AND NOT (end_time <= CAST(? AS TIME) OR start_time >= CAST(? AS TIME))";

        try (
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, courtId);
            ps.setDate(2, java.sql.Date.valueOf(date));
            ps.setObject(3, endTime, java.sql.Types.TIME);
            ps.setObject(4, startTime, java.sql.Types.TIME);

            ResultSet rs = ps.executeQuery();
            boolean hasConflict = rs.next();

            // 🪵 Log ra kết quả kiểm tra
            System.out.println("⚠️ Đặt sân kiểm tra: courtId=" + courtId + ", date=" + date);
            System.out.println("Giờ bắt đầu: " + startTime + ", kết thúc: " + endTime);
            if (hasConflict) {
                System.out.println("❌ Đã trùng với lịch trước đó:");
                do {
                    System.out.println(" -> bookingId=" + rs.getInt("booking_id")
                            + " [" + rs.getTime("start_time") + " - " + rs.getTime("end_time") + "]");
                } while (rs.next());
            } else {
                System.out.println("✅ Không trùng, được phép đặt.");
            }

            return !hasConflict;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean checkSlotAvailableAdmin(int courtId, LocalDate date, Time startTime, Time endTime) {
        String sql = "SELECT COUNT(*) FROM Bookings "
                + "WHERE court_id = ? AND date = ? AND status NOT IN ('cancelled', 'rejected') "
                + "AND (start_time < ? AND end_time > ?)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, courtId);
            ps.setDate(2, Date.valueOf(date));
            ps.setTime(3, endTime);    // start_time < endTime mới
            ps.setTime(4, startTime);  // end_time > startTime mới
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                // Trả về true nếu không có bản ghi giao nhau
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return true;
    }

   public int insertBooking1(int userId, int courtId, LocalDate date, Time startTime, Time endTime, String status, BigDecimal totalPrice) {
    String sql = "INSERT INTO Bookings (user_id, court_id, date, start_time, end_time, status, total_price) VALUES (?, ?, ?, ?, ?, ?, ?)";
    int bookingId = -1;

    try (PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
        ps.setInt(1, userId);
        ps.setInt(2, courtId);
        ps.setDate(3, java.sql.Date.valueOf(date));
        ps.setTime(4, startTime);
        ps.setTime(5, endTime);
        ps.setString(6, status); // e.g., "pending"
        ps.setBigDecimal(7, totalPrice); // truyền giá đã tính toán

        int affectedRows = ps.executeUpdate();
        if (affectedRows > 0) {
            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    bookingId = rs.getInt(1); // lấy booking_id vừa tạo
                }
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }

    return bookingId;
}


    public int insertBooking(int userId, int courtId, LocalDate date, Time startTime, Time endTime, String status) {
        String sql = "INSERT INTO Bookings (user_id, court_id, date, start_time, end_time, status, total_price) VALUES (?, ?, ?, ?, ?, ?, ?)";
        int bookingId = -1;

        try (PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, userId);
            ps.setInt(2, courtId);
            ps.setDate(3, java.sql.Date.valueOf(date));
            ps.setTime(4, startTime);
            ps.setTime(5, endTime);
            ps.setString(6, status);

            double totalPrice = 0;
            Courts c = new CourtDAO().getCourtById(courtId);
            if (c != null) {
                totalPrice = c.getPrice();
            }
            ps.setDouble(7, totalPrice);

            int affectedRows = ps.executeUpdate();
            if (affectedRows > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        bookingId = rs.getInt(1);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return bookingId;
    }

    public Bookings getBookingById1(int bookingId) {
        String sql = "SELECT * FROM Bookings WHERE booking_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, bookingId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Bookings b = new Bookings();
                b.setBooking_id(rs.getInt("booking_id"));
                b.setUser_id(rs.getInt("user_id"));
                b.setCourt_id(rs.getInt("court_id"));
                b.setDate(rs.getDate("date").toLocalDate());
                b.setStart_time(rs.getTime("start_time"));
                b.setEnd_time(rs.getTime("end_time"));
                b.setStatus(rs.getString("status"));
                return b;
            }
        } catch (Exception e) {
            e.printStackTrace();

        }
        return null;
    }

    public Bookings getBookingById(int bookingId) {
        String sql = "SELECT * FROM Bookings WHERE booking_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, bookingId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Bookings b = new Bookings();
                b.setBooking_id(rs.getInt("booking_id"));
                b.setUser_id(rs.getInt("user_id"));
                b.setCourt_id(rs.getInt("court_id"));
                b.setDate(rs.getDate("date").toLocalDate());
                b.setStart_time(rs.getTime("start_time"));
                b.setEnd_time(rs.getTime("end_time"));
                b.setStatus(rs.getString("status"));
                b.setRating(rs.getInt("rating"));
                b.setTotal_price(rs.getDouble("total_price"));
                return b;

            }

        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return null;
    }

    public List<Bookings> getBookingsByUserId(int userId) {
        List<Bookings> list = new ArrayList<>();
        String sql = "SELECT * FROM Bookings b JOIN Courts c ON b.court_id = c.court_id WHERE b.user_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Bookings b = new Bookings();
                b.setBooking_id(rs.getInt("booking_id"));
                b.setCourt_id(rs.getInt("court_id"));
                b.setDate(rs.getDate("date").toLocalDate());
                b.setStart_time(rs.getTime("start_time"));
                b.setEnd_time(rs.getTime("end_time"));
                b.setStatus(rs.getString("status"));
                b.setRating(rs.getInt("rating"));
                b.setTotal_price(rs.getDouble("total_price"));
                list.add(b);

            }

        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return list;
    }

    public boolean cancelBookingById(int bookingId) {
        String sql = "UPDATE bookings SET status = ? WHERE booking_id = ?";
        try (
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, "cancelled");
            ps.setInt(2, bookingId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<BookingScheduleDTO> getManagerBookings(int managerId, Integer areaId, LocalDate start, LocalDate end, String status) {
        List<BookingScheduleDTO> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT b.booking_id, b.user_id, b.court_id, b.date, b.start_time, b.end_time, b.status, u.username, c.court_number, c.area_id, a.name AS area_name "
                + "FROM Bookings b JOIN Courts c ON b.court_id = c.court_id "
                + "JOIN Areas a ON c.area_id = a.area_id "
                + "JOIN Users u ON b.user_id = u.user_id "
                + "WHERE a.manager_id = ?");
        if (areaId != null) {
            sql.append(" AND a.area_id = ?");
        }
        if (start != null) {
            sql.append(" AND b.date >= ?");
        }
        if (end != null) {
            sql.append(" AND b.date <= ?");
        }
        if (status != null && !status.isEmpty()) {
            sql.append(" AND b.status = ?");
        }
        sql.append(" ORDER BY b.date, b.start_time");

        try (PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            int idx = 1;
            ps.setInt(idx++, managerId);
            if (areaId != null) {
                ps.setInt(idx++, areaId);
            }
            if (start != null) {
                ps.setDate(idx++, Date.valueOf(start));
            }
            if (end != null) {
                ps.setDate(idx++, Date.valueOf(end));
            }
            if (status != null && !status.isEmpty()) {
                ps.setString(idx++, status);
            }
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                BookingScheduleDTO dto = new BookingScheduleDTO();
                dto.setBooking_id(rs.getInt("booking_id"));
                dto.setUser_id(rs.getInt("user_id"));
                dto.setCourt_id(rs.getInt("court_id"));
                dto.setDate(rs.getDate("date").toLocalDate());
                dto.setStart_time(rs.getTime("start_time"));
                dto.setEnd_time(rs.getTime("end_time"));
                dto.setStatus(rs.getString("status"));
                dto.setCustomerName(rs.getString("username"));
                dto.setCourtNumber(rs.getString("court_number"));
                dto.setArea_id(rs.getInt("area_id"));
                dto.setAreaName(rs.getString("area_name"));

                list.add(dto);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean updateBookingStatus(int bookingId, String status) {
        String sql = "UPDATE Bookings SET status = ? WHERE booking_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, bookingId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateBooking(int bookingId, LocalDate date, Time startTime, Time endTime,
            String status, List<Integer> serviceIds) {
        String sql = "UPDATE Bookings SET date = ?, start_time = ?, end_time = ?, status = ?, total_price = ? WHERE booking_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setDate(1, Date.valueOf(date));
            ps.setTime(2, startTime);
            ps.setTime(3, endTime);
            ps.setString(4, status);

            // Recalculate price based on court and services
            Bookings current = getBookingById(bookingId);
            double total = 0;
            Courts court = new CourtDAO().getCourtById(current.getCourt_id());
            if (court != null) {
                total += court.getPrice();
            }
            if (serviceIds != null) {
                for (int sid : serviceIds) {
                    Service s = ServiceDAO.getServiceById(sid);
                    if (s != null) {
                        total += s.getPrice();
                    }
                }
            }
            ps.setDouble(5, total);
            ps.setInt(6, bookingId);

            int rows = ps.executeUpdate();
            if (rows > 0) {
                BookingServiceDAO bsDao = new BookingServiceDAO();
                bsDao.removeServicesByBookingId(bookingId);
                if (serviceIds != null) {
                    for (int sid : serviceIds) {
                        bsDao.addServiceToBooking(bookingId, sid);
                    }
                }
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean checkSlotAvailableForUpdate(int bookingId, int courtId, LocalDate date,
            Time startTime, Time endTime) {
        // Use the same overlap logic as when creating a new booking and exclude the
        // current booking by its id. Also ignore cancelled or rejected bookings.
        String sql = "SELECT COUNT(*) FROM Bookings "
                + "WHERE court_id = ? AND date = ? AND booking_id <> ? "
                + "AND status NOT IN ('cancelled', 'rejected') "
                + "AND NOT (end_time <= ? OR start_time >= ?)";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, courtId);
            ps.setDate(2, Date.valueOf(date));
            ps.setInt(3, bookingId);
            ps.setTime(4, startTime);  // compare new slot with existing ones
            ps.setTime(5, endTime);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                // Slot is available when there is no overlapping booking
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return true;
    }

    public List<Bookings> getBookingsByCourtId(int courtId) {
        List<Bookings> list = new ArrayList<>();
        String sql = "SELECT * FROM Bookings WHERE court_id = ?";

        try (
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, courtId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Bookings booking = new Bookings();
                booking.setBooking_id(rs.getInt("booking_id"));
                booking.setCourt_id(rs.getInt("court_id"));
                booking.setUser_id(rs.getInt("user_id"));
                booking.setDate(rs.getDate("date").toLocalDate());
                booking.setStart_time(rs.getTime("start_time"));
                booking.setEnd_time(rs.getTime("end_time"));
                booking.setStatus(rs.getString("status"));

                list.add(booking);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    public boolean updateRating(int bookingId, int rating) {
        String sql = "UPDATE Bookings SET rating = ? WHERE booking_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, rating);
            ps.setInt(2, bookingId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

public List<Bookings> getBookingHistoryByFilter(LocalDate from, LocalDate to, Integer courtId) {
    List<Bookings> list = new ArrayList<>();
    StringBuilder sql = new StringBuilder("SELECT * FROM Bookings WHERE status != 'cancelled'");
    
    // Kiểm tra và thêm điều kiện lọc ngày
    if (from != null) {
        sql.append(" AND date >= ?");
    }
    if (to != null) {
        sql.append(" AND date <= ?");
    }
    
    // Kiểm tra và thêm điều kiện lọc theo court_id
    if (courtId != null) {
        sql.append(" AND court_id = ?");
    }
    
    sql.append(" ORDER BY date DESC, start_time");

    try (PreparedStatement ps = conn.prepareStatement(sql.toString())) {
        int parameterIndex = 1;
        
        // Gán giá trị cho các tham số PreparedStatement
        if (from != null) {
            ps.setDate(parameterIndex++, java.sql.Date.valueOf(from));
        }
        if (to != null) {
            ps.setDate(parameterIndex++, java.sql.Date.valueOf(to));
        }
        if (courtId != null) {
            ps.setInt(parameterIndex++, courtId);
        }
        
        // Thực thi truy vấn
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            Bookings b = new Bookings();
            b.setBooking_id(rs.getInt("booking_id"));
            b.setUser_id(rs.getInt("user_id"));
            b.setCourt_id(rs.getInt("court_id"));
            b.setDate(rs.getDate("date").toLocalDate());
            b.setStart_time(rs.getTime("start_time"));
            b.setEnd_time(rs.getTime("end_time"));
            b.setStatus(rs.getString("status"));
            b.setRating(rs.getInt("rating"));
            b.setTotal_price(rs.getDouble("total_price"));
            list.add(b);
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return list;
}


// Tính tổng doanh thu theo filter: từ ngày, đến ngày, courtId (nếu null thì tất cả)
public BigDecimal getTotalRevenue(LocalDate from, LocalDate to, Integer courtId) {
    StringBuilder sql = new StringBuilder("SELECT SUM(total_price) FROM Bookings WHERE date >= ? AND date <= ? AND status != 'cancelled'");
    if (courtId != null) {
        sql.append(" AND court_id = ?");
    }

    try (PreparedStatement ps = conn.prepareStatement(sql.toString())) {
        ps.setDate(1, java.sql.Date.valueOf(from));
        ps.setDate(2, java.sql.Date.valueOf(to));
        if (courtId != null) {
            ps.setInt(3, courtId);
        }
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            BigDecimal sum = rs.getBigDecimal(1);
            return sum != null ? sum : BigDecimal.ZERO;
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return BigDecimal.ZERO;
}


// Doanh thu từng tháng trong 1 năm
public Map<String, BigDecimal> getRevenueByMonth(int year) {
    Map<String, BigDecimal> result = new LinkedHashMap<>();
    String sql = "SELECT MONTH([date]) AS month, SUM([total_price]) AS total " +
                 "FROM [Bookings] WHERE YEAR([date]) = ? AND [status] != 'cancelled' " +
                 "GROUP BY MONTH([date]) ORDER BY month";
    try (PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setInt(1, year);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            int month = rs.getInt("month");
            BigDecimal total = rs.getBigDecimal("total");
            result.put(String.format("%02d", month), total != null ? total : BigDecimal.ZERO);
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return result;
}

// Doanh thu từng tuần (ISO week) trong 1 năm
public Map<String, BigDecimal> getRevenueByWeek(int year) {
    Map<String, BigDecimal> result = new LinkedHashMap<>();
    String sql = "SELECT DATEPART(iso_week, [date]) AS week, SUM([total_price]) AS total " +
                 "FROM [Bookings] WHERE YEAR([date]) = ? AND [status] != 'cancelled' " +
                 "GROUP BY DATEPART(iso_week, [date]) ORDER BY week";
    try (PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setInt(1, year);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            int week = rs.getInt("week");
            BigDecimal total = rs.getBigDecimal("total");
            result.put(String.valueOf(week), total != null ? total : BigDecimal.ZERO);
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return result;
}


}
