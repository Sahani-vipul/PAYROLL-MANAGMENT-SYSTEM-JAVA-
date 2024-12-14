<%@page import="bean.DepartmentDao"%>
<%@ page import="bean.EmployeeDao, bean.Employee, bean.Department, java.util.List, java.sql.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="mt" tagdir="/WEB-INF/tags" %>

<%
    List<Department> departments = DepartmentDao.getAllDepartments();
    request.setAttribute("departments", departments);

    Integer employeeId = (Integer) session.getAttribute("employeeId");

//    int id = Integer.parseInt(request.getParameter("id"));
    Employee employee = EmployeeDao.getEmployeeById(employeeId);
    request.setAttribute("employee", employee);
%>

<mt:employee_template title="Edit Employee">
    <jsp:attribute name="content">

        <form action="UpdateEmployee.jsp" method="POST" class="space-y-4"> <!-- Assuming you're updating in UpdateEmployee.jsp -->
            <input type="hidden" name="employeeId" value="${employee.employeeId}" />

            <!-- First and Last Name Fields -->
            <div class="grid xl:grid-cols-2 xl:gap-6">
                <div class="flex items-center mb-2 w-full">
                    <label for="floating_first_name" class="w-1/4 text-right mr-4">First name:</label>
                    <input type="text" name="firstName" value="${employee.firstName}" id="floating_first_name" class="form-input w-3/4" placeholder=" " required />
                </div>
                <div class="flex items-center mb-2 w-full">
                    <label for="floating_last_name" class="w-1/4 text-right mr-4">Last name:</label>
                    <input type="text" name="lastName" value="${employee.lastName}" id="floating_last_name" class="form-input w-3/4" placeholder=" " required />
                </div>
            </div>

            <!-- Email and Role Fields -->
            <div class="grid xl:grid-cols-2 xl:gap-6">
                <div class="flex items-center mb-2 w-full">
                    <label for="floating_email" class="w-1/4 text-right mr-4">Email address:</label>
                    <input type="email" name="email" value="${employee.email}" class="form-input w-3/4" placeholder=" " required />
                </div>
                <div class="flex items-center mb-2 w-full">
                    <label for="role" class="w-1/4 text-right mr-4">Role:</label>
                    <select id="role" name="role" class="form-input w-3/4">
                        <option value="Employee" ${employee.role == 'Employee' ? 'selected' : ''}>Employee</option>

                    </select>
                </div>
            </div>

            <!-- Phone and Department Selection -->
            <div class="grid xl:grid-cols-2 xl:gap-6">
                <div class="flex items-center mb-2 w-full">
                    <label for="floating_phone" class="w-1/4 text-right mr-4">Phone number:</label>
                    <input type="tel" name="phone" value="${employee.phone}" class="form-input w-3/4" placeholder=" " required />
                </div>
                <div class="flex items-center mb-2 w-full">
                    <label for="departmentId" class="w-1/4 text-right mr-4">Department:</label>
                    <input type="text" id="departmentId" name="departmentId" class="form-input w-3/4" value="${employee.departmentName}" disabled />
                </div>
            </div>

            <!-- Date of Joining and Basic Salary Fields -->
            <div class="grid xl:grid-cols-2 xl:gap-6">
                <div class="flex items-center mb-2 w-full">
                    <label for="date_of_joining" class="w-1/4 text-right mr-4">Joining Date:</label>
                    <input type="date" name="date_of_joining" value="${employee.dateOfJoining}" class="form-input w-3/4" readonly="true"/>
                </div>
                <div class="flex items-center mb-2 w-full">
                    <label for="floating_salary" class="w-1/4 text-right mr-4">Basic Salary:</label>
                    <input type="text" name="basic_salary" value="${employee.basicSalary}" class="form-input w-3/4" placeholder=" " readonly />
                </div>
            </div>

            <!-- Submit Button -->
            <div class="flex justify-start mt-4">
                <button type="submit" class="inline-block focus:outline-none text-primary-500 hover:bg-primary-500 hover:text-white bg-transparent border border-gray-200 dark:bg-transparent dark:text-primary-500 dark:hover:text-white dark:border-gray-700 dark:hover:bg-primary-500  text-sm font-medium py-1 px-3 rounded mb-1 lg:mb-0"">Submit</button>
            </div>
        </form>
    </jsp:attribute>
</mt:employee_template>
