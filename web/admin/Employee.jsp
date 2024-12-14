<%-- 
    Document   : Employee
    Created on : Oct 15, 2024, 6:31:15 PM
    Author     : SAHANI VIPUL
--%>

<%@page import="bean.Employee"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8" isELIgnored="false" import="bean.EmployeeDao" %>

<%@taglib prefix="mt" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%

       List<Employee> employee = EmployeeDao.gelAllEmployee();
       request.setAttribute("employees", employee);

%>
<mt:admin_template title="Employee">
    <jsp:attribute name="content">

        <div class="flex flex-wrap gap-4 mb-3">
            <div>
                <label class="inline-block focus:outline-none bg-brand-500 mt-1 text-white hover:bg-brand-600 hover:text-white  text-md font-medium py-2 px-4 rounded">
                    Employee
                </label>
            </div>

            <div class="ms-auto">
                <form>
                    <div class="relative">
                        <div class="flex absolute inset-y-0 left-0 items-center pl-3 pointer-events-none">
                            <i data-lucide="search" class="z-[1] w-5 h-5 stroke-slate-400"></i>
                        </div>
                        <input type="search" id="productSearch" class="form-input w-52 rounded-md mt-1 border border-slate-300/60 dark:border-slate-700 dark:text-slate-300 bg-transparent px-3 py-2 focus:outline-none focus:ring-0 placeholder:text-slate-400/70 placeholder:font-normal placeholder:text-sm hover:border-slate-400 focus:border-primary-500 dark:focus:border-primary-500  dark:hover:border-slate-700 pl-10 p-2.5" placeholder="search">
                    </div>
                </form>
            </div>
            <div>
                <a href="AddEmployee.jsp" class="inline-block focus:outline-none bg-brand-500 mt-1 text-white hover:bg-brand-600 hover:text-white  text-md font-medium py-2 px-4 rounded">  
                    Add Employee
                </a>
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
                        Role
                    </th>
                    <th scope="col" class="p-3 text-xs font-medium tracking-wider text-left text-slate-100 uppercase">
                        Phone No
                    </th>
                    <th scope="col" class="p-3 text-xs font-medium tracking-wider text-left text-slate-100 uppercase">
                        Basic Salary
                    </th>
                    
                    <th scope="col" class="p-3 text-xs font-medium tracking-wider text-left text-slate-100 uppercase">
                        Action
                    </th>
                </tr>
            </thead>
            <tbody>
                <!-- 1 -->
           <c:set var="idCounter" value="1" />   
           <c:forEach var="emp" items="${employees}">

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
                         ${emp.getRole()}
                    </td>
                    <td class="p-3 text-sm text-gray-500 whitespace-nowrap dark:text-gray-400">
                        ${emp.getPhone()}
                    </td>
                    
                    <td class="p-3 text-sm text-gray-500 whitespace-nowrap dark:text-gray-400">
                        ${emp.getBasicSalary()}
                    </td>
                    
                    <td class="p-3 text-sm text-gray-500 whitespace-nowrap dark:text-gray-400">
                        <a href="EditEmployee.jsp?id=${emp.getEmployeeId()}"><i class="icofont-edit text-lg text-gray-500 dark:text-gray-400"></i></a>
                        <a href="DeleteEmployee.jsp?id=${emp.getEmployeeId()}"><i class="icofont-ui-delete text-lg text-red-500 dark:text-red-400"></i></a>
                    </td>
                </tr>
                
              <c:set var="idCounter" value="${idCounter + 1}" />  
           </c:forEach>   
            </tbody>
        </table>

    </jsp:attribute>
</mt:admin_template>    