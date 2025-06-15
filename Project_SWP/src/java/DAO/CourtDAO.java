/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import Dal.DBContext;
import Model.Courts;
import java.sql.Time;

/**
 *
 * @author admin
 */
public class CourtDAO extends DBContext {

    Connection connection;

    public CourtDAO() {
        try {
            connection = getConnection();
        } catch (Exception e) {
            System.out.println("Connect failed");
        }
    }
    AreaDAO dao = new AreaDAO();

    public void addCourt(Courts court) {
        String sql = "INSERT INTO Courts (court_number, type, floor_material, lighting, description, image_url, status, area_id) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, court.getCourt_number());
            ps.setString(2, court.getType());
            ps.setString(3, court.getFloor_material());
            ps.setString(4, court.getLighting());
            ps.setString(5, court.getDescription());
            ps.setString(6, court.getImage_url());
            ps.setString(7, court.getStatus());
            ps.setInt(8, court.getArea_id());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Courts> getAllCourts() {
        List<Courts> courts = new ArrayList<>();
        String sql = "SELECT court_id, court_number, type, floor_material, lighting, description, image_url, status, area_id FROM Courts";
        try (
                Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Courts court = new Courts();
                court.setCourt_id(rs.getInt("court_id"));
                court.setCourt_number(rs.getString("court_number"));
                court.setType(rs.getString("type"));
                court.setFloor_material(rs.getString("floor_material"));
                court.setLighting(rs.getString("lighting"));
                court.setDescription(rs.getString("description"));
                court.setImage_url(rs.getString("image_url"));
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

    public Courts getCourtById(int courtId) {
        Courts court = null;
        String sql = "SELECT court_id, court_number, type, floor_material, lighting, description, image_url, status, area_id FROM Courts WHERE court_id = ?";
        try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, courtId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                court = new Courts();
                court.setCourt_id(rs.getInt("court_id"));
                court.setCourt_number(rs.getString("court_number"));
                court.setType(rs.getString("type"));
                court.setFloor_material(rs.getString("floor_material"));
                court.setLighting(rs.getString("lighting"));
                court.setDescription(rs.getString("description"));
                court.setImage_url(rs.getString("image_url"));
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
        String sql = "UPDATE Courts SET court_number = ?, type = ?, floor_material = ?, lighting = ?, description = ?, image_url = ?, status = ?, area_id = ? WHERE court_id = ?";
        try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, court.getCourt_number());
            stmt.setString(2, court.getType());
            stmt.setString(3, court.getFloor_material());
            stmt.setString(4, court.getLighting());
            stmt.setString(5, court.getDescription());
            stmt.setString(6, court.getImage_url());
            stmt.setString(7, court.getStatus());
            stmt.setInt(8, court.getArea_id());
            stmt.setInt(9, court.getCourt_id());
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

<<<<<<< HEAD
     public List<Courts> getCourtsByAreaId(int areaId) {
=======
    public int countCourtsByArea(int areaId) {
        String sql = "SELECT COUNT(*) FROM Courts WHERE area_id = ?";

        try (
                PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, areaId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return 0;
    }

    public int countCourtsByManager(int managerId) {
        String sql = "SELECT COUNT(*) FROM Courts c JOIN Areas a ON c.area_id = a.area_id WHERE a.manager_id = ?";

        try (
                PreparedStatement stmt = connection.prepareStatement(sql)) {
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

    public List<Courts> getCourtsByAreaId(int areaId) {
>>>>>>> 9666cc4c6b177abb4a3002edc56a55bbdeb3db22
        List<Courts> listCourt = new ArrayList<>();
        String sql = "SELECT court_id, court_number, type, floor_material, lighting, description, image_url, status, area_id, open_time, close_time FROM Courts WHERE area_id = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, areaId); // Set tham số ở đây

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    int courtID = rs.getInt("court_id");
                    String courtNumber = rs.getString("court_number");
                    String type = rs.getString("type");
                    String floorMaterial = rs.getString("floor_material");
                    String lighting = rs.getString("lighting");
                    String description = rs.getString("description");
                    String imageUrl = rs.getString("image_url");
                    String status = rs.getString("status");
                    int areaID = rs.getInt("area_id");

                    Courts court = new Courts(courtID, courtNumber, type, floorMaterial, lighting, description, imageUrl, status, areaID);
                    listCourt.add(court);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return listCourt;
    }
<<<<<<< HEAD
=======

    public static void main(String[] args) {

        CourtDAO ls = new CourtDAO();
        int areaId = 1;
        List<Courts> courts = ls.getCourtsByAreaId(areaId);

        System.out.println("Danh sách các sân:");
        for (Courts court : courts) {
            System.out.println(court);
        }

    }
>>>>>>> 9666cc4c6b177abb4a3002edc56a55bbdeb3db22
}
