<%-- 
    Document   : AddDepartment
    Created on : Oct 16, 2024, 11:00:14 AM
    Author     : SAHANI VIPUL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" isELIgnored="false" %>

<%@taglib prefix="mt" tagdir="/WEB-INF/tags"%>

<mt:admin_template title="Add Department">
    <jsp:attribute name="content">

        <div class="w-full relative mb-4">  
            <form action="InsertDepartment.jsp" method="post"> 

                <div class="flex-auto p-0 md:p-4">  
                    <div class="mb-2">
                        <label for="departmentName" class="font-medium text-sm text-slate-600 dark:text-slate-400">Department</label>
                        <input type="text"  name="departmentName" class="form-input w-full rounded-md mt-1 border border-slate-300/60 dark:border-slate-700 dark:text-slate-300 bg-transparent px-3 py-2 focus:outline-none focus:ring-0 placeholder:text-slate-400/70 placeholder:font-normal placeholder:text-sm hover:border-slate-400 focus:border-brand-500 dark:focus:border-brand-500  dark:hover:border-slate-700" placeholder="Enter Department Name" required>

                    </div>

                    <button type="submit" class="px-2 py-2 lg:px-4 bg-brand  text-white text-sm  rounded hover:bg-brand-600 border border-brand-500">Add Department</button>

                </div>

            </form>
        </div><!--end col--> 
    </jsp:attribute>
</mt:admin_template>    