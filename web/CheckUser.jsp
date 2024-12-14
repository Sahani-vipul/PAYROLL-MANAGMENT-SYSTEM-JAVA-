<%-- 
    Document   : CheckUser
    Created on : Oct 10, 2024, 12:59:09 PM
    Author     : SAHANI VIPUL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="bean.UserDao" %>
<jsp:useBean id="obj"  class="bean.Users" ></jsp:useBean>
<jsp:setProperty name="obj" property="*" ></jsp:setProperty>

<%
    int isValidUser = UserDao.validate(obj);
    String email = obj.getEmail();


    if (isValidUser == 1) {
        // If valid, redirect to welcome page
        response.sendRedirect("/payroll/admin/index.jsp");
    } else if(isValidUser == 2){
        response.sendRedirect("/payroll/HR/index.jsp");
    }else if(isValidUser == 3){
         int employeeId = UserDao.getEmployeeIdByEmail(email);
        //    Integer employeeId = (Integer) session.getAttribute("employeeId");

        // Store email and employee ID in session
        session.setAttribute("employeeId", employeeId);
        response.sendRedirect("/payroll/employee/index.jsp");
    }else {
        // If invalid, show error and redirect back to login page
        request.setAttribute("errorMessage","invalid username or password");
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }
%>