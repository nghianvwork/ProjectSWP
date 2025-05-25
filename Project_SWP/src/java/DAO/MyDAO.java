/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 *
 * @author Hoang Tan Bao
 */
public class MyDAO extends DBContext{
     public Connection con = null;
  public PreparedStatement ps = null;
  public ResultSet rs = null;
  public String sql = null;

  public MyDAO() {
     con = connection;
  }
  public void finalize() {
     try {
        if(con != null) con.close();
     }
     catch(Exception e) {
        e.printStackTrace();
     }
  }
}
