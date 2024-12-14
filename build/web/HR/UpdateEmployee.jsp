<%-- 
    Document   : UpdateEmployee
    Created on : Nov 3, 2024, 3:18:21 PM
    Author     : SAHANI VIPUL
--%>

<%@page import="bean.Users"%>
<%@page import="java.math.BigDecimal"%>
<%@page contentType="text/html" pageEncoding="UTF-8" import="bean.EmployeeDao,bean.UserDao"%>
<jsp:useBean id="obj" class="bean.Employee" />
<jsp:useBean id="obj1" class="bean.Users" />

<jsp:setProperty name="obj" property="*" />
<%
    obj.setBasicSalary(new BigDecimal(request.getParameter("basic_salary")));

    int result = EmployeeDao.UpdateEmployee(obj);
    if (result == 1) {

        Users user = UserDao.getUserById(obj.getEmployeeId());
        if (user != null) {
            obj1.setUserId(user.getUserId());
            obj1.setUsername(user.getUsername());
            obj1.setPassword(user.getPassword());
            obj1.setRole(user.getRole());
            obj1.setEmail(obj.getEmail());
            obj1.setEmployeeId(obj.getEmployeeId());
            int re = UserDao.UpdateUser(obj1);
            System.err.println(re);
        }
        response.sendRedirect("/payroll/HR/Employee.jsp");
    } else {
%>
<script>
    alert("Failed to update employee details. Please try again.");
    window.history.back(); // This will take the user back to the previous page.

</script>
<%
    }
%>
