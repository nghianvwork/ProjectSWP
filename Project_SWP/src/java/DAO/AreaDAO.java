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
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author admin
 */
public class AreaDAO extends DBContext {

    Connection conn;

    public AreaDAO() {
        try {
            conn = getConnection();
        } catch (Exception e) {
            System.out.println("Connect failed");
        }
    }

    public void addRegion(Areas re) {
        String sql = "INSERT INTO [dbo].[Areas]\n"
                + "           ([name]\n"
                + "           ,[location]\n"
                + "           ,[manager_id]\n"
                + "           ,[EmptyCourt])\n"
                + "     VALUES\n"
                + "           (?,?,?,?)";
        
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setString(1, re.getName());
            pre.setString(2, re.getLocation());
            pre.setString(3, re.getManager_id());
            pre.setInt(4, re.getEmptyCourt());
            pre.executeUpdate();
        } catch (Exception e) {
             System.out.println(e.getMessage());
        }
    }
    public int countAreasByManagerId(String id){
        String sql  ="SELECT count(*) as Total FROM Areas where manager_id = ?";
        try {
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, id);
            ResultSet rs = stmt.executeQuery();
            while(rs.next()){
                return rs.getInt("Toltal");
            }
        } catch (Exception e) {
            System.out.println("getAllAreas: " + e.getMessage());
        }
        return 0;
    }
   public List<Areas> getAllByManagerID(String id, int pageNum, int pageSize) {
    List<Areas> list = new ArrayList<>();
    String sql = "SELECT * FROM Areas WHERE manager_id = ? ORDER BY area_id OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

    try {
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString(1, id);
        stmt.setInt(2, pageNum * pageSize); // OFFSET = số dòng cần bỏ qua
        stmt.setInt(3, pageSize); // Số dòng cần lấy
        ResultSet rs = stmt.executeQuery();

        while (rs.next()) {
            String areasID = rs.getString("area_id");
            String areaName = rs.getString("name");
            String location = rs.getString("location");
            String managerID = rs.getString("manager_id");
            int emptyCourt = rs.getInt("EmptyCourt");

            Areas ar = new Areas(areasID, areaName, location, managerID, emptyCourt);
            list.add(ar);
        }

    } catch (SQLException e) {
        System.out.println("getAllByManagerID: " + e.getMessage());
    }

    return list;
}

    
    public static void main(String[] args) {
       AreaDAO areaDAO = new AreaDAO();

    
    Areas newArea = new Areas();
    newArea.setName("Khu thể thao B ");
    newArea.setLocation("Hà Nội");
    newArea.setManager_id("001");
    newArea.setEmptyCourt(5);

    
    areaDAO.addRegion(newArea);
    
    System.out.println("Đã thêm khu vực thành công!");
     String managerId = "2";
    int pageNum = 0; // OFFSET sẽ là 0
    int pageSize = 5;

    List<Areas> areas = areaDAO.getAllByManagerID(managerId, pageNum, pageSize);

    if (areas.isEmpty()) {
        System.out.println("Không có khu vực nào được tìm thấy cho manager_id: " + managerId);
    } else {
        for (Areas area : areas) {
            System.out.println("ID: " + area.getArea_id());
            System.out.println("Tên khu: " + area.getName());
            System.out.println("Địa chỉ: " + area.getLocation());
            System.out.println("Quản lý: " + area.getManager_id());
            System.out.println("Sân trống: " + area.getEmptyCourt());
            System.out.println("---------------");
        }
    }
    }
}
