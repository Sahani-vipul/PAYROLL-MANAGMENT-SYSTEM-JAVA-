<%-- 
    Document   : CheckEmployee
    Created on : Nov 6, 2024, 12:58:19 PM
    Author     : SAHANI VIPUL
--%>

<%@page import="java.util.Date"%>
<%@page import="bean.Employee"%>
<%@page contentType="text/html" pageEncoding="UTF-8" import="bean.EmployeeDao"%>
<%

    int id = Integer.parseInt(request.getParameter("Employee_id"));
    Employee result = EmployeeDao.getEmployeeById(id);
    
    if (result != null) {
        response.sendRedirect("/payroll/HR/MarkAttendance.jsp?id=" + id);
    } else {
%>
<script>
    alert("Employee Dose not Exist. Please try again.");
    window.history.back(); // This will take the user back to the previous page.

</script>
<%
    }
%>
