package DAO;

import Dal.DBContext;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import Model.User;

public class UserDAO extends DBContext {
    private Connection conn;

    // Constructor để khởi tạo kết nối
    public UserDAO() {
        try {
            conn = getConnection();
        } catch (Exception e) {
            System.err.println("Lỗi kết nối DB trong UserDAO: " + e.getMessage());
        }
    }

    // Đảm bảo đóng kết nối khi đối tượng bị hủy
    public void finalize() {
        try {
            if (conn != null) conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Đăng nhập
    public User login(String username, String password) {
        String sql = "SELECT * FROM Users WHERE username = ? AND password = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, username);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return extractUserFromResultSet(rs);
            }
        } catch (SQLException e) {
            System.err.println("Lỗi đăng nhập: " + e);
        }
        return null;
    }

    // Lấy danh sách tất cả user
    public List<User> getAllUsers() {
        List<User> list = new ArrayList<>();
        String sql = "SELECT * FROM Users";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(extractUserFromResultSet(rs));
            }
        } catch (SQLException e) {
            System.err.println("Lỗi lấy danh sách user: " + e);
        }
        return list;
    }

    // Thêm user mới
    public void insertUser(User u) {
        String sql = "INSERT INTO Users (username, password, email, phone_number, role, created_at) VALUES (?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, u.getUsername());
            ps.setString(2, u.getPassword());
            ps.setString(3, u.getEmail());
            ps.setString(4, u.getPhone_number());
            ps.setString(5, u.getRole());
            ps.setTimestamp(6, Timestamp.valueOf(u.getCreatedAt()));
            ps.executeUpdate();
        } catch (SQLException e) {
            System.err.println("Lỗi thêm user: " + e);
        }
    }

    // Cập nhật user
    public void updateUser(User u) {
        String sql = "UPDATE Users SET username = ?, password = ?, email = ?, phone_number = ?, role = ? WHERE user_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, u.getUsername());
            ps.setString(2, u.getPassword());
            ps.setString(3, u.getEmail());
            ps.setString(4, u.getPhone_number());
            ps.setString(5, u.getRole());
            ps.setString(6, u.getUser_Id());
            ps.executeUpdate();
        } catch (SQLException e) {
            System.err.println("Lỗi cập nhật user: " + e);
        }
    }

    // Xóa user
    public void deleteUser(int userId) {
        String sql = "DELETE FROM Users WHERE user_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.executeUpdate();
        } catch (SQLException e) {
            System.err.println("Lỗi xóa user: " + e);
        }
    }

    // Tìm user theo ID
    public User getUserById(int userId) {
        String sql = "SELECT * FROM Users WHERE user_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return extractUserFromResultSet(rs);
            }
        } catch (SQLException e) {
            System.err.println("Lỗi tìm user theo ID: " + e);
        }
        return null;
    }

    // Tìm user theo username hoặc email
    public User getUserByUsernameOrEmail(String username, String email) {
        String sql = "SELECT * FROM Users WHERE username = ? OR email = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, username);
            ps.setString(2, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return extractUserFromResultSet(rs);
            }
        } catch (SQLException e) {
            System.err.println("Lỗi tìm user theo username hoặc email: " + e);
        }
        return null;
    }

    // Đăng ký tài khoản
    public boolean register(User user) {
        if (getUserByUsernameOrEmail(user.getUsername(), user.getEmail()) != null) {
            return false;
        }
        String sql = "INSERT INTO Users (username, password, email, phone_number, role) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, user.getUsername());
            ps.setString(2, user.getPassword());
            ps.setString(3, user.getEmail());
            ps.setString(4, user.getPhone_number());
            ps.setString(5, user.getRole());
            ps.executeUpdate();
            return true;
        } catch (SQLException e) {
            System.err.println("Lỗi đăng ký user: " + e);
        }
        return false;
    }

    // Lưu token quên mật khẩu
    public void saveResetToken(int userId, String token) {
        String sql = "INSERT INTO password_reset_tokens (user_id, token) VALUES (?, ?)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setString(2, token);
            ps.executeUpdate();
        } catch (SQLException e) {
            System.err.println("Lỗi lưu token: " + e.getMessage());
        }
    }

    // Kiểm tra token hợp lệ hay không
    public boolean isValidToken(String token) {
        String sql = "SELECT * FROM password_reset_tokens WHERE token = ? AND is_used = 0 AND DATEDIFF(MINUTE, created_at, GETDATE()) <= 5";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, token);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            System.err.println("Lỗi kiểm tra token: " + e.getMessage());
        }
        return false;
    }

    // Đổi mật khẩu bằng token
    public boolean updatePasswordByToken(String token, String newPassword) {
        String sql = "UPDATE Users SET password = ? WHERE user_id = (SELECT user_id FROM password_reset_tokens WHERE token = ? AND is_used = 0 AND DATEDIFF(MINUTE, created_at, GETDATE()) <= 5)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, newPassword);
            ps.setString(2, token);
            int result = ps.executeUpdate();
            if (result > 0) {
                markTokenUsed(token);
                return true;
            }
        } catch (SQLException e) {
            System.err.println("Lỗi cập nhật mật khẩu theo token: " + e.getMessage());
        }
        return false;
    }

    private void markTokenUsed(String token) {
        String sql = "UPDATE password_reset_tokens SET is_used = 1 WHERE token = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, token);
            ps.executeUpdate();
        } catch (SQLException e) {
            System.err.println("Lỗi đánh dấu token đã dùng: " + e.getMessage());
        }
    }

    public void updatePassword(User us) {
        String sql = "UPDATE Users SET password = ? WHERE user_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, us.getPassword());
            ps.setString(2, us.getUser_Id());
            ps.executeUpdate();
        } catch (SQLException e) {
            System.err.println("Lỗi cập nhật mật khẩu: " + e.getMessage());
        }
    }

    public User getUserByEmail(String email) {
        String sql = "SELECT * FROM Users WHERE email = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return extractUserFromResultSet(rs);
            }
        } catch (SQLException e) {
            System.err.println("Lỗi tìm user theo email: " + e.getMessage());
        }
        return null;
    }

    public User getUserByUsername(String username) {
        String sql = "SELECT * FROM Users WHERE username = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return extractUserFromResultSet(rs);
            }
        } catch (SQLException e) {
            System.err.println("Lỗi tìm user theo username: " + e.getMessage());
        }
        return null;
    }

    private User extractUserFromResultSet(ResultSet rs) throws SQLException {
        User user = new User();
        user.setUser_Id(String.valueOf(rs.getInt("user_id")));
        user.setUsername(rs.getString("username"));
        user.setPassword(rs.getString("password"));
        user.setEmail(rs.getString("email"));
        user.setPhone_number(rs.getString("phone_number"));
        user.setRole(rs.getString("role"));
        Timestamp ts = rs.getTimestamp("created_at");
        if (ts != null) {
            user.setCreatedAt(ts.toLocalDateTime());
        }
        return user;
    }

    // Hàm test main
    public static void main(String[] args) {
        UserDAO dao = new UserDAO();
        List<User> list = dao.getAllUsers();
        for (User u : list) {
            System.out.println(u);
        }
    }
}
