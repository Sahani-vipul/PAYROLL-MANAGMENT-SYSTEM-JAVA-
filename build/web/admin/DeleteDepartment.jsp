<%-- 
    Document   : DeleteDepartment
    Created on : Oct 16, 2024, 11:30:39 AM
    Author     : SAHANI VIPUL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="bean.DepartmentDao"%>

<%

   int id = Integer.parseInt(request.getParameter("id"));
   int result = DepartmentDao.deleteDepartment(id);
   
   response.sendRedirect("/payroll/admin/Department.jsp");
%>
