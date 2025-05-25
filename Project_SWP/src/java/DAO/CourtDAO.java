/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Dal.DBContext;
import Model.Courts;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author admin
 */
public class CourtDAO extends DBContext{
    Connection connection;

    public CourtDAO() {
        try {
            connection = getConnection();
        } catch (Exception e) {
            System.out.println("Connect failed");
        }
    }

    public void addCourt(Courts court) {
        String sql = "INSERT INTO Courts (court_id, court_number, status, area_id) VALUES (?, ?, ?, ?)";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, court.getCourt_id());
            ps.setString(2, court.getCourt_number());
            ps.setString(3, court.getStatus());
            ps.setInt(4, court.getArea_id());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Courts> getAllCourts() {
        List<Courts> courts = new ArrayList<>();
        String sql = "SELECT court_id, court_number, status, area_id FROM Courts";
        try (Connection conn = getConnection(); 
            PreparedStatement stmt = conn.prepareStatement(sql)) {
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Courts court = new Courts();
                court.setCourt_id(rs.getInt("court_id"));
                court.setCourt_number(rs.getString("court_number"));
                court.setStatus(rs.getString("status"));
                court.setArea_id(rs.getInt("area_id"));
                courts.add(court);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(CourtDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return courts;
    }

    public Courts getCourtById(String courtId) {
        Courts court = null;
        String sql = "SELECT court_id, court_number, status, area_id FROM Courts WHERE court_id = ?";
        try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, courtId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                court = new Courts();
                court.setCourt_id(rs.getInt("court_id"));
                court.setCourt_number(rs.getString("court_number"));
                court.setStatus(rs.getString("status"));
                court.setArea_id(rs.getInt("area_id"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(CourtDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return court;
    }

    public void updateCourt(Courts court) {
        String sql = "UPDATE Courts SET court_number = ?, status = ?, area_id = ? WHERE court_id = ?";
        try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, court.getCourt_number());
            stmt.setString(2, court.getStatus());
            stmt.setInt(3, court.getArea_id());
            stmt.setInt(4, court.getCourt_id());
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(CourtDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void deleteCourt(String courtId) {
        String sql = "DELETE FROM Courts WHERE court_id = ?";
        try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, courtId);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(CourtDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public static void main(String[] args) throws Exception {
       CourtDAO courtDAO = new CourtDAO();

    
    Courts newCourt = new Courts();

    newCourt.setCourt_number("1");
    newCourt.setStatus("Available");
    newCourt.setArea_id(1);

    
    courtDAO.addCourt(newCourt);
    System.out.println("Đã thêm sân thành công!");
    
    }
}
