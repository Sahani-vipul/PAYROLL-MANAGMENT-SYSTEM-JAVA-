<%-- 
    Document   : InsertEmp
    Created on : Oct 14, 2024, 11:09:07 AM
    Author     : SAHANI VIPUL
--%>

<%@page import="java.util.Locale"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date,java.sql.*"%>
<%@page import="java.math.BigDecimal"%>
<%@page contentType="text/html" pageEncoding="UTF-8" import="bean.EmployeeDao"%>
<jsp:useBean id="obj"  class="bean.Employee" ></jsp:useBean>
<jsp:setProperty name="obj" property="*" ></jsp:setProperty>
<%
    try {

        obj.setFirstName(request.getParameter("first_name"));
        obj.setLastName(request.getParameter("last_name"));
        obj.setBasicSalary(new BigDecimal(request.getParameter("basic_salary")));

        String dateOfJoiningStr = request.getParameter("date_of_joing");
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd", Locale.ENGLISH);
        java.util.Date utilDate = sdf.parse(dateOfJoiningStr);
        java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());
        obj.setDateOfJoining(sqlDate);
        obj.setDepartmentId(Integer.parseInt(request.getParameter("department_id")));
        EmployeeDao obj1 = new EmployeeDao();
        int result = obj1.AddEmplouee(obj);

        if (result == 1) {
            // If valid, redirect to welcome page
            response.sendRedirect("/payroll");
        }
    } catch (Exception e) {
        out.println(e);
    }


%>
