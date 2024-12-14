<%-- 
    Document   : MarkAttendance
    Created on : Nov 6, 2024, 1:16:06?PM
    Author     : SAHANI VIPUL
--%>


<%@page import="bean.DepartmentDao"%>
<%@ page import="bean.EmployeeDao, bean.Employee, bean.Department, java.util.List, java.sql.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="mt" tagdir="/WEB-INF/tags" %>

<%
    List<Department> departments = DepartmentDao.getAllDepartments();
    request.setAttribute("departments", departments);

    int id = Integer.parseInt(request.getParameter("id"));
    Employee employee = EmployeeDao.getEmployeeById(id);
    request.setAttribute("employee", employee);
    
//    String currentDate = new SimpleDateFormat("MM-dd-yyyy").format(new java.util.Date());

%>

<mt:hr_template title="Mark Attendance">
    <jsp:attribute name="content">

        <form action="InsertAttendance.jsp" method="POST" class="space-y-4"> <!-- Assuming you're updating in UpdateEmployee.jsp -->
            <input type="hidden" name="employeeId"  value="${employee.employeeId}" />

            <!-- First and Last Name Fields -->
            <div class="grid xl:grid-cols-2 xl:gap-6">
                <div class="flex items-center mb-2 w-full">
                    <label for="floating_first_name" class="w-1/4 text-right mr-4">First name:</label>
                    <input type="text" name="firstName" readonly value="${employee.firstName}" id="floating_first_name" class="form-input w-3/4" placeholder=" " required />
                </div>
                <div class="flex items-center mb-2 w-full">
                    <label for="floating_last_name" class="w-1/4 text-right mr-4">Last name:</label>
                    <input type="text" name="lastName" readonly value="${employee.lastName}" id="floating_last_name" class="form-input w-3/4" placeholder=" " required />
                </div>
            </div>

            <!-- Email and Role Fields -->
            <div class="grid xl:grid-cols-2 xl:gap-6">
                <div class="flex items-center mb-2 w-full">
                    <label for="floating_email" class="w-1/4 text-right mr-4">Email address:</label>
                    <input type="email" name="email" readonly value="${employee.email}" class="form-input w-3/4" placeholder=" " required />
                </div>
                <div class="flex items-center mb-2 w-full">
                    <label for="role" class="w-1/4 text-right mr-4">Role:</label>
    <input type="text" name="role" id="role" class="form-input w-3/4 bg-gray-100" value="${employee.role}" readonly />
                </div>
            </div>

            <!-- Phone and Department Selection -->
            <div class="grid xl:grid-cols-2 xl:gap-6">
                <div class="flex items-center mb-2 w-full">
                    <label for="floating_phone" class="w-1/4 text-right mr-4">Phone number:</label>
                    <input type="tel" readonly name="phone" value="${employee.phone}" class="form-input w-3/4" placeholder=" " required />
                </div>
                    <div class="flex items-center mb-2 w-full">
                        <!--<label for="departmentId" class="w-1/4 text-right mr-4">Department:</label>-->
                        <label for="department" class="w-1/4 text-right mr-4">Department:</label>
                        <input type="text" name="department" id="department" class="form-input w-3/4 bg-gray-100" value="${employee.departmentName}" readonly />

                    </div>
            </div>
                 <!-- Date, Check-in, and Check-out Fields -->
            <div class="grid xl:grid-cols-3 xl:gap-6">
                <div class="flex items-center mb-2 w-full">
                    <label for="date" class="w-1/4 text-right mr-4">Date:</label>
                    <input type="date" name="date" id="date" class="form-input w-3/4" required />
                </div>
                <div class="flex items-center mb-2 w-full">
                    <label for="checkInTime" class="w-1/4 text-right mr-4">Check-in Time:</label>
                    <input type="time" name="checkInTime" id="checkInTime" class="form-input w-3/4" required />
                </div>
                <div class="flex items-center mb-2 w-full">
                    <label for="checkOutTime" class="w-1/4 text-right mr-4">Check-out Time:</label>
                    <input type="time" name="checkOutTime" id="checkOutTime" class="form-input w-3/4" required />
                </div>
            </div>
             <!-- Submit Button -->
            <div class="flex justify-start mt-4">
                <button type="submit" class="inline-block focus:outline-none text-primary-500 hover:bg-primary-500 hover:text-white bg-transparent border border-gray-200 dark:bg-transparent dark:text-primary-500 dark:hover:text-white dark:border-gray-700 dark:hover:bg-primary-500  text-sm font-medium py-1 px-3 rounded mb-1 lg:mb-0">Submit</button>
            </div>
        </form>
    </jsp:attribute>
</mt:hr_template>
