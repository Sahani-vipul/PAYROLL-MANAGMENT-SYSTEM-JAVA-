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
import javax.persistence.EntityManager;
import javax.persistence.TypedQuery;

public class AttendanceDao {

    public static int markAttendance(Attendance bean) {

        int result = 0;

        String qry = "INSERT INTO `attendance`(`employee_id`, `date`, `status`, `check_in_time`, `check_out_time`) VALUES (?,?,?,?,?)";

        try {
            Connection conn = UserDao.getConnection();
            PreparedStatement pst = conn.prepareStatement(qry);
            pst.setObject(1, bean.getEmployeeId());
            pst.setDate(2, (Date) bean.getDate());
            pst.setString(3, "1");
            pst.setTime(4, (Time) bean.getCheckInTime());
            pst.setTime(5, (Time) bean.getCheckOutTime());

            result = pst.executeUpdate();
        } catch (Exception e) {

            System.err.println(e);
        }
        return result;
    }

    public static boolean isAttendanceMarked(int employeeId, Date date) {
        boolean result = false;
        ResultSet rs = null;

        String sql = "select * from attendance where employee_id = ? and  date = ?";

        try {
            Connection conn = UserDao.getConnection();
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setInt(1, employeeId);
            pst.setDate(2, date);

            rs = pst.executeQuery();

            if (rs.next()) {
                result = true;
            }

        } catch (Exception e) {
        }
        return result;
    }

    public static List<Attendance> getAllAttendance(String filter) {
        List<Attendance> attendanceList = new ArrayList<>();
        String qry = "SELECT e.employee_id, e.first_name, e.last_name, e.email, d.department_name, a.attendance_id , a.date, a.check_in_time, a.check_out_time "
                + "FROM employee e "
                + "JOIN department d ON e.department_id = d.department_id "
                + "JOIN attendance a ON e.employee_id = a.employee_id ";

        // Add filter conditions
        switch (filter) {
            case "yesterday" ->
                qry += "WHERE a.date = CURDATE() - INTERVAL 1 DAY";
            case "lastMonth" ->
                qry += "WHERE MONTH(a.date) = MONTH(CURDATE() - INTERVAL 1 MONTH) "
                        + "AND YEAR(a.date) = YEAR(CURDATE())";
            case "thisMonth" ->
                qry += "WHERE MONTH(a.date) = MONTH(CURDATE()) AND YEAR(a.date) = YEAR(CURDATE())";
            case "all" -> {
            }
            default -> // "today"
                qry += "WHERE a.date = CURDATE()";
        }

        try (Connection conn = UserDao.getConnection(); PreparedStatement pst = conn.prepareStatement(qry); ResultSet rs = pst.executeQuery()) {

            while (rs.next()) {
                Attendance attendance = new Attendance();
                attendance.setEmployeeId(rs.getInt("e.employee_id"));
                attendance.setAttendanceId(rs.getInt("attendance_id"));
                attendance.setFirstName(rs.getString("first_name"));
                attendance.setLastName(rs.getString("last_name"));
                attendance.setEmail(rs.getString("email"));
                attendance.setDepartmentName(rs.getString("department_name"));
                attendance.setDate(rs.getDate("date"));
                attendance.setCheckInTime(rs.getTime("check_in_time"));
                attendance.setCheckOutTime(rs.getTime("check_out_time"));

                attendanceList.add(attendance);
            }

        } catch (Exception e) {
            System.err.println(e);
        }

        return attendanceList;
    }

    public static int deleteAttendance(int id) {

        int result = 0;

        try {
            Connection conn = UserDao.getConnection();
            PreparedStatement pst = conn.prepareStatement("delete from attendance where  attendance_id = ?");
            pst.setInt(1, id);

            result = pst.executeUpdate();
        } catch (Exception e) {
        }
        return result;

    }

    public static Attendance getAttendanceById(int id) {
        Attendance attendance = null;

        try {
            Connection conn = UserDao.getConnection();
            String qry = "SELECT * from attendance WHERE attendance_id = ?";

            PreparedStatement pst = conn.prepareStatement(qry);
            pst.setInt(1, id);

            ResultSet rs = pst.executeQuery();

            if (rs.next()) {
                attendance = new Attendance();
                attendance.setAttendanceId(rs.getInt("attendance_id"));
                attendance.setDate(rs.getDate("date"));
                attendance.setCheckInTime(rs.getTime("check_in_time"));
                attendance.setCheckOutTime(rs.getTime("check_out_time"));
            }

            rs.close();
            pst.close();
            conn.close();
        } catch (Exception e) {
            System.err.println(e);
        }

        return attendance;
    }

    public static int updateAttendance(Attendance bean) {

        int result = 0;

        String qry = "UPDATE `attendance` SET `date`= ?,`check_in_time`= ?,`check_out_time`= ? WHERE `attendance_id`= ?";

        try {
            Connection conn = UserDao.getConnection();
            PreparedStatement pst = conn.prepareStatement(qry);
            pst.setDate(1, (Date) bean.getDate());
            pst.setTime(2, (Time) bean.getCheckInTime());
            pst.setTime(3, (Time) bean.getCheckOutTime());
            pst.setInt(4, bean.getAttendanceId());

            result = pst.executeUpdate();
        } catch (Exception e) {
            System.err.println(e);
        }
        return result;
    }

    public static List<Attendance> getAllAttendanceById(int employeeId) {
        List<Attendance> attendanceList = new ArrayList<>();

        try {
            Connection conn = UserDao.getConnection();
            String qry = "SELECT * FROM attendance WHERE employee_id = ?";

            PreparedStatement pst = conn.prepareStatement(qry);
            pst.setInt(1, employeeId);

            ResultSet rs = pst.executeQuery();

            while (rs.next()) {
                Attendance attendance = new Attendance();
                attendance.setAttendanceId(rs.getInt("attendance_id"));
                attendance.setDate(rs.getDate("date"));
                attendance.setCheckInTime(rs.getTime("check_in_time"));
                attendance.setCheckOutTime(rs.getTime("check_out_time"));
                attendanceList.add(attendance);
            }

            rs.close();
            pst.close();
            conn.close();
        } catch (Exception e) {
            System.err.println("Error while fetching attendance: " + e);
        }

        return attendanceList;
    }
}
