<%-- 
    Document   : DeleteEmployee
    Created on : Oct 15, 2024, 7:23:10 PM
    Author     : SAHANI VIPUL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="bean.UserDao,bean.EmployeeDao"%>

<%
    
  int id = Integer.parseInt(request.getParameter("id"));
  UserDao userdao = new UserDao();
  EmployeeDao employeedao = new EmployeeDao();
  int status = userdao.deleteUser(id);
  int result = employeedao.deleteEmployee(id);
  response.sendRedirect("/payroll/admin/dashboard/Employee.jsp");
  
 
%>