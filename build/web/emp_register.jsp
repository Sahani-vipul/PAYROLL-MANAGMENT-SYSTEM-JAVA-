<%-- 
    Document   : emp_register
    Created on : Oct 11, 2024, 10:41:11 AM
    Author     : SAHANI VIPUL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="bean.UserDao"%>
<jsp:useBean id="obj"  class="bean.Users" ></jsp:useBean>
<jsp:setProperty name="obj" property="*" ></jsp:setProperty>

<%
    // Now the user bean has the username and password properties set from the form
   
    int result = UserDao.register(obj);

    if (result == 1) {
        // If valid, redirect to welcome page
        response.sendRedirect("/payroll/login.jsp");
    } else {
        // If invalid, show error and redirect back to login page
       response.sendRedirect("/payroll/registration.jsp");
    }
%>