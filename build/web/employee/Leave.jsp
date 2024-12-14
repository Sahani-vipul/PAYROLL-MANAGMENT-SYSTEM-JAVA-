<%-- 
    Document   : Leave
    Created on : Nov 9, 2024, 4:23:15 PM
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

   // List<LeaveType> leave = LeaveDao.getAllLeaves();
    List<Leave> leave = LeaveDao.getLeaveSummaryByEmployeeId(employeeId);
    
    request.setAttribute("leaves", leave);

%>

<mt:employee_template title="Leave">
    <jsp:attribute name="content">

        <div class="flex flex-wrap gap-4 mb-3">
            <div>
                <label class="inline-block focus:outline-none bg-brand-500 mt-1 text-white hover:bg-brand-600 hover:text-white  text-md font-medium py-2 px-4 rounded">
                    Leave
                </label>
            </div>

            
        </div>

        <table class="w-full">
            <thead class="bg-primary-500 dark:bg-primary-500">
                <tr>
                    <th scope="col" class="p-3 text-xs font-medium tracking-wider text-left text-slate-100 uppercase">
                        SR. NO
                    </th>

                    <th scope="col" class="p-3 text-xs font-medium tracking-wider text-left text-slate-100 uppercase">
                        Leave Name
                    </th>
                    <th scope="col" class="p-3 text-xs font-medium tracking-wider text-left text-slate-100 uppercase">
                        Total Leave
                    </th>


                    <th scope="col" class="p-3 text-xs font-medium tracking-wider text-left text-slate-100 uppercase">
                        Tack Leaves
                    </th>

                    <th scope="col" class="p-3 text-xs font-medium tracking-wider text-left text-slate-100 uppercase">
                        Action
                    </th>
                </tr>
            </thead>
            <tbody>
                <!-- 1 -->
                <c:set var="idCounter" value="1" />   
                <c:forEach var="emp" items="${leaves}">

                    <tr class="bg-white border-b border-dashed dark:bg-gray-900 dark:border-gray-700/40">

                        <td class="p-2 text-sm text-gray-500 whitespace-nowrap dark:text-gray-400">

                            ${idCounter}
                        </td>

                        <td class="p-3 text-sm text-gray-500 whitespace-nowrap dark:text-gray-400">
                            ${emp.getLeaveType()}
                        </td>
                        <td class="p-3 text-sm text-gray-500 whitespace-nowrap dark:text-gray-400">
                            ${emp.getTotalDays()}
                        </td>


                        <td class="p-3 text-sm text-gray-500 whitespace-nowrap dark:text-gray-400">
                            ${emp.getTakenLeaves()}
                        </td>

                        <td class="p-3 text-sm text-gray-500 whitespace-nowrap dark:text-gray-400">
                            <c:set var="remainingLeaves" value="${emp.getTotalDays() - emp.getTakenLeaves()}" />
                            <!-- Pass remainingLeaves in the link as a parameter -->
                            <a href="LeaveDetails.jsp?id=${emp.getLeaveTypeId()}&remainingLeave=${remainingLeaves}" class="inline-block focus:outline-none bg-brand-500 mt-1 text-white hover:bg-brand-600 hover:text-white text-md font-medium py-2 px-4 rounded">  
                                View
                            </a>
                        </td>
                    </tr>

                    <c:set var="idCounter" value="${idCounter + 1}" />  

                </c:forEach>   
            </tbody>
        </table>

    </jsp:attribute>
</mt:employee_template>    