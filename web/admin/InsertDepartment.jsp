<%-- 
    Document   : InsertDepartment
    Created on : Oct 16, 2024, 11:16:32 AM
    Author     : SAHANI VIPUL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="bean.DepartmentDao"%>
<jsp:useBean id="obj" class="bean.Department" ></jsp:useBean>
<jsp:setProperty property="*" name="obj" />
<%

   int result = DepartmentDao.AddDepartment(obj);
   response.sendRedirect("/payroll/admin/Department.jsp");
%>