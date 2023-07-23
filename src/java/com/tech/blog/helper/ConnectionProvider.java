package com.tech.blog.helper;

import java.sql.*;

public class ConnectionProvider {

    private static Connection con;

    public static Connection getConnection() {

        try {
            if (con == null) {
                // Load Driver
                Class.forName("com.mysql.cj.jdbc.Driver");
                // Class.forName("com.mysql.jdbc.Driver"); // deprecated

                // Create connection
                String url = "jdbc:mysql://localhost:3306/techblog";
                String username = "root";
                String password = "Vikram@123";

                con = DriverManager.getConnection(url, username, password);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return con;
    }

}
