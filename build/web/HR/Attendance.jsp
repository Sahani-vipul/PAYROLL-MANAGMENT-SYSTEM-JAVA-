<%-- 
    Document   : Attendence
    Created on : Nov 6, 2024, 12:40:06 PM
    Author     : SAHANI VIPUL
--%>

<%@page import="bean.Attendance"%>
<%@page import="bean.Employee"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8" isELIgnored="false" import="bean.AttendanceDao" %>

<%@taglib prefix="mt" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%

    String filter = request.getParameter("filter");
    if (filter == null) {
        filter = "today"; // Default filter
    }
    List<Attendance> attendance = AttendanceDao.getAllAttendance(filter);
    request.setAttribute("attendances", attendance);

%>
<mt:hr_template title="Attendance">
    <jsp:attribute name="content">

        <div class="flex flex-wrap gap-4 mb-3 justify-between">
    
    <!-- Filter Dropdown Form -->
    <div>
        <form action="Attendance.jsp" method="get">
            <div class="d-flex align-items-center">
                <!-- Filter Dropdown with Bootstrap Styling -->
                <select name="filter" class="form-select me-2">
                    <option value="today" ${param.filter == 'today' ? 'selected' : ''}>Today</option>
                    <option value="yesterday" ${param.filter == 'yesterday' ? 'selected' : ''}>Yesterday</option>
                    <option value="thisMonth" ${param.filter == 'thisMonth' ? 'selected' : ''}>This Month</option>
                    <option value="lastMonth" ${param.filter == 'lastMonth' ? 'selected' : ''}>Last Month</option>
                    <option value="all" ${param.filter == 'all' ? 'selected' : ''}>All</option>
                </select>

                <!-- Apply Filter Button with Bootstrap Styling -->
                <button type="submit" 
                        class="bg-brand-500 text-white hover:bg-brand-600 text-md font-medium py-2 px-4 rounded focus:outline-none">
                    Apply Filter
                </button>
            </div>
        </form>
    </div>

    <!-- Search and Mark Attendance Form -->
    <div>
        <form action="CheckEmployee.jsp" method="post">
            <div class="flex items-center space-x-4">
                <!-- Search Input -->
                <div class="relative">
                    <div class="flex absolute inset-y-0 left-0 items-center pl-3 pointer-events-none">
                        <i data-lucide="search" class="z-[1] w-5 h-5 stroke-slate-400"></i>
                    </div>
                    <input type="search" id="Employee_id" name="Employee_id" 
                           class="form-input w-52 rounded-md border border-slate-300/60 dark:border-slate-700 dark:text-slate-300 bg-transparent px-3 py-2 focus:outline-none focus:ring-0 placeholder:text-slate-400/70 placeholder:font-normal placeholder:text-sm hover:border-slate-400 focus:border-primary-500 dark:focus:border-primary-500 dark:hover:border-slate-700 pl-10 p-2.5" 
                           placeholder="Enter Employee ID">
                </div>

                <!-- Mark Attendance Button -->
                <button type="submit" 
                        class="bg-brand-500 text-white hover:bg-brand-600 text-md font-medium py-2 px-4 rounded focus:outline-none">  
                    Mark Attendance
                </button>
            </div>
        </form>
    </div>

</div>

        <table class="w-full">
            <thead class="bg-primary-500 dark:bg-primary-500">
                <tr>
                    <th scope="col" class="p-3 text-xs font-medium tracking-wider text-left text-slate-100 uppercase">
                        SR. NO
                    </th>
                    <th scope="col" class="p-3 text-xs font-medium tracking-wider text-left text-slate-100 uppercase">
                        First Name
                    </th>
                    <th scope="col" class="p-3 text-xs font-medium tracking-wider text-left text-slate-100 uppercase">
                        Last Name
                    </th>

                    <th scope="col" class="p-3 text-xs font-medium tracking-wider text-left text-slate-100 uppercase">
                        Email
                    </th>
                    <th scope="col" class="p-3 text-xs font-medium tracking-wider text-left text-slate-100 uppercase">
                        Department
                    </th>
                    <th scope="col" class="p-3 text-xs font-medium tracking-wider text-left text-slate-100 uppercase">
                        Date
                    </th>
                    <th scope="col" class="p-3 text-xs font-medium tracking-wider text-left text-slate-100 uppercase">
                        Check in Time
                    </th>
                    <th scope="col" class="p-3 text-xs font-medium tracking-wider text-left text-slate-100 uppercase">
                        Check out Time
                    </th>

                    <th scope="col" class="p-3 text-xs font-medium tracking-wider text-left text-slate-100 uppercase">
                        Action
                    </th>
                </tr>
            </thead>
            <tbody>
                <!-- 1 -->
                <c:set var="idCounter" value="1" />   
                <c:forEach var="emp" items="${attendances}">


                    <tr class="bg-white border-b border-dashed dark:bg-gray-900 dark:border-gray-700/40">

                        <td class="p-3 text-sm text-gray-500 whitespace-nowrap dark:text-gray-400">

                            ${idCounter}
                        </td>
                        <td class="p-3 text-sm text-gray-500 whitespace-nowrap dark:text-gray-400">
                            ${emp.getFirstName()}
                        </td>
                        <td class="p-3 text-sm text-gray-500 whitespace-nowrap dark:text-gray-400">
                            ${emp.getLastName()}
                        </td>

                        <td class="p-3 text-sm text-gray-500 whitespace-nowrap dark:text-gray-400">
                            ${emp.getEmail()}
                        </td>
                        <td class="p-3 text-sm text-gray-500 whitespace-nowrap dark:text-gray-400">
                            ${emp.getDepartmentName()}
                        </td>
                        <td class="p-3 text-sm text-gray-500 whitespace-nowrap dark:text-gray-400">
                            ${emp.getDate()}
                        </td>
                        <td class="p-3 text-sm text-gray-500 whitespace-nowrap dark:text-gray-400">
                            ${emp.getCheckInTime()}
                        </td>

                        <td class="p-3 text-sm text-gray-500 whitespace-nowrap dark:text-gray-400">
                            ${emp.getCheckOutTime()}
                        </td>

                        <td class="p-3 text-sm text-gray-500 whitespace-nowrap dark:text-gray-400">
                            <a href="EditAttendance.jsp?id=${emp.getAttendanceId()}&emp_id=${emp.getEmployeeId()}"><i class="icofont-edit text-lg text-gray-500 dark:text-gray-400"></i></a>
                            <a href="DeleteAttendance.jsp?id=${emp.getAttendanceId()}"><i class="icofont-ui-delete text-lg text-red-500 dark:text-red-400"></i></a>
                        </td>
                    </tr>

                    <c:set var="idCounter" value="${idCounter + 1}" />  

                </c:forEach>   
            </tbody>
        </table>

    </jsp:attribute>
</mt:hr_template>    