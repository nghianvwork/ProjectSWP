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
}
