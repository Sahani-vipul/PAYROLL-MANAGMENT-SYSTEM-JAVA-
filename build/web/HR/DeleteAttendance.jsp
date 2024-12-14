<%-- 
    Document   : DeleteAttendance
    Created on : Nov 8, 2024, 11:35:56 AM
    Author     : SAHANI VIPUL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="bean.AttendanceDao"%>
<%

   int id = Integer.parseInt(request.getParameter("id"));
   int result = AttendanceDao.deleteAttendance(id);
   response.sendRedirect("/payroll/HR/Attendance.jsp");
%>
