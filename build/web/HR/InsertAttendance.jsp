<%-- 
    Document   : InsertAttendance
    Created on : Nov 6, 2024, 1:46:31 PM
    Author     : SAHANI VIPUL
--%>

<%@page import="bean.Employee"%>
<%@page import="java.sql.Time"%>
<%@page import="java.util.Locale"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalTime"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8" import="bean.AttendanceDao"%>
<jsp:useBean id="obj" class="bean.Attendance" />
<%
    try {
        // Parse date from the request
        String dateStr = request.getParameter("date");
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd", Locale.ENGLISH);
        java.util.Date utilDate = sdf.parse(dateStr);
        java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());
        obj.setDate(sqlDate);

        // Get and parse check-in and check-out times from the request
        String checkin = request.getParameter("checkInTime");
        String checkout = request.getParameter("checkOutTime");
        DateTimeFormatter timeFormatter = DateTimeFormatter.ofPattern("HH:mm");
        LocalTime cin = LocalTime.parse(checkin, timeFormatter);
        LocalTime cout = LocalTime.parse(checkout, timeFormatter);

        // Convert LocalTime to java.sql.Time and set in Attendance object
        obj.setCheckInTime(Time.valueOf(cin));
        obj.setCheckOutTime(Time.valueOf(cout));

        // Parse and set employee ID
        int id = Integer.parseInt(request.getParameter("employeeId"));
        obj.setEmployeeId(id);

        // Mark attendance and redirect if successful
        boolean check = AttendanceDao.isAttendanceMarked(id, sqlDate);

        if (!check) {
            int result = AttendanceDao.markAttendance(obj);
            if (result == 1) {
                response.sendRedirect("/payroll/HR/Attendance.jsp");
            } else {
                out.print("Error: Attendance not marked.");
            }
        } else {
            out.println("<script type='text/javascript'>");
            out.println("alert('Attendance already marked for today');");
            out.println("window.location.href = '/payroll/HR/Attendance.jsp';");
            out.println("</script>");
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.print("Error: " + e.getMessage());
    }
%>
