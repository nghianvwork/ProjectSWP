/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Dal.DBContext;
import Model.Promotion;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/**
 *
 * @author admin
 */
public class PromotionDAO extends DBContext{
    Connection conn;

    public PromotionDAO() {
        try {
            conn = getConnection();
        } catch (Exception e) {
            System.out.println("Connect failed");
        }
    }
    public List<Promotion> getValidPromotionsForArea(int areaId, LocalDateTime bookingTime) throws SQLException {
        List<Promotion> result = new ArrayList<>();
        String sql = "SELECT p.* FROM Promotions p "
                + "JOIN Promotion_Area pa ON p.promotion_id = pa.promotion_id "
                + "WHERE pa.area_id = ? AND p.status = 'active' "
                + "AND ? BETWEEN p.start_date AND p.end_date";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, areaId);
            stmt.setTimestamp(2, Timestamp.valueOf(bookingTime));
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Promotion promo = new Promotion();
                promo.setPromotionId(rs.getInt("promotion_id"));
                promo.setTitle(rs.getString("title"));
                promo.setDescription(rs.getString("description"));
                promo.setDiscountPercent(rs.getDouble("discount_percent"));
                promo.setDiscountAmount(rs.getDouble("discount_amount"));
                promo.setStartDate(rs.getTimestamp("start_date").toLocalDateTime());
                promo.setEndDate(rs.getTimestamp("end_date").toLocalDateTime());
                promo.setStatus(rs.getString("status"));
                promo.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
                Timestamp updated = rs.getTimestamp("updated_at");
                if (updated != null) promo.setUpdatedAt(updated.toLocalDateTime());
                result.add(promo);
            }
        }
        return result;
    }
   public double applyBestPromotion(double price, int areaId, LocalDateTime bookingTime) throws SQLException {
    PromotionDAO promoDAO = new PromotionDAO();
    List<Promotion> promos = promoDAO.getValidPromotionsForArea(areaId, bookingTime);

    double minPrice = price;
    for (Promotion promo : promos) {
        double priceAfter = price;
        if (promo.getDiscountPercent() > 0) {
            priceAfter -= price * promo.getDiscountPercent() / 100.0;
        }
        if (promo.getDiscountAmount() > 0) {
            priceAfter -= promo.getDiscountAmount();
        }
        if (priceAfter < 0) priceAfter = 0;
        if (priceAfter < minPrice) minPrice = priceAfter;
    }
    return minPrice;
}
   public List<Promotion> getAllPromotions()  {
        List<Promotion> list = new ArrayList<>();
        String sql = "SELECT * FROM Promotions";
        try (Statement stmt = conn.createStatement()) {
            ResultSet rs = stmt.executeQuery(sql);
            while (rs.next()) {
                Promotion p = extract(rs);
                list.add(p);
            }
        }catch(SQLException e){
            System.out.println(e.getMessage());
        }
        return list;
    }
