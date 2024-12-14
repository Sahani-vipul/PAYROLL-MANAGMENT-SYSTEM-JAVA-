<%-- 
    Document   : DeleteLeaveType
    Created on : Nov 2, 2024, 11:03:19 PM
    Author     : SAHANI VIPUL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="bean.LeaveDao"%>
<%
    int id = Integer.parseInt(request.getParameter("id"));
    int result = LeaveDao.DeleteLeaveType(id);
    response.sendRedirect("/payroll/admin/Leave.jsp");
    
%>
