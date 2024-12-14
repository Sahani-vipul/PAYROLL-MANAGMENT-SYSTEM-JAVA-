/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package bean;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.mail.*;
import javax.mail.internet.*;
import java.util.Properties;

/**
 *
 * @author SAHANI VIPUL
 */
public class EmployeeDao {

    public static int getTotalEmployee(){
    
        int totalEmployees = 0;
        String qry = "SELECT COUNT(*) AS total FROM employee";

        try {
            // Get connection from UserDao
            Connection conn = UserDao.getConnection();
            PreparedStatement pst = conn.prepareStatement(qry);
            ResultSet rs = pst.executeQuery();

            // Fetch the total count
            if (rs.next()) {
                totalEmployees = rs.getInt("total");
            }

            // Close resources
            rs.close();
            pst.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return totalEmployees-1;
    }
    public static int AddEmplouee(Employee bean) {
        int result = 0;
        Connection conn = null;
        ResultSet rs = null;

        try {
            conn = UserDao.getConnection();

            String sql1 = "INSERT INTO `employee`(`first_name`, `last_name`, `email`, `phone`, `department_id`, `date_of_joining`, `basic_salary`) VALUES (?,?,?,?,?,?,?)";
            System.out.print(sql1);
            PreparedStatement pst = conn.prepareStatement(sql1);
            pst.setString(1, bean.getFirstName());
            pst.setString(2, bean.getLastName());
            pst.setString(3, bean.getEmail());
            pst.setString(4, bean.getPhone());
            pst.setInt(5, bean.getDepartmentId());
            // pst.setDate(6,bean.getDateOfJoining());
            pst.setDate(6, (Date) bean.getDateOfJoining());
            pst.setBigDecimal(7, bean.getBasicSalary());

            result = pst.executeUpdate();

        } catch (Exception e) {
            System.out.println(e);
        }

        return result;
    }

    public static ArrayList<Employee> gelAllEmployee() {

        ArrayList<Employee> employee = new ArrayList<>();

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

//        UserDao obj = new UserDao();
        try {
            conn = UserDao.getConnection();
            String sql = "SELECT e.*, d.department_name, u.role FROM employee e "
                    + "INNER JOIN department d ON e.department_id = d.department_id "
                    + "INNER JOIN users u ON e.employee_id = u.employee_id";
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {

                if (!"Admin".equals(rs.getString("role"))) {
                    Employee e = new Employee();

                    e.setEmployeeId(rs.getInt("employee_id"));
                    e.setFirstName(rs.getString("first_name"));
                    e.setLastName(rs.getString("last_name"));
                    e.setEmail(rs.getString("email"));
                    e.setPhone(rs.getString("phone"));
                    e.setDepartmentId(rs.getInt("department_id"));
                    e.setDepartmentName(rs.getString("department_name"));
                    e.setRole(rs.getString("role"));
                    e.setDateOfJoining(rs.getDate("date_of_joining"));
                    e.setBasicSalary(rs.getBigDecimal("basic_salary"));
                    employee.add(e);
                }
            }
        } catch (Exception e) {
            System.err.println(e);
        }
        return employee;
    }

    public static int deleteEmployee(int id) {

        int status = 0;
        Connection con;
        try {
            con = UserDao.getConnection();
            PreparedStatement pst = con.prepareStatement("delete from employee where employee_id = ?");
            pst.setInt(1, id);
            status = pst.executeUpdate();
        } catch (Exception e) {
            System.out.println("bean.UserDao.delete()");
        }
        return status;
    }

    public static void sendMail(String to) {

        String subject = "Registration Notification";
        String messg = """
                       "Your registration has been successfully completed at our company.\\n"
                       "Please log in using your Username and Password.\\n\\n"
                       "Username: Your Email\\n"
                       "Password: Your Phone Number\\n\\n"
                       "Thank you for joining us!" """;
        final String from = "vipulsahani7600@gmail.com";
        final String pass = "atki zhep gavb tqvq";

        String host = "smtp.gmail.com";

        Properties pros = new Properties();

        pros.put("mail.smtp.auth", "true");
        pros.put("mail.smtp.host", host);
        pros.put("mail.transport.protocol", "smtp");
        pros.put("mail.smtp.starttls.enable", "true");
        pros.put("mail.user", from);
        pros.put("mail.password", pass);
        pros.put("mail.smtp.port", "587");
        pros.put("mail.smtp.ssl.protocols", "TLSv1.2");

        Session mailSesssion = Session.getInstance(pros, new Authenticator() {

            @Override
            protected PasswordAuthentication getPasswordAuthentication() {

                return new PasswordAuthentication(from, pass);
            }
        });

        try {
            MimeMessage message = new MimeMessage(mailSesssion);
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
            message.setSubject(subject);
            message.setText(messg);

            Transport.send(message);

        } catch (Exception e) {
            System.err.println(e);

        }
    }

    public static Employee getEmployeeById(int id) {
        Employee employee = null;
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = UserDao.getConnection();
            String sql = "SELECT e.*, d.department_name, u.role FROM employee e "
                    + "INNER JOIN department d ON e.department_id = d.department_id "
                    + "INNER JOIN users u ON e.employee_id = u.employee_id "
                    + "WHERE e.employee_id = ?";
            ps = conn.prepareStatement(sql);
            ps.setInt(1, id);  // Set the ID parameter

            rs = ps.executeQuery();

            if (rs.next()) {

                employee = new Employee();

                employee.setEmployeeId(rs.getInt("employee_id"));
                employee.setFirstName(rs.getString("first_name"));
                employee.setLastName(rs.getString("last_name"));
                employee.setEmail(rs.getString("email"));
                employee.setPhone(rs.getString("phone"));
                employee.setDepartmentId(rs.getInt("department_id"));
                employee.setDepartmentName(rs.getString("department_name"));
                employee.setRole(rs.getString("role"));
                employee.setDateOfJoining(rs.getDate("date_of_joining"));
                employee.setBasicSalary(rs.getBigDecimal("basic_salary"));

            }
        } catch (Exception e) {
            System.err.println(e);
        }
        return employee;
    }
    
    public static int UpdateEmployee(Employee bean){
    
        int status = 0;
        System.err.println(bean.getBasicSalary());
        Connection conn;
        String qry = "UPDATE `employee` SET `first_name`= ?,`last_name`= ?,`email`= ?,`phone` = ?,`department_id`= ?,`basic_salary` = ? WHERE `employee_id` = ?";
        try{
            conn = UserDao.getConnection();
            PreparedStatement pst = conn.prepareStatement(qry);
            pst.setString(1, bean.getFirstName());
            pst.setString(2, bean.getLastName());
            pst.setString(3, bean.getEmail());
            pst.setString(4, bean.getPhone());
            pst.setInt(5, bean.getDepartmentId());
            pst.setBigDecimal(6, bean.getBasicSalary());
            pst.setInt(7, bean.getEmployeeId());
            
            status = pst.executeUpdate();
        }catch(Exception e){
            System.err.println(e);
        }
        
        return status;
    }

}