public int insertPromotion(Promotion p) throws SQLException {
        String sql = "INSERT INTO Promotions (title, description, discount_percent, discount_amount, start_date, end_date, status, created_at) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setString(1, p.getTitle());
            stmt.setString(2, p.getDescription());
            stmt.setDouble(3, p.getDiscountPercent());
            stmt.setDouble(4, p.getDiscountAmount());
            stmt.setTimestamp(5, Timestamp.valueOf(p.getStartDate()));
            stmt.setTimestamp(6, Timestamp.valueOf(p.getEndDate()));
            stmt.setString(7, p.getStatus());
            stmt.setTimestamp(8, Timestamp.valueOf(LocalDateTime.now()));
            stmt.executeUpdate();
            ResultSet rs = stmt.getGeneratedKeys();
            if (rs.next()) return rs.getInt(1);
        }
        return 0;
    }

   
    public boolean updatePromotion(Promotion p) throws SQLException {
        String sql = "UPDATE Promotions SET title=?, description=?, discount_percent=?, discount_amount=?, start_date=?, end_date=?, status=?, updated_at=? WHERE promotion_id=?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, p.getTitle());
            stmt.setString(2, p.getDescription());
            stmt.setDouble(3, p.getDiscountPercent());
            stmt.setDouble(4, p.getDiscountAmount());
            stmt.setTimestamp(5, Timestamp.valueOf(p.getStartDate()));
            stmt.setTimestamp(6, Timestamp.valueOf(p.getEndDate()));
            stmt.setString(7, p.getStatus());
            stmt.setTimestamp(8, Timestamp.valueOf(LocalDateTime.now()));
            stmt.setInt(9, p.getPromotionId());
            return stmt.executeUpdate() > 0;
        }
    }

    
    public boolean deletePromotion(int id) throws SQLException {
        String sql = "DELETE FROM Promotions WHERE promotion_id=?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
        }
    }

  
    public void insertPromotionArea(int promotionId, int areaId) throws SQLException {
        String sql = "INSERT INTO Promotion_Area(promotion_id, area_id) VALUES (?, ?)";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, promotionId);
            stmt.setInt(2, areaId);
            stmt.executeUpdate();
        }
    }

    
    public void insertPromotionService(int promotionId, int serviceId) throws SQLException {
        String sql = "INSERT INTO Promotion_Service(promotion_id, serviceId) VALUES (?, ?)";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, promotionId);
            stmt.setInt(2, serviceId);
            stmt.executeUpdate();
        }
    }

    
    private Promotion extract(ResultSet rs) throws SQLException {
        Promotion p = new Promotion();
        p.setPromotionId(rs.getInt("promotion_id"));
        p.setTitle(rs.getString("title"));
        p.setDescription(rs.getString("description"));
        p.setDiscountPercent(rs.getDouble("discount_percent"));
        p.setDiscountAmount(rs.getDouble("discount_amount"));
        p.setStartDate(rs.getTimestamp("start_date").toLocalDateTime());
        p.setEndDate(rs.getTimestamp("end_date").toLocalDateTime());
        p.setStatus(rs.getString("status"));
        p.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
        Timestamp updated = rs.getTimestamp("updated_at");
        if (updated != null) p.setUpdatedAt(updated.toLocalDateTime());
        return p;
    }
    public List<Promotion> getPromotionsByPage(int offset, int limit) {
    List<Promotion> list = new ArrayList<>();
    String sql = "SELECT * FROM Promotions ORDER BY promotion_id DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
    try (PreparedStatement stmt = conn.prepareStatement(sql)) {
        stmt.setInt(1, offset);
        stmt.setInt(2, limit);
        ResultSet rs = stmt.executeQuery();
        while (rs.next()) {
            Promotion p = extract(rs);
            list.add(p);
        }
    } catch(SQLException e){
        System.out.println(e.getMessage());
    }
    return list;
}

// Đếm tổng số Promotion để tính số trang
public int getTotalPromotionCount() {
    String sql = "SELECT COUNT(*) FROM Promotions";
    try (Statement stmt = conn.createStatement()) {
        ResultSet rs = stmt.executeQuery(sql);
        if (rs.next()) return rs.getInt(1);
    } catch(SQLException e){
        System.out.println(e.getMessage());
    }
    return 0;
}
// Thêm vào PromotionDAO
public List<String> getAreaNamesByPromotionId(int promotionId) {
    List<String> areaNames = new ArrayList<>();
    String sql = "SELECT a.name FROM Promotion_Area pa JOIN Areas a ON pa.area_id = a.area_id WHERE pa.promotion_id = ?";
    try (PreparedStatement stmt = conn.prepareStatement(sql)) {
        stmt.setInt(1, promotionId);
        ResultSet rs = stmt.executeQuery();
        while (rs.next()) {
            areaNames.add(rs.getString("name"));
        }
    } catch(SQLException e){
        System.out.println(e.getMessage());
    }
    return areaNames;
}

}
