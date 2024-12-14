/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package bean;

/**
 *
 * @author SAHANI VIPUL
 */
import static java.lang.System.out;
import java.util.Calendar;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class SalaryDao {

    public static int getTotalWorkingDays(Date date) {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(date);

        int year = calendar.get(Calendar.YEAR);
        int month = calendar.get(Calendar.MONTH);
        int daysInMonth = calendar.getActualMaximum(Calendar.DAY_OF_MONTH);

        int workingDays = 0;
        for (int day = 1; day <= daysInMonth; day++) {
            calendar.set(year, month, day);
            int dayOfWeek = calendar.get(Calendar.DAY_OF_WEEK);
            // Count only weekdays as working days (excluding Saturday and Sunday)
            if (dayOfWeek != Calendar.SATURDAY && dayOfWeek != Calendar.SUNDAY) {
                workingDays++;
            }
        }
        return workingDays;
    }

    public static int getDaysWorked(int empId, Date date) {
        int daysWorked = 0;
        // Get month and year from the given date
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(date);
        int month = calendar.get(Calendar.MONTH) + 1; // Months are 0-based in Calendar
        int year = calendar.get(Calendar.YEAR);

        // SQL query to count the number of 'Present' days for the specific employee in the given month and year
        String query = """
                SELECT COUNT(*) AS days_worked 
                FROM attendance 
                WHERE employee_id = ? 
                  AND MONTH(check_in_time) = ? 
                  AND YEAR(check_in_time) = ?
                """;

        try {
            Connection conn = UserDao.getConnection();
            PreparedStatement pst = conn.prepareStatement(query);

            pst.setInt(1, empId);      // Employee ID
            pst.setInt(2, month);      // Month
            pst.setInt(3, year);       // Year

            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                daysWorked = rs.getInt("days_worked");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return daysWorked;
    }

    public static int getPaidLeaveDays(int empId, Date date) {
        int paidLeaveDays = 0;

        // Extract year and month from the provided date
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(date);
        int year = calendar.get(Calendar.YEAR);
        int month = calendar.get(Calendar.MONTH) + 1; // Months are 0-based in Calendar

        String qry = """
        SELECT COUNT(*) AS paid_leave_days 
        FROM `leave` l
        WHERE l.employee_id = ?
          AND l.status = 'Approve'
          AND YEAR(l.start_date) = ?
          AND MONTH(l.start_date) = ?
    """;

        try (Connection conn = UserDao.getConnection(); PreparedStatement pst = conn.prepareStatement(qry)) {

            // Set query parameters
            pst.setInt(1, empId);
            pst.setInt(2, year);
            pst.setInt(3, month);

            // Execute the query
            try (ResultSet rs = pst.executeQuery()) {
                if (rs.next()) {
                    paidLeaveDays = rs.getInt("paid_leave_days");
                }
            }
        } catch (Exception e) {
            e.printStackTrace(); // Log the exception (can be improved using a logger)
        }

        return paidLeaveDays;
    }

    public static int paySalary(int empId, Date date, double basicSalary, double totalAllowances, double totalDeductions) {
        int result = 0;
        double finalSalary = 0.0;
        int totalWorkingDays = getTotalWorkingDays(date);
        int daysWorked = getDaysWorked(empId, date);
        int paidLeaveDays = getPaidLeaveDays(empId, date);

        // Total effective days worked including paid leaves
        int totalEffectiveDays = daysWorked + paidLeaveDays;

        // Calculate day-wise salary and total basic salary for effective days
        double dayWiseSalary = basicSalary / totalWorkingDays;
        double totalBasicSalary = dayWiseSalary * totalEffectiveDays;

        // Calculate final net salary
        finalSalary = (totalBasicSalary + totalAllowances) - totalDeductions;
//       out.print(totalWorkingDays);

        String qry = "INSERT INTO `salary`(`employee_id`, `allowances`, `deductions`, `net_salary`, `payment_date`) VALUES (?,?,?,?,?)";

        try {
            Connection conn = UserDao.getConnection();
            PreparedStatement pst = conn.prepareStatement(qry);
            pst.setInt(1, empId);
            pst.setDouble(2, totalAllowances);
            pst.setDouble(3, totalDeductions);
            pst.setDouble(4, finalSalary);
            pst.setDate(5, date);

            result = pst.executeUpdate();
        } catch (Exception e) {
            System.err.println(e);
        }
        return result;
    }

    public static List<Salary> getSalaryDetailsByEmployeeId(int employeeId) {
        List<Salary> salaryList = new ArrayList<>();
        String sql = """
        SELECT 
            allowances, 
            deductions, 
            net_salary, 
            payment_date
        FROM salary
        WHERE employee_id = ?;
    """;

        try (Connection conn = UserDao.getConnection(); PreparedStatement pst = conn.prepareStatement(sql)) {

            pst.setInt(1, employeeId);

            try (ResultSet rs = pst.executeQuery()) {
                while (rs.next()) {
                    Salary salary = new Salary();
                    salary.setAllowances(rs.getBigDecimal("allowances"));
                    salary.setDeductions(rs.getBigDecimal("deductions"));
                    salary.setNetSalary(rs.getBigDecimal("net_salary"));
                    salary.setPaymentDate(rs.getDate("payment_date"));

                    salaryList.add(salary);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return salaryList;
    }

    public static int isSalaryPaidForMonth(int empId, Date date) {
        int isPaid = 0;

        // Extract the month and year from the provided date
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(date);
        int month = calendar.get(Calendar.MONTH) + 1; // Months are 0-based in Calendar
        int year = calendar.get(Calendar.YEAR);

        // Query to check if salary is already paid
        String query = """
        SELECT COUNT(*) AS count
        FROM salary
        WHERE employee_id = ? 
          AND MONTH(payment_date) = ? 
          AND YEAR(payment_date) = ?;
    """;

        try (Connection conn = UserDao.getConnection(); PreparedStatement pst = conn.prepareStatement(query)) {

            pst.setInt(1, empId);  // Set employee ID
            pst.setInt(2, month);  // Set month
            pst.setInt(3, year);   // Set year

            try (ResultSet rs = pst.executeQuery()) {
                if (rs.next()) {
                    isPaid = rs.getInt("count") > 0 ? 1 : 0;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return isPaid;
    }
    
    public static List<Salary> getSalaryDetailsByDateRange(Date startDate, Date endDate) {
    List<Salary> salaryList = new ArrayList<>();

    // SQL query to fetch salary details within the given date range
    String sql = """
        SELECT 
            e.first_name, 
            e.last_name, 
            d.department_name, 
            s.allowances, 
            s.deductions, 
            s.net_salary, 
            s.payment_date
        FROM salary s
        JOIN employee e ON s.employee_id = e.employee_id
        JOIN department d ON e.department_id = d.department_id
        WHERE s.payment_date BETWEEN ? AND ?;
    """;

    try (Connection conn = UserDao.getConnection(); PreparedStatement pst = conn.prepareStatement(sql)) {
        // Set start and end date parameters for the query
        pst.setDate(1, startDate);
        pst.setDate(2, endDate);

        try (ResultSet rs = pst.executeQuery()) {
            while (rs.next()) {
                Salary salary = new Salary();
                salary.setFirstName(rs.getString("first_name"));
                salary.setLastName(rs.getString("last_name"));
                salary.setDepartmentName(rs.getString("department_name"));
                salary.setAllowances(rs.getBigDecimal("allowances"));
                salary.setDeductions(rs.getBigDecimal("deductions"));
                salary.setNetSalary(rs.getBigDecimal("net_salary"));
                salary.setPaymentDate(rs.getDate("payment_date"));

                salaryList.add(salary);
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    }

    return salaryList;
}


}
