/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Dal.DBContext;
import Model.Branch_Equipments;
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
public class Service_BranchDAO extends DBContext{
    Connection conn;

    public Service_BranchDAO() {
        try {
            conn = getConnection();
        } catch (Exception e) {
            System.out.println("Connect failed");
        }
    }
     public  void addServiceToArea(int areaId, int serviceId) throws Exception {
        String sql = "INSERT INTO Areas_Services (area_id, services_id) VALUES (?, ?)";
        try (
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, areaId);
            ps.setInt(2, serviceId);
            ps.executeUpdate();
        }
    }
    public List<Branch_Equipments> getAllAreaServices(int areaID) {
        List<Branch_Equipments> areaServices = new ArrayList<>();
        String query = "SELECT AreaEquipment_id, equipment_id, area_id FROM Areas_Services  where area_id = ?";

        try (PreparedStatement preparedStatement = conn.prepareStatement(query)) {
            preparedStatement.setInt(1, areaID);
            ResultSet resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                Branch_Equipments areaService = new Branch_Equipments();
                areaService.setAreaEquipment_id(resultSet.getInt("AreaEquipment_id"));
                areaService.setEquipment_id(resultSet.getInt("equipment_id"));
                areaService.setArea_id(resultSet.getInt("area_id"));
                areaServices.add(areaService);
            }
        } catch (SQLException e) {
            System.out.println("getAllRoomServices: " + e.getMessage());
        }
        return areaServices;
    }
}
