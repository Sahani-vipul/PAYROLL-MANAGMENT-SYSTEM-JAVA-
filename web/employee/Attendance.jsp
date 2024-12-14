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
      Integer employeeId = (Integer) session.getAttribute("employeeId");
//
   List<Attendance> attendance = AttendanceDao.getAllAttendanceById(employeeId);
    request.setAttribute("attendances", attendance);
   
//
%>
<mt:employee_template title="Attendance">
    <jsp:attribute name="content">

        <div class="flex flex-wrap gap-4 mb-3 justify-between">

            <table class="w-full">
                <thead class="bg-primary-500 dark:bg-primary-500">
                    <tr>
                        <th scope="col" class="p-3 text-xs font-medium tracking-wider text-left text-slate-100 uppercase">
                            SR. NO 
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
                                ${emp.getDate()}
                            </td>
                            <td class="p-3 text-sm text-gray-500 whitespace-nowrap dark:text-gray-400">
                                ${emp.getCheckInTime()}
                            </td>

                            <td class="p-3 text-sm text-gray-500 whitespace-nowrap dark:text-gray-400">
                                ${emp.getCheckOutTime()}
                            </td>

                            
                        </tr>

                        <c:set var="idCounter" value="${idCounter + 1}" />  

                    </c:forEach>   
                </tbody>
            </table>

        </jsp:attribute>
    </mt:employee_template>    