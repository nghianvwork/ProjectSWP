/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Dal.DBContext;
import Model.Areas;
import java.sql.Connection;
import java.sql.PreparedStatement;

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
    public static void main(String[] args) {
       AreaDAO areaDAO = new AreaDAO();

    
    Areas newArea = new Areas();
    newArea.setName("Khu thể thao B ");
    newArea.setLocation("Hà Nội");
    newArea.setManager_id("001");
    newArea.setEmptyCourt(5);

    
    areaDAO.addRegion(newArea);
    
    System.out.println("Đã thêm khu vực thành công!");
    }
}
