package DAO;

import Model.Equipments;
import java.sql.*;
import java.util.*;

public class EquipmentsDAO {

    static final String JDBC_URL = "jdbc:sqlserver://localhost:1433;databaseName=SWP1;encrypt=true;trustServerCertificate=true";
    static final String JDBC_USER = "bin";
    static final String JDBC_PASS = "1";

    public static List<Equipments> getAllEquipments() {
        List<Equipments> list = new ArrayList<>();
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            Connection con = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASS);
            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery("SELECT * FROM Equipments");

            while (rs.next()) {
                list.add(new Equipments(
                        rs.getInt("equipment_id"),
                        rs.getString("name"),
                        rs.getDouble("price"),
                        rs.getString("quantity") // quantity là String
                ));
            }
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public static void addService(Equipments s) throws SQLException {
        try {
            if (isDuplicateService(s.getName())) {
                throw new SQLException("Duplicate service name");
            }

            int nextId = getNextEquipmentId();

            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            Connection con = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASS);
            PreparedStatement ps = con.prepareStatement("INSERT INTO Equipments(equipment_id, name, price, quantity) VALUES (?, ?, ?, ?)");
            ps.setInt(1, nextId);
            ps.setString(2, s.getName());
            ps.setDouble(3, s.getPrice());
            ps.setString(4, s.getQuantity()); // quantity là String
            ps.executeUpdate();
            con.close();
        } catch (SQLException e) {
            throw e;
        } catch (Exception e) {
            e.printStackTrace();
            throw new SQLException("Unknown error", e);
        }
    }

    public static int getNextEquipmentId() {
        int nextId = 1;
        try (Connection conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASS);
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery("SELECT ISNULL(MAX(equipment_id), 0) + 1 FROM Equipments")) {
            if (rs.next()) {
                nextId = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return nextId;
    }

    public static boolean isDuplicateService(String name) {
        boolean isDuplicate = false;
        try (Connection conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASS);
             PreparedStatement ps = conn.prepareStatement("SELECT COUNT(*) FROM Equipments WHERE LTRIM(RTRIM(name)) = ?")) {
            ps.setString(1, name.trim());
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                isDuplicate = rs.getInt(1) > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return isDuplicate;
    }
}
