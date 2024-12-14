<%-- 
    Document   : Report
    Created on : Nov 17, 2024, 1:02:25 PM
    Author     : SAHANI VIPUL
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Locale"%>
<%@page import="bean.Salary"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8" isELIgnored="false" import="bean.SalaryDao" %>

<%@taglib prefix="mt" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
 
    // Declare variables outside the try-catch block
    java.sql.Date start = null;
    java.sql.Date end = null;

    try {
        // Fetch parameters from the request
        String dateStr = request.getParameter("startDate");
        String dateStr1 = request.getParameter("endDate");

        // Validate input parameters
        if (dateStr == null || dateStr.trim().isEmpty() || dateStr1 == null || dateStr1.trim().isEmpty()) {
            throw new IllegalArgumentException("Both startDate and endDate are required!");
        }

        // Parse and convert dates
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd", Locale.ENGLISH);
        java.util.Date utilDate = sdf.parse(dateStr);
        start = new java.sql.Date(utilDate.getTime());

        java.util.Date utilDate1 = sdf.parse(dateStr1);
        end = new java.sql.Date(utilDate1.getTime());

            } catch (Exception e) {
        // Log and handle the exception gracefully
        System.err.println("Error parsing dates: " + e.getMessage());
       
    }

    // Default empty list to prevent further NullPointerException
    List<Salary> employee = new ArrayList<>();
    if (start != null && end != null) {
        employee = SalaryDao.getSalaryDetailsByDateRange(start, end);
    }

    request.setAttribute("employees", employee);


%>
<mt:admin_template title="Report">
    <jsp:attribute name="content">

        <form method="get" action="Report.jsp">
            <div class="flex items-end gap-4 mb-3">
                <div>
                    <label for="startDate" class="block text-sm font-medium text-gray-700">
                        Start Date
                    </label>
                    <input type="date" id="startDate" name="startDate" class="form-input w-52 rounded-md mt-1 border border-slate-300/60 dark:border-slate-700 dark:text-slate-300 bg-transparent px-3 py-2">
                </div>
                <div>
                    <label for="endDate" class="block text-sm font-medium text-gray-700">
                        End Date
                    </label>
                    <input type="date" id="endDate" name="endDate" 
                           class="form-input w-52 rounded-md mt-1 border border-slate-300/60 dark:border-slate-700 dark:text-slate-300 bg-transparent px-3 py-2">
                </div>
                <div>
                    <button type="submit" class="focus:outline-none bg-brand-500 text-white hover:bg-brand-600 hover:text-white text-md font-medium py-2 px-4 rounded">
                        Submit
                    </button>
                </div>
            </div>

        </form>
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
                        Department
                    </th>
                    <th scope="col" class="p-3 text-xs font-medium tracking-wider text-left text-slate-100 uppercase">
                        Allowances
                    </th>
                    <th scope="col" class="p-3 text-xs font-medium tracking-wider text-left text-slate-100 uppercase">
                        Deductions
                    </th>
                    <th scope="col" class="p-3 text-xs font-medium tracking-wider text-left text-slate-100 uppercase">
                      Salary
                    </th>
                    <th scope="col" class="p-3 text-xs font-medium tracking-wider text-left text-slate-100 uppercase">
                      Payment Date
                    </th>
                   
                </tr>
            </thead>
            <tbody>
                <!-- 1 -->
                <c:set var="idCounter" value="1" />   
                <c:forEach var="emp" items="${employees}">
           

                        <tr class="bg-white border-b border-dashed dark:bg-gray-900 dark:border-gray-700/40">

                            <td class="p-2 text-sm text-gray-500 whitespace-nowrap dark:text-gray-400">

                                ${idCounter}
                            </td>
                            
                            <td class="p-3 text-sm text-gray-500 whitespace-nowrap dark:text-gray-400">
                                ${emp.getFirstName()}
                            </td>
                            <td class="p-3 text-sm text-gray-500 whitespace-nowrap dark:text-gray-400">
                                ${emp.getLastName()}
                            </td>

                        
                            <td class="p-3 text-sm text-gray-500 whitespace-nowrap dark:text-gray-400">
                                ${emp.getDepartmentName()}
                            </td>
                            <td class="p-3 text-sm text-gray-500 whitespace-nowrap dark:text-gray-400">
                                ${emp.getAllowances()}
                            </td>
                            <td class="p-3 text-sm text-gray-500 whitespace-nowrap dark:text-gray-400">
                                ${emp.getDeductions()}
                            </td>

                            <td class="p-3 text-sm text-gray-500 whitespace-nowrap dark:text-gray-400">
                                ${emp.getNetSalary()}
                            </td>
                             <td class="p-3 text-sm text-gray-500 whitespace-nowrap dark:text-gray-400">
                                ${emp.getPaymentDate()}
                            </td>

                        </tr>

                        <c:set var="idCounter" value="${idCounter + 1}" />  
                
                </c:forEach>   
            </tbody>
        </table>

    </jsp:attribute>
</mt:admin_template>    