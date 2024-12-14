    // Retrieve the remaining leave value from JSP and inject into JS
    const remainingLeave = <%= request.getAttribute("remainingLeave") != null ? request.getAttribute("remainingLeave") : 0 %>;  // This retrieves the value from request.setAttribute

    // Calculate total days on date selection
    const dateFrom = document.getElementById('date_from');
    const dateTo = document.getElementById('date_to');
    const totalDays = document.getElementById('total_days');
    const applyButton = document.getElementById('applyButton');
    const errorMessage = document.getElementById('error_message');
    const remainingLeaveSpan = document.getElementById('remaining_leave_error');

    const calculateDays = () => {
        if (dateFrom.value && dateTo.value) {
            const from = new Date(dateFrom.value);
            const to = new Date(dateTo.value);

            // Check if the "from" date is before the "to" date
            if (from > to) {
                totalDays.textContent = "Invalid date range";  // Show error if "from" is after "to"
                return;
            }

            const difference = (to - from) / (1000 * 60 * 60 * 24); // Difference in days

            // Ensure non-negative days and update the total days
            const totalSelectedDays = difference >= 0 ? difference + 1 : 0;
            totalDays.textContent = totalSelectedDays;
        } else {
            totalDays.textContent = 0;
        }
    };

    // Add event listeners to the date inputs to trigger calculation when dates change
    dateFrom.addEventListener('change', calculateDays);
    dateTo.addEventListener('change', calculateDays);
