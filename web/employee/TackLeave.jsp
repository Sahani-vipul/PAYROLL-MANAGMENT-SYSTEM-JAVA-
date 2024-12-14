<%-- 
    Document   : TackLeave
    Created on : Dec 14, 2024, 10:21:03 AM
    Author     : SAHANI VIPUL
--%>

<%@page import="bean.LeaveType"%>
<%@page import="java.util.ArrayList"%>
<%@page import="bean.Leave"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8" isELIgnored="false" import="bean.LeaveDao" %>
<%@taglib prefix="mt" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
    Integer employeeId = (Integer) session.getAttribute("employeeId");

    int leaveTypeId = Integer.parseInt(request.getParameter("id"));
    int remainingLeave = Integer.parseInt(request.getParameter("remainingLeave"));
    request.setAttribute("remainingLeave", remainingLeave);
    request.setAttribute("leaveTypeId", leaveTypeId);


%>

<mt:employee_template title="Leave Apply">
    <jsp:attribute name="content">

        <!-- Filter Section: Select From and To Dates -->
        <div class="container mt-4">
            <form method="post" action="ApplyLeave.jsp" class="row g-3 align-items-center" onsubmit="return validateLeave()">
                <input type="hidden" name="leaveTypeId" value="${leaveTypeId}" />
                                <input type="hidden" name="employeeId" value="${employeeId}" />

                <div class="relative z-0 w-full mb-6 group">
                    <label for="date_from" class="mb-2 block text-sm font-medium text-slate-600 dark:text-slate-400">
                        Select From Date
                    </label>
                    <input 
                        type="date" 
                        name="startDate" 
                        id="date_from" 
                        class="block py-3 px-4 w-full text-sm text-gray-900 bg-transparent border-b border-gray-300 appearance-none dark:text-slate-300 dark:border-slate-700 dark:focus:border-primary-500 focus:outline-none focus:border-primary-500 transition"
                        onchange="calculateTotalDays()"
                        />
                </div>

                <div class="relative z-0 w-full mb-6 group">
                    <label for="date_to" class="mb-2 block text-sm font-medium text-slate-600 dark:text-slate-400">
                        Select To Date
                    </label>
                    <input 
                        type="date" 
                        name="endDate" 
                        id="date_to" 
                        class="block py-3 px-4 w-full text-sm text-gray-900 bg-transparent border-b border-gray-300 appearance-none dark:text-slate-300 dark:border-slate-700 dark:focus:border-primary-500 focus:outline-none focus:border-primary-500 transition"
                        onchange="calculateTotalDays()"
                        />
                </div>

                <div class="text-right">
                    <button 
                        id="applyButton"
                        type="submit" 
                        class="inline-block px-6 py-3 text-sm font-medium text-white bg-brand-500 rounded-lg shadow-md hover:bg-brand-600 focus:outline-none focus:ring-2 focus:ring-brand-400 focus:ring-offset-1 transition">
                        Apply
                    </button>
                </div>

                <div class="mt-4 text-sm font-medium text-slate-600 dark:text-slate-400">
                    Total Days Selected: 
                    <span id="total_days" class="text-primary-500 dark:text-primary-400">0</span>
                </div>

                <!-- Error message with remaining leave -->
                <div id="error_message" class="text-red-500 text-sm mt-2 hidden">
                    <span id="remaining_leave_error"></span>
                </div>
            </form>

        </div>



    </jsp:attribute>
</mt:employee_template>
