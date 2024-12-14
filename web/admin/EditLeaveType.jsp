<%-- 
    Document   : EditLeaveType
    Created on : Nov 2, 2024, 11:16:56 PM
    Author     : SAHANI VIPUL
--%>

<%@page import="java.util.List"%>
<%@page import="bean.LeaveDao"%>
<%@page import="bean.LeaveType"%>
<%@page contentType="text/html" pageEncoding="UTF-8" isELIgnored="false" %>

<%@taglib prefix="mt" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%

       List<LeaveType> leaves = LeaveDao.getLeaveTypeById(Integer.parseInt(request.getParameter("id")));
       request.setAttribute("leaves", leaves);

%>
<mt:admin_template title="Edit Leave">
    <jsp:attribute name="content">

        <div class="w-full relative mb-4">  
            <form action="UpdateLeaveType.jsp" method="get"> 
           <c:forEach var="leave" items="${leaves}">

                <div class="flex-auto p-0 md:p-4">  
                    <input type="hidden" name="leaveTypeId"  value="${leave.getLeaveTypeId()}"  />
                    <div class="mb-2">
                        <!--<label for="LeaveType" class="font-medium text-sm text-slate-600 dark:text-slate-400">Enter Leave Name   </label>-->
                        <input type="text"  name="leaveType" value="${leave.getLeaveType()}" class="form-input w-full rounded-md mt-1 border border-slate-300/60 dark:border-slate-700 dark:text-slate-300 bg-transparent px-3 py-2 focus:outline-none focus:ring-0 placeholder:text-slate-400/70 placeholder:font-normal placeholder:text-sm hover:border-slate-400 focus:border-brand-500 dark:focus:border-brand-500  dark:hover:border-slate-700" placeholder="Enter Leave Name" required>

                    </div>
                    <div class="mb-2">
                        <!--<label for="LeaveDay" class="font-medium text-sm text-slate-600 dark:text-slate-400">Enter Days   </label>-->
                        <input type="text"  name="leaveDays" value="${leave.getLeaveDays()}" class="form-input w-full rounded-md mt-1 border border-slate-300/60 dark:border-slate-700 dark:text-slate-300 bg-transparent px-3 py-2 focus:outline-none focus:ring-0 placeholder:text-slate-400/70 placeholder:font-normal placeholder:text-sm hover:border-slate-400 focus:border-brand-500 dark:focus:border-brand-500  dark:hover:border-slate-700" placeholder="Enter Leave Days" required>

                    </div>

                    <button type="submit" class="px-2 py-2 lg:px-4 bg-brand  text-white text-sm  rounded hover:bg-brand-600 border border-brand-500">Update Leave</button>

                </div>
           </c:forEach>
            </form>
        </div><!--end col--> 
    </jsp:attribute>
</mt:admin_template>    