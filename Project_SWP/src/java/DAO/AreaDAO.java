/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Dal.DBContext;
import Model.Areas;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Time;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author admin
 */
public class AreaDAO   extends DBContext {

    Connection conn;

    public AreaDAO() {
        try {
            conn = getConnection();
        } catch (Exception e) {
            System.out.println("Connect failed");
        }
    }

  public void addRegion(Areas re) {
    String sql = "INSERT INTO [dbo].[Areas] " +
                 "([name], [location], [manager_id], [EmptyCourt], [open_time], [close_time]) " +
                 "VALUES (?, ?, ?, ?, ?, ?)";

    try {
        PreparedStatement pre = conn.prepareStatement(sql);
        pre.setString(1, re.getName());
        pre.setString(2, re.getLocation());
        pre.setInt(3, re.getManager_id());
        pre.setInt(4, re.getEmptyCourt());
        pre.setTime(5, re.getOpenTime());
        pre.setTime(6, re.getCloseTime());
        pre.executeUpdate();
    } catch (Exception e) {
        System.out.println(e.getMessage());
    }
}

    
   public void UpdateArea(int id, String name, String location, int emptyCourt, Time openTime, Time closeTime) {
    String sql = "UPDATE Areas SET name = ?, location = ?, EmptyCourt = ?, open_time = ?, close_time = ? WHERE area_id = ?";
    try (PreparedStatement stmt = conn.prepareStatement(sql)) {
        stmt.setString(1, name);
        stmt.setString(2, location);
        stmt.setInt(3, emptyCourt);
        stmt.setTime(4, openTime);
        stmt.setTime(5, closeTime);
        stmt.setInt(6, id);
        stmt.executeUpdate();
    } catch (SQLException e) {
        System.out.println("UpdateArea: " + e.getMessage());
    }
}


    
    public int countAreasByManagerId(int id){
        String sql  ="SELECT count(*) as Total FROM Areas where manager_id = ?";
        try {
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            while(rs.next()){
                return rs.getInt("Total");
            }
        } catch (Exception e) {
            System.out.println("getAllAreas: " + e.getMessage());
        }
        return 0;
    }
  public List<Areas> getAllByManagerID(int id, int pageNum, int pageSize) {
    List<Areas> list = new ArrayList<>();
    String sql = "SELECT * FROM Areas WHERE manager_id = ? ORDER BY area_id OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
    
    try (PreparedStatement stmt = conn.prepareStatement(sql)) {
        
        stmt.setInt(1, id);
        stmt.setInt(2, pageNum);    // OFFSET = (pageNum - 1) * pageSize
        stmt.setInt(3, pageSize);  // Số dòng cần lấy
        ResultSet rs = stmt.executeQuery();
        while (rs.next()) {
            int areasID = rs.getInt("area_id");
            String areaName = rs.getString("name");
            String location = rs.getString("location");
            int managerID = rs.getInt("manager_id");
            int emptyCourt = rs.getInt("EmptyCourt");
            Time openTime = rs.getTime("open_time");
            Time closeTime = rs.getTime("close_time");

            Areas ar = new Areas(areasID, areaName, location, managerID, emptyCourt, openTime, closeTime);
            list.add(ar);
        }

    } catch (SQLException e) {
        System.out.println("getAllByManagerID: " + e.getMessage());
    }

    return list;
}

public void updateEmptyCourtByAreaId(int areaId, int change) {
    try {
       
        String sql = "UPDATE Areas SET EmptyCourt = ISNULL(EmptyCourt, 0) + ? WHERE area_id = ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, change);
        ps.setInt(2, areaId);
        ps.executeUpdate();
        ps.close();
        
    } catch (Exception e) {
        e.printStackTrace();
    }
}
public boolean isRegionNameExist(String name, int managerId) {
    String sql = "SELECT COUNT(*) FROM Areas WHERE name = ? AND manager_id = ?";
    try (
         PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setString(1, name);
        ps.setInt(2, managerId);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            return rs.getInt(1) > 0; 
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return false;
}
 public static void main(String[] args) {
       
        AreaDAO areaDAO = new AreaDAO();
       
        Areas newArea = new Areas(
            0,                   
            "Khu Vực Mới",      
            "Hà Nội",            
            1,              
            5,               
            Time.valueOf("08:00:00"),  
            Time.valueOf("22:00:00")   
        );
        
        // Gọi phương thức addRegion để thêm mới
        areaDAO.addRegion(newArea);
        
         System.out.println("Đã thêm khu vực mới thành công!");
        List<Areas> a = areaDAO.getAllByManagerID(1, 1, 5);
        for(Areas list : a){
            System.out.println(list);
        }
       
    }
}
    
 
