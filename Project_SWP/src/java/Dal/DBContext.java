/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Dal;

import java.sql.Connection;
import java.sql.DriverManager;

/**
 *
 * @author admin
 */
public class DBContext {
    
     public Connection getConnection()throws Exception {
        String url = "jdbc:sqlserver://"+serverName+":"+portNumber + "\\" + instance +";databaseName="+dbName+";encrypt=true;trustServerCertificate=true";
        if(instance == null || instance.trim().isEmpty())
            url = "jdbc:sqlserver://"+serverName+":"+portNumber +";databaseName="+dbName+";encrypt=true;trustServerCertificate=true";
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        return DriverManager.getConnection(url, userID, password);
    }   
   
  
    private final String serverName = "localhost";
    private final String dbName = "SWP";
    private final String portNumber = "1433";
    private final String instance="";
    private final String userID = "sa";
    private final String password = "123";    
    public static void main(String[] args) throws Exception {
        DBContext db = new DBContext();
        System.out.println(db.getConnection() );
    }
}
