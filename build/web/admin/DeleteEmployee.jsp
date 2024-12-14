<%-- 
    Document   : DeleteEmployee
    Created on : Oct 15, 2024, 7:23:10 PM
    Author     : SAHANI VIPUL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="bean.UserDao,bean.EmployeeDao"%>

<%
    
  int id = Integer.parseInt(request.getParameter("id"));
  int status = UserDao.deleteUser(id);
  int result = EmployeeDao.deleteEmployee(id);
  response.sendRedirect("/payroll/admin/Employee.jsp");
  
 
%>