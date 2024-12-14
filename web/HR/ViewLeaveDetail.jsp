<%-- 
    Document   : ViewLeaveDetail
    Created on : Nov 9, 2024, 7:37:33?PM
    Author     : SAHANI VIPUL
--%>

<%@page import="bean.LeaveDao"%>
<%@page import="bean.Leave"%>
<%@page import="bean.DepartmentDao"%>
<%@ page import="bean.EmployeeDao, bean.Employee, bean.Department, java.util.List, java.sql.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="mt" tagdir="/WEB-INF/tags" %>

<%
    List<Department> departments = DepartmentDao.getAllDepartments();
    request.setAttribute("departments", departments);

    int emp_id = Integer.parseInt(request.getParameter("emp_id"));
    Employee employee = EmployeeDao.getEmployeeById(emp_id);
    request.setAttribute("employee", employee);

    int id = Integer.parseInt(request.getParameter("id"));
    Leave leave = LeaveDao.getLeaveDetail(id);
    if (leave == null) {
        out.print("<script>alert('hii')</script>");
    }
    request.setAttribute("leave", leave);

%>

<mt:hr_template title="Leave Detail">
    <jsp:attribute name="content">

        <form action="LeaveUpdation.jsp" method="POST" class="space-y-4"> <!-- Assuming you're updating in UpdateEmployee.jsp -->
            <input type="hidden" name="id"  value="${leave.leaveId}" />

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
            <div class="flex items-center mb-2 w-full">
                <!-- Leave Name -->
                <label for="leave_type" class="w-1/6 p-3 text-right mr-2">Leave Type:</label>
                <input type="text" name="LeaveType" readonly value="${leave.leaveType}" id="leave_type" class="form-input w-1/4 mr-2" placeholder=" " required />

                <!-- From Date -->
                <label for="from_date" class="w-1/6 p-6 text-right mr-2">From:</label>
                <input type="text" name="startDate" readonly value="${leave.startDate}" id="from_date" class="form-input w-1/4 mr-2" placeholder=" " required />

                <!-- To Date -->
                <label for="to_date" class="w-1/6 p-6 text-right mr-2">To:</label>
                <input type="text" name="endDate" readonly value="${leave.endDate}" id="to_date" class="form-input w-1/4" placeholder=" " required />
            </div>
            <div class="flex items-center mb-2 w-full">
                <!-- Total Days Calculation -->
                <label for="day" class="w-1/6 p-6 text-right mr-2">Total Days:</label>
                <input type="text" name="day" readonly value="${leave.totalDays}"  class="form-input w-1/4" placeholder=" " required />
                <!-- Status Dropdown -->
                <label for="status" class="w-1/6 p-3 text-right mr-2">Status:</label>
                <select name="status" id="status" class="form-select me-2">
                    <option value="Pending" <c:if test="${leave.status == 'Pending'}">selected</c:if>>Pending</option>
                    <option value="Approve" <c:if test="${leave.status == 'Approve'}">selected</c:if>>Approve</option>
                    <option value="Reject" <c:if test="${leave.status == 'Reject'}">selected</c:if>>Reject</option>
                    </select>
                </div>
                <!-- Submit Button -->
                <div class="flex justify-start mt-4">
                    <button type="submit" class="inline-block focus:outline-none text-primary-500 hover:bg-primary-500 hover:text-white bg-transparent border border-gray-200 dark:bg-transparent dark:text-primary-500 dark:hover:text-white dark:border-gray-700 dark:hover:bg-primary-500  text-sm font-medium py-1 px-3 rounded mb-1 lg:mb-0">Submit</button>
                </div>
            </form>
    </jsp:attribute>
</mt:hr_template>
