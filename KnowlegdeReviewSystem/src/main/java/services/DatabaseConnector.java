package services;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseConnector {
    private static final String url = "jdbc:mysql://localhost:3306/KRSDB";
    private static final String username = "root";
    private static final String password = "1234";

    public static Connection getConnection() {
        Connection connection = null;

        try {
            // Register the MySQL JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Establish the connection
            connection = DriverManager.getConnection(url, username, password);

            System.out.println("Connected to the database successfully!");
        } catch (ClassNotFoundException e) {
            System.err.println("JDBC Driver not found: " + e.getMessage());
        } catch (SQLException e) {
            System.err.println("Error connecting to the database: " + e.getMessage());
        }

        return connection;
    }

}
