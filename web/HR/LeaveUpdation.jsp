<%-- 
    Document   : LeaveUpdation
    Created on : Nov 10, 2024, 4:16:10 PM
    Author     : SAHANI VIPUL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="bean.LeaveDao"%>
<jsp:useBean id="obj" class="bean.Leave" />
<%

    String status = request.getParameter("status");
    int id = Integer.parseInt(request.getParameter("id"));
    
    obj.setLeaveId(id);
    obj.setStatus(status);
    
    int result = LeaveDao.leaveUpdate(obj);
  
    response.sendRedirect("/payroll/HR/Leave.jsp");
     
%>