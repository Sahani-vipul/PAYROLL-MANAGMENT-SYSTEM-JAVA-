<%-- 
    Document   : UpdateLeaveType
    Created on : Nov 2, 2024, 11:29:01 PM
    Author     : SAHANI VIPUL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="bean.LeaveDao"%>
<jsp:useBean id="obj" class="bean.LeaveType" />
<jsp:setProperty name="obj" property="*" />
<%

   int result = LeaveDao.UpdateLeaveType(obj);
   response.sendRedirect("/payroll/admin/Leave.jsp");

%>