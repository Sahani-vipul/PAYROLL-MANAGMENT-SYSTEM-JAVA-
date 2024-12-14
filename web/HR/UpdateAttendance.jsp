<%-- 
    Document   : UpdateAttendance
    Created on : Nov 9, 2024, 11:54:18 AM
    Author     : SAHANI VIPUL
--%>

<%@page import="java.sql.Time"%>
<%@page import="java.time.LocalTime"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.util.Locale"%>
<%@page contentType="text/html" pageEncoding="UTF-8" import="bean.AttendanceDao"%>
<jsp:useBean id="obj" class="bean.Attendance" />
<%--<jsp:setProperty name="obj" property="*"></jsp:setProperty>--%>
<%

    // Parse and format the date
    String dateStr = request.getParameter("date");
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd", Locale.ENGLISH);
    java.util.Date utilDate = sdf.parse(dateStr);
    java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());
    obj.setDate(sqlDate);

    // Get and parse check-in and check-out times from the request
    String checkin = request.getParameter("checkInTime");
    String checkout = request.getParameter("checkOutTime");

    // Choose the correct formatter based on the input length
    DateTimeFormatter timeFormatter;
    LocalTime cin, cout;

    if (checkin.length() == 5) { // "HH:mm" format
        timeFormatter = DateTimeFormatter.ofPattern("HH:mm");
    } else { // "HH:mm:ss" format
        timeFormatter = DateTimeFormatter.ofPattern("HH:mm:ss");
    }
    cin = LocalTime.parse(checkin, timeFormatter);

    if (checkout.length() == 5) { // "HH:mm" format
        timeFormatter = DateTimeFormatter.ofPattern("HH:mm");
    } else { // "HH:mm:ss" format
        timeFormatter = DateTimeFormatter.ofPattern("HH:mm:ss");
    }
    cout = LocalTime.parse(checkout, timeFormatter);

    // Convert LocalTime to java.sql.Time and set in Attendance object
    obj.setCheckInTime(Time.valueOf(cin));
    obj.setCheckOutTime(Time.valueOf(cout));
//         Parse and set attendance ID
    int id = Integer.parseInt(request.getParameter("attendanceId"));
    obj.setAttendanceId(id);

    int result = AttendanceDao.updateAttendance(obj);

    response.sendRedirect("/payroll/HR/Attendance.jsp");


%>
