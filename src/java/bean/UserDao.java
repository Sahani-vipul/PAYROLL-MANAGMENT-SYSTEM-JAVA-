/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package bean;

/**
 *
 * @author SAHANI VIPUL
 */
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import javax.mail.Session;
import javax.servlet.http.HttpSession;
//import javax.servlet.http.HttpServletRequest ;

public class UserDao {

    // Method to connect to MySQL database
    public static Connection getConnection() throws Exception {

        Connection conn;
        String url = "jdbc:mysql://localhost:3306/payroll";
        String username = "root";  // Update with your DB username
        String password = "";      // Update with your DB password
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, username, password);

        return conn;
    }

    // Method to validate the user login
    public static int validate(Users user) {
        int isValid = 0;

        try {
            Connection connection = getConnection();
            String sql = "SELECT * FROM users WHERE email = ? AND password = ?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, user.getEmail());
            statement.setString(2, user.getPassword());

            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {

                if (null != resultSet.getString("role"))//
                switch (resultSet.getString("role")) {
                    case "Admin" -> isValid = 1;
                    case "HR" -> isValid = 2;
                    case "Employee" -> isValid = 3;
                    default -> {
                    }
                }
            } // Returns true if a match is found
        } catch (Exception e) {
            System.out.print(e);
        }
        return isValid;
    }

    public static int register(Users bean) {
        int result = 0;
        Connection conn = null;
        ResultSet rs = null;
        try {
            conn = getConnection();
            String sql = "SELECT * FROM employee where email = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, bean.getEmail());
            rs = ps.executeQuery();

            if (rs.next()) {
                // If an email exists, it means the user is already registered
                String dbEmail = rs.getString("email");

                if (dbEmail.equals(bean.getEmail())) {

                    String sql1 = "INSERT INTO `users`(`username`, `password`, `email`, `role`, `employee_id`) VALUES (?,?,?,?,?)";
                    PreparedStatement pst = conn.prepareStatement(sql1);
                    pst.setString(1, bean.getUsername());
                    pst.setString(2, bean.getPassword());
                    pst.setString(3, bean.getEmail());
                    pst.setString(4, bean.getRole());
                    pst.setInt(5, rs.getInt("employee_id"));

                    result = pst.executeUpdate();
                }
            }
        } catch (Exception e) {
            System.out.println(e);
        }

        return result;
    }

    public static int deleteUser(int id) {

        int status = 0;
        Connection con;
        try {
            con = getConnection();
            PreparedStatement pst = con.prepareStatement("delete from users where employee_id = ?");
            pst.setInt(1, id);
            status = pst.executeUpdate();
        } catch (Exception e) {
            System.out.println("bean.UserDao.delete()");
        }
        return status;
    }

    public static int UpdateUser(Users bean) {

        int status = 0;
        String qry = "UPDATE `users` SET `username`= ?,`password`= ?,`email`= ?,`role`= ? WHERE `employee_id`= ?";

        try {
            Connection conn = getConnection();
            PreparedStatement pst = conn.prepareStatement(qry);
            pst.setString(1, bean.getUsername());
            pst.setString(2, bean.getPassword());
            pst.setString(3, bean.getEmail());
            pst.setString(4, bean.getRole());
            pst.setInt(5, bean.getEmployeeId());

            status = pst.executeUpdate();
        } catch (Exception e) {
            System.err.println(e);
        }
        return status;
    }

    public static Users getUserById(int id) {
        Users user = null;

        String qry = "SELECT * FROM `users` WHERE employee_id = ?";
        try (Connection conn = getConnection(); PreparedStatement pst = conn.prepareStatement(qry)) {

            pst.setInt(1, id);
            try (ResultSet rs = pst.executeQuery()) {
                if (rs.next()) { // Use if instead of while
                    user = new Users();
                    user.setUserId(rs.getInt("user_id"));
                    user.setUsername(rs.getString("username"));
                    user.setPassword(rs.getString("password"));
                    user.setEmail(rs.getString("email"));
                    user.setRole(rs.getString("role"));
                }
            }
        } catch (Exception e) {
            System.err.println("Error in getUserById: " + e);
        }

        return user; // Will return null if no user found
    }

    public static int getEmployeeIdByEmail(String email) {
        int employeeId = -1; // Default to -1 to indicate not found
        String query = "SELECT employee_id FROM users WHERE email = ?";

        try (Connection conn = getConnection(); PreparedStatement pst = conn.prepareStatement(query)) {

            pst.setString(1, email);
            try (ResultSet rs = pst.executeQuery()) {
                if (rs.next()) {
                    employeeId = rs.getInt("employee_id");
                }
            }
        } catch (Exception e) {
            System.err.println("Error in getEmployeeIdByEmail: " + e);
        }

        return employeeId; // Returns the employee ID or -1 if not found
    }

}
