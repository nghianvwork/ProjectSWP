/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;
import Dal.DBContext;
import Model.User;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.ResultSet;
/**
 *
 * @author admin
 */
public class UserDAO extends DBContext{
    Connection conn;
    public UserDAO(){
        try {
            conn = getConnection();
        } catch (Exception e) {
            System.out.println("Connect failed");
        }
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
        user.setUser_Id(rs.getString("user_id"));
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
            pre.setString(2, us.getUser_Id());
            pre.executeUpdate();
        } catch (SQLException e) {

        }
    }
    public static void main(String[] args) {
    UserDAO dao = new UserDAO();
    String testUsername = "admin1"; 
    User user = dao.getUserByUsername(testUsername);
    
    if (user != null) {
        System.out.println(user.toString());
    } else {
        System.out.println("User not found!");
    }
}

}
    
    