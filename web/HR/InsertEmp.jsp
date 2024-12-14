<%-- 
    Document   : InsertEmp
    Created on : Oct 14, 2024, 11:09:07 AM
    Author     : SAHANI VIPUL
--%>

<%@page import="java.util.Locale"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date,java.sql.*"%>

<%@page import="java.math.BigDecimal"%>
<%@page contentType="text/html" pageEncoding="UTF-8" import="bean.EmployeeDao,bean.UserDao"%>
<jsp:useBean id="obj"  class="bean.Employee" ></jsp:useBean>
<jsp:useBean id="obj1" class="bean.Users"></jsp:useBean>
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
    
        int result = EmployeeDao.AddEmplouee(obj);

        if (result == 1) {
            // If valid, redirect to welcome page
            obj1.setEmail(obj.getEmail());
            obj1.setUsername(obj.getFirstName());
            obj1.setPassword(obj.getPhone());
            obj1.setRole(request.getParameter("role"));
            int status = UserDao.register(obj1);
            
            String to = obj.getEmail();

            EmployeeDao.sendMail(to);
            response.sendRedirect("/payroll/HR/Employee.jsp");
        }
    } catch (Exception e) {
        out.println(e);
    }


%>
