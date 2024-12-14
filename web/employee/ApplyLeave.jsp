<%-- 
    Document   : ApplyLeave
    Created on : Dec 14, 2024, 11:24:10 AM
    Author     : SAHANI VIPUL
--%>

<%@page import="java.util.Date"%>
<%-- ApplyLeave.jsp --%>
<%@page contentType="text/html" pageEncoding="UTF-8" import="bean.LeaveDao"%>
<jsp:useBean id="obj" class="bean.Leave" />
<%

 int leaveId = Integer.parseInt(request.getParameter("leaveTypeId"));
 int empId = Integer.parseInt(request.getParameter("employeeId"));
 String startDate = request.getParameter("startDate");
 String endtDate = request.getParameter("endDate");

 java.sql.Date start = java.sql.Date.valueOf(startDate);
 java.sql.Date end = java.sql.Date.valueOf(endtDate);
 
obj.setEmployeeId(empId);
obj.setLeaveTypeId(leaveId);
obj.setStartDate(start);
obj.setEndDate(end);
obj.setStatus("Pending");


int result = LeaveDao.applyLeave(obj);

if(result == 1){

    response.sendRedirect("/payroll/employee/Leave.jsp");
    }
 
 
%>