/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package bean;

//import com.mysql.cj.protocol.Resultset;
//import com.sun.jdi.connect.spi.Connection;
/**
 *
 * @author SAHANI VIPUL
 */
//import java.sql.*;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class LeaveDao {

    public static int addLeaveType(LeaveType bean) {

        int result = 0;
        Connection conn = null;
        ResultSet rs = null;
        try {

            conn = UserDao.getConnection();
            String sql = "INSERT INTO `leave_type`(`leave_type`, `leave_days`) VALUES (?,?)";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setString(1, bean.getLeaveType());
            pst.setInt(2, bean.getLeaveDays());

            result = pst.executeUpdate();

        } catch (Exception e) {
            System.err.println(e);
        }

        return result;
    }

    public static ArrayList<LeaveType> getAllLeaves() throws Exception {
        ArrayList<LeaveType> leavetype = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = UserDao.getConnection();
            String sql = "SELECT * FROM leave_type";
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                LeaveType l = new LeaveType();
                l.setLeaveTypeId(rs.getInt("leave_type_id"));
                l.setLeaveType(rs.getString("leave_type"));
                l.setLeaveDays(rs.getInt("leave_days"));
                leavetype.add(l);

            }
        } catch (SQLException e) {
            System.out.println(e);
        }

        return leavetype;
    }

    public static int DeleteLeaveType(int id) {

        int status = 0;
        Connection conn;
        try {

            conn = UserDao.getConnection();
            PreparedStatement pst = conn.prepareStatement("delete from leave_type where leave_type_id = ?");
            pst.setInt(1, id);
            status = pst.executeUpdate();
        } catch (Exception e) {
            System.err.println(e);
        }

        return status;
    }

    public static ArrayList<LeaveType> getLeaveTypeById(int id) throws Exception {
        ArrayList<LeaveType> leavetype = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = UserDao.getConnection();
            String sql = "SELECT * FROM leave_type where leave_type_id = ?";
            ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            rs = ps.executeQuery();

            while (rs.next()) {
                LeaveType l = new LeaveType();
                l.setLeaveTypeId(rs.getInt("leave_type_id"));
                l.setLeaveType(rs.getString("leave_type"));
                l.setLeaveDays(rs.getInt("leave_days"));
                leavetype.add(l);

            }
        } catch (SQLException e) {
            System.out.println(e);
        }

        return leavetype;
    }

    public static int UpdateLeaveType(LeaveType bean) {

        int status = 0;
        Connection conn;

        try {

            conn = UserDao.getConnection();
            String qry = "update leave_type set leave_type = ? , leave_days = ? where leave_Type_id = ?";
            PreparedStatement pst = conn.prepareStatement(qry);
            pst.setString(1, bean.getLeaveType());
            pst.setInt(2, bean.getLeaveDays());
            pst.setInt(3, bean.getLeaveTypeId());

            status = pst.executeUpdate();
        } catch (Exception e) {
            System.err.println(e);
        }
        return status;
    }

    public static List<Leave> getAllLeave() {
        List<Leave> leaveList = new ArrayList<>();
        String qry = """
                 SELECT 
                     l.leave_id,
                     e.first_name,
                     e.employee_id,
                     e.last_name,
                     d.department_name
                 FROM 
                     employee e
                 JOIN 
                     department d ON e.department_id = d.department_id
                 JOIN 
                     `leave` l ON e.employee_id = l.employee_id
                 WHERE 
                     status = 'Pending'
                 """;

        System.out.println("Executing query: " + qry); // Debug line

        try {
            Connection conn = UserDao.getConnection();
            PreparedStatement pst = conn.prepareStatement(qry);
            ResultSet rs = pst.executeQuery();

            if (!rs.isBeforeFirst()) {  // Check if ResultSet is empty
                System.out.println("No results found.");
            } else {
                System.out.println("Results found.");
            }

            while (rs.next()) {
                Leave leave = new Leave();
                leave.setLeaveId(rs.getInt("leave_id"));
                leave.setEmployeeId(rs.getInt("employee_id"));
                leave.setFirstName(rs.getString("first_name"));
                leave.setLastName(rs.getString("last_name"));
                leave.setDepartmentName(rs.getString("department_name"));
                leaveList.add(leave);
            }
        } catch (Exception e) {
            System.err.println(e);
        }

        return leaveList;
    }

    public static Leave getLeaveDetail(int id) {
        Leave leave = null;
        String qry = """
                 SELECT 
                     l.leave_id,
                     lt.leave_type AS leave_type,
                     DATEDIFF(l.end_date, l.start_date) AS day,
                     l.start_date, 
                     l.end_date, 
                     l.status 
                 FROM 
                     `leave` l
                 JOIN 
                     leave_type lt ON lt.leave_type_id = l.leave_type_id
                 WHERE 
                     l.leave_id = ?""";

        try {
            Connection conn = UserDao.getConnection();
            PreparedStatement pst = conn.prepareStatement(qry);
            pst.setInt(1, id);  // Set the leave ID in the query
            ResultSet rs = pst.executeQuery();

            if (rs.next()) {
                leave = new Leave();
                leave.setLeaveId(rs.getInt("leave_id"));
                leave.setLeaveType(rs.getString("leave_type"));  // Correct field name
                leave.setStartDate(rs.getDate("start_date"));
                leave.setEndDate(rs.getDate("end_date"));
                leave.setStatus(rs.getString("status"));
                leave.setTotalDays(rs.getInt("day"));
            }

            rs.close();
            pst.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return leave;
    }

    public static int leaveUpdate(Leave bean) {

        int result = 0;

        String qry = "UPDATE `leave` SET `status` = ? WHERE `leave_id` = ?  ";
        try {
            Connection conn = UserDao.getConnection();
            PreparedStatement pst = conn.prepareStatement(qry);
            pst.setString(1, bean.getStatus());
            pst.setInt(2, bean.getLeaveId());

            result = pst.executeUpdate();
        } catch (Exception e) {
            System.err.println(e);
        }
        return result;
    }

    public static int getTotalLeave() {

        int totalleave = 0;
        String qry = "SELECT COUNT(*) AS total FROM `leave` where status = 'Pending' ";

        try {
            // Get connection from UserDao
            Connection conn = UserDao.getConnection();
            PreparedStatement pst = conn.prepareStatement(qry);
            ResultSet rs = pst.executeQuery();

            // Fetch the total count
            if (rs.next()) {
                totalleave = rs.getInt("total");
            }

            // Close resources
            rs.close();
            pst.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return totalleave;
    }

  public static List<Leave> getLeaveSummaryByEmployeeId(int employeeId) {
    List<Leave> leaveSummaryList = new ArrayList<>();

    String qry = """
        SELECT lt.leave_type_id AS leaveTypeId,
               lt.leave_type AS leaveType, 
               lt.leave_days AS totalDays, 
               SUM(DATEDIFF(l.end_date, l.start_date) + 1) AS takenLeaves
        FROM leave_type lt
        LEFT JOIN `leave` l ON lt.leave_type_id = l.leave_type_id 
                             AND l.employee_id = ? 
                             AND l.status != 'Reject'  -- Exclude rejected leaves
        GROUP BY lt.leave_type_id, lt.leave_type, lt.leave_days
    """;

    try (Connection conn = UserDao.getConnection(); PreparedStatement pst = conn.prepareStatement(qry)) {

        pst.setInt(1, employeeId);
        ResultSet rs = pst.executeQuery();

        while (rs.next()) {
            Leave leaveSummary = new Leave();

            leaveSummary.setLeaveTypeId(rs.getInt("leaveTypeId")); // Assign LeaveType object to Leave
            leaveSummary.setLeaveType(rs.getString("leaveType"));
            leaveSummary.setTotalDays(rs.getInt("totalDays"));
            leaveSummary.setTakenLeaves(rs.getInt("takenLeaves"));
            leaveSummaryList.add(leaveSummary);
        }

        rs.close();
    } catch (Exception e) {
        System.err.println("Error while fetching leave summary: " + e);
    }

    return leaveSummaryList;
}


    public static List<Leave> getEmployeeLeaveDetails(int employeeId, int leaveTypeId) {
        List<Leave> leaveList = new ArrayList<>();
        String qry = """
         SELECT 
             l.leave_id,
             lt.leave_type AS leave_type,
             DATEDIFF(l.end_date, l.start_date) + 1 AS total_days,  -- Include the last day
             l.start_date, 
             l.end_date, 
             l.status 
         FROM 
             `leave` l
         JOIN 
             leave_type lt ON lt.leave_type_id = l.leave_type_id
         WHERE 
             l.employee_id = ? AND l.leave_type_id = ?
    """;

        try {
            Connection conn = UserDao.getConnection();
            PreparedStatement pst = conn.prepareStatement(qry);
            pst.setInt(1, employeeId);   // Set the employee ID
            pst.setInt(2, leaveTypeId); // Set the leave type ID
            ResultSet rs = pst.executeQuery();

            while (rs.next()) {
                Leave leave = new Leave();
//            leave.setLeaveId(rs.getInt("leave_id"));
                leave.setLeaveType(rs.getString("leave_type"));
                leave.setStartDate(rs.getDate("start_date"));
                leave.setEndDate(rs.getDate("end_date"));
                leave.setStatus(rs.getString("status"));
                leave.setTotalDays(rs.getInt("total_days")); // Include total days
                leaveList.add(leave);
            }

            rs.close();
            pst.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return leaveList;
    }

    public static int applyLeave(Leave bean){
    
        int result = 0;
        
        try {
            Connection conn = UserDao.getConnection();
            String qry = "INSERT INTO `leave`(`employee_id`, `leave_type_id`, `start_date`, `end_date`, `status`) VALUES (?,?,?,?,?)";
            PreparedStatement pst = conn.prepareCall(qry);
            
            pst.setInt(1,bean.getEmployeeId());
            pst.setInt(2, bean.getLeaveTypeId());
            pst.setDate(3, (Date) bean.getStartDate());
            pst.setDate(4, (Date) bean.getEndDate());
            pst.setString(5, bean.getStatus());
            
            result = pst.executeUpdate();
        } catch (Exception e) {
            System.err.println(e);
        }
        return result;
    }
}
