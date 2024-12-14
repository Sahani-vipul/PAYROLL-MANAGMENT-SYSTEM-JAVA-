<%-- 
    Document   : PaySalary
    Created on : Nov 16, 2024, 3:06:18 PM
    Author     : SAHANI VIPUL
--%>

<%@page import="java.math.BigDecimal"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Locale"%>
<%@page contentType="text/html" pageEncoding="UTF-8" import="bean.SalaryDao"%>
<%

    int id = Integer.parseInt(request.getParameter("employeeId"));
    String dateStr = request.getParameter("date");
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd", Locale.ENGLISH);
    java.util.Date utilDate = sdf.parse(dateStr);
    java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());

    double basicSalary = Double.parseDouble(request.getParameter("basic_salary"));
    double allowance = Double.parseDouble(request.getParameter("allowance"));
    double deductions = Double.parseDouble(request.getParameter("deductions"));

    if (SalaryDao.isSalaryPaidForMonth(id, sqlDate) == 0) {
            int salary = SalaryDao.paySalary(id, sqlDate, basicSalary, allowance, deductions);
            response.sendRedirect("/payroll/HR/Salary.jsp");
     }else{
            out.println("<script type='text/javascript'>");
            out.println("alert('Salary already pay for that Month ');");
            out.println("window.location.href = '/payroll/HR/Salary.jsp';");
            out.println("</script>");
    }

%>