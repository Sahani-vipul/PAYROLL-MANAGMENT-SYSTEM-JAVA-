<%-- 
    Document   : InsertLeaveType
    Created on : Nov 2, 2024, 2:48:59 PM
    Author     : SAHANI VIPUL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="bean.LeaveDao"%>
<jsp:useBean id="obj" class="bean.LeaveType" ></jsp:useBean>
<jsp:setProperty property="*" name="obj" />
<%

   int result = LeaveDao.addLeaveType(obj);
   if(result == 1){
    response.sendRedirect("/payroll/admin/Leave.jsp");
    }else{
        out.print("not insert");
    }
   
%>