/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

/**
 *
 * @author Hoang Tan Bao
 */
import Dal.DBContext;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import Model.User;

public class UserDAO extends DBContext {
    Connection conn;
  public UserDAO(){
        try {
            conn = getConnection();
        } catch (Exception e) {
            System.out.println("Connect failed");
        }
    }

    
    public User login(String username, String password) {
        String sql = "SELECT * FROM Users WHERE username = ? AND password = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new User(
                        rs.getInt("user_id"),
                        rs.getString("username"),
                        rs.getString("password"),
                        rs.getString("email"),
                        rs.getString("phone_number"),
                        rs.getString("role")
                );
            }

        } catch (SQLException e) {
            System.err.println("Lỗi đăng nhập: " + e);
        }
        return null;
    }

    // Lấy tất cả người dùng
    public List<User> getAllUsers() {
        List<User> list = new ArrayList<>();
        String sql = "SELECT * FROM Users";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                User u = new User(
                       rs.getInt("user_id"),
                        rs.getString("username"),
                        rs.getString("password"),
                        rs.getString("email"),
                        rs.getString("phone_number"),
                        rs.getString("role")
                );
                list.add(u);
            }
        } catch (SQLException e) {
            System.err.println("Lỗi lấy danh sách user: " + e);
        }
        return list;
    }

    // Thêm người dùng mới
    public void insertUser(User u) {
        String sql = "INSERT INTO Users (username, password, email, phone_number, role, created_at) VALUES (?, ?, ?, ?, ?, ?)";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, u.getUsername());
            ps.setString(2, u.getPassword());
            ps.setString(3, u.getEmail());
            ps.setString(4, u.getPhone_number());
            ps.setString(5, u.getRole());
            ps.setTimestamp(6, Timestamp.valueOf(u.getCreatedAt())); // chuyển LocalDateTime → Timestamp
            ps.executeUpdate();
        } catch (SQLException e) {
            System.err.println("Lỗi thêm user: " + e);
        }
    }

    // Cập nhật người dùng
    public void updateUser(User u) {
        String sql = "UPDATE Users SET username = ?, password = ?, email = ?, phone_number = ?, role = ? WHERE user_id = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, u.getUsername());
            ps.setString(2, u.getPassword());
            ps.setString(3, u.getEmail());
            ps.setString(4, u.getPhone_number());
            ps.setString(5, u.getRole());
            ps.setInt(6, u.getUser_Id()); // user_Id là String
            ps.executeUpdate();
        } catch (SQLException e) {
            System.err.println("Lỗi cập nhật user: " + e);
        }
    }

    // Xóa người dùng
    public void deleteUser(int userId) {
        String sql = "DELETE FROM Users WHERE user_id = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            ps.executeUpdate();
        } catch (SQLException e) {
            System.err.println("Lỗi xóa user: " + e);
        }
    }

    // Tìm user theo ID
    public User getUserById(int userId) {
        String sql = "SELECT * FROM Users WHERE user_id = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new User(
                        rs.getInt("user_id"), // Ép kiểu sang String
                        rs.getString("username"),
                        rs.getString("password"),
                        rs.getString("email"),
                        rs.getString("phone_number"),
                        rs.getString("role")
                );
            }
        } catch (SQLException e) {
            System.err.println("Lỗi tìm user theo ID: " + e);
        }
        return null;
    }

    // Tìm user theo username và email
    public User getUserByUsernameOrEmail(String username, String email) {
        String sql = "SELECT * FROM Users WHERE username = ? OR email = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                User user = new User(
                       rs.getInt("user_id"),
                        rs.getString("username"),
                        rs.getString("password"),
                        rs.getString("email"),
                        rs.getString("phone_number"),
                        rs.getString("role")
                );
                user.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
                return user;
            }
        } catch (SQLException e) {
            System.err.println("Lỗi tìm user theo username hoặc email: " + e);
        }
        return null;
    }

    public boolean register(User user) {
        // Kiểm tra username đã tồn tại chưa
        if (getUserByUsernameOrEmail(user.getUsername(), user.getEmail()) != null) {
            return false; // Username đã tồn tại
        }

        String sql = "INSERT INTO Users (username, password, email, phone_number, role) VALUES (?, ?, ?, ?, ?)";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
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

    public boolean isValidToken(String token) {
        String sql = "SELECT * FROM password_reset_tokens "
                + "WHERE token = ? AND is_used = 0 AND DATEDIFF(MINUTE, created_at, GETDATE()) <= 5";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, token);
            ResultSet rs = ps.executeQuery();
            return rs.next(); // Nếu có dòng khớp thì token còn hiệu lực
        } catch (SQLException e) {
            System.err.println("Lỗi kiểm tra token: " + e.getMessage());
            return false;
        }
    }

    public boolean updatePasswordByToken(String token, String newPassword) {
        // Cập nhật mật khẩu mới cho user nếu token hợp lệ
        String sql = "UPDATE Users SET password = ? "
                + "WHERE user_id = (SELECT user_id FROM password_reset_tokens "
                + "WHERE token = ? AND is_used = 0 AND DATEDIFF(MINUTE, created_at, GETDATE()) <= 5)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, newPassword);
            ps.setString(2, token);
            int updated = ps.executeUpdate();
            if (updated > 0) {
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

   public User getUserByEmail(String email) {
    String sql = "SELECT * FROM Users WHERE email = ?";
    try (PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setString(1, email);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            return new User(
                    rs.getInt("user_id"),
                    rs.getString("username"),
                    rs.getString("password"),
                    rs.getString("email"),
                    rs.getString("phone_number"),
                    rs.getString("role")
            );
        }
    } catch (SQLException e) {
        System.err.println("Lỗi tìm user theo email: " + e.getMessage());
    }
    return null;
}

 private static final String SQL_SELECT_BY_USERNAME="SELECT *\n" +
"  FROM [dbo].[Users]\n" +
"  where username=?";
    public User getUserByUsername(String username) {
        User user =  null;
        
        try{
            PreparedStatement stmt = conn.prepareStatement(SQL_SELECT_BY_USERNAME);
            stmt.setString(1, username);
            ResultSet rs = stmt.executeQuery();
            if(rs.next()){
                user = extractUserFromResultSet(rs);
            }
        }catch(SQLException e){
            System.out.println("getUserByUsername: " + e.getMessage()); 
        }
        return user;
    }

private User extractUserFromResultSet(ResultSet rs) throws SQLException{
        User user = new User();
        user.setUser_Id(rs.getInt("user_id"));
        user.setUsername(rs.getString("username"));
        user.setPassword(rs.getString("password"));
        user.setEmail(rs.getString("email"));
        user.setPhone_number(rs.getString("phone_number"));
        user.setRole(rs.getString("role"));
        user.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
        return user;
    }
     public void updatePassword(User us) {
        String sql = "update Users set password = ? where user_id = ?";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setString(1, us.getPassword());
            pre.setInt(2, us.getUser_Id());
            pre.executeUpdate();
        } catch (SQLException e) {

        }
    }
     public static void main(String[] args) {
    UserDAO dao = new UserDAO();
    String testUsername = "admin01"; 
    User user = dao.getUserByUsername(testUsername);
    
    if (user != null) {
        System.out.println(user.toString());
    } else {
        System.out.println("User not found!");
    }
}

}
