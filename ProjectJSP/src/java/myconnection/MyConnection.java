package myconnection;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

public class MyConnection {
    private Connection connection;

    public PreparedStatement statement(String st) {
        try {
            return connection.prepareStatement(st);
        } catch (Exception e) {
            return null;
        }
    }

    public MyConnection() {
        try {
            // Load the driver
            Class.forName("com.mysql.cj.jdbc.Driver");
            // Connect to the sample database
            connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/user", "user1", "12345678");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

